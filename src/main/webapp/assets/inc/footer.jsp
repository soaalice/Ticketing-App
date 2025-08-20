<%@ page contentType="text/html;charset=UTF-8" %>
    <footer class="bg-dark text-light py-4 mt-auto">
        <div class="container">
            <div class="row">
                <div class="col-md-4 mb-3 mb-md-0">
                    <h5 class="mb-3">FlyBook</h5>
                    <p class="mb-0">Votre partenaire de confiance pour tous vos voyages en avion.</p>
                </div>
                <div class="col-md-4 mb-3 mb-md-0">
                    <h5 class="mb-3">Liens rapides</h5>
                    <ul class="list-unstyled">
                        <li><a href="${pageContext.request.contextPath}" class="text-light text-decoration-none">Accueil</a></li>
                        <li><a href="${pageContext.request.contextPath}/vols" class="text-light text-decoration-none">Vols</a></li>
                        <li><a href="${pageContext.request.contextPath}/promotions" class="text-light text-decoration-none">Promotions</a></li>
                        <% if (isLogged) { %>
                            <li><a href="${pageContext.request.contextPath}/reservations" class="text-light text-decoration-none">Réservations</a></li>
                        <% } %>
                        <!-- <li><a href="#" class="text-light text-decoration-none">Contact</a></li> -->
                    </ul>
                </div>
                <div class="col-md-4">
                    <h5 class="mb-3">Contact</h5>
                    <p class="mb-0">
                        <i class="fas fa-envelope me-2"></i>contact@flybook.com<br>
                        <i class="fas fa-phone me-2"></i>+261 34 00 000 00
                    </p>
                </div>
            </div>
            <hr class="my-4">
            <div class="row">
                <div class="col text-center">
                    <p class="mb-0">&copy; 2025 FlyBook. Tous droits réservés.</p>
                </div>
            </div>
        </div>
    </footer>