package org.medicale.teleexpertisemedicale.controller;

import org.jasypt.util.password.StrongPasswordEncryptor;
import org.medicale.teleexpertisemedicale.model.Role;
import org.medicale.teleexpertisemedicale.model.Utilisateur;
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

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private EntityManagerFactory emf;
    private UtilisateurRepository utilisateurRepository;
    private static final StrongPasswordEncryptor passwordEncryptor = new StrongPasswordEncryptor();
    @Override
    public void init(){
        EntityManagerFactory emf = (EntityManagerFactory)  getServletContext().getAttribute("emf");
        utilisateurRepository = new UtilisateurRepository(emf);
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
            String storedPassord = user.getPassword();
            if(user != null){
                if(passwordEncryptor.checkPassword(password,storedPassord)){
                    // store user in session
                    req.getSession().setAttribute("loggedUser",user);
                    if(user.getRole().equals(Role.SPECIALISTE)){
                        req.getSession().setAttribute("specialiste",utilisateurRepository.findByUser(user.getId()));
                    }
                    req.getSession().setAttribute("roleUser" , user.getRole());
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
