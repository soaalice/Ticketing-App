package com.itu16.ticketing.model;

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
import jakarta.persistence.Transient;
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
    private Double montantTotal = 0.0;

    @Column(name = "date_reservation", nullable=false)
    private String dateReservation;

    @Column(name = "date_butoire_annulation", nullable = false)
    private String dateButoireAnnulation;

    @OneToMany(mappedBy = "reservation", fetch = FetchType.EAGER)
    private List<ReservationDetails> reservationDetails = new ArrayList<>();

    @Enumerated(EnumType.STRING)
    private Status status = Status.CONFIRMED;

    @Transient
    private Double montantApresAnnulation = 0.0;

    @Column(name = "montant_promu", nullable = false)
    private Double montantPromu = 0.0;

    public String getNumero() {
        return id + "-" + utilisateur.getId() + "-" + vol.getId();
    }

    public void setMontantApresAnnulation(){
        for (ReservationDetails details : reservationDetails) {
            if (details.getStatus() != Status.CANCELLED) {
                montantApresAnnulation += details.getMontantFinal();
            }
        }
    }

    public double getMontantReduit(){
        if (montantPromu != null && montantPromu > 0) return montantTotal - montantPromu;
        return 0;
    }

    // Ce qu'on a annulé par rapport au montant final qui est soit le montant total soit le montant promu
    public double getMontantAnnule(){
        return getMontantFinal() - getMontantApresAnnulation();
    }

    public double getMontantFinal(){
        if (montantPromu != null && montantPromu > 0 ) return montantPromu;
        return montantTotal;
    }
}
