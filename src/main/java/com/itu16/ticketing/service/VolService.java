package com.itu16.ticketing.service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import com.itu16.ticketing.dto.Status;
import com.itu16.ticketing.model.Vol;
import com.itu16.ticketing.utils.DateConverter;

import jakarta.persistence.EntityManager;

public class VolService extends CRUDService<Vol, Long> {

    private static VolService volService;

    private VolService() {
        super();
    }

    public static VolService getInstance() {
        if (volService == null) {
            volService = new VolService();
        }
        return volService;
    }

    public List<Vol> findByCriteria(String dateDepart, String villeD, String villeA) {
        LocalDateTime startDate = null;
        LocalDateTime endDate = null;

        if (dateDepart != null && !dateDepart.isBlank()) {
            LocalDate d = LocalDate.parse(dateDepart); // format "yyyy-MM-dd"
            startDate = d.atStartOfDay();
            endDate = d.plusDays(1).atStartOfDay();
        }

        if (villeA != null && villeA.isBlank()) {
            villeA = null;
        }
        if (villeD != null && villeD.isBlank()) {
            villeD = null;
        }

        try (EntityManager em = emf.createEntityManager()) {
            String jpql = "SELECT v FROM Vol v WHERE 1=1 " +
                "AND (:start IS NULL OR (v.dateDepart >= :start AND v.dateDepart < :end)) " +
                "AND (:vd IS NULL OR v.villeDepart.name = :vd ) " +
                "AND (:va IS NULL OR v.villeArrivee.name = :va)";

            var query = em.createQuery(jpql, Vol.class)
                .setParameter("vd", villeD)
                .setParameter("va", villeA);

            if (startDate == null) {
                query.setParameter("start", null);
                query.setParameter("end", null);
            } else {
                query.setParameter("start", DateConverter.formatToDatabaseDate(startDate));
                query.setParameter("end", DateConverter.formatToDatabaseDate(endDate));
            }

            return query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    private void updateVolStatus(Vol vol) {
        Integer nSiegeLibre = getSingleValue("SELECT get_nombre_sieges_libres(?)", Integer.class, (int) (long) vol.getId());
        if (nSiegeLibre != null && nSiegeLibre == 0) {
            vol.setStatus(Status.FULL);
        }
    }

}
