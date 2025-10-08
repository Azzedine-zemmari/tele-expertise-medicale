package org.medicale.teleexpertisemedicale.model;

import javax.persistence.*;
import java.time.LocalDate;
import java.util.Locale;
import java.util.UUID;

@Entity
@Table(name = "Consultation")
public class Consultation {
    @Id
    @Column(columnDefinition = "uuid")
    private UUID id;

    @ManyToOne
    @JoinColumn(name = "generalist_id")
    private Generalist generalist;

    @ManyToOne
    @JoinColumn(name = "dossier_medical_id")
    private DossierMedical dossierMedical;

    private LocalDate date;

    private String motif;

    private String diagnostique;

    private String traitement;

    private Integer count;

    private StatusConsultation status_consultation;

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public Generalist getGeneralist() {
        return generalist;
    }

    public void setGeneralist(Generalist generalist) {
        this.generalist = generalist;
    }

    public DossierMedical getDossierMedical() {
        return dossierMedical;
    }

    public void setDossierMedical(DossierMedical dossierMedical) {
        this.dossierMedical = dossierMedical;
    }

    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

    public String getMotif() {
        return motif;
    }

    public void setMotif(String motif) {
        this.motif = motif;
    }

    public String getDiagnostique() {
        return diagnostique;
    }

    public void setDiagnostique(String diagnostique) {
        this.diagnostique = diagnostique;
    }

    public String getTraitement() {
        return traitement;
    }

    public void setTraitement(String traitement) {
        this.traitement = traitement;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

    public StatusConsultation getStatus_consultation() {
        return status_consultation;
    }

    public void setStatus_consultation(StatusConsultation status_consultation) {
        this.status_consultation = status_consultation;
    }
}
