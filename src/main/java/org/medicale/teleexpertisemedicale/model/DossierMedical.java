package org.medicale.teleexpertisemedicale.model;

import javax.persistence.*;
import java.util.UUID;

@Entity
@Table(name = "DossierMedical")
public class DossierMedical {
    @Id
    @GeneratedValue
    private UUID id;

    @OneToOne
    @JoinColumn(name = "patient_id",unique = true)
    private Patient patient;

    @Column(name = "blood_type",length = 3)
    private String bloodType;

    @Column(columnDefinition = "TEXT")
    private String allergies;

    @Column(columnDefinition = "TEXT")
    private String medications;

    @Column(columnDefinition = "TEXT")
    private String pastSurgeries;

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public Patient getPatient() {
        return patient;
    }

    public void setPatient(Patient patient) {
        this.patient = patient;
    }

    public String getBloodType() {
        return bloodType;
    }

    public void setBloodType(String bloodType) {
        this.bloodType = bloodType;
    }

    public String getAllergies() {
        return allergies;
    }

    public void setAllergies(String allergies) {
        this.allergies = allergies;
    }

    public String getMedications() {
        return medications;
    }

    public void setMedications(String medications) {
        this.medications = medications;
    }

    public String getPastSurgeries() {
        return pastSurgeries;
    }

    public void setPastSurgeries(String pastSurgeries) {
        this.pastSurgeries = pastSurgeries;
    }
}
