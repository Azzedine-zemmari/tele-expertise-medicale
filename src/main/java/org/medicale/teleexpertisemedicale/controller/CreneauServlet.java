package org.medicale.teleexpertisemedicale.controller;

import org.medicale.teleexpertisemedicale.repository.CreneauRepository;

import javax.persistence.EntityManagerFactory;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "CreeCrenau" , value = "/CreeCreneau")
public class CreneauServlet extends HttpServlet {
    private CreneauRepository creneauRepository;

    @Override
    public void init() throws ServletException {
        EntityManagerFactory emf = (EntityManagerFactory) getServletContext().getAttribute("emf");
        creneauRepository = new CreneauRepository(emf);

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/Specialiste/CreationCreneau.jsp").forward(req, resp);
    }
}
