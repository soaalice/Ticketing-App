CREATE TABLE modele(
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE avion (
    id SERIAL PRIMARY KEY,
    modele_id INT NOT NULL REFERENCES modele(id),
    date_fabrication DATE NOT NULL
);

CREATE TABLE ville (
    id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL UNIQUE
);

CREATE TABLE admin(
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    user_name VARCHAR(100) NOT NULL UNIQUE,
    pwd VARCHAR(255) NOT NULL
);

CREATE TABLE utilisateur(
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    user_name VARCHAR(100) NOT NULL UNIQUE,
    pwd VARCHAR(255) NOT NULL
);

CREATE TABLE type_siege(
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE modele_type_siege(
    id SERIAL PRIMARY KEY,
    modele_id INT NOT NULL REFERENCES modele(id),
    type_siege_id INT NOT NULL REFERENCES type_siege(id),
    n_siege INT NOT NULL DEFAULT 0,
    constraint unique_modele_type_siege UNIQUE (modele_id, type_siege_id)
);

CREATE TABLE siege_avion(
    id SERIAL PRIMARY KEY,
    type_siege_id INT NOT NULL REFERENCES type_siege(id),
    avion_id INT NOT NULL REFERENCES avion(id)
);

CREATE TABLE prix_siege_avion(
    id SERIAL PRIMARY KEY,
    siege_avion_id INT NOT NULL REFERENCES siege_avion(id),
    prix NUMERIC(10,2) NOT NULL DEFAULT 0
);

CREATE TABLE vol(
    id SERIAL PRIMARY KEY,
    avion_id INT NOT NULL REFERENCES avion(id),
    date_depart TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    date_arrivee TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ville_depart_id INT NOT NULL REFERENCES ville(id),
    ville_arrivee_id INT NOT NULL REFERENCES ville(id),
);

CREATE TABLE reservation(
    id SERIAL PRIMARY KEY,
    utilisateur_id INT NOT NULL REFERENCES utilisateur(id),
    vol_id INT NOT NULL REFERENCES vol(id),
    montant_total NUMERIC NOT NULL DEFAULT 0,
    prix_siege_avion_id NUMERIC NOT NULL DEFAULT 0,
    date_reservation TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE reservation_details(
    id SERIAL PRIMARY KEY,
    reservation_id INT NOT NULL REFERENCES reservation(id),
    siege_avion_id INT NOT NULL REFERENCES siege_avion(id),
    montant NUMERIC NOT NULL DEFAULT 0
);

CREATE TABLE promotion_vol(
    id SERIAL PRIMARY KEY,
    vol_id INT NOT NULL REFERENCES vol(id),
    reduction NUMERIC NOT NULL DEFAULT 0 CHECK (reduction >= 0 AND reduction <= 100),
    date_debut TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    date_fin TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    type_siege_id INT NOT NULL REFERENCES type_siege(id),
    n_siege INT NOT NULL DEFAULT 0
);

CREATE TABLE param (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    value VARCHAR(255) NOT NULL
);
