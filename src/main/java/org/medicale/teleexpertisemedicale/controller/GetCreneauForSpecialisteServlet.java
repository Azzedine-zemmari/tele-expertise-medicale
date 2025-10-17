package org.medicale.teleexpertisemedicale.controller;

import com.google.gson.Gson;
import org.hibernate.Hibernate;
import org.medicale.teleexpertisemedicale.model.Creneu;
import org.medicale.teleexpertisemedicale.model.Specialiste;
import org.medicale.teleexpertisemedicale.repository.CreneauRepository;
import org.medicale.teleexpertisemedicale.repository.SpecialisteRepository;

import javax.persistence.EntityManagerFactory;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.transaction.Transactional;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@WebServlet("/getCreneaux")
public class GetCreneauForSpecialisteServlet extends HttpServlet {
    private CreneauRepository creneauRepository;
    private SpecialisteRepository specialisteRepository;

    @Override
    public void init() throws ServletException {
        EntityManagerFactory emf = (EntityManagerFactory) getServletContext().getAttribute("emf");
        creneauRepository = new CreneauRepository(emf);
        specialisteRepository = new SpecialisteRepository(emf);
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            String specialisteIdStr = req.getParameter("specialisteId");
            if (specialisteIdStr == null || specialisteIdStr.isEmpty()) {
                resp.setContentType("application/json");
                resp.getWriter().write("[]");
                return;
            }

            UUID specialisteId = UUID.fromString(specialisteIdStr);

            // SOLUTION : Initialiser explicitement les collections
            List<Creneu> creneus = creneauRepository.findCreneauBySpecialisteId(specialisteId);

            // Force l'initialisation de toutes les collections lazy
            if (creneus != null) {
                for (Creneu creneu : creneus) {
                    Hibernate.initialize(creneu.getSpecialiste()); // Si Specialiste a des lazy collections
                }
            }

            Gson gson = new Gson();
            String json = gson.toJson(creneus != null ? creneus : new ArrayList<>());

            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().write(json);
        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
