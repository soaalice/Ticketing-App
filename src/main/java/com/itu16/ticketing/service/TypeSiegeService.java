package com.itu16.ticketing.service;

import com.itu16.ticketing.model.TypeSiege;

public class TypeSiegeService extends CRUDService<TypeSiege, Long> {

    private static TypeSiegeService typeSiegeService;

    private TypeSiegeService() {
        super();
    }

    public static TypeSiegeService getInstance() {
        if (typeSiegeService == null) {
            typeSiegeService = new TypeSiegeService();
        }
        return typeSiegeService;
    }

}
