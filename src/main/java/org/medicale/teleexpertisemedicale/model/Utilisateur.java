package org.medicale.teleexpertisemedicale.model;

import javax.persistence.*;
import java.util.UUID;

@Entity
@Table(name="Utilisateur")
@Inheritance(strategy = InheritanceType.JOINED)
public class Utilisateur {
    @Id
    @GeneratedValue
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
//    @Column(columnDefinition = "role")
    private Role role;

    public UUID getId(){
        return  this.id;
    }
    public void setId(UUID id){
        this.id = id;
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

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }
}
