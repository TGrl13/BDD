CREATE TABLE Evenement(
   Id_Evenement INT AUTO_INCREMENT,
   Gain_total_evenement_adherent INT NOT NULL,
   PRIMARY KEY(Id_Evenement)
);

CREATE TABLE Tour(
   Id_Evenement INT,
   Id_Tour INT AUTO_INCREMENT,
   Gain_tour_adherent INT NOT NULL,
   PRIMARY KEY(Id_Tour),
   FOREIGN KEY(Id_Evenement) REFERENCES Evenement(Id_Evenement)
);

CREATE TABLE Adherent(
   Id_Adherent INT AUTO_INCREMENT,
   Nom VARCHAR(50)  NOT NULL,
   Prenom VARCHAR(50)  NOT NULL,
   Gain_total_adherent INT NOT NULL,
   Resultat BOOLEAN NOT NULL,
   PRIMARY KEY(Id_Adherent)
);

CREATE TABLE Numero(
   Id_Evenement INT,
   Id_Tour INT,
   Id_Numero INT AUTO_INCREMENT,
   Libelle_num VARCHAR(50)  NOT NULL,
   Id_Adherent INT NOT NULL,
   PRIMARY KEY(Id_Numero),
   FOREIGN KEY(Id_Tour) REFERENCES Tour(Id_Tour),
   FOREIGN KEY(Id_Adherent) REFERENCES Adherent(Id_Adherent)
);