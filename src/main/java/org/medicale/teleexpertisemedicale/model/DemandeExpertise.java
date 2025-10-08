package org.medicale.teleexpertisemedicale.model;

import javax.persistence.*;
import java.time.LocalDate;
import java.util.UUID;

@Entity
@Table(name = "DemandeExpertise")
public class DemandeExpertise {

    @Id
    @Column(columnDefinition = "uuid")
    private UUID id;

    @Column(name = "date_demand")
    private LocalDate dateDemand;

    private String question;

    private String priority;

    @Enumerated(EnumType.STRING)
    @Column(name = "status_expertise")
    private StatusExperitse statusExpertise;

    private String avis;

    @Column(name = "date_avis")
    private LocalDate dateAvis;

    //  One-to-one with Consultation
    @OneToOne
    @JoinColumn(name = "consultation_id", unique = true)
    private Consultation consultation;

    //  One-to-one with Specialiste
    @OneToOne
    @JoinColumn(name = "speciality_id", unique = true)
    private Specialiste specialiste;

    //  Constructors
    public DemandeExpertise() {}

    //  Getters & Setters
    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public LocalDate getDateDemand() {
        return dateDemand;
    }

    public void setDateDemand(LocalDate dateDemand) {
        this.dateDemand = dateDemand;
    }

    public String getQuestion() {
        return question;
    }

    public void setQuestion(String question) {
        this.question = question;
    }

    public String getPriority() {
        return priority;
    }

    public void setPriority(String priority) {
        this.priority = priority;
    }

    public StatusExperitse getStatusExpertise() {
        return statusExpertise;
    }

    public void setStatusExpertise(StatusExperitse statusExpertise) {
        this.statusExpertise = statusExpertise;
    }

    public String getAvis() {
        return avis;
    }

    public void setAvis(String avis) {
        this.avis = avis;
    }

    public LocalDate getDateAvis() {
        return dateAvis;
    }

    public void setDateAvis(LocalDate dateAvis) {
        this.dateAvis = dateAvis;
    }

    public Consultation getConsultation() {
        return consultation;
    }

    public void setConsultation(Consultation consultation) {
        this.consultation = consultation;
    }

    public Specialiste getSpecialiste() {
        return specialiste;
    }

    public void setSpecialiste(Specialiste specialiste) {
        this.specialiste = specialiste;
    }
}
