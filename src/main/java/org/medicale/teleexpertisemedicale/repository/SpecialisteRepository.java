package org.medicale.teleexpertisemedicale.repository;

import org.medicale.teleexpertisemedicale.model.Specialiste;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import java.util.List;
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
}
