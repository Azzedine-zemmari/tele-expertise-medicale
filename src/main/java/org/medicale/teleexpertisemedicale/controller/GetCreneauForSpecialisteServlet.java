package org.medicale.teleexpertisemedicale.controller;

import com.google.gson.Gson;
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
import java.io.IOException;
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
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String specialisteIdStr = req.getParameter("specialisteId");
        UUID specialisteId = UUID.fromString(specialisteIdStr);

        List<Creneu> creneus = creneauRepository.findCreneauBySpecialisteId(specialisteId);
        req.setAttribute("creneau", creneus);

        Gson gson = new Gson();
        String json = gson.toJson(creneus);
        resp.setContentType("application/json");
        resp.getWriter().write(json);
    }
}
