package org.medicale.teleexpertisemedicale.controller;

import org.medicale.teleexpertisemedicale.model.Patient;
import org.medicale.teleexpertisemedicale.model.SigneVital;
import org.medicale.teleexpertisemedicale.repository.PatientRepository;
import org.medicale.teleexpertisemedicale.repository.SigneVitalRepository;

import javax.persistence.EntityManagerFactory;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

@WebServlet(name="CreeSigneVitalServlet" , value = "/SigneVital")
public class CreeSigneVitalServlet extends HttpServlet {
    private SigneVitalRepository signeVitalRepository;
    private PatientRepository patientRepository;

    @Override
    public void init() throws ServletException {
        EntityManagerFactory emf = (EntityManagerFactory) getServletContext().getAttribute("emf");
        signeVitalRepository = new SigneVitalRepository(emf);
        patientRepository = new PatientRepository(emf);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Patient> patientList = patientRepository.findAll();
        req.setAttribute("patientList", patientList);
        req.getRequestDispatcher("/WEB-INF/views/CreeSigneVitaux.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try{

        String patientId = req.getParameter("patientId");
        String tension = req.getParameter("tension");
        String frequenceCardiaque = req.getParameter("frequenceCardiaque");
        String temperature = req.getParameter("temperature");
        String poids = req.getParameter("poids");


        UUID patientUUID = UUID.fromString(patientId);
        Patient patient = patientRepository.findById(patientUUID);
        Double tensionDouble = Double.parseDouble(tension);
        Double frequenceCardiaqueDouble = Double.parseDouble(frequenceCardiaque);
        Integer temperatureInterger = Integer.parseInt(temperature);
        Double poidsDouble = Double.parseDouble(poids);

        SigneVital signeVital = new SigneVital();
        signeVital.setTension(tensionDouble);
        signeVital.setPatient(patient);
        signeVital.setFrequenceCardiaque(frequenceCardiaqueDouble);
        signeVital.setTemperature(temperatureInterger);
        signeVital.setPoids(poidsDouble);
        signeVital.setDate_mesure(LocalDate.now());
        signeVitalRepository.save(signeVital);
            resp.sendRedirect(req.getContextPath() + "/fille_attente");
//            resp.setContentType("text/plain");
//            resp.getWriter().write("Signe vital inserted successfully" + signeVital.getId());
        }catch (Exception e){
            e.printStackTrace();
            resp.setContentType("text/plain");
            resp.getWriter().write(e.getMessage());
        }
    }
}
