INSERT INTO ville (nom) VALUES 
('Canada'),
('Tananarive'),
('France'),
('Nigeria');

INSERT INTO vol(avion_id, date_depart, date_arrivee, ville_depart_id, ville_arrivee_id) VALUES 
(1, '2025-10-01 10:00:00', '2025-10-01 14:00:00', 1, 2),
(1, '2025-10-02 15:00:00', '2025-10-02 19:00:00', 2, 3),
(1, '2025-10-03 08:00:00', '2025-10-03 12:00:00', 3, 4);

INSERT INTO age_categorie (name, min, max) VALUES
('Enfant', 0, 12),
('Adolescent', 13, 17),
('Adulte', 18, 64),
('Senior', 65, 120);

INSERT INTO param (name, value) VALUES
('heure_minimale_fin_reservation', '12:00'),
('heure_minimale_annulation', '12:00');