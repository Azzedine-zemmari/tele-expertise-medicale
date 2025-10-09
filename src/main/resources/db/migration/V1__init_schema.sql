-- Roles
CREATE TYPE role AS ENUM ('PATIENT','INFIRMIER','GENERALISTE','SPECIALISTE');

-- Utilisateur
CREATE TABLE Utilisateur(
    id UUID PRIMARY KEY,
    nom varchar(20),
    prenom varchar(20),
    email varchar(60) UNIQUE,
    password varchar(60),
    role role
);

-- Shifts
CREATE TYPE shift AS ENUM('JOUR', 'NUIT');

-- Infirmier
CREATE TABLE Infirmier (
    id UUID PRIMARY KEY,
    service VARCHAR(50),
    shift shift,
    experience INT,
    user_id UUID UNIQUE,
    FOREIGN KEY (user_id) REFERENCES Utilisateur(id)
);

-- Generalist
CREATE TABLE Generalist (
    id UUID PRIMARY KEY,
    experience INT,
    tarifConsultation DECIMAL(6,2) DEFAULT 150.00,
    user_id UUID UNIQUE,
    FOREIGN KEY (user_id) REFERENCES Utilisateur(id)
);

-- Specialiste
CREATE TABLE Specialiste(
    id UUID PRIMARY KEY,
    experience INT,
    tarif DECIMAL,
    user_id UUID UNIQUE,
    FOREIGN KEY (user_id) REFERENCES Utilisateur(id)
);

-- StatusConsultation
CREATE TYPE StatusConsultation AS ENUM ('EN_ATTENTE','EN_COURS','EN_ATTENTE_AVIS_SPECIALISTE','TERMINEE','ANNULEE');

-- Patient
CREATE TABLE Patient (
    id UUID PRIMARY KEY,
    mutuelle VARCHAR(30),
    adress VARCHAR(50),
    num_securite_social VARCHAR(20),
    CIN VARCHAR(10),
    FOREIGN KEY (id) REFERENCES Utilisateur(id)
);

-- DossierMedical
CREATE TABLE DossierMedical(
    id UUID PRIMARY KEY,
    patient_id UUID UNIQUE,
    blood_type VARCHAR(3),
    allergies TEXT,
    medications TEXT,
    past_surgeries TEXT,
    FOREIGN KEY(patient_id) REFERENCES Patient(id)
);

-- Consultation
CREATE TABLE Consultation (
    id UUID PRIMARY KEY,
    generalist_id UUID,
    dossier_medical_id UUID,
    date DATE,
    motif VARCHAR(255),
    diagnostique VARCHAR(255),
    traitement VARCHAR(255),
    cont INT,
    status_consultation StatusConsultation,
    FOREIGN KEY (generalist_id) REFERENCES Generalist(id),
    FOREIGN KEY (dossier_medical_id) REFERENCES DossierMedical(id)
);

-- SigneVital
CREATE TABLE SigneVital(
    id UUID PRIMARY KEY,
    tension DECIMAL,
    frequenceCardiaque DECIMAL,
    temperature INT ,
    poids DECIMAL,
    date_mesure DATE,
    consultation_id UUID UNIQUE,
    FOREIGN KEY (consultation_id) REFERENCES Consultation(id)
);

-- statusExpertise
CREATE TYPE statusExpertise AS ENUM ('EN_ATTENTE','EN_COURS','TERMINE');

-- DemandeExpertise
CREATE TABLE DemandeExpertise (
    id UUID PRIMARY KEY,
    date_demand DATE,
    question VARCHAR(255),
    priority VARCHAR(50),
    status_expertise statusExpertise,
    avis VARCHAR(255),
    date_avis DATE,
    consultation_id UUID UNIQUE,
    speciality_id UUID UNIQUE,
    FOREIGN KEY (consultation_id) REFERENCES Consultation(id) ON DELETE CASCADE,
    FOREIGN KEY (speciality_id) REFERENCES Specialiste(id)
);

-- Creneau
CREATE TABLE Creneau (
    id UUID PRIMARY KEY,
    heurdebut TIME,
    heurfin TIME,
    disponibilite BOOLEAN,
    specialiste_id UUID,
    FOREIGN KEY (specialiste_id) REFERENCES Specialiste(id)
);
