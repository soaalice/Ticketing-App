package com.itu16.ticketing.service;

import com.itu16.ticketing.model.Ville;

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

}
