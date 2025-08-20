<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.itu16.ticketing.model.Reservation" %>
<%@ page import="com.itu16.ticketing.dto.Status" %>

<%
    List<Reservation> reservations = (List<Reservation>) request.getAttribute("reservations");
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mes Réservations - FlyBook</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .reservation-card {
            transition: transform 0.2s;
        }
        .reservation-card:hover {
            transform: translateY(-5px);
        }
        .status-badge {
            position: absolute;
            top: 1rem;
            right: 1rem;
        }
    </style>
</head>
<body class="d-flex flex-column min-vh-100 bg-light">
    <%@ include file="assets/inc/header.jsp" %>

    <div class="container py-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1 class="h2 mb-0">
                <% if (isAdmin) { %>
                    Toutes les Réservations
                <% } else { %>
                    Mes Réservations
                <% } %>
            </h1>
        </div>

        <div class="row g-4">
            <% 
            if (reservations != null && !reservations.isEmpty()) {
                for (Reservation reservation : reservations) {
            %>
                <div class="col-md-6 col-lg-4">
                    <div class="card reservation-card h-100 shadow-sm">
                        <div class="card-body">
                            <div class="status-badge">
                                <% if(reservation.getStatus() != Status.CANCELLED) { %>
                                    <span class="badge bg-success">Confirmée</span>
                                <% } else { %>
                                    <span class="badge bg-danger">Annulée</span>
                                <% } %>
                            </div>

                            <h5 class="card-title mb-3">
                                <i class="fas fa-plane-departure text-primary me-2"></i>
                                <%= reservation.getVol().getVilleDepart().getName() %> 
                                <i class="fas fa-arrow-right mx-2"></i> 
                                <%= reservation.getVol().getVilleArrivee().getName() %>
                            </h5>
                            
                            <div class="card-text">
                                <p class="mb-2">
                                    <i class="fas fa-calendar me-2 text-secondary"></i>
                                    <strong>Date du vol:</strong> <%= reservation.getVol().getDateDepart() %>
                                </p>
                                <p class="mb-2">
                                    <i class="fas fa-clock me-2 text-secondary"></i>
                                    <strong>Réservé le:</strong> <%= reservation.getDateReservation() %>
                                </p>
                                <% if (isAdmin) { %>
                                    <p class="mb-2">
                                        <i class="fas fa-user me-2 text-secondary"></i>
                                        <strong>Client:</strong> <%= reservation.getUtilisateur().getFullName() %>
                                    </p>
                                <% } %>
                                <div class="d-flex justify-content-between align-items-center mt-3">
                                    <div>
                                        <i class="fas fa-receipt text-success me-2"></i>
                                        <strong>Montant total</strong>
                                    </div>
                                    <span class="h5 mb-0 text-success">
                                        <%= String.format("%,.2f", reservation.getMontantTotal()) %> Ar
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="card-footer bg-transparent border-top-0">
                            <div class="d-flex justify-content-between align-items-center">
                                <a href="${pageContext.request.contextPath}/reservations/details?id=<%= reservation.getId() %>" 
                                   class="btn btn-outline-primary btn-sm">
                                    <i class="fas fa-info-circle me-1"></i>Détails
                                </a>
                                <div class="btn-group">
                                    <!-- <a href="#" class="btn btn-outline-success btn-sm">
                                        <i class="fas fa-download me-1"></i>Facture
                                    </a> -->
                                    <% if (reservation.getStatus() != Status.CANCELLED) { %>
                                        <form action="${pageContext.request.contextPath}/reservations/cancel" 
                                              method="post" class="d-inline ms-2">
                                            <input type="hidden" name="id" value="<%= reservation.getId() %>">
                                            <button type="submit" class="btn btn-outline-danger btn-sm" 
                                                    onclick="return confirm('Êtes-vous sûr de vouloir annuler cette réservation ?')">
                                                <i class="fas fa-times me-1"></i>Annuler
                                            </button>
                                        </form>
                                    <% } %>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            <%
                }
            } else {
            %>
                <div class="col-12">
                    <div class="alert alert-info" role="alert">
                        <i class="fas fa-info-circle me-2"></i>Aucune réservation trouvée.
                    </div>
                </div>
            <%
            }
            %>
        </div>
    </div>

    <%@ include file="assets/inc/footer.jsp" %>
</body>
</html>