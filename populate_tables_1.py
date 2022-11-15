from sqlalchemy import create_engine, MetaData, select
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
faker = Faker()


Organisme_de_prise_en_charge = metadata.tables["Organisme_de_prise_en_charge"]
Chat = metadata.tables["Chat"]
Opération = metadata.tables["Opération"]

database=[]

try :
    database.append((Organisme_de_prise_en_charge,2000))
    database.append((Chat,2000))
    database.append((Opération,2000))
except KeyError as err:
    print("error : Metadata.tables "+str(err)+" not found")

# race list
race_list = ["Abyssin", "Brume australienne", "Californian spangled", "Devon rex", "European shorthair", "German rex",
    "Havana brown", "Khao Manee", "LaPerm", "Maine coon", "Nebelung"]

# type_opération list
type_operation_list = ["Ovariectomie", "Castration", "Urétrotomie", "Urétérostomie", "Gastrotomie", "Entérotomie",
    "Césarienne", "Extractions dentaires", "Détartrages"]

# situation list
situation_list = ["Errance", "En attente", "Placé"]

# etat_de_sante list
etat_de_sante_list = ["Enceinte", "Calculs urinaires", "A ingéré un corps étranger", "Fracture", "Tarte dans les dents"]

# etat_de_sante list
type_organisme_list = ["Vétérinaire", "Association", "Refuge", "SPA"]


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

        if self.table.name == "Organisme_de_prise_en_charge":
            with engine.begin() as conn:
                for _ in range(self.num_records):
                    date_ins = datetime.datetime.now() - datetime.timedelta(days=random.randint(0,30))
                    insert_stmt = self.table.insert().values(
                        Nom_organisme = faker.company(),
                        Adresse_ = faker.providers.address.fr_FR.Provider.street_address(),
                        Date_d_inscription = date_ins.strftime("%Y/%m/%d"),
                        Date_de_création = date_ins.strftime("%Y/%m/%d"),
                        Type_d_organisme = random.choice(type_organisme_list)
                    )
                    conn.execute(insert_stmt)

        if self.table.name == "Chat":
            with engine.begin() as conn:
                for _ in range(self.num_records):
                    insert_stmt = self.table.insert().values(
                        Sexe = faker.random_int(0, 2),
                        Departement_de_decouverte = int(faker.providers.address.fr_FR.Provider.department_number()),
                        Race = random.choice(race_list),
                        Date_reperage = date_ins.strftime("%Y/%m/%d"),
                        Date_de_prise_en_charge = date_ins.strftime("%Y/%m/%d"),
                        Etat_de_sante = random.choice(etat_de_sante_list),
                        Situation = random.choice(situation_list),
                        Localisation = faker.providers.address.fr_FR.Provider.address(),
                        Siret=random.choice(conn.execute(select([Organisme_de_prise_en_charge.c.Siret])).fetchall())[0]
                    )
                    conn.execute(insert_stmt)

        if self.table.name == "Opération":
            with engine.begin() as conn:
                for _ in range(self.num_records):
                    insert_stmt = self.table.insert().values(
                        Date_opération = date_ins.strftime("%Y/%m/%d"),
                        Type_opération = random.choice(type_operation_list),
                        Id_Chat = random.choice(conn.execute(select([Chat.c.Id_Chat])).fetchall())[0],
                        Siret = random.choice(conn.execute(select([Organisme_de_prise_en_charge.c.Siret])).fetchall())[0]
                    )
                    conn.execute(insert_stmt)

if __name__ == "__main__":
    for i in database:
        generate_data = GenerateData(i)
        generate_data.create_data()
