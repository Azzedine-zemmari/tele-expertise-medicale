package org.medicale.teleexpertisemedicale.repository;

import org.medicale.teleexpertisemedicale.model.Patient;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;
import java.util.List;
import java.util.UUID;

public class PatientRepository {
    @PersistenceContext
    private EntityManager em;

    @Transactional
    public void save(Patient p){
        em.persist(p);
    }

    public Patient findById(UUID id){
        return  em.find(Patient.class,id);
    }

    public List<Patient> findAll(){
        return em.createQuery("SELECT p FROM Patient p",Patient.class).getResultList();
    }

    @Transactional
    public void delete(Patient p){
        em.remove(em.contains(p) ? p : em.merge(p));
    }

}
