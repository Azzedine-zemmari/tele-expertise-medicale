package org.medicale.teleexpertisemedicale.controller;

import org.medicale.teleexpertisemedicale.model.*;
import org.medicale.teleexpertisemedicale.repository.ActMedicalRepository;
import org.medicale.teleexpertisemedicale.repository.ConsultationRepository;

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

@WebServlet(name = "consultationServlet" , value = "/CreeConsultation")
public class CreeConsultationServlet extends HttpServlet {

    private ConsultationRepository consultationRepository;
    private ActMedicalRepository actMedicalRepository;
    @Override
    public void init() throws ServletException{
        EntityManagerFactory emf = (EntityManagerFactory) getServletContext().getAttribute("emf");
        consultationRepository = new ConsultationRepository(emf);
        actMedicalRepository = new ActMedicalRepository(emf);
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Role role = (Role) request.getSession().getAttribute("roleUser");
        Object userObject = request.getSession().getAttribute("loggedUser");
        if(userObject== null){
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        if(role != Role.GENERALISTE){
            request.getRequestDispatcher("/WEB-INF/views/AccessDenied.jsp").forward(request,response);
            return;
        }
        String dossier_medical_id = request.getParameter("dossier_medical_id");
        UUID dossier_medical_uuid = UUID.fromString(dossier_medical_id);
        DossierMedical dossierMedical =  consultationRepository.findDossierMedicalById(dossier_medical_uuid);
        request.setAttribute("TypeAct" , TypeAct.values());
        request.setAttribute("dossier_medical", dossierMedical);
        request.getRequestDispatcher("/WEB-INF/views/CreeConsultation.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // 1. Validate required fields
            String dossier_medical_id = req.getParameter("dossier_medical_id");
            String date = req.getParameter("date");
            String motif = req.getParameter("motif");
            String diagnostique = req.getParameter("diagnostique");
            String traitement = req.getParameter("traitement");
            String count = req.getParameter("count");
            String[] typeActParam = req.getParameterValues("typeact");
            String action = req.getParameter("action");

            if (dossier_medical_id == null || date == null || count == null || typeActParam == null) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing required fields");
                return;
            }

            // 2. Parse values safely
            UUID dossierMedicalUUID = UUID.fromString(dossier_medical_id);
            LocalDate consultationDate = LocalDate.parse(date);
            int integerCount = Integer.parseInt(count);

            // 3. Fetch dependencies
            DossierMedical dossierMedical = consultationRepository.findDossierMedicalById(dossierMedicalUUID);
            if (dossierMedical == null) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Dossier medical not found");
                return;
            }

            // 4. Build Consultation
            Consultation consultation = new Consultation();
            consultation.setDossierMedical(dossierMedical);
            consultation.setDate(consultationDate);
            consultation.setMotif(motif);
            consultation.setDiagnostique(diagnostique);
            consultation.setTraitement(traitement);
            consultation.setCount(integerCount);
            if("termine".equals(action)){
                consultation.setStatus_consultation(StatusConsultation.TERMINEE);
            }else if("avis".equals(action)){
                consultation.setStatus_consultation(StatusConsultation.EN_ATTENTE_AVIS_SPECIALISTE);
            }

            System.out.println("ACTION = " + action);
            consultationRepository.saveConsultation(consultation);

            //  5. Loop for multiple TypeAct values
            if (typeActParam != null) {
                for (String actValue : typeActParam) {
                        TypeAct actEnum = TypeAct.valueOf(actValue.trim().toUpperCase());

                        ActMedical actMedical = new ActMedical();
                        actMedical.setTypeAct(actEnum);
                        actMedical.setConsultation(consultation);
                        actMedical.setCount(integerCount);

                        actMedicalRepository.save(actMedical);
                }
            } else {
                System.out.println("No TypeAct selected!");
            }

            resp.sendRedirect("dashboard");

        } catch (IllegalArgumentException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid input format: " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Server error: " + e.getMessage());
        }
    }

}
