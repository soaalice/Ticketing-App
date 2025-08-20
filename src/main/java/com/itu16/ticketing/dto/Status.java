package com.itu16.ticketing.dto;

public enum Status {
    CONFIRMED("Confirmée"),
    CANCELLED("Annulée");

    private final String label;

    Status(String label) {
        this.label = label;
    }

    public String getLabel() {
        return label;
    }
}
