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
@Table(name = "modele_type_siege")
public class ModeleTypeSiege {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "modele_id", nullable = false)
    private Modele modele;

    @ManyToOne
    @JoinColumn(name = "type_siege_id", nullable = false)
    private TypeSiege typeSiege;

    @Column(name = "n_siege",nullable = false)
    private Integer nSiege;
}
