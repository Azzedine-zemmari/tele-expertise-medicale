package org.medicale.teleexpertisemedicale.controller;

import org.medicale.teleexpertisemedicale.model.Patient;
import org.medicale.teleexpertisemedicale.model.StatusConsultation;
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
import java.time.LocalDate;
import java.util.List;

@WebServlet(name = "dashboard", value = "/dashboard")
public class DashboardServlet extends HttpServlet {
    private PatientRepository patientRepository;

    @Override
    public void init() throws ServletException {
        EntityManagerFactory emf = (EntityManagerFactory) getServletContext().getAttribute("emf");
        patientRepository = new PatientRepository(emf);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if(req.getSession().getAttribute("loggedUser") == null){
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        List<Patient> patientList = patientRepository.findPatientWithStatusConsultationAttente();

        req.setAttribute("patients", patientList);
        List<Patient> patientAjourdhui = patientRepository.findPatientWithConsultationToday();
        req.setAttribute("patientAjourdhui", patientAjourdhui);
        // fix
        List<Patient> patientStatus = patientRepository.findPatientStatus();
        req.setAttribute("patientstatus", patientStatus);
        req.getRequestDispatcher("/WEB-INF/views/Dashboard.jsp").forward(req, resp);
    }

}
