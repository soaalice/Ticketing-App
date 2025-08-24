package com.itu16.ticketing.controller;

import com.itu16.ticketing.service.ParamService;

import dev.ModelView;
import mg.annotation.AnnotationController;
import mg.annotation.Param;
import mg.annotation.Url;
import mg.annotation.authentification.Authentified;
import mg.annotation.verbs.Get;
import mg.annotation.verbs.Post;

@Authentified(roles={"admin"})
@AnnotationController
public class ParamController {
    
    private final ParamService paramService = ParamService.getInstance();

    @Get
    @Url("edit-minimal-hours")
    public ModelView afficherEditMinimalHours() {
        ModelView modelView = new ModelView();
        modelView.addObject("paramHeureReservation", paramService.findByName("heure_minimale_fin_reservation"));
        modelView.addObject("paramHeureAnnulation", paramService.findByName("heure_minimale_annulation"));
        modelView.setUrl("/edit-minimal-hours.jsp");
        return modelView;
    }

    @Post
    @Url("edit-minimal-hours")
    public ModelView traiterEditMinimalHours(@Param(name="paramHeureReservation") String paramHeureReservation, 
                                            @Param(name="paramHeureAnnulation") String paramHeureAnnulation) {
        ModelView modelView = new ModelView();

        com.itu16.ticketing.model.Param param1 = paramService.findByName("heure_minimale_fin_reservation");
        com.itu16.ticketing.model.Param param2 = paramService.findByName("heure_minimale_annulation");

        if (paramHeureReservation!= null) {
            param1.setValue(paramHeureReservation);
            paramService.update(param1);
        }

        if (paramHeureAnnulation!= null) {
            param2.setValue(paramHeureAnnulation);
            paramService.update(param2);
        }

        modelView.addObject("paramHeureReservation", param1);
        modelView.addObject("paramHeureAnnulation", param2);
        modelView.setUrl("/edit-minimal-hours.jsp");
        return modelView;
    }
}
