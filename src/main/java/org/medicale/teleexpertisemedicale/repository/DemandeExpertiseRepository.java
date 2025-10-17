package org.medicale.teleexpertisemedicale.repository;

import org.medicale.teleexpertisemedicale.model.DemandeExpertise;
import org.medicale.teleexpertisemedicale.model.StatusExperitse;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.NoResultException;
import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

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
    public List<DemandeExpertise> findAllDemandeExpertiseForSpecialiste(UUID specialistId) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        List<DemandeExpertise> demandeExpertiseList = em.createQuery("select de from DemandeExpertise de JOIN FETCH de.consultation C JOIN FETCH C.dossierMedical d where de.specialiste.id = :id ").setParameter("id",specialistId).getResultList();
        em.getTransaction().commit();
        return demandeExpertiseList;
    }

    public List<DemandeExpertise> FilterDemandeExpertiseForSpecialisteBYSTATUSANDPRIORITE(UUID specialistId , StatusExperitse statusExperitse , String priority) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        List<DemandeExpertise> demandeExpertiseList = em.createQuery("select de from DemandeExpertise de JOIN FETCH de.consultation C JOIN FETCH C.dossierMedical d where de.specialiste.id = :id and de.statusExpertise = :statusExperitse and de.priority = :priority ")
                .setParameter("id",specialistId)
                .setParameter("statusExperitse",statusExperitse)
                .setParameter("priority",priority)
                .getResultList();
        em.getTransaction().commit();
        return demandeExpertiseList;
    }

    public DemandeExpertise findDetailsForDemandeExpertise(UUID id) {
        EntityManager em = emf.createEntityManager();
        try {
            return em.createQuery(
                            "SELECT de FROM DemandeExpertise de " +
                                    "JOIN FETCH de.consultation c " +
                                    "JOIN FETCH c.dossierMedical dm " +
                                    "WHERE de.id = :id", DemandeExpertise.class)
                    .setParameter("id", id)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }
    public DemandeExpertise findById(UUID id) {
        EntityManager em = emf.createEntityManager();
        return em.find(DemandeExpertise.class, id);
    }
    public void AddAvis(UUID demandeId, String avis, LocalDate dateAvis , StatusExperitse statusExpertise) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.createQuery("UPDATE DemandeExpertise d SET d.avis = :avis, d.dateAvis = :dateAvis, d.statusExpertise = :status WHERE d.id = :demandeId")
                    .setParameter("avis", avis)
                    .setParameter("dateAvis", dateAvis)
                    .setParameter("demandeId", demandeId)
                    .setParameter("status", statusExpertise)
                    .executeUpdate();
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }


}
