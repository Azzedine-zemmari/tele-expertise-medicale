package org.medicale.teleexpertisemedicale.repository;

import org.medicale.teleexpertisemedicale.model.SigneVital;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.transaction.Transactional;
import java.util.UUID;

public class SigneVitalRepository {
    private final EntityManagerFactory entityManagerFactory;
    public SigneVitalRepository(EntityManagerFactory entityManagerFactory) {
        this.entityManagerFactory = entityManagerFactory;
    }

    @Transactional
    public void save(SigneVital signeVital) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try{
            entityManager.getTransaction().begin();
            entityManager.persist(signeVital);
            entityManager.getTransaction().commit();
        } catch (Exception e) {
            entityManager.getTransaction().rollback();
            throw new RuntimeException(e);
        }finally {
            entityManager.close();
        }
    }
    public SigneVital getSigneVital(UUID id) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try{
            return entityManager.find(SigneVital.class,id);
        }finally {
            entityManager.close();
        }
    }
}
