package org.medicale.teleexpertisemedicale.model;

import javax.persistence.*;
import java.util.UUID;

@Entity
@Table(name="Utilisateur")
@Inheritance(strategy = InheritanceType.JOINED)
public class Utilisateur {
    @Id
    @Column(columnDefinition = "uuid")
    private UUID id;

    @Column(length = 20)
    private String nom;

    @Column(length = 20)
    private String prenom;

    @Column(length = 60 , unique = true)
    private String email;

    @Column(length = 60)
    private String password;

    @Enumerated(EnumType.STRING)
    private Role role;
}
