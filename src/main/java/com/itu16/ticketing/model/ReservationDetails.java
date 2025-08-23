package com.itu16.ticketing.model;

import java.util.HashSet;
import java.util.Set;

import com.itu16.ticketing.dto.Status;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Data
@Table(name = "reservation_details")
public class ReservationDetails {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "reservation_id", nullable = false)
    private Reservation reservation;

    @ManyToOne
    @JoinColumn(name = "siege_avion_id", nullable = false)
    private SiegeAvion siegeAvion;

    @Column(name = "montant", nullable = false)
    private Double montant = 0.0;

    @Column(name = "montant_promu", nullable = false)
    private Double montantPromu = 0.0;

    @Enumerated(EnumType.STRING)
    private Status status;

    @ManyToMany
    @JoinTable(
        name = "reservation_details_promotion",
        joinColumns = @JoinColumn(name = "reservation_details_id"),
        inverseJoinColumns = @JoinColumn(name = "promotion_vol_id")
    )

    private Set<PromotionVol> promotions = new HashSet<>();

    public double getMontantFinal() {
        if (montantPromu != null && montantPromu > 0) return montantPromu;
        return montant;
    }

}
