package com.itu16.ticketing.controller;

import java.util.List;

import com.itu16.ticketing.dto.LoginCredentials;
import com.itu16.ticketing.model.Utilisateur;
import com.itu16.ticketing.service.UtilisateurService;

import dev.CustomSession;
import dev.ModelView;
import mg.annotation.AnnotationController;
import mg.annotation.Param;
import mg.annotation.RestApi;
import mg.annotation.Url;
import mg.annotation.verbs.Get;
import mg.annotation.verbs.Post;

@AnnotationController
public class UtilisateurController {

    private final UtilisateurService utilisateurService = UtilisateurService.getInstance();

    @Get
    @RestApi
    @Url("utilisateurs")
    public List<Utilisateur> listerUtilisateurs() {
        return utilisateurService.findAll();
    }

    @Get
    @Url("login")
    public ModelView login() {
        ModelView mv = new ModelView();
        mv.setUrl("login.jsp");
        return mv;
    }

    @Get
    @Url("loginA")
    public ModelView loginA() {
        ModelView mv = new ModelView();
        mv.setUrl("loginA.jsp");
        return mv;
    }

    @Post
    @Url("login")
    public ModelView login(@Param(name = "log")LoginCredentials credentials, CustomSession customSession) {
        Utilisateur utilisateur = utilisateurService.findByUserNameAndPwd(credentials);
        if (utilisateur != null) {
            customSession.set("authentified", true);
            customSession.set("role", "user");
            customSession.set("idUtilisateur", utilisateur.getId());
            ModelView mv = new ModelView();
            mv.setUrl("index.jsp");
            return mv;
        }
        ModelView mv = new ModelView();
        mv.addObject("msg", "Utilisateur non trouvé");
        mv.setUrl("login.jsp");
        return mv;
    }

    @Post
    @Url("loginA")
    public ModelView loginA(@Param(name = "log")LoginCredentials credentials, CustomSession customSession) {
        Utilisateur utilisateur = utilisateurService.findByUserNameAndPwd(credentials);
        if (utilisateur != null) {
            customSession.set("authentified", true);
            customSession.set("role", "admin");
            customSession.set("idAdmin", utilisateur.getId());
            ModelView mv = new ModelView();
            mv.setUrl("index.jsp");
            return mv;
        }
        ModelView mv = new ModelView();
        mv.addObject("msg", "Utilisateur non trouvé");
        mv.setUrl("login.jsp");
        return mv;
    }

    @Get
    @Url("signin")
    public ModelView signin() {
        ModelView mv = new ModelView();
        mv.setUrl("signin.jsp");
        return mv;
    }
    
}
