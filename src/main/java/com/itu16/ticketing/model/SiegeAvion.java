package com.itu16.ticketing.model;

import com.itu16.ticketing.dto.Status;

import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;
import lombok.Data;

@Entity
@Data
@Table(name = "siege_avion")
public class SiegeAvion {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "avion_id", nullable=false)
    private Avion avion;

    @ManyToOne
    @JoinColumn(name = "type_siege_id", nullable=false)
    private TypeSiege typeSiege;

    @Transient
    private Double prix = 0.0;

    @Transient
    private Status status = Status.FREE;

    public String getNumero() {
        return avion.getId() + "-" + typeSiege.getName() + "-" + id;
    }
}
