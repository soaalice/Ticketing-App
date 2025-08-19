package com.itu16.ticketing.utils;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class DateConverter {
    public static final String DEFAULT_PATTERN = "yyyy-MM-dd HH:mm:ss";
    public static final String ALTERNATIVE_PATTERN = "yyyy-MM-dd'T'HH:mm";


    // Fonction pour convertir une chaîne de date en LocalDateTime
    public static LocalDateTime convertToLocalDateTime(String dateStr, String pattern) {
        // Création du DateTimeFormatter avec le pattern donné
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern(pattern);
        
        // Conversion de la chaîne en LocalDateTime
        return LocalDateTime.parse(dateStr, formatter);
    }

    // Fonction pour formater un LocalDateTime en chaîne avec secondes
    public static String formatToDatabaseDate(LocalDateTime dateTime) {
        // Format cible pour la base de données : yyyy-MM-dd HH:mm:ss
        DateTimeFormatter dbFormatter = DateTimeFormatter.ofPattern(DEFAULT_PATTERN);
        
        // Retourne la date formatée en chaîne
        return dateTime.format(dbFormatter);
    }

}
