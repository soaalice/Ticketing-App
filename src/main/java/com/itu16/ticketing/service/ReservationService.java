package com.itu16.ticketing.service;

import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.itu16.ticketing.dto.Status;
import com.itu16.ticketing.model.PrixTypeSiegeVol;
import com.itu16.ticketing.model.PromotionVol;
import com.itu16.ticketing.model.Reservation;
import com.itu16.ticketing.model.ReservationDetails;
import com.itu16.ticketing.model.SiegeAvion;
import com.itu16.ticketing.model.Utilisateur;
import com.itu16.ticketing.model.Vol;
import com.itu16.ticketing.model.AgeCategorie;
import com.itu16.ticketing.model.Param;

import jakarta.transaction.Transactional;

public class ReservationService extends CRUDService<Reservation, Long> {

    private static ReservationService reservationService;
    private final ReservationDetailsService reservationDetailsService = ReservationDetailsService.getInstance();
    private final SiegeAvionService siegeAvionService = SiegeAvionService.getInstance();
    private final PrixTypeSiegeVolService prixTypeSiegeVolService = PrixTypeSiegeVolService.getInstance();
    private final PromotionVolService promotionVolService = PromotionVolService.getInstance();
    private final AgeCategorieService ageCategorieService = AgeCategorieService.getInstance();
    private final ParamService paramService = ParamService.getInstance();

    private ReservationService() {
        super();
    }

    public static ReservationService getInstance() {
        if (reservationService == null) {
            reservationService = new ReservationService();
        }
        return reservationService;
    }

    @Override
    public Reservation findById(Long id) {
        Reservation reservation = super.findById(id);
        
        int cancelledDetails = 0;
        if (reservation != null) {
            for (ReservationDetails details : reservation.getReservationDetails()) {
                if (details.getStatus() == Status.CANCELLED) {
                    cancelledDetails++;
                }
            }
            if (cancelledDetails == reservation.getReservationDetails().size()) {
                reservation.setStatus(Status.CANCELLED);
                update(reservation);
            }
        }
        return reservation;
    }

    @Transactional
    public Reservation generateReservation(Vol vol, Utilisateur utilisateur, Map<String, String> request) {
        System.out.println("............................Génération de la réservation..................................");

        System.err.println("REQUEST MAP: " + request);
        Reservation reservation = new Reservation();

        Integer nSiege = Integer.parseInt(request.get("nSiege"));
        System.err.println("Nombre de sièges à réserver: " + nSiege);

        List<ReservationDetails> reservationDetailsList = new ArrayList<>();
        double montantTotal = 0;
        double montantPromu = 0;

        for (int i = 1; i <= nSiege; i++) {
            String paramName = "siegeAvionId" + i;
            String siegeIdStr = request.get(paramName);

            System.out.println(paramName + ": " + siegeIdStr);

            ReservationDetails reservationDetails = new ReservationDetails();

            String ageCategorieParam = "ageCategorie" + i;
            String ageCategorie = request.get(ageCategorieParam);
            AgeCategorie age = null;
            if (ageCategorie != null && !ageCategorie.isEmpty()) {
                age = ageCategorieService.findById(Long.parseLong(ageCategorie));
            }
            reservationDetails.setAgeCategorie(age);

            if (siegeIdStr != null && !siegeIdStr.isEmpty()) {
                try {
                    SiegeAvion siegeAvion = siegeAvionService.findById(Long.parseLong(siegeIdStr));
                    reservationDetails.setSiegeAvion(siegeAvion);
                    PrixTypeSiegeVol prix = prixTypeSiegeVolService.findByTypeSiegeVol(siegeAvion.getTypeSiege(), vol);
                    double prixAReduire = prix.getPrix();

                    System.out.println("Prix de base pour le siège " + siegeAvion.getId() + ": " + prixAReduire);

                    List<PromotionVol> promotions = promotionVolService.findByVolId(vol.getId());
                    System.out.println("Promotions applicables:"+promotions);

                    // Si aucune promotion n'est applicable, le prix réduit est 0
                    if (promotions.size() <= 0) {
                        prixAReduire = 0;
                    }

                    for (PromotionVol promo : promotions) {
                        if(prixAReduire == 0) {
                            break;
                        }

                        if (promo.getStatus() == Status.ACTIVE 
                            && promo.getTypeSiege().getId().intValue() == siegeAvion.getTypeSiege().getId().intValue()
                            && promo.getNSiegesPromus().intValue() < promo.getNSiege().intValue()) {
                                if (prixAReduire - prixAReduire * promo.getReduction()/100 <= 0) {
                                    prixAReduire = 0;
                                } else {
                                    System.out.println("Application de la promotion: "+promo+" sur le siege +"+siegeAvion.getId());

                                    prixAReduire -= prixAReduire * promo.getReduction()/100;
                                    promo.setNSiege(promo.getNSiege() - 1);
                                    promo.setNSiegesPromus(promo.getNSiegesPromus() + 1);
                                    promotionVolService.update(promo);
                                }
                            System.out.println("Prix réduit après "+promo+" : "+prixAReduire);
                        }
                    }

                    reservationDetails.setMontant(prix.getPrix());
                    reservationDetails.setMontantPromu(prixAReduire);
                    reservationDetailsList.add(reservationDetails);

                    montantTotal += prix.getPrix();
                    montantPromu += prixAReduire;
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                }
            }
        }
        reservation.setReservationDetails(reservationDetailsList);
        reservation.setVol(vol);
        reservation.setDateReservation(LocalDateTime.now().toString());
        reservation.setMontantTotal(montantTotal);
        reservation.setMontantPromu(montantPromu);
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

    public void setDateButoireAnnulation(Reservation reservation) {
        // A priori ca doit etre la valeur de l'heure avant le départ du vol
        Param param = paramService.findByName("heure_minimale_annulation");
        if (param != null) {
            LocalDateTime dateTime = LocalDateTime.parse(reservation.getVol().getDateDepart());
            dateTime = dateTime.minusHours(Long.parseLong(param.getValue()));
            reservation.setDateButoireAnnulation(dateTime.toString());
        }
    }

    @Override
    public void create(Reservation entity) {
        setDateButoireAnnulation(entity);
        super.create(entity);
    }
}