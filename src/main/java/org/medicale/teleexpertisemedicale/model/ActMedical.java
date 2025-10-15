package org.medicale.teleexpertisemedicale.model;

import javax.persistence.*;
import java.util.List;
import java.util.UUID;

@Entity
@Table(name = "actemidical")
public class ActMedical {
    @Id
    @GeneratedValue
    @Column(columnDefinition = "uuid")
    private UUID id;

    @Enumerated(EnumType.STRING)
    private TypeAct typeAct;

    private double count;

    @ManyToOne
    @JoinColumn(name = "consultation_id")
    private Consultation consultation;

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public TypeAct getTypeAct() {
        return typeAct;
    }

    public void setTypeAct(TypeAct typeAct) {
        this.typeAct = typeAct;
    }

    public double getCount() {
        return count;
    }

    public void setCount(double count) {
        this.count = count;
    }

    public Consultation getConsultation() {
        return consultation;
    }

    public void setConsultation(Consultation consultation) {
        this.consultation = consultation;
    }
}
