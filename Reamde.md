# 🏥 Système de Télé-Expertise Médicale
Plateforme web permettant la collaboration à distance entre **médecins généralistes**, **spécialistes** et **infirmiers** afin d'améliorer le parcours patient et accélérer la prise en charge médicale.

---

## 📌 Contexte du Projet
Ce système optimise le parcours patient en facilitant la coordination entre les professionnels de santé.  
Il permet à un **médecin généraliste** de solliciter l’avis d’un **spécialiste** (télé-expertise synchrone ou asynchrone), tout en assurant un suivi structuré des consultations et des informations médicales.

---

## 🧑‍⚕️ Processus Complet du Parcours Patient

### 1️⃣ Accueil du patient — **Module Infirmier**
- Saisie des informations administratives
- Historique médical, traitements, allergies
- Signes vitaux :
    - Tension artérielle
    - Fréquence cardiaque
    - Température
    - Fréquence respiratoire
    - Poids & taille
- Ajout automatique dans la **file d'attente**

Fonctionnalités :
- Recherche patient (existant / nouveau)
- Mise à jour des signes vitaux
- Liste des patients du jour (tri + filtrage Stream API)

---

### 2️⃣ Consultation — **Module Médecin Généraliste**
- Accès au dossier complet du patient
- Examen clinique + analyse des symptômes
- Création de consultation (tarif fixe : **150 DH**)
- Deux scénarios :

#### ✔ Scénario A — Prise en charge directe
- Diagnostic
- Prescription de traitement
- Clôture de la consultation

#### ✔ Scénario B — Demande de Télé-Expertise
Étapes automatisées :
1. Demander avis spécialiste
2. Sélection d’une spécialité (Cardio, Dermato, Pneumo…)
3. Filtrage avec **Stream API** (spécialité + tarif)
4. Affichage des créneaux disponibles
5. Sélection créneau + question au spécialiste
6. Demande liée à la consultation (statut : **EN_ATTENTE_AVIS_SPECIALISTE**)
7. Notification au spécialiste

#### ➕ Calcul du coût total
- Consultation
- Expertise
- Actes techniques (radio, écho, IRM, ECG, analyses…)  
  Utilisation Lambda : `map().sum()`

---

### 3️⃣ Télé-Expertise — **Module Médecin Spécialiste**

#### ⚙ US5 : Configurer son profil
- Définir spécialité
- Tarif consultation
- Durée consultation (30 min fixe)

#### 🗓 US6 : Gestion des créneaux
Créneaux générés automatiquement :
- 09h00 – 09h30
- 09h30 – 10h00
- 10h00 – 10h30
- 10h30 – 11h00
- 11h00 – 11h30
- 11h30 – 12h00

Avec règles :
- Réservé → indisponible
- Passé → archivé
- Annulé → redevient disponible

#### 📥 US7 : Liste des demandes d’expertise
- Filtrer par statut (EN_ATTENTE, TERMINEE)
- Filtrer par priorité (URGENTE, NORMALE, NON URGENTE)
- Voir dossier patient + question posée

#### 🩺 US8 : Répondre à une expertise
- Rédiger avis médical
- Rédiger recommandations
- Clôturer l'expertise
- Mise à jour consultation principale

---

## 🔐 Authentification & Sécurité
- Login / Logout classique
- Authentification **stateful (sessions)**
- 3 rôles : `INFIRMIER`, `GENERALISTE`, `SPECIALISTE`
- Hashage passwords : **bcrypt**
- Protection : **CSRF** activée

---

## 🧰 Technologies Utilisées

### Backend
| Technologie     | Rôle |
|-----------------|------|
| **Maven**       | Gestion des dépendances |
| **Jakarta EE**  | Base web Java |
| **Servlet / JSP / JSTL** | Front côté serveur |
| **Tomcat**      | Serveur application |
| **JPA / Hibernate** | Persistance |
| **MySQL / PostgreSQL** | Base réelle |
| **H2**          | Base de test |
| **Stream API / Lambda** | Traitements |
| **bcrypt**      | Hashage mots de passe |

---
