<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.itu16.ticketing.model.Vol" %>
<%@ page import="java.time.LocalDateTime" %>

<%
    Vol vol = (Vol) request.getAttribute("vol");
    vol.setDuree();
%>

<html>
<head>
    <title>Fiche de Vol</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body{
            background: linear-gradient(rgba(255, 255, 255, 0.5), rgba(255, 255, 255, -0.3)), url('${pageContext.request.contextPath}/assets/img/tropic.avif');
            background-size: cover;
            background-repeat: no-repeat;
        }
        .flight-path {
            position: relative;
            padding: 2rem;
            background: rgba(13, 110, 253, 0.05);
            border-radius: 1rem;
            margin-bottom: 2rem;
        }
        /* .flight-path::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 25%;
            right: 25%;
            border-top: 2px dashed #dee2e6;
            z-index: 0;
        } */
        .detail-item {
            background: #fff;
            border-radius: 0.5rem;
            padding: 1.5rem;
            box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
            transition: transform 0.2s;
        }
        .detail-item:hover {
            transform: translateY(-2px);
        }
    </style>
</head>
<body class="d-flex flex-column min-vh-100 bg-light">
    <%@ include file="assets/inc/header.jsp" %>

    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-10">
                <div class="card shadow-sm border-0">
                    <div class="card-header bg-white py-3">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h1 class="h3 mb-1">Vol n°<%= vol.getId() %></h1>
                                <p class="text-muted mb-0">Ref: <%= vol.getAvion().toString() %></p>
                            </div>
                            <% if (isAdmin) { %>
                                <div class="btn-group">
                                    <a href="${pageContext.request.contextPath}/vols/edit?id=<%= vol.getId() %>" 
                                       class="btn btn-outline-primary">
                                        <i class="fas fa-edit me-2"></i>Éditer
                                    </a>
                                </div>
                            <% } %>
                        </div>
                    </div>
                    
                    <div class="card-body p-4">
                        <div class="flight-path">
                            <div class="row position-relative">
                                <div class="col-md-5 text-center">
                                    <i class="fas fa-plane-departure text-primary mb-3 fa-2x"></i>
                                    <h5 class="mb-2"><%= vol.getVilleDepart().getName() %></h5>
                                    <p class="text-muted mb-0"><%= vol.getDateDepart() %></p>
                                </div>
                                <div class="col-md-2 text-center d-flex align-items-center justify-content-center">
                                    <i class="fas fa-plane text-muted fa-2x"></i>
                                </div>
                                <div class="col-md-5 text-center">
                                    <i class="fas fa-plane-arrival text-primary mb-3 fa-2x"></i>
                                    <h5 class="mb-2"><%= vol.getVilleArrivee().getName() %></h5>
                                    <p class="text-muted mb-0"><%= vol.getDateArrivee() %></p>
                                </div>
                            </div>
                        </div>

                        <div class="row g-4">
                            <div class="col-md-6">
                                <div class="detail-item">
                                    <div class="d-flex align-items-center">
                                        <div class="rounded-circle bg-primary bg-opacity-10 p-3 me-3">
                                            <i class="fas fa-plane text-primary"></i>
                                        </div>
                                        <div>
                                            <h6 class="text-muted mb-1">Avion</h6>
                                            <p class="mb-0 fw-bold"><%= vol.getAvion().getModele().getName() %></p>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="detail-item">
                                    <div class="d-flex align-items-center">
                                        <div class="rounded-circle bg-success bg-opacity-10 p-3 me-3">
                                            <i class="fas fa-clock text-success"></i>
                                        </div>
                                        <div>
                                            <h6 class="text-muted mb-1">Durée estimée</h6>
                                            <p class="mb-0 fw-bold"> <%= vol.getDuree() %> </p>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="detail-item">
                                    <div class="d-flex align-items-center">
                                        <div class="rounded-circle bg-info bg-opacity-10 p-3 me-3">
                                            <i id="status-icon" class="fas fa-info text-info"></i>
                                        </div>
                                        <div>
                                            <h6 class="text-muted mb-1">Statut</h6>
                                            <p class="mb-0 fw-bold"> <%= vol.getStatus().getLabel() %> </p>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="detail-item">
                                    <div class="d-flex align-items-center">
                                        <div class="rounded-circle bg-warning bg-opacity-10 p-3 me-3">
                                            <i class="fas fa-hourglass-end text-warning"></i>
                                        </div>
                                        <div>
                                            <h6 class="text-muted mb-1">Réservations jusqu'au</h6>
                                            <p class="mb-0 fw-bold"><%= vol.getDateButoireReservation() %></p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="card-footer bg-white py-3">
                        <div class="d-flex justify-content-between align-items-center">
                            <a href="${pageContext.request.contextPath}/vols" class="btn btn-light">
                                <i class="fas fa-arrow-left me-2"></i>Retour
                            </a>
                            <% 
                                LocalDateTime now = LocalDateTime.now();
                                LocalDateTime dateButoire = LocalDateTime.parse(vol.getDateButoireReservation());
                                boolean reservationsClosed = now.isAfter(dateButoire);
                            
                                if(isLogged && !isAdmin) { 
                                    if(!reservationsClosed) {
                            %>
                                <div class="btn-group">
                                    <a href="${pageContext.request.contextPath}/reservations/create?volId=<%= vol.getId() %>"
                                        class="btn btn-success btn-sm ms-2">
                                        <i class="fas fa-ticket me-1"></i>Réserver
                                    </a>
                                </div>
                            <%      } else { %>
                                <div class="alert alert-warning mb-0 py-2">
                                    <i class="fas fa-exclamation-triangle me-2"></i>Les réservations sont closes pour ce vol
                                </div>
                            <%      }
                                } 
                            %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%@ include file="assets/inc/footer.jsp" %>
</body>
</html>
