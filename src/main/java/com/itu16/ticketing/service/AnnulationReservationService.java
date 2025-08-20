package com.itu16.ticketing.service;

import java.time.LocalDateTime;

import com.itu16.ticketing.dto.Status;
import com.itu16.ticketing.model.AnnulationReservation;
import com.itu16.ticketing.model.AnnulationReservationDetails;
import com.itu16.ticketing.model.Reservation;
import com.itu16.ticketing.model.ReservationDetails;

import jakarta.transaction.Transactional;

public class AnnulationReservationService extends CRUDService<AnnulationReservation, Long> {
    private final AnnulationReservationDetailsService annulationReservationDetailsService = AnnulationReservationDetailsService.getInstance();
    private final ReservationService reservationService = ReservationService.getInstance();
    private final ReservationDetailsService reservationDetailsService = ReservationDetailsService.getInstance();

    private static AnnulationReservationService annulationReservationService;

    private AnnulationReservationService() {
        super();
    }

    public static AnnulationReservationService getInstance() {
        if (annulationReservationService == null) {
            annulationReservationService = new AnnulationReservationService();
        }
        return annulationReservationService;
    }

    @Transactional
    public AnnulationReservation cancelReservation(Reservation reservation, String description) {
        AnnulationReservation annulationReservation = new AnnulationReservation();
        reservation.setStatus(Status.CANCELLED);
        reservationService.update(reservation);
        annulationReservation.setReservation(reservation);
        annulationReservation.setDateAnnulation(LocalDateTime.now().toString());
        annulationReservation.setDescription(description);
        create(annulationReservation);

        for (ReservationDetails details : reservation.getReservationDetails()) {
            AnnulationReservationDetails annulationDetails = new AnnulationReservationDetails();
            details.setStatus(Status.CANCELLED);
            reservationDetailsService.update(details);
            annulationDetails.setReservationDetails(details);
            annulationDetails.setDateAnnulation(annulationReservation.getDateAnnulation());
            annulationDetails.setDescription("Annulation de la réservation principale pour le vol " + reservation.getVol().getId());
            annulationReservationDetailsService.create(annulationDetails);
        }
        return annulationReservation;
    }

}
