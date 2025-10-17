package org.medicale.teleexpertisemedicale.repository;

import org.medicale.teleexpertisemedicale.model.Generalist;
import org.medicale.teleexpertisemedicale.model.Infirmier;
import org.medicale.teleexpertisemedicale.model.Specialiste;
import org.medicale.teleexpertisemedicale.model.Utilisateur;

import javax.persistence.Entity;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;
import java.util.List;
import java.util.UUID;

public class UtilisateurRepository {
    private final EntityManagerFactory entityManagerFactory;

    public UtilisateurRepository(EntityManagerFactory emf){
        this.entityManagerFactory = emf;
    }

    @Transactional
    public void saveGeneralist(Generalist g){
        EntityManager em  = entityManagerFactory.createEntityManager();
        try{
            em.getTransaction().begin();
            em.persist(g);
            em.getTransaction().commit();
        }catch (Exception e){
            em.getTransaction().rollback();
            e.getMessage();
        }finally {
            em.close();
        }
    }    @Transactional
    public void saveInfirmier(Infirmier i){
        EntityManager em  = entityManagerFactory.createEntityManager();
        try{
            em.getTransaction().begin();
            em.persist(i);
            em.getTransaction().commit();
        }catch (Exception e){
            em.getTransaction().rollback();
            e.getMessage();
        }finally {
            em.close();
        }
    }    @Transactional
    public void saveSpecialiste(Specialiste s){
        EntityManager em  = entityManagerFactory.createEntityManager();
        try{
            em.getTransaction().begin();
            em.persist(s);
            em.getTransaction().commit();
        }catch (Exception e){
            em.getTransaction().rollback();
            e.getMessage();
        }finally {
            em.close();
        }
    }
    public void saveUser(Utilisateur u){
        EntityManager em  = entityManagerFactory.createEntityManager();
        try{
            em.getTransaction().begin();
            em.persist(u);
            em.getTransaction().commit();
        }catch (Exception e){
            em.getTransaction().rollback();
            e.getMessage();
        }finally {
            em.close();
        }
    }

    public Specialiste findByUser(UUID id){
        EntityManager em = entityManagerFactory.createEntityManager();
        try{
            return em.createQuery("SELECT S from Specialiste S where S.utilisateur.id  = :id",Specialiste.class).setParameter("id", id).getSingleResult();
        }finally {
            em.close();
        }
    }
    public List<Generalist> findAll(){
        EntityManager em = entityManagerFactory.createEntityManager();
        try{
        return em.createQuery("SELECT G FROM Generalist G",Generalist.class).getResultList();
        }finally {
            em.close();
        }
    }
    public Utilisateur findByEmail(String email){
        EntityManager em = entityManagerFactory.createEntityManager();
        try{
            return em.createQuery("SELECT u FROM Utilisateur u WHERE u.email = :email",Utilisateur.class)
                    .setParameter("email",email)
                    .getSingleResult();
        }finally {
            em.close();
        }
    }

    @Transactional
    public void delete(Generalist g){
        EntityManager em = entityManagerFactory.createEntityManager();
        try {
            em.remove(em.contains(g) ? g : em.merge(g));
        }finally {
            em.close();
        }
    }
}
