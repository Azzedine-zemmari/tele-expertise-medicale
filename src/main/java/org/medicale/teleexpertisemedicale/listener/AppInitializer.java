package org.medicale.teleexpertisemedicale.listener;

import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

@WebListener
public class AppInitializer  implements ServletContextListener {
    private EntityManagerFactory emf;

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        emf = Persistence.createEntityManagerFactory("myPU");
        sce.getServletContext().setAttribute("emf",emf);
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        if(emf != null){
            emf.close();
        }
    }
}
