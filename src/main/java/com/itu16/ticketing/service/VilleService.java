package com.itu16.ticketing.service;

import com.itu16.ticketing.model.Ville;

import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;

public class VilleService extends CRUDService<Ville, Long> {

    private static VilleService villeService;

    private VilleService() {
        super();
    }

    public static VilleService getInstance() {
        if (villeService == null) {
            villeService = new VilleService();
        }
        return villeService;
    }

    public Ville getVilleByName(String name) {
        try (EntityManager em = emf.createEntityManager();) {
            return em.createQuery(
                            "SELECT v FROM Ville v WHERE v.name = :name", Ville.class)
                    .setParameter("name", name)
                    .getSingleResult();
        } catch (NoResultException ignored) {
            return null;
        }
    }

}
