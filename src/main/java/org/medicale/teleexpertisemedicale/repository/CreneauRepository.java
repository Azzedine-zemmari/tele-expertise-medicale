package org.medicale.teleexpertisemedicale.repository;

import org.medicale.teleexpertisemedicale.model.Creneu;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;

public class CreneauRepository {
   private final EntityManagerFactory emf;
   public CreneauRepository(EntityManagerFactory emf) {
       this.emf = emf;
   }
   public void save(Creneu creneu) {
       EntityManager em = emf.createEntityManager();
       try{
           em.getTransaction().begin();
           em.persist(creneu);
           em.getTransaction().commit();
       }catch (Exception e) {
           em.getTransaction().rollback();
           e.printStackTrace();
       }finally {
           em.close();
       }
   }
}
