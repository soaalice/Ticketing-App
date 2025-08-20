package com.itu16.ticketing.model;

import java.util.ArrayList;
import java.util.List;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import lombok.Data;

@Entity
@Data
public class Utilisateur {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, name = "full_name")
    private String fullName;

    @Column(nullable = false, unique = true, name = "user_name")
    private String userName;

    @Column(nullable = false)
    private String pwd;

    @OneToMany(mappedBy = "utilisateur", fetch = FetchType.EAGER)
    private List<Reservation> reservations = new ArrayList<>();
}
