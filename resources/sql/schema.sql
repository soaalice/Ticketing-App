CREATE TABLE modele(
    id SERIAL PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE avion (
    id SERIAL PRIMARY KEY,
    modele_id INT NOT NULL REFERENCES modele(id),
    date_fabrication DATE
);

CREATE TABLE ville (
    id SERIAL PRIMARY KEY,
    name VARCHAR(150)
);

CREATE TABLE aeroport(
    id SERIAL PRIMARY KEY,
    name VARCHAR(150),
    ville_id INT NOT NULL REFERENCES ville(id)
);

CREATE TABLE utilisateur(
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(255)
);

CREATE TABLE type_siege(
    id SERIAL PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE modele_type_siege(
    id SERIAL PRIMARY KEY,
    modele_id INT NOT NULL REFERENCES modele(id),
    type_siege_id INT NOT NULL REFERENCES type_siege(id),
    n_siege INT NOT NULL DEFAULT 0
);

CREATE TABLE siege_avion(
    id SERIAL PRIMARY KEY,
    type_siege_id INT NOT NULL REFERENCES type_siege(id),
    avion_id INT NOT NULL REFERENCES avion(id)
);

CREATE TABLE vol(
    id SERIAL PRIMARY KEY,
    avion_id INT NOT NULL REFERENCES avion(id),
    date_depart TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    date_arrivee TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    aeroport_depart INT NOT NULL REFERENCES aeroport(id),
    aeroport_arrivee INT NOT NULL REFERENCES aeroport(id),
);

CREATE TABLE reservation(
    id SERIAL PRIMARY KEY,
    utilisateur_id INT NOT NULL REFERENCES utilisateur(id),
    vol_id INT NOT NULL REFERENCES vol(id)
);

CREATE TABLE reservation_details(
    id SERIAL PRIMARY KEY,
    reservation_id INT NOT NULL REFERENCES reservation(id),
    siege_avion_id INT NOT NULL REFERENCES siege_avion(id)
);


