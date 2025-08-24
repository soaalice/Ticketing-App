<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.itu16.ticketing.model.Vol" %>
<%@ page import="java.time.LocalDateTime" %>

<%
    String errorMessage = (String) request.getAttribute("errorMessage");
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des Vols</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body class="d-flex flex-column min-vh-100">
    <%@ include file="assets/inc/header.jsp" %>

    <div class="container py-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1 class="h2">Liste des Vols</h1>
            <% if (isAdmin) { %>
                <a href="${pageContext.request.contextPath}/vols/create" class="btn btn-primary">
                    <i class="fas fa-plus me-2"></i>Nouveau Vol
                </a>
            <% } %>
        </div>

        <% if (errorMessage != null) { %>
            <div class="alert alert-danger alert-dismissible fade show mb-4" role="alert">
                <i class="fas fa-exclamation-triangle me-2"></i>
                <%= errorMessage %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <% } %>

        <div class="row g-4">
            <% 
                List<Vol> vols = (List<Vol>) request.getAttribute("vols");
                if (vols != null && !vols.isEmpty()) {
                    for (Vol vol : vols) {
            %>
                <div class="col-md-6 col-lg-4">
                    <div class="card h-100 shadow-sm">
                        <div class="card-header bg-white d-flex justify-content-between align-items-center py-3">
                            <h6 class="mb-0">
                                <i class="fas fa-plane text-primary me-2"></i>Vol N°<%= vol.getId() %>
                            </h6>
                            <%
                                LocalDateTime now = LocalDateTime.now();
                                LocalDateTime dateButoire = LocalDateTime.parse(vol.getDateButoireReservation());
                                boolean reservationsClosed = now.isAfter(dateButoire);
                                if (reservationsClosed) {
                            %>
                                <span class="badge bg-warning">
                                    <i class="fas fa-lock me-1"></i>Réservations fermées
                                </span>
                            <% } else { %>
                                <span class="badge bg-success">
                                    <i class="fas fa-check-circle me-1"></i>Réservations ouvertes
                                </span>
                            <% } %>
                        </div>
                        <div class="card-body">
                            <h5 class="card-title mb-3">
                                <%= vol.getVilleDepart().getName() %> 
                                - 
                                <%= vol.getVilleArrivee().getName() %>
                            </h5>
                            <div class="card-text">
                                <p class="mb-2">
                                    <i class="fas fa-plane me-2 text-secondary"></i>
                                    <strong>Ref :</strong>
                                    <%= vol.getAvion().toString() %>
                                </p>
                                <p class="mb-2">
                                    <i class="fas fa-calendar me-2 text-secondary"></i>
                                    <strong>Départ :</strong> <%= vol.getDateDepart() %>
                                </p>
                                <p class="mb-3">
                                    <i class="fas fa-calendar-check me-2 text-secondary"></i>
                                    <strong>Arrivée :</strong> <%= vol.getDateArrivee() %>
                                </p>
                                <p class="mb-2">
                                    <i class="fas fa-hourglass-end me-2 text-warning"></i>
                                    <strong>Réservations jusqu'au:</strong> <%= vol.getDateButoireReservation() %>
                                </p>
                            </div>
                        </div>
                        <div class="card-footer bg-transparent border-top-0">
                            <div class="d-flex justify-content-between align-items-center">
                                <div class="btn-group">
                                    <a href="${pageContext.request.contextPath}/vols/details?id=<%= vol.getId() %>" 
                                       class="btn btn-outline-primary btn-sm">
                                        <i class="fas fa-info-circle me-1"></i>Détails
                                    </a>
                                </div>
                                <% if (isLogged && !isAdmin && !reservationsClosed) { %>
                                    <div class="btn-group">
                                        <a href="${pageContext.request.contextPath}/reservations/create?volId=<%= vol.getId() %>" 
                                           class="btn btn-success btn-sm ms-2">
                                            <i class="fas fa-ticket me-1"></i>Réserver
                                        </a>
                                    </div>
                                <% } %>
                                <% if (isAdmin) { %>
                                    <div class="btn-group">
                                        <a href="${pageContext.request.contextPath}/vols/edit?id=<%= vol.getId() %>" 
                                           class="btn btn-outline-secondary btn-sm">
                                            <i class="fas fa-edit me-1"></i>Modifier
                                        </a>
                                    </div>
                                    <div class="btn-group">
                                        <form action="${pageContext.request.contextPath}/vols/delete?id=<%= vol.getId() %>" 
                                              method="post" class="d-inline">
                                            <button type="submit" class="btn btn-outline-danger btn-sm ms-2" 
                                                    onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce vol ?')">
                                                <i class="fas fa-trash me-1"></i>Supprimer
                                            </button>
                                        </form>
                                    </div>
                                <% } %>
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
                        <i class="fas fa-info-circle me-2"></i>Aucun vol trouvé.
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
