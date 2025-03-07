package com.itu16.ticketing.service;

import com.itu16.ticketing.model.Modele;

public class ModeleService extends CRUDService<Modele, Long> {

    private static ModeleService modeleService;

    private ModeleService() {
        super();
    }

    public static ModeleService getInstance() {
        if (modeleService == null) {
            modeleService = new ModeleService();
        }
        return modeleService;
    }

}
