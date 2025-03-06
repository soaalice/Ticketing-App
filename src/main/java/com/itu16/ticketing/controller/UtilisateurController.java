package com.itu16.ticketing.controller;

import java.util.List;

import com.itu16.ticketing.model.Utilisateur;
import com.itu16.ticketing.service.UtilisateurService;

import mg.annotation.AnnotationController;
import mg.annotation.RestApi;
import mg.annotation.Url;
import mg.annotation.verbs.Get;

@AnnotationController
public class UtilisateurController {

    @Get
    @RestApi
    @Url("utilisateurs")
    public List<Utilisateur> listerUtilisateurs() {
        return UtilisateurService.getInstance().findAll();
    }
    
}
