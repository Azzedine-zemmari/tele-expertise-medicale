package org.medicale.teleexpertisemedicale.repository;


import org.medicale.teleexpertisemedicale.model.Consultation;
import org.medicale.teleexpertisemedicale.model.DossierMedical;
import org.medicale.teleexpertisemedicale.model.Generalist;
import org.medicale.teleexpertisemedicale.model.SigneVital;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import java.util.List;
import java.util.UUID;

public class ConsultationRepository {
    private EntityManagerFactory entityManagerFactory;
    public ConsultationRepository(EntityManagerFactory emf){
        this.entityManagerFactory = emf;
    }


    public List<Generalist> findAllGeneralist(){
        EntityManager em = entityManagerFactory.createEntityManager();
        try{
            return em.createQuery("SELECT g from Generalist g JOIN FETCH g.utilisateur" ,Generalist.class).getResultList();
        }finally {
            em.close();
        }
    }

    public List<DossierMedical> findAllDossierMedical(){
        EntityManager em = entityManagerFactory.createEntityManager();
        try{
            return em.createQuery("SELECT d from DossierMedical d JOIN FETCH d.patient").getResultList();
        }finally {
            em.close();
        }
    }

    public Generalist findGeneralistById(UUID id){
        EntityManager em = entityManagerFactory.createEntityManager();
        try{
            return em.find(Generalist.class, id);
        }finally {
            em.close();
        }
    }

    public DossierMedical findDossierMedicalById(UUID id){
        EntityManager em = entityManagerFactory.createEntityManager();
        try{
            return em.find(DossierMedical.class,id);
        }finally {
            em.close();
        }
    }

    public void saveConsultatinAndSigneVitaux(Consultation consultation , SigneVital sn){
        EntityManager em = entityManagerFactory.createEntityManager();
        try{
            em.getTransaction().begin();
            em.persist(consultation);
            em.persist(sn);
            em.getTransaction().commit();
        }catch (Exception e){
            if(em.getTransaction().isActive()){
                em.getTransaction().rollback();
                e.getMessage();
            }
        }finally {
            em.close();
        }
    }
    public void saveConsultation(Consultation consultation){
        EntityManager em = entityManagerFactory.createEntityManager();
        try{
            em.getTransaction().begin();
            em.persist(consultation);
            em.getTransaction().commit();
        }catch (Exception e){
            if(em.getTransaction().isActive()){
                em.getTransaction().rollback();
                e.getMessage();
            }
        }finally {
            em.close();
        }
    }

    public List<Consultation> getAllConsultationWithMoreDetails(){
        EntityManager em = entityManagerFactory.createEntityManager();
        try{
            return em.createQuery("SELECT c FROM Consultation c JOIN FETCH c.dossierMedical JOIN FETCH c.generalist").getResultList();
        }finally {
            em.close();
        }
    }

    public Consultation findById(UUID id){
        EntityManager em = entityManagerFactory.createEntityManager();
        try{
            return em.createQuery("SELECT c from Consultation c where id = :id", Consultation.class).setParameter("id", id).getSingleResult();
        }finally {
            em.close();
        }
    }
    public void updateCount(double count , UUID consultationId){
        EntityManager em = entityManagerFactory.createEntityManager();
        try{
            em.getTransaction().begin();
            em.createQuery("UPDATE Consultation c SET c.count = :count WHERE c.id = :id")
                .setParameter("count", count)
                .setParameter("id", consultationId)
                .executeUpdate();
            em.getTransaction().commit();
        }catch (Exception e){
            if(em.getTransaction().isActive()){
                em.getTransaction().rollback();
                e.getMessage();
            }
        }finally {
            em.close();
        }
    }
}
