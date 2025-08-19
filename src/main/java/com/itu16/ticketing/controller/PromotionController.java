package com.itu16.ticketing.controller;

import com.itu16.ticketing.model.PromotionVol;
import com.itu16.ticketing.model.TypeSiege;
import com.itu16.ticketing.model.Vol;
import com.itu16.ticketing.service.PromotionVolService;
import com.itu16.ticketing.service.TypeSiegeService;
import com.itu16.ticketing.service.VolService;

import dev.ModelView;
import mg.annotation.AnnotationController;
import mg.annotation.Param;
import mg.annotation.Url;
import mg.annotation.authentification.Authentified;
import mg.annotation.verbs.Get;
import mg.annotation.verbs.Post;

@AnnotationController
public class PromotionController {
    private final PromotionVolService promotionVolService = PromotionVolService.getInstance();
    private final VolService volService = VolService.getInstance();
    private final TypeSiegeService typeSiegeService = TypeSiegeService.getInstance();

    @Get
    @Url("promotions")
    public ModelView afficherPromotions() {
        ModelView modelView = new ModelView();
        modelView.setUrl("/promotions.jsp");
        modelView.addObject("promotions", promotionVolService.findAll());
        return modelView;
    }

    @Get
    @Url("promotions/create")
    @Authentified(roles={"admin"})
    public ModelView afficherFormulaireCreationPromotion() {
        ModelView modelView = new ModelView();
        modelView.addObject("vols", volService.findAll());
        modelView.addObject("typesSiege", typeSiegeService.findAll());
        modelView.setUrl("/promotion-create.jsp");
        return modelView;
    }

    @Post
    @Url("promotions/create")
    @Authentified(roles={"admin"})
    public ModelView creerPromotion(@Param(name = "volId") String volId,
                                    @Param(name = "reduction") String reduction,
                                    @Param(name = "typeSiegeId") String typeSiegeId,
                                    @Param(name = "dateDebut") String dateDebut,
                                    @Param(name = "dateFin") String dateFin,
                                    @Param(name= "nSiege") String nSiege) {
        Long volIdLong = Long.valueOf(volId);
        Vol vol = volService.findById(volIdLong);
        Long typeSiegeIdLong = Long.valueOf(typeSiegeId);
        TypeSiege typeSiege = TypeSiegeService.getInstance().findById(typeSiegeIdLong);
        Integer nSiegeLong = Integer.valueOf(nSiege);
        Double reductionDouble = Double.valueOf(reduction);
        PromotionVol promotion = new PromotionVol();
        promotion.setVol(vol);
        promotion.setReduction(reductionDouble);
        promotion.setTypeSiege(typeSiege);
        promotion.setDateDebut(dateDebut);
        promotion.setDateFin(dateFin);
        promotion.setNSiege(nSiegeLong);
        promotionVolService.create(promotion);
        ModelView modelView = new ModelView();
        modelView.setUrl("/promotions.jsp");
        modelView.addObject("promotions", promotionVolService.findAll());
        return modelView;
    }
}
