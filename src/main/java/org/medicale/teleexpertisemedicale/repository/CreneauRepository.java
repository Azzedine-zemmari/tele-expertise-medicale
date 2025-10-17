package org.medicale.teleexpertisemedicale.repository;

import org.medicale.teleexpertisemedicale.model.Creneu;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import java.util.List;
import java.util.UUID;

public class CreneauRepository {
    private final EntityManagerFactory emf;

    public CreneauRepository(EntityManagerFactory emf) {
        this.emf = emf;
    }

    public void save(Creneu creneu) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(creneu);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    public List<Creneu> findCreneauBySpecialisteId(UUID specialisteId) {
        EntityManager em = emf.createEntityManager();
        return em.createQuery("SELECT C from Creneu C WHERE C.specialiste.id = :specialisteId and C.disponibilite=true").setParameter("specialisteId", specialisteId).getResultList();
    }

    public Creneu findCreneauById(UUID id) {
        EntityManager em = emf.createEntityManager();
        return em.find(Creneu.class, id);
    }

    public void UpdateCreneauStatus(UUID id) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        em.createQuery("UPDATE Creneu c set c.disponibilite = false where c.id = :id").setParameter("id", id).executeUpdate();
        em.getTransaction().commit();
    }
}
