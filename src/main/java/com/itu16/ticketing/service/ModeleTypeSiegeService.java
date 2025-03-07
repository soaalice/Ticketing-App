package com.itu16.ticketing.service;

import com.itu16.ticketing.model.ModeleTypeSiege;

public class ModeleTypeSiegeService extends CRUDService<ModeleTypeSiege, Long> {

    private static ModeleTypeSiegeService modeleTypeSiegeService;

    private ModeleTypeSiegeService() {
        super();
    }

    public static ModeleTypeSiegeService getInstance() {
        if (modeleTypeSiegeService == null) {
            modeleTypeSiegeService = new ModeleTypeSiegeService();
        }
        return modeleTypeSiegeService;
    }

}
