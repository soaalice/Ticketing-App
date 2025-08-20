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

@Entity
@Data
@Table(name = "prix_type_siege_vol")
public class PrixTypeSiegeVol {
    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private Long id;

    @Column(name = "prix", nullable=false)
    private Double prix = 0.0;

    @ManyToOne
    @JoinColumn(name = "type_siege_id", nullable=false)
    private TypeSiege typeSiege;

    @ManyToOne
    @JoinColumn(name = "vol_id", nullable=false)
    private Vol vol;
}
