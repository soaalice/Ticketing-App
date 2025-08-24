package com.itu16.ticketing.dto;

public enum Status {
    // Sieges
    FREE("Libre"),
    TAKEN("Réservé"),
    // Vols
    FULL("Complet"),
    // Vols || Reservations
    ACTIVE("Actif"),
    INACTIVE("Inactif"),
    // SUSPENDED("Suspendue"),
    CONFIRMED("Confirmée"),
    CANCELLED("Annulée"),
    PENDING("En attente");

    private final String label;

    Status(String label) {
        this.label = label;
    }

    public String getLabel() {
        return label;
    }
}
