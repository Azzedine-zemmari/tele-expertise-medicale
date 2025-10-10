package org.medicale.teleexpertisemedicale.controller;

import org.medicale.teleexpertisemedicale.model.Patient;
import org.medicale.teleexpertisemedicale.model.StatusConsultation;

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

@WebServlet(name = "dashboard" ,  value = "/dashboard")
public class DashboardServlet extends HttpServlet {
    private EntityManagerFactory emf;

    @Override
    public void init() throws ServletException {
        emf = Persistence.createEntityManagerFactory("myPU");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        EntityManager em = emf.createEntityManager();

        List<Patient> patientList = em.createQuery(
                        "SELECT distinct dm.patient FROM Consultation c " +
                                "JOIN c.dossierMedical dm " +
                                "JOIN dm.patient " +
                                "WHERE c.status_consultation = :status",
                        Patient.class
                )
                .setParameter("status", StatusConsultation.EN_ATTENTE)
                .getResultList();

        req.setAttribute("patients", patientList);
        List<Patient> patientAjourdhui = em.createQuery(
                "SELECT  distinct dm.patient FROM Consultation c " +
                        "JOIN c.dossierMedical dm " +
                        "JOIN dm.patient " +
                        "WHERE c.date = :date",Patient.class
        ).setParameter("date", LocalDate.now()).getResultList();
        req.setAttribute("patientAjourdhui",patientAjourdhui);
        // fix
        List<Patient> patientStatus = em.createQuery(
                        "SELECT dm.patient FROM Consultation c " +
                                "JOIN c.dossierMedical dm " +
                                "JOIN dm.patient " ,
                        Patient.class
                ).getResultList();
        req.setAttribute("patientstatus",patientStatus);
        req.getRequestDispatcher("/WEB-INF/views/Dashboard.jsp").forward(req, resp);
    }

}
