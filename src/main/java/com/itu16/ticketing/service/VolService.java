package com.itu16.ticketing.service;

import java.util.List;

import com.itu16.ticketing.model.Utilisateur;
import com.itu16.ticketing.model.Vol;

import jakarta.persistence.EntityManager;

public class VolService extends CRUDService<Vol, Long> {

    private static VolService volService;

    private VolService() {
        super();
    }

    public static VolService getInstance() {
        if (volService == null) {
            volService = new VolService();
        }
        return volService;
    }

    public List<Vol> findByCriteria(String dateDepart, String villeA, String villeD){
       try (EntityManager em = emf.createEntityManager();) {
            return em.createQuery("SELECT v FROM Vol v WHERE "+
                                    "(:dd IS NULL or v.dateDepart = :dd) AND "+
                                    "(:vd IS NULL or v.villeDepart.name = :vd) AND "+
                                    "(:va IS NULL or v.villeArrivee.name= :va)",
                                    
                        Vol.class)
            .setParameter("vd", villeD)
            .setParameter("va", villeA)
            .getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

}
