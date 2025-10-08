package org.medicale.teleexpertisemedicale.model;

import javax.persistence.*;
import java.util.UUID;

@Entity
@Table(name = "Generalist")
public class Generalist {
    @Id
    @Column(columnDefinition = "uuid")
    private UUID id;

    private int experience;
    private double tarifConsultation;

    @OneToOne
    @MapsId
    @JoinColumn(name = "id")
    private Utilisateur utilisateur;

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public int getExperience() {
        return experience;
    }

    public void setExperience(int experience) {
        this.experience = experience;
    }

    public double getTarif() {
        return tarifConsultation;
    }

    public void setTarif(double tarif) {
        this.tarifConsultation = tarif;
    }

    public Utilisateur getUtilisateur() {
        return utilisateur;
    }

    public void setUtilisateur(Utilisateur utilisateur) {
        this.utilisateur = utilisateur;
    }
}
