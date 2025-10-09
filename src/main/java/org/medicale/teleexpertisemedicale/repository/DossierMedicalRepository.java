package org.medicale.teleexpertisemedicale.repository;

import org.medicale.teleexpertisemedicale.model.DossierMedical;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;
import java.util.List;
import java.util.UUID;

public class DossierMedicalRepository {
    @PersistenceContext
    private EntityManager em;

    @Transactional
    public void save(DossierMedical d){
        em.persist(d);
    }

    public DossierMedical findById(UUID id){
        return em.find(DossierMedical.class,id);
    }

    public List<DossierMedical> findAll(){
        return em.createQuery("SELECT d FROM DossierMedical d",DossierMedical.class).getResultList();
    }
    @Transactional
    public void delete(DossierMedical d){
        em.remove(em.contains(d) ? d : em.merge(d));
    }
}
