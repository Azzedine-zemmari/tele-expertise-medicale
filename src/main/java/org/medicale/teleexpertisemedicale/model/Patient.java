package org.medicale.teleexpertisemedicale.model;

import javax.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Entity
@Table(name = "Patient")
public class Patient {
    @Id
    @GeneratedValue
    @Column(columnDefinition = "uuid")
    private UUID id;

    private String nom;

    private String prenom;

    private String mutuelle;

    private String address;

    private String num_securite_social;

    private LocalDateTime date_arrive;

    @OneToMany(mappedBy = "patient")
    private List<SigneVital> signesVitaux;

    @OneToOne(mappedBy = "patient")
    private DossierMedical dossierMedical;

    @Column(name = "cin", unique = true)
    private String CIN;

    private String Status_patient ;

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

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getPrenom() {
        return prenom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public LocalDateTime getDate_arrive() {
        return date_arrive;
    }

    public void setDate_arrive(LocalDateTime date_arrive) {
        this.date_arrive = date_arrive;
    }

    public List<SigneVital> getSignesVitaux() {
        return signesVitaux;
    }

    public void setSignesVitaux(List<SigneVital> signesVitaux) {
        this.signesVitaux = signesVitaux;
    }

    public DossierMedical getDossierMedical() {
        return dossierMedical;
    }

    public void setDossierMedical(DossierMedical dossierMedical) {
        this.dossierMedical = dossierMedical;
    }

    public String getStatus_patient() {
        return Status_patient;
    }

    public void setStatus_patient(String status_patient) {
        this.Status_patient = status_patient;
    }
}
