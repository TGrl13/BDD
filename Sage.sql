CREATE TABLE Personne(
   id_personne INT,
   nom_personne VARCHAR(50) ,
   prenom_personne VARCHAR(50) ,
   telephone TINYINT,
   mail VARCHAR(50) ,
   rue VARCHAR(50) ,
   ville VARCHAR(50) ,
   code_postal VARCHAR(50) ,
   situation BOOLEAN,
   nb_enfants_ INT,
   PRIMARY KEY(id_personne)
);

CREATE TABLE Catégorie_Administrative(
   id_categorie_administrative INT,
   nom_categorie_administrative VARCHAR(50) ,
   PRIMARY KEY(id_categorie_administrative)
);

CREATE TABLE Dossier_social(
   id_dossier_social VARCHAR(50) ,
   id_personne INT NOT NULL,
   PRIMARY KEY(id_dossier_social),
   UNIQUE(id_personne),
   FOREIGN KEY(id_personne) REFERENCES Personne(id_personne)
);

CREATE TABLE Emplacement(
   id_emplacement INT,
   batiment VARCHAR(50) ,
   piece VARCHAR(50) ,
   numero_meuble VARCHAR(50) ,
   etage VARCHAR(50) ,
   PRIMARY KEY(id_emplacement)
);

CREATE TABLE Partenaire(
   id_partenaire VARCHAR(50) ,
   nom_partenaire VARCHAR(50) ,
   type_partenaire VARCHAR(50) ,
   PRIMARY KEY(id_partenaire)
);

CREATE TABLE Formation(
   id_formation INT,
   nom_formation VARCHAR(50) ,
   thematique VARCHAR(50) ,
   date_formation DATE,
   heure_debut_formation TIME,
   heure_fin_formation TIME,
   PRIMARY KEY(id_formation)
);

CREATE TABLE Réunion(
   id_reunion VARCHAR(50) ,
   type_reunion VARCHAR(50) ,
   date_reunion DATE,
   heure_debut_reunion VARCHAR(50) ,
   heure_fin_reunion VARCHAR(50) ,
   PRIMARY KEY(id_reunion)
);

CREATE TABLE Problématique(
   id_problematique INT,
   nom_domaine_problematique VARCHAR(50) ,
   PRIMARY KEY(id_problematique)
);

CREATE TABLE Agent_administratif(
   id_agent INT,
   nom_agent VARCHAR(50) ,
   prenom_agent VARCHAR(50) ,
   id_categorie_administrative INT NOT NULL,
   PRIMARY KEY(id_agent),
   FOREIGN KEY(id_categorie_administrative) REFERENCES Catégorie_Administrative(id_categorie_administrative)
);

CREATE TABLE Rendez_vous(
   id_rdv INT,
   date_rdv DATE NOT NULL,
   heure_debut_rdv TIME,
   heure_fin_rdv TIME,
   type_prise_rdv VARCHAR(50) ,
   motif_absence_personne VARCHAR(50) ,
   motif_absence_agent VARCHAR(50) ,
   nature_intervention VARCHAR(50) ,
   id_personne INT,
   id_agent INT,
   id_dossier_social VARCHAR(50)  NOT NULL,
   PRIMARY KEY(id_rdv),
   FOREIGN KEY(id_personne) REFERENCES Personne(id_personne),
   FOREIGN KEY(id_agent) REFERENCES Agent_administratif(id_agent),
   FOREIGN KEY(id_dossier_social) REFERENCES Dossier_social(id_dossier_social)
);

CREATE TABLE Document_administratif(
   id_document VARCHAR(50) ,
   nom_document VARCHAR(50)  NOT NULL,
   categorie_document VARCHAR(50) ,
   id_emplacement INT NOT NULL,
   id_dossier_social VARCHAR(50)  NOT NULL,
   PRIMARY KEY(id_document),
   FOREIGN KEY(id_emplacement) REFERENCES Emplacement(id_emplacement),
   FOREIGN KEY(id_dossier_social) REFERENCES Dossier_social(id_dossier_social)
);

CREATE TABLE Dispositif(
   id_dispositif VARCHAR(50) ,
   nom_dispositif VARCHAR(50) ,
   id_partenaire VARCHAR(50)  NOT NULL,
   PRIMARY KEY(id_dispositif),
   FOREIGN KEY(id_partenaire) REFERENCES Partenaire(id_partenaire)
);

CREATE TABLE Aide(
   id_aide VARCHAR(50) ,
   montant INT,
   type_aide VARCHAR(50) ,
   id_dispositif VARCHAR(50) ,
   id_rdv INT NOT NULL,
   PRIMARY KEY(id_aide),
   FOREIGN KEY(id_dispositif) REFERENCES Dispositif(id_dispositif),
   FOREIGN KEY(id_rdv) REFERENCES Rendez_vous(id_rdv)
);

CREATE TABLE Participer_formation(
   id_agent INT,
   id_formation INT,
   PRIMARY KEY(id_agent, id_formation),
   FOREIGN KEY(id_agent) REFERENCES Agent_administratif(id_agent),
   FOREIGN KEY(id_formation) REFERENCES Formation(id_formation)
);

CREATE TABLE Participer_réunion_2(
   id_partenaire VARCHAR(50) ,
   id_reunion VARCHAR(50) ,
   PRIMARY KEY(id_partenaire, id_reunion),
   FOREIGN KEY(id_partenaire) REFERENCES Partenaire(id_partenaire),
   FOREIGN KEY(id_reunion) REFERENCES Réunion(id_reunion)
);

CREATE TABLE Participer_réunion_1(
   id_agent INT,
   id_reunion VARCHAR(50) ,
   PRIMARY KEY(id_agent, id_reunion),
   FOREIGN KEY(id_agent) REFERENCES Agent_administratif(id_agent),
   FOREIGN KEY(id_reunion) REFERENCES Réunion(id_reunion)
);

CREATE TABLE Associer_problématique(
   id_rdv INT,
   id_problematique INT,
   PRIMARY KEY(id_rdv, id_problematique),
   FOREIGN KEY(id_rdv) REFERENCES Rendez_vous(id_rdv),
   FOREIGN KEY(id_problematique) REFERENCES Problématique(id_problematique)
);