package org.medicale.teleexpertisemedicale.model;

import javax.persistence.*;
import java.util.UUID;

@Entity
@Table(name = "generalist")
public class Generalist {
    @Id
    @GeneratedValue
    @Column(columnDefinition = "uuid")
    private UUID id;

    private int experience;
    private double tarifConsultation;

    @OneToOne
    @JoinColumn(name = "user_id")
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
