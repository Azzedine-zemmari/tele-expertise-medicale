package org.medicale.teleexpertisemedicale.repository;

import org.medicale.teleexpertisemedicale.model.Patient;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;
import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

public class PatientRepository {

    private final EntityManagerFactory entityManagerFactory;
    public PatientRepository(EntityManagerFactory emf){
        this.entityManagerFactory = emf;
    }
    @Transactional
    public void save(Patient p){
        EntityManager em = entityManagerFactory.createEntityManager();
        try{
            em.getTransaction().begin();
            em.persist(p);
            em.getTransaction().commit();
        }catch (Exception e){
            em.getTransaction().rollback();
            e.getMessage();
        }finally {
            em.close();
        }
    }

    public Patient findById(UUID id){
        EntityManager em = entityManagerFactory.createEntityManager();
        try{
        return  em.find(Patient.class,id);
        }finally {
            em.close();
        }
    }

    public List<Patient> findAll(){
        EntityManager em = entityManagerFactory.createEntityManager();
        try{
            return em.createQuery("SELECT p FROM Patient p",Patient.class).getResultList();
        }finally {
            em.close();
        }
    }

    @Transactional
    public void delete(Patient p){
        EntityManager em = entityManagerFactory.createEntityManager();
        try{
            em.getTransaction().begin();
            em.remove(em.contains(p) ? p : em.merge(p));
            em.getTransaction().commit();
        }catch (Exception e ){
            em.getTransaction().rollback();
            e.getMessage();
        }finally {
            em.close();
        }
    }

}
