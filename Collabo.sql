CREATE TABLE Enregistrement(
   Numero_de_ticket INT AUTO_INCREMENT,
   Date_Enregistrement DATE NOT NULL,
   Heure_Enregistrement TIME NOT NULL,
   PRIMARY KEY(Numero_de_ticket)
);

CREATE TABLE Medecin(
   Numéro_RPPS INT AUTO_INCREMENT,
   Nom_medecin VARCHAR(50),
   Prenom_medecin VARCHAR(50),
   Adresse_postal VARCHAR(100),
   Mail_medecin VARCHAR(50),
   PRIMARY KEY(Numéro_RPPS)
);

CREATE TABLE Patient(
   Numero_patient INT AUTO_INCREMENT,
   Nom_patient VARCHAR(50),
   Prenom_patient VARCHAR(50),
   Date_de_naissance DATE,
   Adresse_patient VARCHAR(100),
   Poids_patient DECIMAL(4,1),
   Taille_patient INT NOT NULL,
   NSS_patient VARCHAR(50),
   Medecin_traitant VARCHAR(50),
   Autorisation_partage BOOLEAN,
   Numéro_RPPS INT NOT NULL,
   PRIMARY KEY(Numero_patient),
   FOREIGN KEY(Numéro_RPPS) REFERENCES Medecin(Numéro_RPPS)
);

CREATE TABLE Analyse(
   Numéro_analyse INT AUTO_INCREMENT,
   Date_analyse DATE,
   Heure_analyse TIME,
   Type_analyse VARCHAR(50),
   Forfait_analyse VARCHAR(100),
   Vecteur_analyse VARCHAR(50),
   Numero_patient INT NOT NULL,
   PRIMARY KEY(Numéro_analyse),
   FOREIGN KEY(Numero_patient) REFERENCES Patient(Numero_patient)
);

CREATE TABLE S_enregistre(
   Id_S_enregistre INT AUTO_INCREMENT,
   Numero_patient INT NOT NULL,
   Numero_de_ticket INT NOT NULL,
   PRIMARY KEY(Id_S_enregistre),
   FOREIGN KEY(Numero_patient) REFERENCES Patient(Numero_patient),
   FOREIGN KEY(Numero_de_ticket) REFERENCES Enregistrement(Numero_de_ticket)
);