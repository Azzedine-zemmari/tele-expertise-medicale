package org.medicale.teleexpertisemedicale.controller;

import org.medicale.teleexpertisemedicale.model.DemandeExpertise;
import org.medicale.teleexpertisemedicale.repository.DemandeExpertiseRepository;

import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.UUID;

@WebServlet("/DemandeExpertiseDetails")
public class DemandeExpertiseDetailServlet extends HttpServlet {
    private DemandeExpertiseRepository demandeExpertiseRepository;

    @Override
    public void init() throws ServletException {
        EntityManagerFactory emf = (EntityManagerFactory) getServletContext().getAttribute("emf");
        demandeExpertiseRepository = new DemandeExpertiseRepository(emf);
    }

    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String demandeExpertiseId  = req.getParameter("id");
        UUID demandeExpertiseUuid = UUID.fromString(demandeExpertiseId);

        DemandeExpertise demandeExpertiseDetails = demandeExpertiseRepository.findDetailsForDemandeExpertise(demandeExpertiseUuid);
        req.setAttribute("demandeExpertiseDetails", demandeExpertiseDetails);
        req.getRequestDispatcher("/WEB-INF/views/Specialiste/ExpertiseDetails.jsp").forward(req, resp);

    }
}
