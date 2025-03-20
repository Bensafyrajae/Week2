import psycopg2

class MenuManager:
    @classmethod
    def get_by_name(cls, name):
        """Récupère un item par son nom"""
        try:
            conn = psycopg2.connect(dbname="restaurant", user="postgres", password="password", host="localhost", port="5432")
            cur = conn.cursor()
            cur.execute("SELECT * FROM Menu_Items WHERE item_name = %s", (name,))
            item = cur.fetchone()
            cur.close()
            conn.close()
            return item if item else None
        except Exception as e:
            print(" Erreur get_by_name:", e)
            return None

    @classmethod
    def all_items(cls):
        """Récupère tous les items"""
        try:
            conn = psycopg2.connect(dbname="restaurant", user="postgres", password="password", host="localhost", port="5432")
            cur = conn.cursor()
            cur.execute("SELECT * FROM Menu_Items")
            items = cur.fetchall()
            cur.close()
            conn.close()
            return items
        except Exception as e:
            print(" Erreur all_items:", e)
            return []
