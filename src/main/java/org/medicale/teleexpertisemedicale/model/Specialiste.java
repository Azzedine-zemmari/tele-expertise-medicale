package org.medicale.teleexpertisemedicale.model;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Entity
@Table(name = "specialiste")
public class Specialiste {
    @Id
    @GeneratedValue
    @Column(columnDefinition = "uuid")
    private UUID id;

    private int experience;
    private double tarif;

    @OneToOne
    @JoinColumn(name = "user_id")
    private Utilisateur utilisateur;

    private String specialiste;

    @OneToMany(mappedBy = "specialiste")
    private List<Creneu> creneaux = new ArrayList<>();

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
        return tarif;
    }

    public void setTarif(double tarif) {
        this.tarif = tarif;
    }

    public Utilisateur getUtilisateur() {
        return utilisateur;
    }

    public void setUtilisateur(Utilisateur utilisateur) {
        this.utilisateur = utilisateur;
    }

    public String getSpecialiste() {
        return specialiste;
    }

    public void setSpecialiste(String specialiste) {
        this.specialiste = specialiste;
    }
    public List<Creneu> getCreneaux() {
        return creneaux;
    }

    public void setCreneaux(List<Creneu> creneaux) {
        this.creneaux = creneaux;
    }
}
