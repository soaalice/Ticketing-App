CREATE OR REPLACE FUNCTION insert_sieges_avion()
RETURNS TRIGGER AS $$
DECLARE
    modele_id INT;
    type_siege_id INT;
    n_siege INT;
    i INT;
BEGIN
    modele_id := NEW.modele_id;
    
    FOR type_siege_id, n_siege IN
        SELECT mts.type_siege_id, mts.n_siege
        FROM modele_type_siege mts
        WHERE mts.modele_id = NEW.modele_id
    LOOP
        FOR i IN 1..n_siege LOOP
            INSERT INTO siege_avion (type_siege_id, avion_id)
            VALUES (type_siege_id, NEW.id);
        END LOOP;
    END LOOP;

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
