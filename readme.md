Usando faker para generar datos:
pip install Faker mysql-connector-python


python3 -m venv /home/juan/pyenv
source /home/juan/pyenv/bin/activate

Cargar csv en tabla:
LOAD DATA INFILE 'ruta_al_archivo/recintos.csv'
INTO TABLE TuTabla
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
