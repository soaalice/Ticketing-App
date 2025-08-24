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
public class Avion {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "date_fabrication", nullable = false)
    private String dateFabrication;

    @ManyToOne
    @JoinColumn(name = "modele_id", nullable = false)
    private Modele modele;


    @Override
    public String toString() {
        return "A"+id + "-" + modele.toString() + "-" + dateFabrication.replace("-", "");
    }

    @OneToMany(mappedBy = "avion", fetch=FetchType.EAGER)
    private List<SiegeAvion> sieges = new ArrayList<>();
}
