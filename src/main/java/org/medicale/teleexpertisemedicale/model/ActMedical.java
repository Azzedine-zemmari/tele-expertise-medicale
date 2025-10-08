package org.medicale.teleexpertisemedicale.model;

import javax.persistence.*;
import java.util.List;
import java.util.UUID;

@Entity
@Table(name = "ActeMidical")
public class ActMedical {
    @Id
    @Column(columnDefinition = "uuid")
    private UUID id;

    @Enumerated(EnumType.STRING)
    private TypeAct typeAct;

    private double count;

    @OneToMany(mappedBy = "ActeMidical")
    private List<Consultation> consultations;

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

    public List<Consultation> getConsultations() {
        return consultations;
    }

    public void setConsultations(List<Consultation> consultations) {
        this.consultations = consultations;
    }
}
