import requests
import psycopg2
import random

DB_NAME = "public"
DB_USER = "postgres"
DB_PASSWORD = "rajae19"
DB_HOST = "localhost"
DB_PORT = "5432"


def create_table():
    conn = psycopg2.connect(dbname=DB_NAME, user=DB_USER, password=DB_PASSWORD, host=DB_HOST, port=DB_PORT)
    cur = conn.cursor()
    cur.execute("""
        CREATE TABLE IF NOT EXISTS countries (
            id SERIAL PRIMARY KEY,
            name VARCHAR(100),
            capital VARCHAR(100),
            flag TEXT,
            subregion VARCHAR(100),
            population INTEGER
        )
    """)
    conn.commit()
    cur.close()
    conn.close()

def fetch_random_countries():
    url = "https://restcountries.com/v3.1/all"
    response = requests.get(url)
    if response.status_code == 200:
        countries = response.json()
        return random.sample(countries, 10)
    else:
        print("Failed to fetch data from the API")
        return []

def insert_countries(countries):
    conn = psycopg2.connect(dbname=DB_NAME, user=DB_USER, password=DB_PASSWORD, host=DB_HOST, port=DB_PORT)
    cur = conn.cursor()
    for country in countries:
        name = country.get('name', {}).get('common', 'N/A')
        capital = country.get('capital', ['N/A'])[0]
        flag = country.get('flags', {}).get('png', 'N/A')
        subregion = country.get('subregion', 'N/A')
        population = country.get('population', 0)
        cur.execute("""
            INSERT INTO countries (name, capital, flag, subregion, population)
            VALUES (%s, %s, %s, %s, %s)
        """, (name, capital, flag, subregion, population))
    conn.commit()
    cur.close()
    conn.close()

def main():
    create_table()
    countries = fetch_random_countries()
    if countries:
        insert_countries(countries)
        print("10 random countries have been written to the database.")
    else:
        print("No countries were fetched from the API.")

if __name__ == "__main__":
    main()