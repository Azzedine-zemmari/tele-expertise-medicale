package org.medicale.teleexpertisemedicale.controller;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "UserRegistre" , value = "/Register")
public class UtilisateurServlet extends HttpServlet {
    private EntityManagerFactory emf;
    @Override
    public void init() throws ServletException{
        emf = Persistence.createEntityManagerFactory("myPU");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/Register.jsp").forward(req,resp);
    }
}
