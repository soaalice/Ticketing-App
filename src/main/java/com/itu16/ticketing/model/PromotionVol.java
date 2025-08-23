package com.itu16.ticketing.model;

import java.beans.Transient;
import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.Set;

import com.itu16.ticketing.dto.Status;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToMany;
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

    @jakarta.persistence.Transient
    private Status status = Status.ACTIVE;

    @Column(name= "n_sieges_promus", nullable=false)
    private Integer nSiegesPromus = 0;

    @ManyToMany(mappedBy = "promotions")
    private Set<ReservationDetails> reservations = new HashSet<>();

    public void setStatus(){
        LocalDateTime dateTimeFin = LocalDateTime.parse(dateFin);
        if (dateTimeFin.isBefore(LocalDateTime.now())) {
            status = Status.INACTIVE;
        }
    }

    @Override
    public String toString() {
        setStatus();
        return "PromotionVol{id=" + id + ", status="+getStatus()+", reduction="+reduction+"}";
    }

}
