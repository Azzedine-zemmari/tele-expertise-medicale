package org.medicale.teleexpertisemedicale.controller;

import org.jasypt.util.password.StrongPasswordEncryptor;
import org.medicale.teleexpertisemedicale.model.Patient;
import org.medicale.teleexpertisemedicale.model.Role;
import org.medicale.teleexpertisemedicale.model.Utilisateur;
import org.medicale.teleexpertisemedicale.repository.PatientRepository;
import org.medicale.teleexpertisemedicale.repository.UtilisateurRepository;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private EntityManagerFactory emf;
    private UtilisateurRepository utilisateurRepository;
    private static final StrongPasswordEncryptor passwordEncryptor = new StrongPasswordEncryptor();
    private PatientRepository patientRepository;
    @Override
    public void init(){
        EntityManagerFactory emf = (EntityManagerFactory)  getServletContext().getAttribute("emf");
        utilisateurRepository = new UtilisateurRepository(emf);
        patientRepository  = new PatientRepository(emf);
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/Login.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        try{
            Utilisateur user = utilisateurRepository.findByEmail(email);
            if(user != null){
                String storedPassord = user.getPassword();
                if(passwordEncryptor.checkPassword(password,storedPassord)){
                    // store user in session
                    req.getSession().setAttribute("loggedUser",user);
                    req.getSession().setAttribute("roleUser" , user.getRole());
                    if(user.getRole().equals(Role.SPECIALISTE)){
                        req.getSession().setAttribute("specialiste",utilisateurRepository.findByUser(user.getId()));
                        req.getRequestDispatcher("/WEB-INF/views/Specialiste/ProfileSpecialiste.jsp").forward(req,resp);
                        return;
                    }
                    else if(user.getRole().equals(Role.GENERALISTE) || user.getRole().equals(Role.INFIRMIER)){
                        List<Patient> patients = patientRepository.findPatientDateArriveToday();
                        req.setAttribute("patients", patients);

                        // Forward to the JSP with the patients
                        req.getRequestDispatcher("/WEB-INF/views/FilleDattente.jsp").forward(req, resp);
                        return;
                    }
                    // Forwared
                    resp.setContentType("text/plain");
                    resp.sendRedirect(req.getContextPath() + "/dashboard");
                }
            }
            else{
                req.setAttribute("error","invalid email or password");
                req.getRequestDispatcher("/WEB-INF/views/Login.jsp").forward(req, resp);
            }
        }catch (Exception e){
            req.setAttribute("error","invalid email or password");
            req.getRequestDispatcher("/WEB-INF/views/Login.jsp").forward(req, resp);
        }

    }
}
// todo : specialiste imchi profile dylo fin i9dr i dir creneu o ijwb f avis
// todo : generalist imchi fille attente o i9dr idwz wach consultation ola demande avis zid lih statistics
// todo : infirmier dkhl patient signe viteau o act medical tl3 liha fille attente fiha status bach t3rf status dyl kola patient
// todo : figma
