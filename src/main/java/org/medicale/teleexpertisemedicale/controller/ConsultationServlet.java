package org.medicale.teleexpertisemedicale.controller;

import org.medicale.teleexpertisemedicale.HelloServlet;
import org.medicale.teleexpertisemedicale.model.*;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

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

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        EntityManager em = emf.createEntityManager();

        try {
            // 1️⃣ Get parameters from form
            String generalistIdStr = req.getParameter("generalist_id");
            String dossierMedicalIdStr = req.getParameter("dossier_medical_id");
            String dateStr = req.getParameter("date");
            String motif = req.getParameter("motif");
            String diagnostique = req.getParameter("diagnostique");
            String traitement = req.getParameter("traitement");
            String countStr = req.getParameter("count");

            UUID generalistId = UUID.fromString(generalistIdStr);
            UUID dossierMedicalId = UUID.fromString(dossierMedicalIdStr);
            LocalDate date = LocalDate.parse(dateStr); // format yyyy-MM-dd
            Integer count = Integer.parseInt(countStr);

            // 2️⃣ Find related entities
            Generalist generalist = em.find(Generalist.class, generalistId);
            DossierMedical dossierMedical = em.find(DossierMedical.class, dossierMedicalId);

            if (generalist == null || dossierMedical == null) {
                resp.getWriter().write("Generalist or DossierMedical not found!");
                return;
            }

            // 3️⃣ Create Consultation entity
            Consultation consultation = new Consultation();
            consultation.setGeneralist(generalist);
            consultation.setDossierMedical(dossierMedical);
            consultation.setDate(date);
            consultation.setMotif(motif);
            consultation.setDiagnostique(diagnostique);
            consultation.setTraitement(traitement);
            consultation.setCount(count);
            consultation.setStatus_consultation(StatusConsultation.EN_ATTENTE); // example status

            // 4️⃣ Persist entity
            em.getTransaction().begin();
            em.persist(consultation);
            em.getTransaction().commit();

            resp.getWriter().write("Consultation created successfully!");

        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
            resp.getWriter().write("Erreur inserting consultation: " + e.getMessage());
        } finally {
            em.close();
        }
    }

}
