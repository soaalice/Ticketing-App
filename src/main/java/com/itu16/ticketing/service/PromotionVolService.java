package com.itu16.ticketing.service;

import com.itu16.ticketing.model.PromotionVol;

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

}
