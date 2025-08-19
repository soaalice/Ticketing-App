SELECT
    vol.date_depart,
    vol.date_arrivee,
    ville.name AS ville_depart,
    ville2.name AS ville_arrivee
FROM
    vol
JOIN
    ville ON vol.ville_depart_id = ville.id
JOIN
    ville AS ville2 ON vol.ville_arrivee_id = ville2.id;
