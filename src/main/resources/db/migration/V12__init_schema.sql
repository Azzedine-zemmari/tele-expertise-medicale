ALTER table SigneVital DROP constraint signevital_consultation_id_fkey ;

ALTER TABLE SigneVital DROP COLUMN consultation_id;


ALTER TABLE SigneVital ADD COLUMN patient_id UUID;

alter table SigneVital add constraint fk_patient foreign key (patient_id) references Patient(id);


alter table Consultation drop constraint consultation_generalist_id_fkey;

alter table Consultation drop column generalist_id;

ALTER TABLE Patient ADD COLUMN date_arrive DATE;