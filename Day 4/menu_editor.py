from menu_item import MenuItem
from menu_manager import MenuManager

def show_user_menu():
    while True:
        print("\n MENU DE GESTION ")
        print("V - Voir un article")
        print("A - Ajouter un article")
        print("D - Supprimer un article")
        print("U - Mettre à jour un article")
        print("S - Afficher le menu")
        print("Q - Quitter")

        try:
            choice = input("Votre choix : ").strip().upper()  # On enlève les espaces et convertit en majuscules
            print(f"Vous avez choisi : {choice}")  # Débogage
        except Exception as e:
            print(f"Erreur lors de la lecture de l'entrée : {e}")
            continue

        if choice == "V":
            name = input("Nom de l'article ? ").strip()
            item = MenuManager.get_by_name(name)
            if item:
                print(f" {item}")
            else:
                print(" Article non trouvé.")

        elif choice == "A":
            name = input("Nom de l'article : ").strip()
            try:
                price = int(input("Prix de l'article : ").strip())
                item = MenuItem(name, price)
                item.save()
            except ValueError:
                print(" Prix invalide, veuillez entrer un nombre.")

        elif choice == "D":
            name = input("Nom de l'article à supprimer : ").strip()
            item = MenuItem(name, 0)
            item.delete()

        elif choice == "U":
            name = input("Nom actuel de l'article : ").strip()
            new_name = input("Nouveau nom : ").strip()
            try:
                new_price = int(input("Nouveau prix : ").strip())
                item = MenuItem(name, 0)
                item.update(new_name, new_price)
            except ValueError:
                print("Prix invalide, veuillez entrer un nombre.")

        elif choice == "S":
            menu = MenuManager.all_items()
            print("\n MENU DU RESTAURANT ")
            for item in menu:
                print(f"{item[1]} - {item[2]}€")

        elif choice == "Q":
            print("\n Menu final :")
            show_restaurant_menu()
            print(" Au revoir !")
            break

        else:
            print(" Mauvais choix ! Veuillez entrer une option valide.")

def show_restaurant_menu():
    menu = MenuManager.all_items()
    print("\n MENU FINAL ")
    for item in menu:
        print(f"{item[1]} - {item[2]}€")

if __name__ == "__main__":
    show_user_menu()