<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.itu16.ticketing.model.Reservation" %>
<%@ page import="com.itu16.ticketing.model.ReservationDetails" %>
<%@ page import="java.util.List" %>
<%@ page import="com.itu16.ticketing.dto.Status" %>

<%
    Reservation reservation = (Reservation) request.getAttribute("reservation");
    reservation.setMontantApresAnnulation();
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Détails de la Réservation - FlyBook</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body{
            background: linear-gradient(rgba(255, 255, 255, 0.5), rgba(255, 255, 255, -0.3)), url('../assets/img/beach.avif');
            background-size: cover;
            background-repeat: no-repeat;
        }
        .card-body{
            padding: 5% 2%;
        }
        .flight-info {
            background: rgba(13, 110, 253, 0.05);
            border-radius: 1rem;
            padding: 2rem;
            margin-bottom: 2rem;
        }
        .detail-card {
            transition: all 0.3s ease;
            border-radius: 0.5rem;
        }
        .detail-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
        }
        .seat-badge {
            font-size: 1.2rem;
            width: 3rem;
            height: 3rem;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            background: rgba(13, 110, 253, 0.1);
            color: #0d6efd;
        }
        .detail-card.cancelled {
            opacity: 0.75;
            border: 1px solid #dee2e6 !important;
        }
        .detail-card.cancelled:hover {
            transform: none;
            box-shadow: none;
        }
        .seat-badge.cancelled {
            background: rgba(220, 53, 69, 0.1);
            color: #dc3545;
        }
        .cancelled-label {
            position: absolute;
            top: 0;
            right: 0;
            border-radius: 0 0.5rem 0 0.5rem;
            padding: 0.25rem 0.75rem;
            font-size: 0.75rem;
            background: rgba(220, 53, 69, 0.1);
            color: #dc3545;
        }
        .child-seat-indicator {
            position: absolute;
            top: 5px;
            right: 5px;
            background: rgba(255, 193, 7, 0.1);
            color: #ffc107;
            padding: 2px 8px;
            border-radius: 12px;
            font-size: 0.75rem;
        }
        .status-container {
            margin-bottom: 1rem;
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
        }

        .status-badge {
            font-size: 0.75rem;
        }

        .status-badge i {
            font-size: 0.8rem;
        }

        .status-badge.cancelled {
            color: #dc3545;
            background-color: rgba(220, 53, 69, 0.1);
        }

        .status-badge.age-category {
            color: #0dcaf0;
            background-color: rgba(13, 202, 240, 0.1);
        }

        .detail-info {
            margin-top: 0.5rem;
        }
    </style>
</head>
<body class="d-flex flex-column min-vh-100 bg-light">
    <%@ include file="assets/inc/header.jsp" %>

    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-10">
                <div class="card shadow-sm">
                    <div class="card-header bg-white py-3">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h1 class="h3 mb-1">Réservation N°<%= reservation.getId() %></h1>
                                <p class="text-muted mb-0">Réservée le <%= reservation.getDateReservation() %></p>
                            </div>
                            <div class="status-badge">
                                <% if(reservation.getStatus() != Status.CANCELLED) { %>
                                    <span class="badge bg-success">Confirmée</span>
                                <% } else { %>
                                    <span class="badge bg-danger">Annulée</span>
                                <% } %>
                            </div>
                        </div>
                    </div>

                    <div class="card-body p-4">
                        <!-- Informations du vol -->
                        <div class="flight-info">
                            <div class="row align-items-center">
                                <div class="col-md-5 text-center">
                                    <i class="fas fa-plane-departure text-primary mb-3 fa-2x"></i>
                                    <h5 class="mb-2"><%= reservation.getVol().getVilleDepart().getName() %></h5>
                                    <p class="text-muted mb-0"><%= reservation.getVol().getDateDepart() %></p>
                                </div>
                                <div class="col-md-2 text-center">
                                    <i class="fas fa-plane text-muted"></i>
                                </div>
                                <div class="col-md-5 text-center">
                                    <i class="fas fa-plane-arrival text-primary mb-3 fa-2x"></i>
                                    <h5 class="mb-2"><%= reservation.getVol().getVilleArrivee().getName() %></h5>
                                    <p class="text-muted mb-0"><%= reservation.getVol().getDateArrivee() %></p>
                                </div>
                            </div>
                        </div>

                        <!-- Détails des sièges -->
                        <h4 class="mb-4">Sièges réservés</h4>
                        <div class="row g-4 mb-4">
                            <% List<ReservationDetails> details = reservation.getReservationDetails();
                                if (details == null || details.isEmpty()) {
                                %>
                                <p>Aucun siège réservé.</p>
                                <% } else { %>
                                    <div class="row g-4 mb-4">
                                        <% for(ReservationDetails detail : details) { 
                                            boolean isCancelled = detail.getStatus() == Status.CANCELLED;
                                        %>
                                            <div class="col-md-6">
                                                <div class="detail-card card border-0 shadow-sm position-relative <%= isCancelled ? "cancelled" : "" %>">
                                                    <div class="card-header bg-white d-flex gap-2 align-items-center">
                                                        <% if (detail.getAgeCategorie() != null) { %>
                                                            <span class="status-badge age-category badge">
                                                                <i class="fas fa-user-alt me-1"></i>
                                                                <%= detail.getAgeCategorie().getName() %>
                                                            </span>
                                                        <% } %>
                                                        <% if (isCancelled) { %>
                                                            <span class="status-badge cancelled badge">
                                                                <i class="fas fa-ban me-1"></i>
                                                                Annulé
                                                            </span>
                                                        <% } %>
                                                    </div>
                                                    <div class="card-body">
                                                        <div class="d-flex align-items-center">
                                                            <div class="seat-badge me-3 <%= isCancelled ? "cancelled" : "" %>">
                                                                <%= detail.getSiegeAvion().getId() %>
                                                            </div>
                                                            <div class="flex-grow-1">
                                                                <h6 class="mb-1">
                                                                    <%= detail.getSiegeAvion().getTypeSiege().getName() %>
                                                                </h6>
                                                                <% if (detail.getMontantPromu() > 0) { 
                                                                    %>
                                                                    <p class="text-muted mb-0">
                                                                        <span style="text-decoration: line-through;">
                                                                            <%= String.format("%,.2f", detail.getMontant()) %> Ar
                                                                        </span>
                                                                        <br>
                                                                        <span class="text-success fw-bold">
                                                                            <%= String.format("%,.2f", detail.getMontantPromu()) %> Ar
                                                                        </span>
                                                                    </p>
                                                                <% } else { %>
                                                                    <p class="text-muted mb-0">
                                                                        Prix: <%= String.format("%,.2f", detail.getMontant()) %> Ar
                                                                    </p>
                                                                <% } %>
                                                            </div>
                                                            <% if(!isAdmin && !isCancelled && reservation.getStatus() != Status.CANCELLED) { %>
                                                                <div class="ms-3">
                                                                    <button type="button" 
                                                                            class="btn btn-outline-danger btn-sm"
                                                                            onclick="if(confirm('Êtes-vous sûr de vouloir annuler ce siège ?')) {
                                                                                document.getElementById('cancelSeat<%= detail.getId() %>').submit();
                                                                            }">
                                                                        <i class="fas fa-times"></i>
                                                                    </button>
                                                                    <form id="cancelSeat<%= detail.getId() %>" 
                                                                          action="${pageContext.request.contextPath}/reservations/details/cancel" 
                                                                          method="post" class="d-none">
                                                                        <input type="hidden" name="id" value="<%= detail.getId() %>">
                                                                        <input type="hidden" name="reservationId" value="<%= reservation.getId() %>">
                                                                    </form>
                                                                </div>
                                                            <% } %>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        <% } %>
                                    </div>
                                <% } %>
                        </div>


                        <!-- Informations de paiement -->
                        <div class="card bg-light border-0">
                            <div class="card-body">
                                <h4 class="mb-4">Détails du paiement</h4>
                                <% if (reservation.getMontantApresAnnulation() != reservation.getMontantTotal()) { %>
                                    <div class="d-flex justify-content-between mb-2 text-muted">
                                        <span>Montant initial</span>
                                        <span class="text-success">
                                            <%= String.format("%,.2f", reservation.getMontantTotal()) %> Ar
                                        </span>
                                    </div>
                                    <div class="d-flex justify-content-between mb-2">
                                        <span>Montant réduit</span>
                                        <span class="text-danger">
                                            - <%= String.format("%,.2f", reservation.getMontantReduit()) %> Ar
                                        </span>
                                    </div>
                                    <div class="d-flex justify-content-between mb-2">
                                        <span>Montant annulé</span>
                                        <span class="text-danger">
                                            - <%= String.format("%,.2f", reservation.getMontantAnnule()) %> Ar
                                        </span>
                                    </div>
                                    <div class="d-flex justify-content-between mt-3 pt-3 border-top">
                                        <span>Montant total</span>
                                        <strong class="text-primary">
                                            <%= String.format("%,.2f", reservation.getMontantApresAnnulation()) %> Ar
                                        </strong>
                                    </div>
                                <% } else { %>
                                    <div class="d-flex justify-content-between mb-2">
                                        <span>Montant total</span>
                                        <strong><%= String.format("%,.2f", reservation.getMontantFinal()) %> Ar</strong>
                                    </div>
                                <% } %>
                            </div>
                        </div>
                    </div>

                    <div class="card-footer bg-white py-3">
                        <div class="d-flex justify-content-between align-items-center">
                            <a href="${pageContext.request.contextPath}/reservations" 
                               class="btn btn-light">
                                <i class="fas fa-arrow-left me-2"></i>Retour
                            </a>
                                <% if(isAdmin) { %>
                            <div class="btn-group">
                                <!-- <a href="#" class="btn btn-outline-primary">
                                    <i class="fas fa-download me-2"></i>Télécharger la facture
                                </a> -->
                                    <button type="button" class="btn btn-outline-danger" 
                                            onclick="if(confirm('Êtes-vous sûr de vouloir annuler cette réservation ?')) {
                                                document.getElementById('cancelForm').submit();
                                            }">
                                        <i class="fas fa-times me-2"></i>Annuler la réservation
                                    </button>
                                    <form id="cancelForm" action="${pageContext.request.contextPath}/reservations/cancel" 
                                          method="post" class="d-none">
                                        <input type="hidden" name="id" value="<%= reservation.getId() %>">
                                    </form>
                            </div>
                                <% } %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%@ include file="assets/inc/footer.jsp" %>
</body>
</html>