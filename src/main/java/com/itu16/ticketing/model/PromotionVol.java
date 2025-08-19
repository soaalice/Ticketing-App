package com.itu16.ticketing.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Data;

@Data
@Entity
@Table(name = "promotion_vol")
public class PromotionVol {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "vol_id", nullable = false)
    private Vol vol;

    @Column(nullable = false)
    private Double reduction;

    @Column(name = "date_debut", nullable = false)
    private String dateDebut;

    @Column(name = "date_fin", nullable = false)
    private String dateFin;

    @ManyToOne
    @JoinColumn(name = "type_siege_id", nullable = false)
    private TypeSiege typeSiege;

    @Column(name = "n_siege", nullable = false)
    private Integer nSiege = 0;
}
