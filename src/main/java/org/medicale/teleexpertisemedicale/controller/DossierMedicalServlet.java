package org.medicale.teleexpertisemedicale.controller;

import org.medicale.teleexpertisemedicale.model.DossierMedical;
import org.medicale.teleexpertisemedicale.model.Patient;
import org.medicale.teleexpertisemedicale.repository.DossierMedicalRepository;

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
    private DossierMedicalRepository dossierMedicalRepository;
    @Override
    public void init() throws ServletException {
        EntityManagerFactory emf = (EntityManagerFactory) getServletContext().getAttribute("emf");
        dossierMedicalRepository = new DossierMedicalRepository(emf);
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse response) throws ServletException , IOException {
        if(req.getSession().getAttribute("loggedUser") == null){
            response.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        List<Patient> patientList = dossierMedicalRepository.getAllPatients();
        req.setAttribute("patients" , patientList);
        req.getRequestDispatcher("/WEB-INF/views/DossierMedicalCreate.jsp").forward(req,response);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try{
            String patient_id = req.getParameter("patient_id");
            String bloodType = req.getParameter("bloodType");
            String Allergies = req.getParameter("allergie");
            String Medications = req.getParameter("medications");
            String pastSergery = req.getParameter("Psurgeries");

            UUID patient_uuid = UUID.fromString(patient_id);
            Patient patient = dossierMedicalRepository.findPatientById(patient_uuid);

            DossierMedical dossierMedical = new DossierMedical();
            dossierMedical.setPatient(patient);
            dossierMedical.setBloodType(bloodType);
            dossierMedical.setAllergies(Allergies);
            dossierMedical.setMedications(Medications);
            dossierMedical.setPastSurgeries(pastSergery);

            dossierMedicalRepository.save(dossierMedical);
            resp.setContentType("text/plain");
            resp.getWriter().write("dossier Medical insrted successfully");
        }catch (Exception e){
            resp.getWriter().write("Erreur insertint dossier medical " + e.getMessage());
        }
    }
}
