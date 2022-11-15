CREATE TABLE Organisme_de_prise_en_charge(
   Siret INT AUTO_INCREMENT,
   Nom_organisme VARCHAR(50)  NOT NULL,
   Adresse_ VARCHAR(50)  NOT NULL,
   Date_d_inscription DATE NOT NULL,
   Date_de_création DATE NOT NULL,
   Type_d_organisme VARCHAR(50)  NOT NULL,
   PRIMARY KEY(Siret)
);

CREATE TABLE Chat(
   Id_Chat INT AUTO_INCREMENT,
   Siret INT,
   Sexe INT NOT NULL,
   Departement_de_decouverte INT NOT NULL,
   Race VARCHAR(50)  NOT NULL,
   Date_reperage DATE NOT NULL,
   Date_de_prise_en_charge DATE NOT NULL,
   Etat_de_sante VARCHAR(50)  NOT NULL,
   Situation VARCHAR(50)  NOT NULL,
   Localisation VARCHAR(50) ,
   PRIMARY KEY(Id_Chat),
   FOREIGN KEY(Siret) REFERENCES Organisme_de_prise_en_charge(Siret)
);

CREATE TABLE Opération(
   Id_opération INT AUTO_INCREMENT,
   Siret INT,
   Id_Chat INT,
   Date_opération DATE,
   Type_opération VARCHAR(50)  NOT NULL,
   PRIMARY KEY(Id_opération),
   FOREIGN KEY(Id_Chat) REFERENCES Chat(Id_Chat),
   FOREIGN KEY(Siret) REFERENCES Organisme_de_prise_en_charge(Siret)
);