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
faker = Faker(['fr-FR'])

Enregistrement = metadata.tables["Enregistrement"]
Medecin = metadata.tables["Medecin"]
Patient = metadata.tables["Patient"]
Analyse = metadata.tables["Analyse"]
S_enregistre = metadata.tables["S_enregistre"]

database=[]

try :
    database.append((Enregistrement,2000))
    database.append((Medecin,2000))
    database.append((Patient,2000))
    database.append((Analyse,2000))
    database.append((S_enregistre,2000))
except KeyError as err:
    print("error : Metadata.tables "+str(err)+" not found")

# rvecteur list
vecteur_list = ["Prélèvement sanguin", "Prélèvement salivaire", "Prélèvement urinaire", "Prélèvement broncho-pulmonaires",
    "prélèvement de liquide gastrique", "prélèvement cutané", "Prélèvement de pus", "prélèvement uro-génital"]

# type list
type_list = ["VIH", "Thyroïde", "Shyphilis", "Mucoviscidose", "allergies alimentaires", "cholestérole", "globules rouges", "glycémie"
    "magnésium", "fer", "MST", "test de paternité"]

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

        if self.table.name == "Enregistrement":
            with engine.begin() as conn:
                for _ in range(self.num_records):
                    insert_stmt = self.table.insert().values(
                        Date_heure = faker.date_time(tzinfo: Optional[datetime.tzinfo] = 'Europe/Paris', end_datetime: Union[datetime.date, datetime.datetime, datetime.timedelta] = None).strftime("%Y/%m/%d, %H:%M:%S"),
                    )
                    conn.execute(insert_stmt)

        if self.table.name == "Medecin":
            with engine.begin() as conn:
                for _ in range(self.num_records):
                    insert_stmt = self.table.insert().values(
                        Nom_medecin = faker.last_name(),
                        Prenom_medecin = faker.first_name(),
                        Adresse_postal = faker.address(),
                        Mail_medecin = faker.email(),
                    )
                    conn.execute(insert_stmt)

        if self.table.name == "Patient":
            with engine.begin() as conn:
                for _ in range(self.num_records):
                    insert_stmt = self.table.insert().values(
                        Nom_patient = faker.last_name(),
                        Prenom_patient = faker.first_name(),
                        Date_de_naissance = faker.date_of_birth(minimum_age=1, maximum_age=120),
                        Adresse_patient = faker.address(),
                        Poids_patient = faker.pydecimal(left_digits=None, right_digits=1, positive=True, min_value=2.5, max_value=200),
                        Taille_patient = faker.random_int(45, 250),
                        NSS_patient = faker.ssn(),
                        Medecin_traitant = faker.name(),
                        Autorisation_partage = faker.boolean(chance_of_getting_true=50),
                        Numéro_RPPS = random.choice(conn.execute(select([ Medecin.c.Numéro_RPPS])).fetchall())[0]
                    )
                    conn.execute(insert_stmt)

        if self.table.name == "Analyse":
            with engine.begin() as conn:
                for _ in range(self.num_records):
                    insert_stmt = self.table.insert().values(
                        Date_analyse = faker.date().strftime("%Y/%m/%d"),
                        Heure_analyse = faker.time().strftime("%H/%M/%S"),
                        Type_analyse = random.choice(type_list),
                        Forfait_analyse = random.choice(type_list) + ", " + random.choice(type_list) + ", " + random.choice(type_list),
                        Vecteur_analyse = random.choice(vecteur_list),
                        Numero_patient=random.choice(conn.execute(select([Patient.c.Numero_patient])).fetchall())[0]
                    )
                    conn.execute(insert_stmt)

        if self.table.name == "S_enregistre":
            with engine.begin() as conn:
                for _ in range(self.num_records):
                    insert_stmt = self.table.insert().values(
                        Numero_patient = random.choice(conn.execute(select([Patient.c.Numero_patient])).fetchall())[0],
                        Numero_de_ticket = random.choice(conn.execute(select([Enregistrement.c.Numero_de_ticket])).fetchall())[0]
                    )
                    conn.execute(insert_stmt)

if __name__ == "__main__":
    for i in database:
        generate_data = GenerateData(i)
        generate_data.create_data()
