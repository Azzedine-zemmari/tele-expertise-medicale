package org.medicale.teleexpertisemedicale.model;

import javax.persistence.*;
import java.time.LocalDate;
import java.util.Date;
import java.util.UUID;

@Entity
@Table(name="SigneVital")
public class SigneVital {
    @Id
    @GeneratedValue
    @Column(columnDefinition = "uuid")
    private UUID id;

    private double tension;

    private double frequenceCardiaque;

    private int temperature;

    private double poids ;

    private LocalDate date_mesure;

    @OneToOne
    @JoinColumn(name = "consultation_id",unique = true)
    private Consultation consultation;

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public double getTension() {
        return tension;
    }

    public void setTension(double tension) {
        this.tension = tension;
    }

    public double getFrequenceCardiaque() {
        return frequenceCardiaque;
    }

    public void setFrequenceCardiaque(double frequenceCardiaque) {
        this.frequenceCardiaque = frequenceCardiaque;
    }

    public int getTemperature() {
        return temperature;
    }

    public void setTemperature(int temperature) {
        this.temperature = temperature;
    }

    public double getPoids() {
        return poids;
    }

    public void setPoids(double poids) {
        this.poids = poids;
    }

    public LocalDate getDate_mesure() {
        return date_mesure;
    }

    public void setDate_mesure(LocalDate date_mesure) {
        this.date_mesure = date_mesure;
    }

    public Consultation getConsultation() {
        return consultation;
    }

    public void setConsultation(Consultation consultation) {
        this.consultation = consultation;
    }
}
