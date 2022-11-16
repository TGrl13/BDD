from sqlalchemy import create_engine, MetaData, select
import sqlalchemy
from faker import Faker
import sys
import random
import datetime
import configparser
from connect import engine


engine = engine
metadata = MetaData()
metadata.reflect(bind=engine)

# Instantiate faker object
faker = Faker(['fr-FR'])

Personne = metadata.tables["Personne"]
Catégorie_Administrative = metadata.tables["Catégorie_Administrative"]
Dossier_social = metadata.tables["Dossier_social"]
Emplacement = metadata.tables["Emplacement"]
Partenaire = metadata.tables["Partenaire"]
Formation = metadata.tables["Formation"]
Réunion = metadata.tables["Réunion"]
Problématique = metadata.tables["Problématique"]
Agent_administratif = metadata.tables["Agent_administratif"]
Rendez_vous = metadata.tables["Rendez_vous"]
Document_administratif = metadata.tables["Document_administratif"]
Dispositif = metadata.tables["Dispositif"]
Aide = metadata.tables["Aide"]
Participer_formation = metadata.tables["Participer_formation"]
Participer_réunion_2 = metadata.tables["Participer_réunion_2"]
Participer_réunion_1 = metadata.tables["Participer_réunion_1"]
Associer_problématique = metadata.tables["Associer_problématique"]

database=[]

try :
    database.append((Personne,2000))
    database.append((Catégorie_Administrative,2000))
    database.append((Dossier_social,2000))
    database.append((Emplacement,2000))
    database.append((Partenaire,2000))
    database.append((Formation,2000))
    database.append((Réunion,2000))
    database.append((Problématique,2000))
    database.append((Agent_administratif,2000))
    database.append((Rendez_vous,2000))
    database.append((Document_administratif,10000))
    database.append((Dispositif,2000))
    database.append((Aide,2000))
    database.append((Participer_formation,2000))
    database.append((Participer_réunion_2,2000))
    database.append((Participer_réunion_1,2000))
    database.append((Associer_problématique,2000))

except KeyError as err:
    print("error : Metadata.tables "+str(err)+" not found")

# Liste catégorie administrative 
cat_admin = ["A", "B", "C"]

thematique_formation = ["New Comer", "Social", "Manager", "Juridique", "Sécurité", "Finance"]

nom_formation = ["Formation1", "Formation2", "Formation3", "Formation4", "Formation5", "Formation6"]

nom_piece = ["Piece", "Piece2", "Piece3", "Piece4", "Piece5", "Piece6"]

nom_batiment = ["Batiment1", "Batiment2", "Batiment3", "Batiment4", "Batiment5", "Batiment6"]

type_partenaire = ["Commune", "Etat", "Association", "Departement", "Entreprise", "Région"]

type_reunion = ["Par Téléphone", "En visio", "En presentiel"]

type_absence = ["Maladie", "Erreur de planning", "Bug informatique", "Retard", "Raison personnel", "Grève"]

nature_rendez_vous = ["1er RDV", "Suivie dossier"]

type_aide = ["Logement", "Financière", "Sociale", "Transport"]

cat_doc = ["Identité", "Domicile", "Compte bancaire", "Revenus", "Famille", "Santé"]

nom_doc = ["CNI", "Justificatif de domicile", "RIB", "Déclaration d'impot", "Passeport", "Livret de famille", "NSS"]

nom_dispositif_list = ["Allocations familiales", "Prestation d’accueil du jeune enfant", "Allocation de rentrée scolaire",
    "L’ Allocation Personnalisée d’ Autonomie APA", "Aide au permis de conduire", "APL"]

class GenerateData:
    """
    generate a specific number of records to a target table
    """

    def __init__(self,table):
        """
        initialize command line arguments
        """
        self.table = table[0]
        self.num_records = table[1]


    def create_data(self):
        """
        using faker library, generate data and execute DML
        """

        if self.table.name == "Personne":
            with engine.begin() as conn:
                for _ in range(self.num_records):
                    insert_stmt = self.table.insert().values(
                        nom_personne = faker.last_name(),
                        prenom_personne = faker.first_name(),
                        telephone = faker.phone_number(),
                        mail = faker.email(),
                        rue = faker.building_number(),
                        ville = faker.city(),
                        code_postal = faker.postcode(),
                        situation = faker.boolean(chance_of_getting_true=50),
                        nb_enfants_ = faker.random_int(0, 10)
                    )
                    conn.execute(insert_stmt)

        if self.table.name == "Catégorie_Administrative":
            with engine.begin() as conn:
                for _ in range(self.num_records):
                    insert_stmt = self.table.insert().values(
                        nom_categorie_administrative = random.choice(cat_admin)
                    )
                    conn.execute(insert_stmt)

        if self.table.name == "Dossier_social":
            with engine.begin() as conn:
                personnes = conn.execute(select([Personne.c.id_personne])).fetchall()
                for _ in range(self.num_records):
                    insert_stmt = self.table.insert().values(
                        id_personne = personnes[_]['id_personne']
                    )
                    conn.execute(insert_stmt)
                    
        if self.table.name == "Emplacement":
            with engine.begin() as conn:
                for _ in range(self.num_records):
                    insert_stmt = self.table.insert().values(
                        batiment = random.choice(nom_batiment),
                        piece = random.choice(nom_piece),
                        numero_meuble = faker.random_int(1,200),
                        etage = faker.random_int(0, 10)
                    )
                    conn.execute(insert_stmt)
                    
        if self.table.name == "Partenaire":
            with engine.begin() as conn:
                for _ in range(self.num_records):
                    insert_stmt = self.table.insert().values(
                        nom_partenaire = faker.company(),
                        type_partenaire = random.choice(type_partenaire)
                    )
                    conn.execute(insert_stmt)
                    
        if self.table.name == "Formation":
            with engine.begin() as conn:
                for _ in range(self.num_records):
                    date_obj = datetime.datetime.now() - datetime.timedelta(days=random.randint(0,30))
                    insert_stmt = self.table.insert().values(
                        nom_formation = random.choice(nom_formation),
                        thematique = random.choice(thematique_formation),
                        date_formation = date_obj.strftime("%Y/%m/%d"),
                        heure_debut_formation = faker.time("%H:%M%S"),
                        heure_fin_formation = faker.time("%H:%M%S")
                    )
                    conn.execute(insert_stmt)
        
        if self.table.name == "Réunion":
            with engine.begin() as conn:
                for _ in range(self.num_records):
                    date_obj = datetime.datetime.now() - datetime.timedelta(days=random.randint(0,30))
                    insert_stmt = self.table.insert().values(
                        type_reunion = random.choice(type_reunion),
                        date_reunion = date_obj.strftime("%Y/%m/%d"),
                        heure_debut_reunion = faker.time("%H:%M%S"),
                        heure_fin_reunion = faker.time("%H:%M%S")
                    )
                    conn.execute(insert_stmt)
                    
        if self.table.name == "Problématique":
            with engine.begin() as conn:
                for _ in range(self.num_records):
                    insert_stmt = self.table.insert().values(
                        nom_domaine_problematique = random.choice(type_aide)
                    )
                    conn.execute(insert_stmt)
        
        if self.table.name == "Agent_administratif":
            with engine.begin() as conn:
                for _ in range(self.num_records):
                    insert_stmt = self.table.insert().values(
                        nom_agent = faker.first_name(),
                        prenom_agent = faker.last_name(),
                        id_categorie_administrative = random.choice(conn.execute(select([Catégorie_Administrative.c.id_categorie_administrative])).fetchall())[0]
                    )
                    conn.execute(insert_stmt)
        
        if self.table.name == "Rendez_vous":
            with engine.begin() as conn:
                for _ in range(self.num_records):
                    date_obj = datetime.datetime.now() - datetime.timedelta(days=random.randint(0,30))
                    insert_stmt = self.table.insert().values(
                        date_rdv =  date_obj.strftime("%Y/%m/%d"),
                        heure_debut_rdv = faker.time("%H:%M%S"),
                        heure_fin_rdv = faker.time("%H:%M%S"),
                        type_prise_rdv = random.choice(type_reunion),
                        motif_absence_personne =  random.choice(type_absence),
                        motif_absence_agent = random.choice(type_absence),
                        nature_intervention = random.choice(nature_rendez_vous),
                        id_personne = random.choice(conn.execute(select([Personne.c.id_personne])).fetchall())[0],
                        id_agent = random.choice(conn.execute(select([Agent_administratif.c.id_agent])).fetchall())[0],
                        id_dossier_social = random.choice(conn.execute(select([Dossier_social.c.id_dossier_social])).fetchall())[0]
                    )
                    conn.execute(insert_stmt)
        
        if self.table.name == "Document_administratif":
            with engine.begin() as conn:
                for _ in range(self.num_records):
                    insert_stmt = self.table.insert().values(
                        nom_document = random.choice(nom_doc),
                        categorie_document =  random.choice(cat_doc),
                        id_emplacement = random.choice(conn.execute(select([Emplacement.c.id_emplacement])).fetchall())[0],
                        id_dossier_social = random.choice(conn.execute(select([Dossier_social.c.id_dossier_social])).fetchall())[0]
                    )
                    conn.execute(insert_stmt)
        
        if self.table.name == "Dispositif":
            with engine.begin() as conn:
                for _ in range(self.num_records):
                    insert_stmt = self.table.insert().values(
                        nom_dispositif = random.choice(nom_dispositif_list),
                        id_partenaire = random.choice(conn.execute(select([Partenaire.c.id_partenaire])).fetchall())[0]
                    )
                    conn.execute(insert_stmt)
        
        if self.table.name == "Aide":
            with engine.begin() as conn:
                for _ in range(self.num_records):
                    insert_stmt = self.table.insert().values(
                        montant = random.randint(100,2000),
                        type_aide = random.choice(type_aide),
                        id_dispositif = random.choice(conn.execute(select([Dispositif.c.id_dispositif])).fetchall())[0],
                        id_rdv = random.choice(conn.execute(select([Rendez_vous.c.id_rdv])).fetchall())[0]
                    )
                    conn.execute(insert_stmt)
                    
        if self.table.name == "Participer_formation":
            with engine.begin() as conn:
                for _ in range(self.num_records):
                    insert_stmt = self.table.insert().values(
                        id_agent = random.choice(conn.execute(select([Agent_administratif.c.id_agent])).fetchall())[0],
                        id_formation = random.choice(conn.execute(select([Formation.c.id_formation])).fetchall())[0]
                    )
                    conn.execute(insert_stmt)
                    
        if self.table.name == "Participer_réunion_2":
            with engine.begin() as conn:
                for _ in range(self.num_records):
                    insert_stmt = self.table.insert().values(
                        id_partenaire = random.choice(conn.execute(select([Partenaire.c.id_partenaire])).fetchall())[0],
                        id_reunion = random.choice(conn.execute(select([Réunion.c.id_reunion])).fetchall())[0]
                    )
                    conn.execute(insert_stmt)
                    
        if self.table.name == "Participer_réunion_1":
            with engine.begin() as conn:
                for _ in range(self.num_records):
                    insert_stmt = self.table.insert().values(
                        id_agent = random.choice(conn.execute(select([Agent_administratif.c.id_agent])).fetchall())[0],
                        id_reunion = random.choice(conn.execute(select([Réunion.c.id_reunion])).fetchall())[0]
                    )
                    conn.execute(insert_stmt)
                    
        if self.table.name == "Associer_problématique":
            with engine.begin() as conn:
                for _ in range(self.num_records):
                    insert_stmt = self.table.insert().values(
                        id_rdv = random.choice(conn.execute(select([Rendez_vous.c.id_rdv])).fetchall())[0],
                        id_problematique = random.choice(conn.execute(select([Problématique.c.id_problematique])).fetchall())[0]
                    )
                    conn.execute(insert_stmt)
        


if __name__ == "__main__":
    for i in database:
        generate_data = GenerateData(i)
        generate_data.create_data()