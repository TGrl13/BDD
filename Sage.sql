CREATE TABLE Personne(
   id_personne INT AUTO_INCREMENT,
   nom_personne VARCHAR(50) ,
   prenom_personne VARCHAR(50) ,
   telephone VARCHAR(50) NOT NULL,
   mail VARCHAR(50) NOT NULL,
   rue VARCHAR(50) NOT NULL,
   ville VARCHAR(50) NOT NULL,
   code_postal INT NOT NULL,
   situation BOOLEAN NOT NULL,
   nb_enfants_ INT NOT NULL,
   PRIMARY KEY(id_personne)
);

CREATE TABLE Catégorie_Administrative(
   id_categorie_administrative INT AUTO_INCREMENT,
   nom_categorie_administrative VARCHAR(50) NOT NULL,
   PRIMARY KEY(id_categorie_administrative)
);

CREATE TABLE Dossier_social(
   id_dossier_social INT AUTO_INCREMENT,
   id_personne INT NOT NULL,
   PRIMARY KEY(id_dossier_social),
   UNIQUE(id_personne),
   FOREIGN KEY(id_personne) REFERENCES Personne(id_personne)
);

CREATE TABLE Emplacement(
   id_emplacement INT AUTO_INCREMENT,
   batiment VARCHAR(50) NOT NULL,
   piece VARCHAR(50) NOT NULL,
   numero_meuble INT NOT NULL,
   etage INT NOT NULL,
   PRIMARY KEY(id_emplacement)
);

CREATE TABLE Partenaire(
   id_partenaire INT AUTO_INCREMENT,
   nom_partenaire VARCHAR(50) NOT NULL,
   type_partenaire VARCHAR(50) NOT NULL,
   PRIMARY KEY(id_partenaire)
);

CREATE TABLE Formation(
   id_formation INT AUTO_INCREMENT,
   nom_formation VARCHAR(50) NOT NULL,
   thematique VARCHAR(50) NOT NULL,
   date_formation DATE NOT NULL,
   heure_debut_formation TIME NOT NULL,
   heure_fin_formation TIME NOT NULL,
   PRIMARY KEY(id_formation)
);

CREATE TABLE Réunion(
   id_reunion INT AUTO_INCREMENT,
   type_reunion VARCHAR(50) NOT NULL,
   date_reunion DATE NOT NULL,
   heure_debut_reunion TIME NOT NULL,
   heure_fin_reunion TIME NOT NULL,
   PRIMARY KEY(id_reunion)
);

CREATE TABLE Problématique(
   id_problematique INT AUTO_INCREMENT,
   nom_domaine_problematique VARCHAR(50) NOT NULL,
   PRIMARY KEY(id_problematique)
);

CREATE TABLE Agent_administratif(
   id_agent INT AUTO_INCREMENT,
   nom_agent VARCHAR(50) NOT NULL,
   prenom_agent VARCHAR(50) NOT NULL,
   id_categorie_administrative INT NOT NULL,
   PRIMARY KEY(id_agent),
   FOREIGN KEY(id_categorie_administrative) REFERENCES Catégorie_Administrative(id_categorie_administrative)
);

CREATE TABLE Rendez_vous(
   id_rdv INT AUTO_INCREMENT,
   date_rdv DATE NOT NULL,
   heure_debut_rdv TIME NOT NULL,
   heure_fin_rdv TIME NOT NULL,
   type_prise_rdv VARCHAR(50) NOT NULL,
   motif_absence_personne VARCHAR(50) NOT NULL,
   motif_absence_agent VARCHAR(50) NOT NULL,
   nature_intervention VARCHAR(50) NOT NULL,
   id_personne INT NOT NULL,
   id_agent INT NOT NULL,
   id_dossier_social INT NOT NULL,
   PRIMARY KEY(id_rdv),
   FOREIGN KEY(id_personne) REFERENCES Personne(id_personne),
   FOREIGN KEY(id_agent) REFERENCES Agent_administratif(id_agent),
   FOREIGN KEY(id_dossier_social) REFERENCES Dossier_social(id_dossier_social)
);

CREATE TABLE Document_administratif(
   id_document INT AUTO_INCREMENT,
   nom_document VARCHAR(50) NOT NULL,
   categorie_document VARCHAR(50) ,
   id_emplacement INT NOT NULL,
   id_dossier_social INT NOT NULL,
   PRIMARY KEY(id_document),
   FOREIGN KEY(id_emplacement) REFERENCES Emplacement(id_emplacement),
   FOREIGN KEY(id_dossier_social) REFERENCES Dossier_social(id_dossier_social)
);

CREATE TABLE Dispositif(
   id_dispositif INT AUTO_INCREMENT,
   nom_dispositif VARCHAR(50) NOT NULL,
   id_partenaire INT NOT NULL,
   PRIMARY KEY(id_dispositif),
   FOREIGN KEY(id_partenaire) REFERENCES Partenaire(id_partenaire)
);

CREATE TABLE Aide(
   id_aide INT AUTO_INCREMENT,
   montant INT NOT NULL,
   type_aide VARCHAR(100) NOT NULL,
   id_dispositif INT NOT NULL,
   id_rdv INT NOT NULL,
   PRIMARY KEY(id_aide),
   FOREIGN KEY(id_dispositif) REFERENCES Dispositif(id_dispositif),
   FOREIGN KEY(id_rdv) REFERENCES Rendez_vous(id_rdv)
);

CREATE TABLE Participer_formation(
   id_Participer_formation INT AUTO_INCREMENT,
   id_agent INT NOT NULL,
   id_formation INT NOT NULL,
   PRIMARY KEY(id_Participer_formation),
   FOREIGN KEY(id_agent) REFERENCES Agent_administratif(id_agent),
   FOREIGN KEY(id_formation) REFERENCES Formation(id_formation)
);

CREATE TABLE Participer_réunion_2(
   id_Participer_réunion_2 INT AUTO_INCREMENT,
   id_partenaire INT NOT NULL,
   id_reunion INT NOT NULL,
   PRIMARY KEY(id_Participer_réunion_2),
   FOREIGN KEY(id_partenaire) REFERENCES Partenaire(id_partenaire),
   FOREIGN KEY(id_reunion) REFERENCES Réunion(id_reunion)
);

CREATE TABLE Participer_réunion_1(
   id_Participer_réunion_1 INT AUTO_INCREMENT,
   id_agent INT NOT NULL,
   id_reunion INT NOT NULL,
   PRIMARY KEY(id_Participer_réunion_1),
   FOREIGN KEY(id_agent) REFERENCES Agent_administratif(id_agent),
   FOREIGN KEY(id_reunion) REFERENCES Réunion(id_reunion)
);

CREATE TABLE Associer_problématique(
   id_Associer_problématique INT AUTO_INCREMENT,
   id_rdv INT NOT NULL,
   id_problematique INT NOT NULL,
   PRIMARY KEY(id__Associer_problématique),
   FOREIGN KEY(id_rdv) REFERENCES Rendez_vous(id_rdv),
   FOREIGN KEY(id_problematique) REFERENCES Problématique(id_problematique)
);