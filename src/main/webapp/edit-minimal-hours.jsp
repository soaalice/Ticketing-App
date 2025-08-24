<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.itu16.ticketing.model.Param" %>

<%
    Param paramHeureReservation = (Param) request.getAttribute("paramHeureReservation");
    Param paramHeureAnnulation = (Param) request.getAttribute("paramHeureAnnulation");
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Paramètres - Délais minimaux</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css">
</head>
<body class="d-flex flex-column min-vh-100 bg-light">
    <%@ include file="assets/inc/header.jsp" %>

    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card shadow-sm">
                    <div class="card-header bg-white py-3">
                        <h1 class="h3 mb-0">Délais minimaux</h1>
                    </div>
                    <div class="card-body p-4">
                        <form action="${pageContext.request.contextPath}/edit-minimal-hours" method="post" class="needs-validation" novalidate>
                            <div class="row g-4">
                                <div class="col-md-6">
                                    <div class="card h-100">
                                        <div class="card-body">
                                            <h5 class="card-title mb-3">
                                                <i class="fas fa-clock text-primary me-2"></i>
                                                Délai minimal avant la fin des réservations
                                            </h5>
                                            <div class="form-floating">
                                                <input type="number" 
                                                       class="form-control" 
                                                       id="paramHeureReservation" 
                                                       name="paramHeureReservation" 
                                                       value="<%= paramHeureReservation.getValue() %>" 
                                                       min="0" 
                                                       required>
                                                <label for="paramHeureReservation">Heures avant le départ</label>
                                            </div>
                                            <small class="text-muted mt-2 d-block">
                                                Nombre d'heures minimum avant le départ où les réservations sont encore possibles
                                            </small>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="card h-100">
                                        <div class="card-body">
                                            <h5 class="card-title mb-3">
                                                <i class="fas fa-ban text-danger me-2"></i>
                                                Délai minimal avant annulation
                                            </h5>
                                            <div class="form-floating">
                                                <input type="number" 
                                                       class="form-control" 
                                                       id="paramHeureAnnulation" 
                                                       name="paramHeureAnnulation" 
                                                       value="<%= paramHeureAnnulation.getValue() %>" 
                                                       min="0" 
                                                       required>
                                                <label for="paramHeureAnnulation">Heures avant le départ</label>
                                            </div>
                                            <small class="text-muted mt-2 d-block">
                                                Nombre d'heures minimum avant le départ où les annulations sont encore possibles
                                            </small>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="d-flex justify-content-end gap-2 mt-4">
                                <a href="${pageContext.request.contextPath}/" 
                                   class="btn btn-light btn-lg px-4">
                                    <i class="fas fa-arrow-left me-2"></i>Retour
                                </a>
                                <button type="submit" class="btn btn-primary btn-lg px-4">
                                    <i class="fas fa-save me-2"></i>Enregistrer
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%@ include file="assets/inc/footer.jsp" %>

    <script>
        // Validation des formulaires Bootstrap
        (function () {
            'use strict'
            var forms = document.querySelectorAll('.needs-validation')
            Array.prototype.slice.call(forms).forEach(function (form) {
                form.addEventListener('submit', function (event) {
                    if (!form.checkValidity()) {
                        event.preventDefault()
                        event.stopPropagation()
                    }
                    form.classList.add('was-validated')
                }, false)
            })
        })()
    </script>
</body>
</html>