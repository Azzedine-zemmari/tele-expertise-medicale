package org.medicale.teleexpertisemedicale.controller;

import org.jasypt.util.password.PasswordEncryptor;
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
import org.jasypt.util.password.StrongPasswordEncryptor;
import org.medicale.teleexpertisemedicale.repository.UtilisateurRepository;

import static org.medicale.teleexpertisemedicale.model.Role.INFIRMIER;

@WebServlet(name = "UserRegistre" , value = "/Register")
public class UtilisateurServlet extends HttpServlet {
    private UtilisateurRepository utilisateurRepository;
    private static final StrongPasswordEncryptor passwordEncryptor = new StrongPasswordEncryptor();
    @Override
    public void init() throws ServletException{
        EntityManagerFactory emf = (EntityManagerFactory) getServletContext().getAttribute("emf");
        utilisateurRepository = new UtilisateurRepository(emf);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/Register.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try{
            String prenom = req.getParameter("firstName");
            String nom = req.getParameter("lastName");
            String email = req.getParameter("email");
            String password = req.getParameter("password");
            String encryptedPasword = passwordEncryptor.encryptPassword(password);
            Role role = Role.valueOf(req.getParameter("role"));

            Utilisateur user = new Utilisateur();
//            user.setId(UUID.randomUUID());
            user.setNom(nom);
            user.setPrenom(prenom);
            user.setEmail(email);
            user.setPassword(encryptedPasword);
            user.setRole(role);

            utilisateurRepository.saveUser(user);
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
                    utilisateurRepository.saveInfirmier(infirmier);
                    break;
                case GENERALISTE:
                    int exeperience = Integer.parseInt(req.getParameter("experience_gen"));
                    double tarif = Double.parseDouble(req.getParameter("tarifConsultation"));
                    Generalist generalist = new Generalist();
                    generalist.setExperience(exeperience);
                    generalist.setTarif(tarif);
                    generalist.setUtilisateur(user);
                    utilisateurRepository.saveGeneralist(generalist);
                    break;
                case SPECIALISTE :
                    int exeperienceSpec = Integer.parseInt(req.getParameter("experience_spec"));
                    double tarifSpec = Double.parseDouble(req.getParameter("tarif"));
                    String specialite = req.getParameter("specialite");
                    Specialiste specialiste = new Specialiste();
                    specialiste.setExperience(exeperienceSpec);
                    specialiste.setTarif(tarifSpec);
                    specialiste.setUtilisateur(user);
                    specialiste.setSpecialiste(specialite);
                    utilisateurRepository.saveSpecialiste(specialiste);
                    break;
                default:
                    System.out.println("choose something else ");
            }
            req.getRequestDispatcher("/WEB-INF/views/Login.jsp").forward(req,resp);
        }catch (Exception e){
            e.printStackTrace();
            resp.getWriter().write("Erreur inserting patient : " + e.getMessage());
        }
    }
}
