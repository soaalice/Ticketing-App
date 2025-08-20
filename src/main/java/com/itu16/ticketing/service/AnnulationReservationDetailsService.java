package com.itu16.ticketing.service;

import java.time.LocalDateTime;

import com.itu16.ticketing.dto.Status;
import com.itu16.ticketing.model.AnnulationReservationDetails;
import com.itu16.ticketing.model.ReservationDetails;

import jakarta.transaction.Transactional;

public class AnnulationReservationDetailsService extends CRUDService<AnnulationReservationDetails, Long> {

    private static AnnulationReservationDetailsService annulationReservationDetailsService;
    private final SiegeAvionService siegeAvionService = SiegeAvionService.getInstance();
    private final ReservationDetailsService reservationDetailsService = ReservationDetailsService.getInstance();

    private AnnulationReservationDetailsService() {
        super();
    }

    public static AnnulationReservationDetailsService getInstance() {
        if (annulationReservationDetailsService == null) {
            annulationReservationDetailsService = new AnnulationReservationDetailsService();
        }
        return annulationReservationDetailsService;
    }
    
    @Transactional
    public void cancelReservationDetails(ReservationDetails details) {
        AnnulationReservationDetails annulationReservationDetails = new AnnulationReservationDetails();
        details.getSiegeAvion().setStatus(Status.FREE);
        siegeAvionService.update(details.getSiegeAvion());
        details.setStatus(Status.CANCELLED);
        reservationDetailsService.update(details);
        annulationReservationDetails.setReservationDetails(details);
        annulationReservationDetails.setDateAnnulation(LocalDateTime.now().toString());
        annulationReservationDetails.setDescription("Annulation de la réservation pour le siege " + details.getSiegeAvion().getId());
        create(annulationReservationDetails);
    }
}
