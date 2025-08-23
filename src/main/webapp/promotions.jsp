<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.itu16.ticketing.model.PromotionVol" %>
<%@ page import="com.itu16.ticketing.model.Vol" %>

<%
    List<PromotionVol> promotions = (List<PromotionVol>) request.getAttribute("promotions");
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Promotions - FlyBook</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .promotion-card {
            transition: transform 0.2s, box-shadow 0.2s;
            border: none;
        }
        .promotion-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1) !important;
        }
        .reduction-badge {
            position: absolute;
            top: -10px;
            right: -10px;
            padding: 1rem;
            border-radius: 50%;
            font-weight: bold;
            font-size: 1.2rem;
            z-index: 1;
            box-shadow: 0 4px 8px rgba(220, 53, 69, 0.2);
        }
        .seat-info {
            display: inline-block;
            padding: 0.25rem 0.75rem;
            background: rgba(13, 110, 253, 0.1);
            border-radius: 2rem;
            color: #0d6efd;
            font-size: 0.9rem;
        }
    </style>
</head>
<body class="d-flex flex-column min-vh-100 bg-light">
    <%@ include file="assets/inc/header.jsp" %>

    <div class="container py-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1 class="h2 mb-0">Promotions en cours</h1>
            <% if (isAdmin) { %>
                <a href="${pageContext.request.contextPath}/promotions/create" class="btn btn-primary">
                    <i class="fas fa-plus me-2"></i>Nouvelle Promotion
                </a>
            <% } %>
        </div>

        <div class="row g-4">
            <% 
            if (promotions != null && !promotions.isEmpty()) {
                for (PromotionVol promotion : promotions) {
                    Vol vol = promotion.getVol();
            %>
                <div class="col-md-6 col-lg-4">
                    <div class="card promotion-card h-100 shadow-sm">
                        <div class="reduction-badge bg-danger text-white">
                            -<%= String.format("%.0f", promotion.getReduction()) %>%
                        </div>
                        <div class="card-body">
                            <h5 class="card-title mb-3">
                                <i class="fas fa-plane-departure text-primary me-2"></i>
                                <%= vol.getVilleDepart().getName() %> 
                                <i class="fas fa-arrow-right mx-2"></i> 
                                <%= vol.getVilleArrivee().getName() %>
                            </h5>
                            
                            <div class="card-text">
                                <div class="d-flex align-items-center mb-3">
                                    <span class="seat-info">
                                        <i class="fas fa-couch me-1"></i><%= promotion.getTypeSiege().getName() %>
                                    </span>
                                    <span class="badge bg-primary ms-2">
                                        <i class="fas fa-chair me-1"></i><%= promotion.getNSiege() %> sièges
                                    </span>
                                </div>
                                
                                <p class="mb-2">
                                    <i class="fas fa-calendar me-2 text-secondary"></i>
                                    <strong>Départ:</strong> <%= vol.getDateDepart() %>
                                </p>
                                <p class="mb-2">
                                    <i class="fas fa-plane me-2 text-secondary"></i>
                                    <%= vol.getAvion().getModele().getName() %>
                                </p>
                            </div>

                            <div class="card-footer bg-transparent border-top-0">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div class="btn-group">
                                        <a href="${pageContext.request.contextPath}/vols/details?id=<%= vol.getId() %>"
                                            class="btn btn-outline-primary btn-sm">
                                            <i class="fas fa-info-circle me-1"></i>Voir le vol
                                        </a>
                                        <% if (isLogged && !isAdmin) { %>
                                            <a href="${pageContext.request.contextPath}/reservations/create?volId=<%= vol.getId() %>"
                                                class="btn btn-success">
                                                <i class="fas fa-ticket-alt me-1"></i>Réserver
                                            </a>
                                            <% } %>
                                    </div>
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
                        <i class="fas fa-info-circle me-2"></i>Aucune promotion en cours.
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