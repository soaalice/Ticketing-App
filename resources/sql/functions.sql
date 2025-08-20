CREATE OR REPLACE FUNCTION insert_sieges_avion(avion_id INT)
RETURNS void AS $$
DECLARE
    var_modele_id INT;
    var_type_siege_id INT;
    var_n_siege INT;
    i INT;
BEGIN
    -- Récupérer le modèle de l'avion
    SELECT a.modele_id INTO var_modele_id
    FROM avion a
    WHERE a.id = avion_id;

    IF var_modele_id IS NULL THEN
        RAISE EXCEPTION 'Avion avec ID % introuvable ou sans modèle.', avion_id;
    END IF;

    -- Boucler sur les types de sièges du modèle
    FOR var_type_siege_id, var_n_siege IN
        SELECT mts.type_siege_id, mts.n_siege
        FROM modele_type_siege mts
        WHERE mts.modele_id = var_modele_id
    LOOP
        FOR i IN 1..var_n_siege LOOP
            INSERT INTO siege_avion (type_siege_id, avion_id)
            VALUES (var_type_siege_id, avion_id);
        END LOOP;
    END LOOP;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION trigger_insert_sieges_avion()
RETURNS TRIGGER AS $$
BEGIN
    PERFORM insert_sieges_avion(NEW.id);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trigger_insert_sieges
AFTER INSERT ON avion
FOR EACH ROW
EXECUTE FUNCTION insert_sieges_avion();


CREATE OR REPLACE FUNCTION get_nombre_sieges_libres(vol_id INT)
RETURNS INT AS $$
DECLARE
    total_sieges INT;
    sieges_reserves INT;
BEGIN
    -- Obtenir le nombre total de sièges dans l'avion pour ce vol
    SELECT COALESCE(SUM(mts.n_siege), 0)
    INTO total_sieges
    FROM modele_type_siege mts
    JOIN siege_avion sa ON mts.type_siege_id = sa.type_siege_id
    JOIN avion a ON sa.avion_id = a.id
    WHERE a.id = (SELECT avion_id FROM vol WHERE id = vol_id);

    -- Obtenir le nombre de sièges réservés pour ce vol
    SELECT COUNT(*)
    INTO sieges_reserves
    FROM reservation_details rd
    JOIN reservation r ON rd.reservation_id = r.id
    JOIN vol v ON r.vol_id = v.id
    WHERE v.id = get_nombre_sieges_libres.vol_id;

    -- Retourner le nombre de sièges libres
    RETURN total_sieges - sieges_reserves;
END;
$$ LANGUAGE plpgsql;

-- SANS VERIFICATION DES ANNULATIONS
CREATE OR REPLACE FUNCTION est_siege_libre_vol_actif(siege_id INT)
RETURNS BOOLEAN AS $$
DECLARE
    libre BOOLEAN;
BEGIN
    SELECT NOT EXISTS (
        SELECT 1
        FROM reservation_details rd
        JOIN reservation r ON r.id = rd.reservation_id
        JOIN vol v ON v.id = r.vol_id
        JOIN siege_avion sa ON sa.id = rd.siege_avion_id
        WHERE
            sa.id = siege_id
            AND CAST(v.date_depart AS TIMESTAMP) > NOW()
    ) INTO libre;

    RETURN libre;
END;
$$ LANGUAGE plpgsql;

select est_siege_libre_vol_actif(5);

-- AVEC VERIFICATION DES ANNULATIONS
CREATE OR REPLACE FUNCTION est_siege_libre_vol_actif(siege_id INT)
RETURNS BOOLEAN AS $$
DECLARE
    libre BOOLEAN;
BEGIN
    SELECT NOT EXISTS (
        SELECT 1
        FROM reservation_details rd
        JOIN reservation r ON r.id = rd.reservation_id
        JOIN vol v ON v.id = r.vol_id
        LEFT JOIN annulation_reservation ar ON ar.reservation_id = r.id
        LEFT JOIN annulation_reservation_details ard ON ard.reservation_details_id = rd.id
        WHERE
            rd.siege_avion_id = siege_id
            AND CAST(v.date_depart AS TIMESTAMP) > NOW()
            AND ar.id IS NULL -- la réservation globale n’est pas annulée
            AND ard.id IS NULL -- le détail de la réservation n’est pas annulé non plus
    ) INTO libre;

    RETURN libre;
END;
$$ LANGUAGE plpgsql;
