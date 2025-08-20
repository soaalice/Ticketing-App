package com.itu16.ticketing.service;

import com.itu16.ticketing.model.PrixTypeSiegeVol;
import com.itu16.ticketing.model.TypeSiege;
import com.itu16.ticketing.model.Vol;

import jakarta.persistence.EntityManager;

public class PrixTypeSiegeVolService extends CRUDService<PrixTypeSiegeVol, Object>{

    private static PrixTypeSiegeVolService prixTypeSiegeVolService;

    private PrixTypeSiegeVolService() {
        super();
    }

    public static PrixTypeSiegeVolService getInstance() {
        if (prixTypeSiegeVolService == null) {
            prixTypeSiegeVolService = new PrixTypeSiegeVolService();
        }
        return prixTypeSiegeVolService;
    }

    public PrixTypeSiegeVol findByTypeSiegeVol(TypeSiege typeSiege, Vol vol) {
        try (EntityManager em = emf.createEntityManager();) {
            return em.createQuery(
                    "SELECT p FROM PrixTypeSiegeVol p WHERE p.typeSiege.id = :typeSiege AND p.vol.id = :vol", PrixTypeSiegeVol.class)
                    .setParameter("typeSiege", typeSiege.getId())
                    .setParameter("vol", vol.getId())
                    .getSingleResult();
        } catch (Exception e) {
            return null;
        }
    }
}
