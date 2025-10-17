package org.medicale.teleexpertisemedicale.controller;

import org.medicale.teleexpertisemedicale.model.Specialiste;
import org.medicale.teleexpertisemedicale.repository.SpecialisteRepository;

import javax.persistence.EntityManagerFactory;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/rechercher-specialiste")
public class SpecialisteRechercheServlet extends HttpServlet {
    private SpecialisteRepository specialisteRepository;

    @Override
    public void init() throws ServletException {
        EntityManagerFactory emf = (EntityManagerFactory) getServletContext().getAttribute("emf");
        specialisteRepository = new SpecialisteRepository(emf);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/RechercheSpecialiste.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try{
        Double tarif = Double.parseDouble(req.getParameter("tarif"));
            String specialite = req.getParameter("specialite");
            String consultationId = req.getParameter("consultationId");
            req.setAttribute("consultationId", consultationId);
            List<Specialiste> result = specialisteRepository.rechercheSpecialParTarifEtParSpecialite(specialite,tarif);
            req.setAttribute("specialistes",result);
            req.getRequestDispatcher("/WEB-INF/views/RechercheSpecialiste.jsp").forward(req,resp);
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
