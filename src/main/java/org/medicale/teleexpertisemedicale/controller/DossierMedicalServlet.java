package org.medicale.teleexpertisemedicale.controller;

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

@WebServlet(name = "DossierMedical" , value = "/Dossier-Medical")
public class DossierMedicalServlet extends HttpServlet {
    private EntityManagerFactory emf;
    @Override
    public void init() throws ServletException {
        emf = Persistence.createEntityManagerFactory("myPU");
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse response) throws ServletException , IOException {
        EntityManager em = emf.createEntityManager();
        List<Patient> patientList = em.createQuery("SELECT p From Patient p", Patient.class).getResultList();
        em.close();
        req.setAttribute("patients" , patientList);
        req.getRequestDispatcher("/WEB-INF/views/DossierMedicalCreate.jsp").forward(req,response);
    }
}
