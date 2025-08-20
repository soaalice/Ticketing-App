<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.itu16.ticketing.model.Reservation" %>
<%@ page import="com.itu16.ticketing.model.ReservationDetails" %>
<%@ page import="java.util.List" %>

<%
    Reservation reservation = (Reservation) request.getAttribute("reservation");
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Détails de la Réservation - FlyBook</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
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
                                <h1 class="h3 mb-1">Réservation #<%= reservation.getId() %></h1>
                                <p class="text-muted mb-0">Réservée le <%= reservation.getDateReservation() %></p>
                            </div>
                            <span class="badge bg-success">Confirmée</span>
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
                        
                        <% List<ReservationDetails> details = reservation.getReservationDetails();
                            if (details == null || details.isEmpty()) {
                            %>
                            <p>Aucun siège réservé.</p>
                            <% } else { %>
                                <div class="row g-4 mb-4">
                                    <% for(ReservationDetails detail : details) { %>
                                        <div class="col-md-6">
                                            <div class="detail-card card border-0 shadow-sm">
                                                <div class="card-body">
                                                    <div class="d-flex align-items-center">
                                                        <div class="seat-badge me-3">
                                                            <%= detail.getSiegeAvion().getId() %>
                                                        </div>
                                                        <div>
                                                            <h6 class="mb-1">
                                                                <%= detail.getSiegeAvion().getTypeSiege().getName() %>
                                                            </h6>
                                                            <p class="text-muted">
                                                                Prix: <%= String.format("%,.2f", detail.getMontant()) %> Ar
                                                            </p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <% } %>
                                </div>
                                <% } %>


                        <!-- Informations de paiement -->
                        <div class="card bg-light border-0">
                            <div class="card-body">
                                <h4 class="mb-4">Détails du paiement</h4>
                                <div class="d-flex justify-content-between mb-2">
                                    <span>Montant total</span>
                                    <strong><%= String.format("%,.2f", reservation.getMontantTotal()) %> Ar</strong>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="card-footer bg-white py-3">
                        <div class="d-flex justify-content-between align-items-center">
                            <a href="${pageContext.request.contextPath}/reservations" 
                               class="btn btn-light">
                                <i class="fas fa-arrow-left me-2"></i>Retour
                            </a>
                            <div class="btn-group">
                                <!-- <a href="#" class="btn btn-outline-primary">
                                    <i class="fas fa-download me-2"></i>Télécharger la facture
                                </a> -->
                                <% if(isAdmin) { %>
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
                                <% } %>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%@ include file="assets/inc/footer.jsp" %>
</body>
</html>