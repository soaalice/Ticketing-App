package com.itu16.ticketing.model;

import java.beans.Transient;
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import com.itu16.ticketing.dto.Status;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import lombok.Data;

@Data
@Entity
public class Vol {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "avion_id", nullable = false)
    private Avion avion;

    @Column(name = "date_depart", nullable = false)
    private String dateDepart;

    @Column(name = "date_arrivee", nullable = false)
    private String dateArrivee;

    @Column(name="date_butoire_reservation", nullable = false)
    private String dateButoireReservation;

    @ManyToOne
    @JoinColumn(name = "ville_depart_id", nullable = false)
    private Ville villeDepart;

    @ManyToOne
    @JoinColumn(name = "ville_arrivee_id", nullable = false)
    private Ville villeArrivee;

    @Enumerated(EnumType.STRING)
    private Status status = Status.ACTIVE;

    @jakarta.persistence.Transient
    private List<PromotionVol> promotions = new ArrayList<>();

    @jakarta.persistence.Transient
    private String duree;

    public void setDuree(){
        LocalDateTime dateDepart = LocalDateTime.parse(this.dateDepart);
        LocalDateTime dateArrivee = LocalDateTime.parse(this.dateArrivee);
        Duration duration = Duration.between(dateDepart, dateArrivee);
        this.duree = String.format("%d h %d min", duration.toHours(), duration.toMinutesPart());
    }

}
