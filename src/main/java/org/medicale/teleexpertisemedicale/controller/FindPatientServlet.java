package org.medicale.teleexpertisemedicale.controller;

import org.medicale.teleexpertisemedicale.model.Patient;
import org.medicale.teleexpertisemedicale.repository.PatientRepository;

import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/searchPatient")
public class FindPatientServlet extends HttpServlet {
    private PatientRepository patientRepository;

    @Override
    public void init() throws ServletException {
        EntityManagerFactory emf = (EntityManagerFactory) getServletContext().getAttribute("emf");
        patientRepository = new PatientRepository(emf);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String cin = req.getParameter("patient_cin");
        Patient patient = patientRepository.findPatientByCIN(cin);
        req.setAttribute("patientfound", patient);
        if (patient != null) {
            req.setAttribute("patientId", patient.getId());
        }
        req.getRequestDispatcher("/WEB-INF/views/RegisterPatient.jsp").forward(req, resp);
    }

}
