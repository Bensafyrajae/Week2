import psycopg2


DB_NAME = "rest"
DB_USER = "postgres"
DB_PASSWORD = "rajae19"
DB_HOST = "localhost"
DB_PORT = "5432"

class MenuItem:
    def __init__(self, name, price):
        self.name = name
        self.price = price

    def save(self):
       
        try:
            conn = psycopg2.connect(dbname=DB_NAME, user=DB_USER, password=DB_PASSWORD, host=DB_HOST, port=DB_PORT)
            cur = conn.cursor()
            cur.execute("INSERT INTO Menu_Items (item_name, item_price) VALUES (%s, %s)", (self.name, self.price))
            conn.commit()
            cur.close()
            conn.close()
            print(f" {self.name} ajouté !")
        except Exception as e:
            print(" Erreur save:", e)

    def delete(self):
        """Supprime un item"""
        try:
            conn = psycopg2.connect(dbname=DB_NAME, user=DB_USER, password=DB_PASSWORD, host=DB_HOST, port=DB_PORT)
            cur = conn.cursor()
            cur.execute("DELETE FROM Menu_Items WHERE item_name = %s", (self.name,))
            conn.commit()
            cur.close()
            conn.close()
            print(f" {self.name} supprimé !")
        except Exception as e:
            print(" Erreur delete:", e)

    def update(self, new_name, new_price):
        """Met à jour un item"""
        try:
            conn = psycopg2.connect(dbname=DB_NAME, user=DB_USER, password=DB_PASSWORD, host=DB_HOST, port=DB_PORT)
            cur = conn.cursor()
            cur.execute("UPDATE Menu_Items SET item_name = %s, item_price = %s WHERE item_name = %s",
                        (new_name, new_price, self.name))
            conn.commit()
            cur.close()
            conn.close()
            print(f" {self.name} -> {new_name} ({new_price}€) !")
        except Exception as e:
            print(" Erreur update:", e)