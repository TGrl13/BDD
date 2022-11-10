CREATE TABLE Organisme_de_prise_en_charge(
   Siret FLOAT,
   Nom_organisme VARCHAR(50)  NOT NULL,
   Adresse_ VARCHAR(50)  NOT NULL,
   Date_d_inscription DATE NOT NULL,
   Date_de_création DATE NOT NULL,
   Type_d_organisme BOOLEAN NOT NULL,
   PRIMARY KEY(Siret)
);

CREATE TABLE Chat(
   Siret FLOAT,
   Id_Chat INT AUTO_INCREMENT,
   Sexe BOOLEAN NOT NULL,
   Departement_de_decouverte INT NOT NULL,
   Race VARCHAR(50)  NOT NULL,
   Date_reperage DATE NOT NULL,
   Date_de_prise_en_charge DATE NOT NULL,
   Etat_de_sante VARCHAR(50)  NOT NULL,
   Situation VARCHAR(50)  NOT NULL,
   Localisation VARCHAR(50) ,
   PRIMARY KEY(Siret, Id_Chat),
   FOREIGN KEY(Siret) REFERENCES Organisme_de_prise_en_charge(Siret)
);

CREATE TABLE Opération(
   Siret FLOAT,
   Id_Chat INT,
   Siret_1 FLOAT,
   Date_opération DATE,
   Type_opération VARCHAR(50)  NOT NULL,
   PRIMARY KEY(Siret, Id_Chat, Siret_1, Date_opération),
   FOREIGN KEY(Siret, Id_Chat) REFERENCES Chat(Siret, Id_Chat),
   FOREIGN KEY(Siret_1) REFERENCES Organisme_de_prise_en_charge(Siret)
);