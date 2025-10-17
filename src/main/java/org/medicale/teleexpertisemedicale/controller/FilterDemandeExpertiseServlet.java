package org.medicale.teleexpertisemedicale.controller;

import org.medicale.teleexpertisemedicale.model.DemandeExpertise;
import org.medicale.teleexpertisemedicale.model.Specialiste;
import org.medicale.teleexpertisemedicale.model.StatusExperitse;
import org.medicale.teleexpertisemedicale.repository.DemandeExpertiseRepository;

import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@WebServlet("/filter")
public class FilterDemandeExpertiseServlet extends HttpServlet {
    private DemandeExpertiseRepository demandeExpertiseRepository;

    @Override
    public void init() throws ServletException {
        EntityManagerFactory emf = (EntityManagerFactory) getServletContext().getAttribute("emf");
        demandeExpertiseRepository = new DemandeExpertiseRepository(emf);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Specialiste specialiste = (Specialiste) req.getSession().getAttribute("specialiste");
        UUID specialisteId = specialiste.getId();
        String filter = req.getParameter("statusExpertise");
        String priority = req.getParameter("priority");
        List<DemandeExpertise> expertises = demandeExpertiseRepository.FilterDemandeExpertiseForSpecialisteBYSTATUSANDPRIORITE(specialisteId, StatusExperitse.valueOf(filter),priority);
        req.setAttribute("expertises", expertises);
        req.getRequestDispatcher("/WEB-INF/views/Specialiste/CreationAvis.jsp").forward(req, resp);
    }
}
