package com.itu16.ticketing.service;

import com.itu16.ticketing.model.Param;

import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;

public class ParamService extends CRUDService<Param, Long> {

    private static ParamService paramService;

    private ParamService() {
        super();
    }

    public static ParamService getInstance() {
        if (paramService == null) {
            paramService = new ParamService();
        }
        return paramService;
    }

    public Param findByName(String name) {
        try (EntityManager em = emf.createEntityManager();) {
            return em.createQuery(
                            "SELECT p FROM Param p WHERE p.name = :name", Param.class)
                    .setParameter("name", name)
                    .getSingleResult();
        } catch (NoResultException ignored) {
            return null;
        }
    }

}
