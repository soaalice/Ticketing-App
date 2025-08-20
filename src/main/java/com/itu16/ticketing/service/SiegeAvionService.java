package com.itu16.ticketing.service;

import com.itu16.ticketing.dto.Status;
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

    public SiegeAvion updateStatus(SiegeAvion siegeAvion) {
        if (siegeAvion != null) {
            Boolean isUpdated = getSingleValue("SELECT est_siege_libre_vol_actif(?)", Boolean.class, siegeAvion.getId());
            if (isUpdated != null) {
                siegeAvion.setStatus(isUpdated ? Status.FREE : Status.TAKEN);
                update(siegeAvion);
            } else {
                System.err.println("Erreur lors de la mise à jour du statut du siège avion avec ID: " + siegeAvion.getId());
            }
        }
        return siegeAvion;
    }
}
