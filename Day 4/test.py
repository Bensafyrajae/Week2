import psycopg2

HOSTNAME = "localhost"
USERNAME = "postgres"
PASSWORD = "rajae19"
DATABASE = "public"

try:
    with psycopg2.connect(
        dbname=DATABASE,
        user=USERNAME,
        password=PASSWORD,
        host=HOSTNAME
    ) as connection:
        with connection.cursor() as cursor:
            # Set client encoding to match database encoding
            cursor.execute("SET client_encoding TO 'LATIN1';")  # Change if necessary
            query = "SELECT * FROM items LIMIT 20;"
            cursor.execute(query)
            results = cursor.fetchall()

            # Convert each result to UTF-8
            for row in results:
                print([str(item).encode('latin1').decode('utf-8') if isinstance(item, str) else item for item in row])

except Exception as e:
    print(f"Error: {e}")
