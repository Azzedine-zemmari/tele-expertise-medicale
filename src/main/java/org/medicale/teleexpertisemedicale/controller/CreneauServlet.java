package org.medicale.teleexpertisemedicale.controller;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
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
import java.time.OffsetDateTime;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@WebServlet(name = "CreeCrenau" , value = "/CreeCreneau")
public class CreneauServlet extends HttpServlet {
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
        req.getRequestDispatcher("/WEB-INF/views/Specialiste/CreationCreneau.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try{
            String specialist_id = req.getParameter("specialiste_id");
            String crenauxJson = req.getParameter("crenaux");

            UUID specialiste_uuid = UUID.fromString(specialist_id);
            Specialiste specialiste = specialisteRepository.findByID(specialiste_uuid);

            ObjectMapper mapper = new ObjectMapper();
            List<Map<String,String>> slots = mapper.readValue(crenauxJson, new TypeReference<List<Map<String, String>>>() {});
            for(Map<String,String> slot : slots){
                String Str_start = slot.get("start");
                String Str_end = slot.get("end");

                Creneu c = new Creneu();
                c.setHeureDebut(OffsetDateTime.parse(Str_start).toLocalDateTime());
                c.setHeureFin(OffsetDateTime.parse(Str_end).toLocalDateTime());
                c.setSpecialiste(specialiste);
                c.setDisponibilite(true);
                creneauRepository.save(c);
                resp.setContentType("text/plain");
                resp.getWriter().write("creneu insrted successfully");

            }
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
