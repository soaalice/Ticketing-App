package com.itu16.ticketing.controller;

import java.util.List;

import com.itu16.ticketing.model.*;
import com.itu16.ticketing.service.*;

import mg.annotation.AnnotationController;
import mg.annotation.RestApi;
import mg.annotation.Url;
import mg.annotation.verbs.Get;

@AnnotationController
public class TestController {

    private final AvionService avionService = AvionService.getInstance();
    private final UtilisateurService utilisateurService = UtilisateurService.getInstance();
    private final ModeleService modeleService = ModeleService.getInstance();
    private final VilleService villeService = VilleService.getInstance();
    private final ModeleTypeSiegeService modeleTypeSiegeService = ModeleTypeSiegeService.getInstance();
    
    @Get
    @RestApi
    @Url("test")
    public List<ModeleTypeSiege> test() {
        System.out.println("test controller");
        return modeleTypeSiegeService.findAll();
    }
}
