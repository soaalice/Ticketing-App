<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.itu16.ticketing.model.Vol" %>
<%@ page import="com.itu16.ticketing.model.SiegeAvion" %>

<% Vol vol=(Vol) request.getAttribute("vol"); List<SiegeAvion> sieges = (List<SiegeAvion>)
request.getAttribute("sieges");
%>

<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Réserver un Vol - FlyBook</title>
    <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
        rel="stylesheet">
    <style>
        .siege-card {
            transition: all 0.2s ease;
            cursor: pointer;
        }

        .siege-card:hover {
            transform: translateY(-3px);
        }

        .siege-checkbox:checked+.siege-card {
            border-color: #0d6efd !important;
            background-color: rgba(13, 110, 253, 0.1);
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
                            <h1 class="h3 mb-0">Réserver des sièges</h1>
                        </div>
                        <div class="card-body p-4">
                            <div class="flight-info mb-4 p-3 bg-light rounded">
                                <div class="row align-items-center">
                                    <div class="col-md-4 text-center">
                                        <h5 class="mb-1">
                                            <%= vol.getVilleDepart().getName() %>
                                        </h5>
                                        <p class="text-muted mb-0">
                                            <%= vol.getDateDepart() %>
                                        </p>
                                    </div>
                                    <div class="col-md-4 text-center">
                                        <i class="fas fa-plane text-primary"></i>
                                    </div>
                                    <div class="col-md-4 text-center">
                                        <h5 class="mb-1">
                                            <%= vol.getVilleArrivee().getName() %>
                                        </h5>
                                        <p class="text-muted mb-0">
                                            <%= vol.getDateArrivee() %>
                                        </p>
                                    </div>
                                </div>
                            </div>

                            <form
                                action="${pageContext.request.contextPath}/reservations/create"
                                method="post">
                                <input type="hidden" name="volId" value="<%= vol.getId() %>">
                                <input type="hidden" name="dateReservation"
                                    value="<%= java.time.LocalDateTime.now().toString() %>">
                                <input type="hidden" name="nSiege" id="nSiege" value="0">

                                <h5 class="mb-4">Sélectionnez vos sièges :</h5>
                                <div class="row g-4">
                                    <% if (sieges !=null) { for (int i=0; i < sieges.size();
                                        i++) { SiegeAvion siege=sieges.get(i); %>
                                        <div class="col-6 col-md-4 col-lg-3">
                                            <input type="checkbox"
                                                value="<%= siege.getId() %>"
                                                data-price="<%= siege.getPrix() %>"
                                                class="siege-checkbox d-none"
                                                id="siege<%= siege.getId() %>">
                                            <label for="siege<%= siege.getId() %>"
                                                class="siege-card card border h-100 mb-0">
                                                <div class="card-body text-center">
                                                    <div class="mb-2">
                                                        <span class="h4">
                                                            <%= siege.getId() %>
                                                        </span>
                                                    </div>
                                                    <div class="text-muted small">
                                                        <%= siege.getTypeSiege().getName() %>
                                                    </div>
                                                    <div class="mt-2 text-primary fw-bold">
                                                        <%= String.format("%,.2f",
                                                            siege.getPrix()) %> Ar
                                                    </div>
                                                </div>
                                            </label>
                                        </div>
                                        <% } } %>
                                </div>

                                <div class="total-section mt-4 p-3 bg-light rounded">
                                    <div
                                        class="d-flex justify-content-between align-items-center">
                                        <h5 class="mb-0">Total :</h5>
                                        <div class="h4 mb-0 text-primary">
                                            <span id="totalAmount">0</span> Ar
                                        </div>
                                    </div>
                                </div>

                                <div class="d-flex justify-content-between mt-4">
                                    <a href="${pageContext.request.contextPath}/vols"
                                        class="btn btn-light">
                                        <i class="fas fa-arrow-left me-2"></i>Retour
                                    </a>
                                    <button type="submit" class="btn btn-primary"
                                        id="submitBtn">
                                        <i class="fas fa-check me-2"></i>Réserver
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
                document.addEventListener('DOMContentLoaded', function () {
                        const checkboxes = document.querySelectorAll('.siege-checkbox');
                        const totalAmount = document.getElementById('totalAmount');
                        const form = document.querySelector('form');
                        const nSiegeInput = document.getElementById('nSiege');

                        // Met à jour les noms et total
                        function updateSelections() {
                            let total = 0;
                            let selected = [];

                            checkboxes.forEach(checkbox => {
                                checkbox.removeAttribute('name'); // reset all
                                if (checkbox.checked) {
                                    selected.push(checkbox);
                                    const price = parseFloat(checkbox.getAttribute('data-price')) || 0;
                                    total += price;
                                }
                            });

                            // Réattribuer les noms selon l'ordre
                            selected.forEach((cb, index) => {
                                cb.setAttribute('name', 'siegeAvionId' + (index + 1));
                            });

                            // Mettre à jour total + nSiege
                            totalAmount.textContent = total.toLocaleString('fr-FR', {
                                minimumFractionDigits: 2,
                                maximumFractionDigits: 2
                            });
                            nSiegeInput.value = selected.length;
                        }

                        // Écouteurs de changement sur chaque case
                        checkboxes.forEach(checkbox => {
                            checkbox.addEventListener('change', updateSelections);
                        });

                        // Gestion du submit
                        form.addEventListener('submit', function (e) {
                            const selected = Array.from(checkboxes).filter(cb => cb.checked);
                            if (selected.length === 0) {
                                e.preventDefault();
                                alert('Veuillez sélectionner au moins un siège.');
                                return;
                            }

                            const total = parseFloat(totalAmount.textContent.replace(/\s/g, '').replace(',', '.')) || 0;
                            const confirmMessage = `Vous avez sélectionné ` + selected.length + ` siège(s) pour un total de ` + total.toFixed(2) + ` Ar.\n\nVoulez-vous confirmer cette réservation ?`;

                            if (!confirm(confirmMessage)) {
                                e.preventDefault();
                            }
                        });

                        // Init
                        updateSelections();
                    });
            </script>
</body>

</html>