package org.medicale.teleexpertisemedicale.repository;

import org.medicale.teleexpertisemedicale.model.Patient;
import org.medicale.teleexpertisemedicale.model.StatusConsultation;

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
    public List<Patient> findPatientWithStatusConsultationAttente(){
        EntityManager em = entityManagerFactory.createEntityManager();
        try{
            return em.createQuery(
                            "SELECT distinct dm.patient FROM Consultation c " +
                                    "JOIN c.dossierMedical dm " +
                                    "JOIN dm.patient " +
                                    "WHERE c.status_consultation = :status",
                            Patient.class
                    )
                    .setParameter("status", StatusConsultation.EN_ATTENTE)
                    .getResultList();
        }finally {
            em.close();
        }
    }
    public List<Patient> findPatientWithConsultationToday(){
        EntityManager em = entityManagerFactory.createEntityManager();
        try{
            return em.createQuery(
                    "SELECT  distinct dm.patient FROM Consultation c " +
                            "JOIN c.dossierMedical dm " +
                            "JOIN dm.patient " +
                            "WHERE c.date = :date", Patient.class
            ).setParameter("date", LocalDate.now()).getResultList();
        }finally {
            em.close();
        }
    }

    public List<Patient> findPatientStatus(){
        EntityManager em = entityManagerFactory.createEntityManager();
        try{
            return  em.createQuery(
                    "SELECT dm.patient FROM Consultation c " +
                            "JOIN c.dossierMedical dm " +
                            "JOIN dm.patient ",
                    Patient.class
            ).getResultList();
        }finally {
            em.close();
        }
    }
    public List<Patient> findPatientDateArriveToday(){
        EntityManager em = entityManagerFactory.createEntityManager();
        try{
            return em.createQuery("SELECT DISTINCT p from Patient  p JOIN FETCH p.dossierMedical dm join fetch p.signesVitaux sn  Where p.date_arrive = :date", Patient.class)
                    .setParameter("date", LocalDate.now())
                    .getResultList();
        }finally {
            em.close();
        }
    }
}
