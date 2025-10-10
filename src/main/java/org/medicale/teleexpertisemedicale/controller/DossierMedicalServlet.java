package org.medicale.teleexpertisemedicale.controller;

import org.medicale.teleexpertisemedicale.model.DossierMedical;
import org.medicale.teleexpertisemedicale.model.Patient;

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

@WebServlet(name = "DossierMedical" , value = "/Dossier-Medical")
public class DossierMedicalServlet extends HttpServlet {
    private EntityManagerFactory emf;
    @Override
    public void init() throws ServletException {
        emf = Persistence.createEntityManagerFactory("myPU");
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse response) throws ServletException , IOException {
        if(req.getSession().getAttribute("loggedUser") == null){
            response.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        EntityManager em = emf.createEntityManager();
        List<Patient> patientList = em.createQuery("SELECT p From Patient p", Patient.class).getResultList();
        em.close();
        req.setAttribute("patients" , patientList);
        req.getRequestDispatcher("/WEB-INF/views/DossierMedicalCreate.jsp").forward(req,response);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        EntityManager em = emf.createEntityManager();
        try{
            String patient_id = req.getParameter("patient_id");
            String bloodType = req.getParameter("bloodType");
            String Allergies = req.getParameter("allergie");
            String Medications = req.getParameter("medications");
            String pastSergery = req.getParameter("Psurgeries");

            UUID patient_uuid = UUID.fromString(patient_id);
            Patient patient =  em.find(Patient.class,patient_uuid);

            DossierMedical dossierMedical = new DossierMedical();
            dossierMedical.setPatient(patient);
            dossierMedical.setBloodType(bloodType);
            dossierMedical.setAllergies(Allergies);
            dossierMedical.setMedications(Medications);
            dossierMedical.setPastSurgeries(pastSergery);

            em.getTransaction().begin();
            em.persist(dossierMedical);
            em.getTransaction().commit();
            resp.setContentType("text/plain");
            resp.getWriter().write("dossier Medical insrted successfully");
        }catch (Exception e){
            em.getTransaction().rollback();
            resp.getWriter().write("Erreur insertint dossier medical " + e.getMessage());
        }
        finally {
            em.close();
        }
    }
}
