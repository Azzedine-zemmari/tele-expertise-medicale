package org.medicale.teleexpertisemedicale.repository;

import org.medicale.teleexpertisemedicale.model.ActMedical;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;

public class ActMedicalRepository {
    private EntityManagerFactory entityManagerFactory;
    public ActMedicalRepository(EntityManagerFactory emf){
        this.entityManagerFactory = emf;
    }

    public void save(ActMedical actMedical){
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try{
            entityManager.getTransaction().begin();
            entityManager.persist(actMedical);
            entityManager.getTransaction().commit();
        }catch (Exception e){
            e.getMessage();
            entityManager.getTransaction().rollback();
        }finally {
            entityManager.close();
        }
    }
}
