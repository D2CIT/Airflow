# Airflow
Airflow 

## Fernetkey

#### Install cryptography for python
```
pip install --upgrade pip
pip install cryptography
```

#### Run pythonscript to create a fernetkey
```
from cryptography.fernet import Fernet

fernet_key = Fernet.generate_key()
print(fernet_key.decode())  # Output the generated key
```
