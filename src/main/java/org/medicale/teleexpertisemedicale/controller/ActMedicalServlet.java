package org.medicale.teleexpertisemedicale.controller;

import org.medicale.teleexpertisemedicale.model.ActMedical;
import org.medicale.teleexpertisemedicale.model.Consultation;
import org.medicale.teleexpertisemedicale.model.TypeAct;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

@WebServlet(name = "actMedical",value = "/actmedical")
public class ActMedicalServlet extends HttpServlet {
    private EntityManagerFactory emf;

    @Override
    public void init() throws ServletException {
        emf = Persistence.createEntityManagerFactory("myPU");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if(req.getSession().getAttribute("loggedUser") == null){
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        EntityManager em = emf.createEntityManager();
        List<Consultation> consultations = em.createQuery("SELECT c FROM Consultation c JOIN FETCH c.dossierMedical JOIN FETCH c.generalist").getResultList();
        req.setAttribute("consultations",consultations);
        req.setAttribute("actTypes", TypeAct.values());
        req.getRequestDispatcher("/WEB-INF/views/CreeActMedical.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        EntityManager em = emf.createEntityManager();
        try{
        String consultationStr = req.getParameter("consultation");
        String count = req.getParameter("count");
        UUID consultationId = UUID.fromString(consultationStr);

        Consultation consultation = em.find(Consultation.class,consultationId);
        Double countdouble = Double.parseDouble(count);
        em.getTransaction().begin();

        String[] actsMedical = req.getParameterValues("actmedical");
        for(String a : actsMedical){
            ActMedical actMedical = new ActMedical();
            actMedical.setTypeAct(TypeAct.valueOf(a));
            actMedical.setConsultation(consultation);
            actMedical.setCount(countdouble);
            em.persist(actMedical);
        }
        em.getTransaction().commit();
        resp.getWriter().write("Consultation & multiple ActMedical saved!");
        }catch (Exception e){
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
            resp.getWriter().write("Erreur inserting consultation: " + e.getMessage());
        }finally {
            em.close();
        }
    }
}
