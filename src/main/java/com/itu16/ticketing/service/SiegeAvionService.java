package com.itu16.ticketing.service;

import com.itu16.ticketing.model.SiegeAvion;

public class SiegeAvionService extends CRUDService<SiegeAvion, Long> {

    private static SiegeAvionService siegeAvionService;

    private SiegeAvionService() {
        super();
    }

    public static SiegeAvionService getInstance() {
        if (siegeAvionService == null) {
            siegeAvionService = new SiegeAvionService();
        }
        return siegeAvionService;
    }
    
}
