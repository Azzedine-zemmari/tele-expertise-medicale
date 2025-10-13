package org.medicale.teleexpertisemedicale.repository;

import org.medicale.teleexpertisemedicale.model.DossierMedical;
import org.medicale.teleexpertisemedicale.model.Patient;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;
import java.util.List;
import java.util.UUID;

public class DossierMedicalRepository {
    private final EntityManagerFactory entityManagerFactory;


    public DossierMedicalRepository(EntityManagerFactory emf){
        this.entityManagerFactory = emf;
    }
    @Transactional
    public void save(DossierMedical d){
        EntityManager em = entityManagerFactory.createEntityManager();
        try{
            em.getTransaction().begin();
            em.persist(d);
            em.getTransaction().commit();
        }catch (Exception e){
            em.getTransaction().rollback();
            e.printStackTrace();
        }finally {
            em.close();
        }
    }

    public DossierMedical findById(UUID id){
        EntityManager em = entityManagerFactory.createEntityManager();
        try{
            return em.find(DossierMedical.class,id);
        }finally {
            em.close();
        }
    }

    public Patient findPatientById(UUID id){
        EntityManager em = entityManagerFactory.createEntityManager();
        try {
            return em.find(Patient.class, id);
        }
        finally {
            em.close();
        }
    }

    public List<DossierMedical> findAll(){
        EntityManager em = entityManagerFactory.createEntityManager();
        try{
            return em.createQuery("SELECT d FROM DossierMedical d",DossierMedical.class).getResultList();
        }finally {
            em.close();
        }
    }
    @Transactional
    public void delete(DossierMedical d){
        EntityManager em = entityManagerFactory.createEntityManager();
        try{
            em.getTransaction().begin();
            em.remove(em.contains(d) ? d : em.merge(d));
            em.getTransaction().commit();
        }catch (Exception e){
            em.getTransaction().rollback();
            e.printStackTrace();
        }finally {
            em.close();
        }
    }

    public List<Patient> getAllPatients(){
        EntityManager em = entityManagerFactory.createEntityManager();
        try{
            return em.createQuery("SELECT p From Patient p", Patient.class).getResultList();
        }finally {
            em.close();
        }
    }
}
