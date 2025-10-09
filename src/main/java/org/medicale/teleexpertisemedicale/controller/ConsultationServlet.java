package org.medicale.teleexpertisemedicale.controller;

import org.medicale.teleexpertisemedicale.HelloServlet;
import org.medicale.teleexpertisemedicale.model.ActMedical;
import org.medicale.teleexpertisemedicale.model.DossierMedical;
import org.medicale.teleexpertisemedicale.model.Generalist;

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

@WebServlet(name = "consultationServlet" , value = "/CreeConsultation")
public class ConsultationServlet extends HttpServlet {
    private EntityManagerFactory emf;

    @Override
    public void init() throws ServletException{
        emf = Persistence.createEntityManagerFactory("myPU");
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        EntityManager em = emf.createEntityManager();
        List<Generalist> generalistList = em.createQuery("SELECT g from Generalist g JOIN FETCH g.utilisateur" ,Generalist.class).getResultList();
        List<DossierMedical> dossierMedicalList = em.createQuery("SELECT d from DossierMedical d JOIN FETCH d.patient").getResultList();
        em.close();
        request.setAttribute("generalists" , generalistList);
        request.setAttribute("dossierMedical" , dossierMedicalList);
        request.getRequestDispatcher("/WEB-INF/views/CreeConsultation.jsp").forward(request,response);
    }
}
