package org.medicale.teleexpertisemedicale.controller;

import org.medicale.teleexpertisemedicale.model.Patient;
import org.medicale.teleexpertisemedicale.repository.PatientRepository;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.ParameterizedType;
import java.time.LocalDate;
import java.util.UUID;

@WebServlet(name = "RegisterPatient",value = "/Register-Patient")
public class RegisterPatientServlet extends HttpServlet {
    private PatientRepository patientRepository;

    @Override
    public void init() throws ServletException{
        EntityManagerFactory emf =(EntityManagerFactory) getServletContext().getAttribute("emf");
        patientRepository = new PatientRepository(emf);
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if(req.getSession().getAttribute("loggedUser") == null){
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        req.getRequestDispatcher("/WEB-INF/views/RegisterPatient.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try{
        String prenom = req.getParameter("firstName");
        String nom = req.getParameter("lastName");
        String mutuelle =  req.getParameter("mutuelle");
        String ss = req.getParameter("securite_social");
        String cin = req.getParameter("CIN");
        String adress = req.getParameter("adress");

        Patient patient = new Patient();
//       patient.setId(UUID.randomUUID());
        patient.setNom(nom);
        patient.setPrenom(prenom);
        patient.setMutuelle(mutuelle);
        patient.setAddress(adress);
        patient.setNum_securite_social(ss);
        patient.setCIN(cin);
        patient.setDate_arrive(LocalDate.now());

        patientRepository.save(patient);
        // Response
            resp.setContentType("text/plain");
            resp.getWriter().write("Patient inserted successfully" + patient.getId());
        }catch (Exception e){
            resp.getWriter().write("Erreur inserting patient : " + e.getMessage());
        }
    }
}
