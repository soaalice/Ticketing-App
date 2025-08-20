package com.itu16.ticketing.service;

import com.itu16.ticketing.model.ReservationDetails;

public class ReservationDetailsService extends CRUDService<ReservationDetails, Long> {

    private static ReservationDetailsService reservationDetailsService;

    private ReservationDetailsService() {
        super();
    }

    public static ReservationDetailsService getInstance() {
        if (reservationDetailsService == null) {
            reservationDetailsService = new ReservationDetailsService();
        }
        return reservationDetailsService;
    }
}
