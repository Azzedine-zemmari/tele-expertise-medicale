package org.medicale.teleexpertisemedicale.repository;

import org.medicale.teleexpertisemedicale.model.Specialiste;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

public class SpecialisteRepository {
    private EntityManagerFactory emf;
    public SpecialisteRepository(EntityManagerFactory emf){
        this.emf = emf;
    }

    public List<Specialiste> rechercheSpecialParTarifEtParSpecialite(String specialite , double tarif){
        EntityManager em = emf.createEntityManager();
        List<Specialiste> specialistes = em.createQuery("SELECT s FROM Specialiste s",Specialiste.class).getResultList();
        return specialistes.stream()
                .filter(specialiste -> Double.compare(specialiste.getTarif(),tarif) == 0)
                .filter(specialiste -> specialiste.getSpecialiste().equalsIgnoreCase(specialite))
                .collect(Collectors.toList());
    }
    public Specialiste findByID(UUID id){
        EntityManager em = emf.createEntityManager();
        try{
            return em.find(Specialiste.class, id);
        }finally{
            em.close();
        }
    }
}
