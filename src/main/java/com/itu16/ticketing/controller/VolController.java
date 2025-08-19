package com.itu16.ticketing.controller;

import java.util.List;

import com.itu16.ticketing.model.Vol;
import com.itu16.ticketing.service.AvionService;
import com.itu16.ticketing.service.VilleService;
import com.itu16.ticketing.service.VolService;

import dev.ModelView;
import mg.annotation.AnnotationController;
import mg.annotation.Param;
import mg.annotation.RestApi;
import mg.annotation.Url;
import mg.annotation.authentification.Authentified;
import mg.annotation.verbs.Get;
import mg.annotation.verbs.Post;

@AnnotationController
public class VolController {

    private final VolService volService = VolService.getInstance();
    private final AvionService avionService = AvionService.getInstance();
    private final VilleService villeService = VilleService.getInstance();

    @Get
    @RestApi
    @Url("api/vols")
    public List<Vol> listerVols(@Param(name = "dateDepart") String dateDepart, 
                                @Param(name = "villeDepart") String villeDepart,
                                @Param(name = "villeArrivee") String villeArrivee) {
        return volService.findByCriteria(dateDepart, villeDepart, villeArrivee);
    }

    @Get
    @Url("vols")
    public ModelView afficherVols(@Param(name = "dateDepart") String dateDepart,
                                @Param(name = "villeDepart") String villeDepart,
                                @Param(name = "villeArrivee") String villeArrivee) {
        ModelView mv = new ModelView();
        mv.setUrl("/vols.jsp");
        List<Vol> vols =  volService.findByCriteria(dateDepart, villeDepart, villeArrivee);
        System.out.println("Vols trouvés : " + vols);
        mv.addObject("vols", vols);
        return mv;
    }

    @Get
    @Url("vols/create")
    @Authentified(roles = {"admin"})
    public ModelView afficherFormCreationVol() {
        ModelView mv = new ModelView();
        mv.addObject("avions", avionService.findAll());
        mv.addObject("villes", villeService.findAll());
        mv.setUrl("/vol-create.jsp");
        return mv;
    }

    @Post
    @Url("vols/create")
    @Authentified(roles = {"admin"})
    public ModelView creerVol(@Param(name = "avion_id") String avionId,
                               @Param(name = "dateDepart") String dateDepart,
                               @Param(name = "dateArrivee") String dateArrivee,
                               @Param(name = "ville_depart_id") String villeDepartId,
                               @Param(name = "ville_arrivee_id") String villeArriveeId) {
        ModelView mv = new ModelView();
        Vol vol = new Vol();
        Long avionIdLong = Long.valueOf(avionId);
        vol.setAvion(avionService.findById(avionIdLong));
        vol.setDateDepart(dateDepart);
        vol.setDateArrivee(dateArrivee);
        Long villeDepartIdLong = Long.valueOf(villeDepartId);
        Long villeArriveeIdLong = Long.valueOf(villeArriveeId);
        vol.setVilleDepart(villeService.findById(villeDepartIdLong));
        vol.setVilleArrivee(villeService.findById(villeArriveeIdLong));
        volService.create(vol);
        mv.setUrl("/vols.jsp");
        return mv;
    
    }

    @Post
    @Url("vols/delete")
    @Authentified(roles = {"admin"})
    public ModelView supprimerVol(@Param(name = "id") String id) {
        ModelView mv = new ModelView();
        Long idLong = Long.valueOf(id);
        volService.delete(idLong);
        mv.setUrl("/vols.jsp");
        return mv;
    }

    @Get
    @Url("vols/edit")
    @Authentified(roles = {"admin"})
    public ModelView afficherFormEditionVol(@Param(name = "id") String id) {
        ModelView mv = new ModelView();
        Long idLong = Long.valueOf(id);
        Vol vol = volService.findById(idLong);
        mv.addObject("vol", vol);
        mv.addObject("avions", avionService.findAll());
        mv.addObject("villes", villeService.findAll());
        mv.setUrl("/vol-edit.jsp");
        return mv;
    }

    @Post
    @Url("vols/edit")
    @Authentified(roles = {"admin"})
    public ModelView modifierVol(@Param(name = "id") String id,
                                  @Param(name = "avion_id") String avionId,
                                  @Param(name = "dateDepart") String dateDepart,
                                  @Param(name = "dateArrivee") String dateArrivee,
                                  @Param(name = "ville_depart_id") String villeDepartId,
                                  @Param(name = "ville_arrivee_id") String villeArriveeId) {
        ModelView mv = new ModelView();
        Long idLong = Long.valueOf(id);
        Long avionIdLong = Long.valueOf(avionId);
        Long villeDepartIdLong = Long.valueOf(villeDepartId);
        Long villeArriveeIdLong = Long.valueOf(villeArriveeId);
        Vol vol = volService.findById(idLong);
        vol.setAvion(avionService.findById(avionIdLong));
        vol.setDateDepart(dateDepart);
        vol.setDateArrivee(dateArrivee);
        vol.setVilleDepart(villeService.findById(villeDepartIdLong));
        vol.setVilleArrivee(villeService.findById(villeArriveeIdLong));
        volService.update(vol);
        mv.setUrl("/vols.jsp");
        return mv;
    }

    @Get
    @Url("vols/details")
    public ModelView afficherDetailsVol(@Param(name = "id") String id) {
        ModelView mv = new ModelView();
        Long idLong = Long.valueOf(id);
        Vol vol = volService.findById(idLong);
        mv.addObject("vol", vol);
        mv.setUrl("/vol-details.jsp");
        return mv;
    }

}

