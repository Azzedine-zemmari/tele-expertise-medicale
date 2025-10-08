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
import java.util.UUID;

@WebServlet(name = "RegisterPatient",value = "/Register-Patient")
public class RegisterPatientServlet extends HttpServlet {
//    PatientRepository patientRepository = new PatientRepository();
    private EntityManagerFactory emf;
    @Override
    public void init() throws ServletException{
        emf = Persistence.createEntityManagerFactory("myPU");
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/RegisterPatient.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        EntityManager em = emf.createEntityManager();
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

        em.getTransaction().begin();
        em.persist(patient);
        em.getTransaction().commit();
        // Response
            resp.setContentType("text/plain");
            resp.getWriter().write("Patient inserted successfully" + patient.getId());
        }catch (Exception e){
            em.getTransaction().rollback();
            resp.getWriter().write("Erreur inserting patient : " + e.getMessage());
        }
        finally {
            em.close();
        }
    }
}
