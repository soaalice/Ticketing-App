package com.itu16.ticketing.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.itu16.ticketing.model.PrixTypeSiegeVol;
import com.itu16.ticketing.model.Reservation;
import com.itu16.ticketing.model.ReservationDetails;
import com.itu16.ticketing.model.SiegeAvion;
import com.itu16.ticketing.model.Utilisateur;
import com.itu16.ticketing.model.Vol;

public class ReservationService extends CRUDService<Reservation, Long> {

    private static ReservationService reservationService;
    private final ReservationDetailsService reservationDetailsService = ReservationDetailsService.getInstance();
    private final SiegeAvionService siegeAvionService = SiegeAvionService.getInstance();
    private final PrixTypeSiegeVolService prixTypeSiegeVolService = PrixTypeSiegeVolService.getInstance();

    private ReservationService() {
        super();
    }

    public static ReservationService getInstance() {
        if (reservationService == null) {
            reservationService = new ReservationService();
        }
        return reservationService;
    }

    public Reservation generateReservation(Vol vol, Utilisateur utilisateur, Map<String, String> request) {
        System.out.println("Génération de la réservation...");
        System.out.println("REQUETES MAP : " + request);
        Reservation reservation = new Reservation();

        Integer nSiege = Integer.parseInt(request.get("nSiege"));
        System.err.println("Nombre de sièges à réserver: " + nSiege);
        List<ReservationDetails> reservationDetailsList = new ArrayList<>();
        double montantTotal = 0;
        for (int i = 1; i <= nSiege; i++) {
            String paramName = "siegeAvionId" + i;
            String siegeIdStr = request.get(paramName);
            System.out.println(paramName + ": " + siegeIdStr);
            ReservationDetails reservationDetails = new ReservationDetails();
            if (siegeIdStr != null && !siegeIdStr.isEmpty()) {
                try {
                    SiegeAvion siegeAvion = siegeAvionService.findById(Long.parseLong(siegeIdStr));
                    reservationDetails.setSiegeAvion(siegeAvion);
                    PrixTypeSiegeVol prix = prixTypeSiegeVolService.findByTypeSiegeVol(siegeAvion.getTypeSiege(), vol);
                    reservationDetails.setMontant(prix.getPrix());
                    reservationDetailsList.add(reservationDetails);

                    montantTotal += prix.getPrix();
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                }
            }
        }
        reservation.setReservationDetails(reservationDetailsList);
        reservation.setVol(vol);
        reservation.setDateReservation(request.get("dateReservation"));
        reservation.setMontantTotal(montantTotal);
        reservation.setUtilisateur(utilisateur);
        reservationService.create(reservation);
        createDetails(reservation, reservationDetailsList);
        return reservation;
    }

    private void createDetails(Reservation reservation, List<ReservationDetails> detailsList) {
        for (ReservationDetails details : detailsList) {
            details.setReservation(reservation);
            reservationDetailsService.create(details);
        }
    }
}