package org.medicale.teleexpertisemedicale.model;

import javax.persistence.*;
import java.util.UUID;

@Entity
@Table(name = "Patient")
public class Patient {
    @Id
    @Column(columnDefinition = "uuid")
    private UUID id;

    private String mutuelle;

    private String address;

    private String num_securite_social;

    private String CIN;

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

    public String getMutuelle() {
        return mutuelle;
    }

    public void setMutuelle(String mutuelle) {
        this.mutuelle = mutuelle;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getNum_securite_social() {
        return num_securite_social;
    }

    public void setNum_securite_social(String num_securite_social) {
        this.num_securite_social = num_securite_social;
    }

    public String getCIN() {
        return CIN;
    }

    public void setCIN(String CIN) {
        this.CIN = CIN;
    }

    public Utilisateur getUtilisateur() {
        return utilisateur;
    }

    public void setUtilisateur(Utilisateur utilisateur) {
        this.utilisateur = utilisateur;
    }
}
