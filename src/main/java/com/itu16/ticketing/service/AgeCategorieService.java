package com.itu16.ticketing.service;

import com.itu16.ticketing.model.AgeCategorie;

public class AgeCategorieService extends CRUDService<AgeCategorie, Long> {
    
    private static AgeCategorieService ageCategorieService;

    private AgeCategorieService() {
        super();
    }

    public static AgeCategorieService getInstance() {
        if (ageCategorieService == null) {
            ageCategorieService = new AgeCategorieService();
        }
        return ageCategorieService;
    }
}
