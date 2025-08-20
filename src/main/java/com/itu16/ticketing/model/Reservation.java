package com.itu16.ticketing.model;

import java.util.ArrayList;
import java.util.List;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import lombok.Data;

@Entity
@Data
public class Reservation {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "utilisateur_id", nullable=false)
    private Utilisateur utilisateur;

    @ManyToOne
    @JoinColumn(name = "vol_id", nullable=false)
    private Vol vol;

    @Column(name = "montant_total", nullable=false)
    private Double montantTotal;

    @Column(name = "date_reservation", nullable=false)
    private String dateReservation;

    @OneToMany(mappedBy = "reservation", fetch = FetchType.EAGER)
    private List<ReservationDetails> reservationDetails = new ArrayList<>();
}
