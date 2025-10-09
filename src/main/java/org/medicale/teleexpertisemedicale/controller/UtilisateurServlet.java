package org.medicale.teleexpertisemedicale.controller;

import org.medicale.teleexpertisemedicale.model.*;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.UUID;

import static org.medicale.teleexpertisemedicale.model.Role.INFIRMIER;

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

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        EntityManager em = emf.createEntityManager();
        try{
            String prenom = req.getParameter("firstName");
            String nom = req.getParameter("lastName");
            String email = req.getParameter("email");
            String password = req.getParameter("password");
            Role role = Role.valueOf(req.getParameter("role"));

            Utilisateur user = new Utilisateur();
//            user.setId(UUID.randomUUID());
            user.setNom(nom);
            user.setPrenom(prenom);
            user.setEmail(email);
            user.setPassword(password);
            user.setRole(role);

            em.getTransaction().begin();
            em.persist(user);
            switch (role){
                case INFIRMIER:
                    String service = req.getParameter("service");
                    Shift shift = Shift.valueOf(req.getParameter("shift"));
                    int experience = Integer.parseInt(req.getParameter("experience"));
                    Infirmier infirmier = new Infirmier();
                    infirmier.setExperience(experience);
                    infirmier.setService(service);
                    infirmier.setShift(shift);
                    infirmier.setUtilisateur(user);
                    em.persist(infirmier);
                    break;
                case GENERALISTE:
                    int exeperience = Integer.parseInt(req.getParameter("experience_gen"));
                    double tarif = Double.parseDouble(req.getParameter("tarifConsultation"));
                    Generalist generalist = new Generalist();
                    generalist.setExperience(exeperience);
                    generalist.setTarif(tarif);
                    generalist.setUtilisateur(user);
                    em.persist(generalist);
                    break;
                case SPECIALISTE :
                    int exeperienceSpec = Integer.parseInt(req.getParameter("experience_spec"));
                    double tarifSpec = Double.parseDouble(req.getParameter("tarif"));
                    Specialiste specialiste = new Specialiste();
                    specialiste.setExperience(exeperienceSpec);
                    specialiste.setTarif(tarifSpec);
                    specialiste.setUtilisateur(user);
                    em.persist(specialiste);
                    break;
                default:
                    System.out.println("choose something else ");
            }
            em.getTransaction().commit();
            resp.setContentType("text/plain");
            resp.getWriter().write("User and role inserted successfully!");
        }catch (Exception e){
            em.getTransaction().rollback();
            e.printStackTrace();
            resp.getWriter().write("Erreur inserting patient : " + e.getMessage());
        }
        finally {
            em.close();
        }
    }
}
