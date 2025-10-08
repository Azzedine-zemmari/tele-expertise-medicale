DROP TABLE IF EXISTS patient CASCADE;

create table patient (
    id UUID PRIMARY KEY ,
    nom varchar(20),
    prenom varchar(20),
    mutuelle VARCHAR(30),
    adress VARCHAR(50),
    num_securite_social VARCHAR(20),
    CIN VARCHAR(10)
);

create type typeAct as Enum('RADIO','ECHO','LASER','ANALYSE_SANG');
create table ActeMidical (
    id UUID PRIMARY KEY ,
    typeAct typeAct,
    cout float,
    consultation_id UUID,
    FOREIGN KEY (consultation_id) REFERENCES Consultation(id));