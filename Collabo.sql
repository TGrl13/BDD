CREATE TABLE Enregistrement(
   Numero_de_ticket VARCHAR(50) ,
   Date_heure DATETIME,
   PRIMARY KEY(Numero_de_ticket)
);

CREATE TABLE Medecin(
   Numéro_RPPS VARCHAR(50) ,
   Nom_medecin VARCHAR(50) ,
   Adresse_postal VARCHAR(50) ,
   Mail_medecin VARCHAR(50) ,
   PRIMARY KEY(Numéro_RPPS)
);

CREATE TABLE Patient(
   Numero_patient INT,
   Nom_patient VARCHAR(50) ,
   Prenom_patient VARCHAR(50) ,
   Date_de_naissance DATE,
   Adresse_patient VARCHAR(50) ,
   Poids_patient DECIMAL(15,2)  ,
   Taille_patient DECIMAL(15,2)  ,
   NSS_patient VARCHAR(50) ,
   Medecin_traitant VARCHAR(50) ,
   Autorisation_partage BOOLEAN,
   Numéro_RPPS VARCHAR(50)  NOT NULL,
   PRIMARY KEY(Numero_patient),
   FOREIGN KEY(Numéro_RPPS) REFERENCES Medecin(Numéro_RPPS)
);

CREATE TABLE Analyse(
   Numéro_analyse INT,
   Date_analyse DATE,
   Heure_analyse TIME,
   Type_analyse VARCHAR(50) ,
   Forfait_analyse VARCHAR(50) ,
   Vecteur_analyse VARCHAR(50) ,
   Numero_patient INT NOT NULL,
   PRIMARY KEY(Numéro_analyse),
   FOREIGN KEY(Numero_patient) REFERENCES Patient(Numero_patient)
);

CREATE TABLE S_enregistre(
   Numero_patient INT,
   Numero_de_ticket VARCHAR(50) ,
   PRIMARY KEY(Numero_patient, Numero_de_ticket),
   FOREIGN KEY(Numero_patient) REFERENCES Patient(Numero_patient),
   FOREIGN KEY(Numero_de_ticket) REFERENCES Enregistrement(Numero_de_ticket)
);