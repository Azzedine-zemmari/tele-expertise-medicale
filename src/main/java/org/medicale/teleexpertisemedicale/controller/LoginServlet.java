package org.medicale.teleexpertisemedicale.controller;

import org.jasypt.util.password.StrongPasswordEncryptor;
import org.medicale.teleexpertisemedicale.model.Utilisateur;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "loginServlet" , value = "/login")
public class LoginServlet extends HttpServlet {
    private EntityManagerFactory emf;
    private static final StrongPasswordEncryptor passwordEncryptor = new StrongPasswordEncryptor();
    @Override
    public void init() throws ServletException{
        emf = Persistence.createEntityManagerFactory("myPU");
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/Login.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        EntityManager em = emf.createEntityManager();

        try{
            Utilisateur user = em.createQuery("SELECT u FROM Utilisateur u WHERE u.email = :email",Utilisateur.class)
                    .setParameter("email",email)
                    .getSingleResult();
            String storedPassord = user.getPassword();
            if(user != null){
                if(passwordEncryptor.checkPassword(password,storedPassord)){
                    // store user in session
                    req.getSession().setAttribute("loggedUser",user);
                    // Forwared
                    resp.setContentType("text/plain");
                    resp.getWriter().write("User logged in successfully!" + req.getSession());                }
            }
            else{
                req.setAttribute("error","invalid email or password");
                req.getRequestDispatcher("/WEB-INF/views/Login.jsp").forward(req, resp);
            }
        }catch (Exception e){
            req.setAttribute("error","invalid email or password");
            req.getRequestDispatcher("/WEB-INF/views/Login.jsp").forward(req, resp);
        }finally {
            em.close();
        }

    }
}
