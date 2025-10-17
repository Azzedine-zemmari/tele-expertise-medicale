package org.medicale.teleexpertisemedicale.controller;

import org.medicale.teleexpertisemedicale.model.Consultation;
import org.medicale.teleexpertisemedicale.model.DemandeExpertise;
import org.medicale.teleexpertisemedicale.model.Specialiste;
import org.medicale.teleexpertisemedicale.model.StatusExperitse;
import org.medicale.teleexpertisemedicale.repository.ConsultationRepository;
import org.medicale.teleexpertisemedicale.repository.DemandeExpertiseRepository;
import org.medicale.teleexpertisemedicale.repository.SpecialisteRepository;

import javax.persistence.EntityManagerFactory;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.util.UUID;

@WebServlet("/demande-expertise/create")
public class DemandeExpertiseServlet extends HttpServlet {
    private DemandeExpertiseRepository demandeExpertiseRepository;
    private ConsultationRepository consultationRepository;
    private SpecialisteRepository specialisteRepository;

    @Override
    public void init() throws ServletException {
        EntityManagerFactory entityMangerFactory =  (EntityManagerFactory) getServletContext().getAttribute("emf");
        demandeExpertiseRepository = new DemandeExpertiseRepository(entityMangerFactory);
        consultationRepository = new ConsultationRepository(entityMangerFactory);
        specialisteRepository = new SpecialisteRepository(entityMangerFactory);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try{

        String dateDemand = req.getParameter("datedemande");
        String question = req.getParameter("question");
        String priorite = req.getParameter("priorite");
        String consultationId = req.getParameter("consultationId");
        String specialisteId = req.getParameter("specialistId");
         System.out.println(consultationId);
        UUID consultationUuid = UUID.fromString(consultationId);

            System.out.println("Searching for Consultation with ID: " + consultationId);


        Consultation consultation = consultationRepository.findById(consultationUuid);
            System.out.println("Result: " + consultation);
        UUID specialisteUuid = UUID.fromString(specialisteId);
        Specialiste specialiste = specialisteRepository.findByID(specialisteUuid);

            if (consultation == null) throw new RuntimeException("Consultation not found with ID: " + consultationId);
            if (specialiste == null) throw new RuntimeException("Specialiste not found with ID: " + specialisteId);

        DemandeExpertise demandeExpertise = new DemandeExpertise();
        demandeExpertise.setDateDemand(dateDemand);
        demandeExpertise.setQuestion(question);
        demandeExpertise.setPriority(priorite);
        demandeExpertise.setStatusExpertise(StatusExperitse.EN_ATTENTE);
        demandeExpertise.setConsultation(consultation);
        demandeExpertise.setSpecialiste(specialiste);
        demandeExpertiseRepository.save(demandeExpertise);
        }catch (Exception e){
            e.printStackTrace();
        }

    }
}
