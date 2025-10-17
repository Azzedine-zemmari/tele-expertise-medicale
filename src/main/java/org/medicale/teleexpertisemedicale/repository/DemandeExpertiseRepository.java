package org.medicale.teleexpertisemedicale.repository;

import org.medicale.teleexpertisemedicale.model.DemandeExpertise;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;

public class DemandeExpertiseRepository {
    private final EntityManagerFactory emf;
    public DemandeExpertiseRepository(EntityManagerFactory emf) {
        this.emf = emf;
    }

    public void save(DemandeExpertise demande) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(demande);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

}
