package com.itu16.ticketing.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.itu16.ticketing.model.PrixTypeSiegeVol;
import com.itu16.ticketing.model.Reservation;
import com.itu16.ticketing.model.ReservationDetails;
import com.itu16.ticketing.model.SiegeAvion;
import com.itu16.ticketing.model.Utilisateur;
import com.itu16.ticketing.model.Vol;
import com.itu16.ticketing.model.AgeCategorie;
import com.itu16.ticketing.service.AnnulationReservationDetailsService;
import com.itu16.ticketing.service.AnnulationReservationService;
import com.itu16.ticketing.service.PrixTypeSiegeVolService;
import com.itu16.ticketing.service.AgeCategorieService;
import com.itu16.ticketing.service.ReservationDetailsService;
import com.itu16.ticketing.service.ReservationService;
import com.itu16.ticketing.service.SiegeAvionService;
import com.itu16.ticketing.service.UtilisateurService;
import com.itu16.ticketing.service.VolService;

import dev.CustomSession;
import dev.ModelView;
import mg.annotation.AnnotationController;
import mg.annotation.Param;
import mg.annotation.Url;
import mg.annotation.authentification.Authentified;
import mg.annotation.verbs.Get;
import mg.annotation.verbs.Post;

@AnnotationController
public class ReservationController {
    private final ReservationService reservationService = ReservationService.getInstance();
    private final ReservationDetailsService reservationDetailsService = ReservationDetailsService.getInstance();
    private final UtilisateurService utilisateurService = UtilisateurService.getInstance();
    private  final SiegeAvionService siegeAvionService = SiegeAvionService.getInstance();
    private final VolService volService = VolService.getInstance();
    private final PrixTypeSiegeVolService prixTypeSiegeVolService = PrixTypeSiegeVolService.getInstance();
    private final AnnulationReservationService annulationReservationService = AnnulationReservationService.getInstance();
    private final AnnulationReservationDetailsService annulationReservationDetailsService = AnnulationReservationDetailsService.getInstance();
    private final AgeCategorieService ageCategorieService = AgeCategorieService.getInstance();

    @Get
    @Url("reservations")
    @Authentified(roles={"user", "admin"})
    public ModelView afficherReservations(CustomSession session) {
        String role = (String) session.get("role");
        List<Reservation> reservations = new ArrayList<>();
        switch (role) {
            case "admin":
                reservations = reservationService.findAll();
                break;
            case "user":
                long userId = (long) session.get("idUtilisateur");
                Utilisateur utilisateur = utilisateurService.findById((int) userId);
                reservations = utilisateur.getReservations();
                break;
            default:
                throw new AssertionError();
        }
        ModelView modelView = new ModelView();
        modelView.setUrl("/reservations.jsp");
        modelView.addObject("reservations", reservations);
        return modelView;
    }

    @Get
    @Url("reservations/details")
    @Authentified(roles={"user", "admin"})
    public ModelView afficherDetailsReservation(@Param(name="id") String id) {
        ModelView modelView = new ModelView();
        modelView.setUrl("/reservation-details.jsp");
        Long reservationId = Long.parseLong(id);
        Reservation reservation = reservationService.findById(reservationId);
        modelView.addObject("reservation", reservation);
        return modelView;
    }

    @Get
    @Url("reservations/create")
    @Authentified(roles={"user", "admin"})
    public ModelView afficherFormulaireCreationReservation(@Param(name="volId") String volId) {
        Vol vol = volService.findById(Long.parseLong(volId));
        ModelView modelView = new ModelView();
        modelView.setUrl("/reservation-create.jsp");
        modelView.addObject("vol", vol);
        List<SiegeAvion> sieges = vol.getAvion().getSieges();
        for (SiegeAvion siege : sieges) {
            PrixTypeSiegeVol prix = prixTypeSiegeVolService.findByTypeSiegeVol(siege.getTypeSiege(), vol);
            siege.setPrix(prix.getPrix());
            siegeAvionService.updateStatus(siege);
        }
        modelView.addObject("sieges", sieges);

        List<AgeCategorie> ageCategories = ageCategorieService.findAll();
        modelView.addObject("ageCategories", ageCategories);
        return modelView;
    }

    @Post
    @Url("reservations/create")
    @Authentified(roles={"user"})
    public ModelView creerReservation(Map<String, String> request, CustomSession session) {
        Object idObj = session.get("idUtilisateur");

        Long idUtilisateur = (idObj instanceof Long) ? (Long) idObj
                        : (idObj instanceof Integer) ? ((Integer) idObj).longValue()
                        : null;

        Utilisateur utilisateur = utilisateurService.findById((int) (long) idUtilisateur);
        ModelView modelView = new ModelView();
        modelView.setUrl("/reservation-details.jsp");
        Vol vol = volService.findById(Long.parseLong(request.get("volId")));
        Reservation reservation = reservationService.generateReservation(vol, utilisateur, request);
        modelView.addObject("reservation", reservation);
        return modelView;
    }

    @Post
    @Url("reservations/cancel")
    @Authentified(roles={"user", "admin"})
    public ModelView annulerReservation(@Param(name = "id") String id, CustomSession session) {
        Long idReservation = Long.parseLong(id);
        Reservation reservation = reservationService.findById(idReservation);
        String description = "Annulation de la réservation pour le vol " + reservation.getVol().getId();
        if (session.get("role").equals("admin")) {
            description += " par un administrateur";
        } else {
            description += " par l'utilisateur";
        }
        if (reservation != null) {
            annulationReservationService.cancelReservation(reservation, description);
        }
        ModelView modelView = new ModelView();
        List<Reservation> reservations = reservationService.findAll();
        modelView.addObject("reservations", reservations);
        modelView.setUrl("/reservations.jsp");
        return modelView;
    }

    @Post
    @Url("reservations/details/cancel")
    @Authentified(roles={"user"})
    public ModelView annulerReservationDetails(@Param(name="id") String id){
        Long idReservationDetails = Long.parseLong(id);
        ReservationDetails details = reservationDetailsService.findById(idReservationDetails);
        if (details != null) {
            annulationReservationDetailsService.cancelReservationDetails(details);
        }
        ModelView modelView = new ModelView();
        modelView.setUrl("/reservation-details.jsp");
        modelView.addObject("reservation", details.getReservation());
        return modelView;
    }
}