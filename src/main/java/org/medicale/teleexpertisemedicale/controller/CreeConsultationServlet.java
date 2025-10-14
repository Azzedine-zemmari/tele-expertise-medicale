//package org.medicale.teleexpertisemedicale.controller;
//
//import org.medicale.teleexpertisemedicale.model.*;
//import org.medicale.teleexpertisemedicale.repository.ConsultationRepository;
//
//import javax.persistence.EntityManagerFactory;
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import java.io.IOException;
//import java.time.LocalDate;
//import java.util.List;
//import java.util.UUID;
//
//@WebServlet(name = "consultationServlet" , value = "/CreeConsultation")
//public class CreeConsultationServlet extends HttpServlet {
//
//    private ConsultationRepository consultationRepository;
//    @Override
//    public void init() throws ServletException{
//        EntityManagerFactory emf = (EntityManagerFactory) getServletContext().getAttribute("emf");
//        consultationRepository = new ConsultationRepository(emf);
//    }
//
//    @Override
//    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        Role role = (Role) request.getSession().getAttribute("roleUser");
//        Object userObject = request.getSession().getAttribute("loggedUser");
//        if(userObject== null){
//            response.sendRedirect(request.getContextPath() + "/login");
//            return;
//        }
//        if(role != Role.INFIRMIER){
//            request.getRequestDispatcher("/WEB-INF/views/AccessDenied.jsp").forward(request,response);
//            return;
//        }
////        List<Generalist> generalistList = consultationRepository.findAllGeneralist();
////        List<DossierMedical> dossierMedicalList = consultationRepository.findAllDossierMedical();
////        request.setAttribute("generalists" , generalistList);
////        request.setAttribute("dossierMedical" , dossierMedicalList);
//        request.getRequestDispatcher("/WEB-INF/views/CreeConsultation.jsp").forward(request,response);
//    }
//
//    @Override
//    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//
//        try {
//            // Get parameters from form
//            String temperateurStr = req.getParameter("temperature");
//            String poidStr = req.getParameter("poids");
//            String FrequenceCardiaqueStr = req.getParameter("FrequenceCardiaque");
//            String tensionStr = req.getParameter("tension");
//
//
//            Integer temperatur = Integer.parseInt(temperateurStr);
//            Double poid = Double.parseDouble(poidStr);
//            Double frequenceCardiaqueDouble = Double.parseDouble(FrequenceCardiaqueStr);
//            Double tension = Double.parseDouble(tensionStr);
//
//            //  Create Consultation entity
//            Consultation consultation = new Consultation();
//            consultation.setStatus_consultation(StatusConsultation.EN_ATTENTE); // example status
//            // create signe viteau
//            SigneVital sn = new SigneVital();
//            sn.setConsultation(consultation);
//            sn.setPoids(poid);
//            sn.setTemperature(temperatur);
//            sn.setFrequenceCardiaque(frequenceCardiaqueDouble);
//            sn.setTension(tension);
//            sn.setDate_mesure(LocalDate.now());
//            //  Persist entity
//            consultationRepository.saveConsultatinAndSigneVitaux(consultation,sn);
//
//            resp.sendRedirect("/generaliste/completeConsultation?id=" + consultation.getId());
//
//
//        } catch (Exception e) {
//            e.printStackTrace();
//            resp.getWriter().write("Erreur inserting consultation: " + e.getMessage());
//        }
//    }
//
//}
