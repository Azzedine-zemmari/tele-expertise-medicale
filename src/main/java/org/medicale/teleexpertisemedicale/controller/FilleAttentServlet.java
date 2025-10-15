package org.medicale.teleexpertisemedicale.controller;

import org.medicale.teleexpertisemedicale.model.Patient;
import org.medicale.teleexpertisemedicale.repository.PatientRepository;

import javax.persistence.EntityManagerFactory;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/fille_attente")
public class FilleAttentServlet extends HttpServlet {
    private PatientRepository patientRepository;

    @Override
    public void init() throws ServletException {
        EntityManagerFactory emf  = (EntityManagerFactory) getServletContext().getAttribute("emf");
        patientRepository = new PatientRepository(emf);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Patient> patients = patientRepository.findPatientDateArriveToday();
        req.setAttribute("patients", patients);
        req.getRequestDispatcher("/WEB-INF/views/FilleDattente.jsp").forward(req, resp);
    }
}
