package com.itu16.ticketing.controller;

import java.util.List;

import com.itu16.ticketing.model.Ville;
import com.itu16.ticketing.service.VilleService;

import mg.annotation.AnnotationController;
import mg.annotation.RestApi;
import mg.annotation.Url;
import mg.annotation.verbs.Get;

@AnnotationController
public class VilleController {
    private final VilleService villeService = VilleService.getInstance();

    @Get
    @RestApi
    @Url("api/villes")
    public List<Ville> villes() {
        return villeService.findAll();
    }
}
