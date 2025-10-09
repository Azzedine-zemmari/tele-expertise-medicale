package org.medicale.teleexpertisemedicale.repository;

import org.medicale.teleexpertisemedicale.model.Generalist;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;
import java.util.List;
import java.util.UUID;

public class UtilisateurRepository {
    @PersistenceContext
    private EntityManager em;

    @Transactional
    public void save(Generalist g){
        em.persist(g);
    }
    public Generalist findById(UUID id){
        return em.find(Generalist.class,id);
    }
    public List<Generalist> findAll(){
        return em.createQuery("SELECT G FROM Generalist G",Generalist.class).getResultList();
    }

    @Transactional
    public void delete(Generalist g){
        em.remove(em.contains(g) ? g : em.merge(g));
    }
}
