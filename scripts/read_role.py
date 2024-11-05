#!/usr/bin/env python3

import requests
from requests.auth import HTTPBasicAuth
import json

url = "http://localhost:8080/api/v1/roles"
response = requests.get(url, auth=HTTPBasicAuth('admin', 'admin'))

if response.status_code == 200:
    roles = response.json()
    print(json.dumps(roles, indent=4))
else:
    print(f"Failed to get roles: {response.status_code} - {response.text}")
