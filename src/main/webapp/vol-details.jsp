<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.itu16.ticketing.model.Vol" %>

<%
    Vol vol = (Vol) request.getAttribute("vol");
%>

<html>
<head>
    <title>Fiche de Vol</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .flight-path {
            position: relative;
            padding: 2rem;
            background: rgba(13, 110, 253, 0.05);
            border-radius: 1rem;
            margin-bottom: 2rem;
        }
        .flight-path::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 25%;
            right: 25%;
            border-top: 2px dashed #dee2e6;
            z-index: 0;
        }
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
                                <p class="text-muted mb-0"><%= vol.getAvion().getModele().getName() %></p>
                            </div>
                            <% if (isAdmin) { %>
                                <div class="btn-group">
                                    <a href="${pageContext.request.contextPath}/vols/edit?id=<%= vol.getId() %>" 
                                       class="btn btn-outline-primary">
                                        <i class="fas fa-edit me-2"></i>Éditer
                                    </a>
                                    <a href="${pageContext.request.contextPath}/vols" 
                                       class="btn btn-outline-dark border-start-0">
                                        <i class="fas fa-arrow-left me-2"></i>Retour
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
                            <div class="col-md-4">
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

                            <div class="col-md-4">
                                <div class="detail-item">
                                    <div class="d-flex align-items-center">
                                        <div class="rounded-circle bg-success bg-opacity-10 p-3 me-3">
                                            <i class="fas fa-clock text-success"></i>
                                        </div>
                                        <div>
                                            <h6 class="text-muted mb-1">Durée estimée</h6>
                                            <p class="mb-0 fw-bold" id="flight-duration">Calcul en cours...</p>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-4">
                                <div class="detail-item">
                                    <div class="d-flex align-items-center">
                                        <div class="rounded-circle bg-info bg-opacity-10 p-3 me-3">
                                            <i id="status-icon" class="fas fa-info text-info"></i>
                                        </div>
                                        <div>
                                            <h6 class="text-muted mb-1">Statut</h6>
                                            <p class="mb-0 fw-bold" id="flight-status">Vérification...</p>
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
                            <% if(!isAdmin) { %>
                                <div class="btn-group">
                                    <button type="button" class="btn btn-outline-danger">
                                        <i class="fas fa-ticket me-2"></i>Réserver pour ce vol
                                    </button>
                                    <form id="cancelForm" action="${pageContext.request.contextPath}/reservations/create" method="post"
                                        class="d-none">
                                        <input type="hidden" name="id" value="<%= vol.getId() %>">
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

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Fonction pour convertir le format de date
            function parseDateTime(dateStr) {
                const [datePart, timePartRaw] = dateStr.trim().split(' ');
                const timePart = timePartRaw.split('.')[0]; // Enlève les millisecondes
                const [year, month, day] = datePart.split('-');
                const [hours, minutes, seconds] = timePart.split(':');
                return new Date(year, month - 1, day, hours, minutes, seconds);
            }

            // Formater la durée
            function formatDuration(hours, minutes) {
                return `${hours}h ${minutes.toString().padStart(2, '0')}min`;
            }

            // Récupérer les dates du vol
            const departDate = new Date("<%= vol.getDateDepart().toString().replace(' ', 'T') %>");
            const arriveeDate = new Date("<%= vol.getDateArrivee().toString().replace(' ', 'T') %>");
            const now = new Date();

            // Calculer la durée du vol
            const durationMs = arriveeDate - departDate;
            const hours = Math.floor(durationMs / (1000 * 60 * 60));
            const minutes = Math.floor((durationMs % (1000 * 60 * 60)) / (1000 * 60));
            document.getElementById('flight-duration').textContent = formatDuration(hours, minutes);

            // Déterminer le statut du vol
            const statusIcon = document.getElementById('status-icon');
            const statusText = document.getElementById('flight-status');
            const statusContainer = statusText.closest('.detail-item');

            console.log("Départ :", departDate);
            console.log("Arrivée :", arriveeDate);
            console.log("Durée (ms) :", arriveeDate - departDate);

            function updateStatus(iconClass, text, colorClass) {
                statusIcon.className = iconClass;
                statusText.textContent = text;
                // Mise à jour de la couleur du cercle
                statusIcon.closest('.rounded-circle').className = 
                    `rounded-circle ${colorClass} bg-opacity-10 p-3 me-3`;
            }

            if (now < departDate) {
                // Vol à venir
                updateStatus('fas fa-clock text-primary', 'Programmé', 'bg-primary');
            } else if (now >= departDate && now <= arriveeDate) {
                // Vol en cours
                updateStatus('fas fa-plane text-success', 'En vol', 'bg-success');
            } else {
                // Vol terminé
                updateStatus('fas fa-check-circle text-success', 'Terminé', 'bg-success');
            }

            // Vérifier si le vol est retardé
            const delayThreshold = 15 * 60 * 1000; // 15 minutes en millisecondes
            if (now > departDate && (now - departDate) > delayThreshold && now < arriveeDate) {
                updateStatus('fas fa-exclamation-circle text-warning', 'Retardé', 'bg-warning');
            }
        });
    </script>
</body>
</html>
