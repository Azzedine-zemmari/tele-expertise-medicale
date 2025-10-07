package org.medicale.teleexpertisemedicale.model;

import javax.persistence.*;
import java.util.UUID;

@Entity
@Table(name = "Infirmier")
public class Infirmier {
    @Id
    @Column(columnDefinition = "uuid")
    private UUID id;

    private String service;

    @Enumerated(EnumType.STRING)
    private Shift shift;

    private int experience;

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

    public String getService() {
        return service;
    }

    public void setService(String service) {
        this.service = service;
    }

    public Shift getShift() {
        return shift;
    }

    public void setShift(Shift shift) {
        this.shift = shift;
    }

    public int getExperience() {
        return experience;
    }

    public void setExperience(int experience) {
        this.experience = experience;
    }

    public Utilisateur getUtilisateur() {
        return utilisateur;
    }

    public void setUtilisateur(Utilisateur utilisateur) {
        this.utilisateur = utilisateur;
    }
}
