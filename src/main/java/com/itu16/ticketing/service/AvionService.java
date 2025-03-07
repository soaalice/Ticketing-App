package com.itu16.ticketing.service;

import com.itu16.ticketing.model.Avion;

public class AvionService extends CRUDService<Avion, Long> {

    private static AvionService avionService;

    private AvionService() {
        super();
    }

    public static AvionService getInstance() {
        if (avionService == null) {
            avionService = new AvionService();
        }
        return avionService;
    }

}
