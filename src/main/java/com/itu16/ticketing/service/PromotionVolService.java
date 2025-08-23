package com.itu16.ticketing.service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import com.itu16.ticketing.model.PrixTypeSiegeVol;
import com.itu16.ticketing.model.PromotionVol;

import jakarta.persistence.EntityManager;

public class PromotionVolService extends CRUDService<PromotionVol, Long>{
    
    private static PromotionVolService promotionVolService;

    private PromotionVolService() {
        super();
    }

    public static PromotionVolService getInstance() {
        if (promotionVolService == null) {
            promotionVolService = new PromotionVolService();
        }
        return promotionVolService;
    }

    @Override
    public PromotionVol findById(Long id) {
        PromotionVol promotion = super.findById(id);
        promotion.setStatus();
        return promotion;
    }

    public List<PromotionVol> findByVolId(Long volId) {
        List<PromotionVol> promotions = new ArrayList<>();
        try(EntityManager em = emf.createEntityManager()) {
            String jpql = "SELECT p FROM PromotionVol p WHERE p.vol.id = :volId";
            var query = em.createQuery(jpql, PromotionVol.class)
                .setParameter("volId", volId);
            promotions = query.getResultList();
            for (PromotionVol promotion : promotions) {
                promotion.setStatus();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return promotions;
    }
}
