<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.itu16.ticketing.model.Vol" %>
<%@ page import="com.itu16.ticketing.model.TypeSiege" %>

<%
    List<Vol> vols = (List<Vol>) request.getAttribute("vols");
    List<TypeSiege> typesSiege = (List<TypeSiege>) request.getAttribute("typesSiege");
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nouvelle Promotion - FlyBook</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body class="d-flex flex-column min-vh-100 bg-light">
    <%@ include file="assets/inc/header.jsp" %>

    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card shadow-sm">
                    <div class="card-header bg-white py-3">
                        <h1 class="h3 mb-0">Créer une nouvelle promotion</h1>
                    </div>
                    <div class="card-body p-4">
                        <form action="${pageContext.request.contextPath}/promotions/create" method="post" 
                              class="needs-validation" novalidate>
                            
                            <div class="row g-4">
                                <div class="col-12">
                                    <div class="form-floating">
                                        <select name="volId" id="vol" class="form-select" required>
                                            <option value="">Sélectionnez un vol</option>
                                            <% for (Vol vol : vols) { %>
                                                <option value="<%= vol.getId() %>">
                                                    <%= vol.getVilleDepart().getName() %> → 
                                                    <%= vol.getVilleArrivee().getName() %> 
                                                    (<%= vol.getDateDepart() %>)
                                                </option>
                                            <% } %>
                                        </select>
                                        <label for="vol">Vol</label>
                                        <div class="invalid-feedback">
                                            Veuillez sélectionner un vol.
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="form-floating">
                                        <input type="number" id="reduction" name="reduction" 
                                               class="form-control" min="1" max="100" required
                                               placeholder="Réduction en pourcentage">
                                        <label for="reduction">Réduction (%)</label>
                                        <div class="invalid-feedback">
                                            La réduction doit être entre 1 et 100%.
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="form-floating">
                                        <select name="typeSiegeId" id="typeSiege" class="form-select" required>
                                            <option value="">Sélectionnez un type</option>
                                            <% for (TypeSiege type : typesSiege) { %>
                                                <option value="<%= type.getId() %>">
                                                    <%= type.getName() %>
                                                </option>
                                            <% } %>
                                        </select>
                                        <label for="typeSiege">Type de siège</label>
                                        <div class="invalid-feedback">
                                            Veuillez sélectionner un type de siège.
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="form-floating">
                                        <input type="datetime-local" id="dateDebut" name="dateDebut" 
                                               class="form-control" required>
                                        <label for="dateDebut">Date de début</label>
                                        <div class="invalid-feedback">
                                            Veuillez sélectionner une date de début.
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="form-floating">
                                        <input type="datetime-local" id="dateFin" name="dateFin" 
                                               class="form-control" required>
                                        <label for="dateFin">Date de fin</label>
                                        <div class="invalid-feedback">
                                            Veuillez sélectionner une date de fin.
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="form-floating">
                                        <input type="number" id="nSiege" name="nSiege" 
                                               class="form-control" min="1" required
                                               placeholder="Nombre de sièges">
                                        <label for="nSiege">Nombre de sièges</label>
                                        <div class="invalid-feedback">
                                            Veuillez indiquer le nombre de sièges.
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="d-flex justify-content-end gap-2 mt-4">
                                <a href="${pageContext.request.contextPath}/promotions" 
                                   class="btn btn-light btn-lg px-4">
                                    <i class="fas fa-arrow-left me-2"></i>Retour
                                </a>
                                <button type="submit" class="btn btn-primary btn-lg px-4">
                                    <i class="fas fa-check me-2"></i>Créer
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
        // Validation du formulaire
        (function() {
            'use strict';
            const forms = document.querySelectorAll('.needs-validation');
            
            Array.from(forms).forEach(form => {
                form.addEventListener('submit', event => {
                    if (!form.checkValidity()) {
                        event.preventDefault();
                        event.stopPropagation();
                    }
                    form.classList.add('was-validated');
                }, false);
            });

            // Validation des dates
            const dateDebut = document.getElementById('dateDebut');
            const dateFin = document.getElementById('dateFin');

            dateDebut.addEventListener('change', function() {
                dateFin.min = this.value;
            });

            dateFin.addEventListener('change', function() {
                if (this.value <= dateDebut.value) {
                    this.setCustomValidity('La date de fin doit être postérieure à la date de début');
                } else {
                    this.setCustomValidity('');
                }
            });
        })();
    </script>
</body>
</html>