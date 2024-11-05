import requests
import json

# Configuratie
AIRFLOW_API_URL = "http://localhost:8080/api/v1"
USERNAME = 'admin'
PASSWORD = 'admin'

auth = (USERNAME, PASSWORD)

print(f"AIRFLOW_API_URL: {AIRFLOW_API_URL}")

# Functie voor het ophalen van rollen in Airflow via API
def get_airflow_roles(uri, auth):
    url = f"{uri}/roles"
    response = requests.get(url, auth=auth)

    if response.status_code == 200:
        print("Rollen opgehaald:")
        print(response.json())
    else:
        print(f"Failed to get roles: {response.status_code}")
        print(response.text)

# Functie voor het aanmaken van een rol in Airflow via API
def create_airflow_role(uri, auth, role_name):
    url = f"{uri}/roles"
    headers = {'Content-Type': 'application/json'}
    data = json.dumps({"name": role_name})  # Veranderd veld naar "name"

    response = requests.post(url, headers=headers, auth=auth, data=data)

    if response.status_code == 201:
        print(f"Rol '{role_name}' aangemaakt.")
    else:
        print(f"Failed to create role: {response.status_code}")
        print(response.text)

# Hoofdfunctie
if __name__ == "__main__":
    # Voorbeeld: Ophalen van bestaande rollen
    # get_airflow_roles(AIRFLOW_API_URL, auth)

    # Voorbeeld: Aanmaken van een nieuwe rol
    nieuwe_rol_naam = "example_new_role"
    create_airflow_role(AIRFLOW_API_URL, auth, nieuwe_rol_naam)
