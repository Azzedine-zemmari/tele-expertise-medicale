package org.medicale.teleexpertisemedicale.controller;

import org.medicale.teleexpertisemedicale.model.DemandeExpertise;
import org.medicale.teleexpertisemedicale.model.Specialiste;
import org.medicale.teleexpertisemedicale.model.StatusExperitse;
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
import java.util.List;
import java.util.UUID;

@WebServlet("/CreationAvis")
public class CreationAvisServlet  extends HttpServlet {
    private DemandeExpertiseRepository demandeExpertiseRepository;
    private SpecialisteRepository specialisteRepository;

    @Override
    public void init() throws ServletException {
        EntityManagerFactory emf = (EntityManagerFactory) getServletContext().getAttribute("emf");
        demandeExpertiseRepository = new DemandeExpertiseRepository(emf);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Specialiste specialiste = (Specialiste) req.getSession().getAttribute("specialiste");
        UUID specialisteId = specialiste.getId();
        List<DemandeExpertise> demandeExpertiseList = demandeExpertiseRepository.findAllDemandeExpertiseForSpecialiste(specialisteId);
        req.setAttribute("demandeExpertiseList", demandeExpertiseList);
        req.getRequestDispatcher("/WEB-INF/views/Specialiste/CreationAvis.jsp").forward(req, resp);
    }

//    @Override
//    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        String demandeavisID = req.getParameter("demandeExpertise");
//        UUID demandeavisUUID = UUID.fromString(demandeavisID);
//        LocalDate dateAvis = LocalDate.now();
//        StatusExperitse statusExperitse = StatusExperitse.TERMINE;
//        String avis = req.getParameter("avis");
//
//        demandeExpertiseRepository.AddAvis(demandeavisUUID, avis, dateAvis,statusExperitse);
//        resp.sendRedirect(req.getContextPath() + "/CreationAvis?success=true");
//
//    }
}
