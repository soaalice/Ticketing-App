package com.itu16.ticketing.service;

// import java.util.List;

import com.itu16.ticketing.dto.LoginCredentials;
import com.itu16.ticketing.model.Utilisateur;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;

public class UtilisateurService extends CRUDService<Utilisateur, Integer> {

    private static UtilisateurService utilisateurService;

    private UtilisateurService() {
        super();
    }

    public static UtilisateurService getInstance() {
        if (utilisateurService == null) {
            utilisateurService = new UtilisateurService();
        }
        return utilisateurService;
    }

    public Utilisateur findByUserNameAndPwd(LoginCredentials credentials) {
        try (EntityManager em = emf.createEntityManager();) {
            return em.createQuery(
                            "SELECT u FROM Utilisateur u WHERE u.userName = :user_name AND u.pwd = :pwd", Utilisateur.class)
                    .setParameter("user_name", credentials.getUserName())
                    .setParameter("pwd", credentials.getPassword())
                    .getSingleResult();
        } catch (NoResultException ignored) {
            return null;
        }
    }

}
