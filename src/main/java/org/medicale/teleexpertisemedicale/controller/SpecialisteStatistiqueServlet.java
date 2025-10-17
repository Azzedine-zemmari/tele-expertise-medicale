package org.medicale.teleexpertisemedicale.controller;

import org.medicale.teleexpertisemedicale.model.Specialiste;
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


@WebServlet("/specialiste-statistiques")
public class SpecialisteStatistiqueServlet extends HttpServlet {
    private DemandeExpertiseRepository demandeExpertiseRepository;

    @Override
    public void init() throws ServletException {
        EntityManagerFactory emf = (EntityManagerFactory) getServletContext().getAttribute("emf");
        demandeExpertiseRepository = new DemandeExpertiseRepository(emf);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Specialiste specialiste = (Specialiste) req.getSession().getAttribute("specialiste");
        UUID specialisteId = specialiste.getId();
        long count = demandeExpertiseRepository.countDemandeExpertise(specialisteId);
        double revenu = demandeExpertiseRepository.countRevenu(specialisteId);
        req.setAttribute("specialiste", specialiste);
        req.setAttribute("count", count);
        req.setAttribute("revenu", revenu);
        req.getRequestDispatcher("/WEB-INF/views/Specialiste/specialiste-statistique.jsp").forward(req, resp);
    }
}

