<%@ page contentType="text/html;charset=UTF-8" %>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <nav class="navbar navbar-expand-lg navbar-light bg-primary">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}">
                <h1 class="h3 mb-0 text-white">FlyBook</h1>
            </a>
            
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" 
                    data-bs-target="#navbarNav" aria-controls="navbarNav" 
                    aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link text-white" href="${pageContext.request.contextPath}">Accueil</a>
                    </li>

                    <%
                    Object userLoggedIn = session.getAttribute("authentified");
                    boolean isLogged = userLoggedIn != null && (Boolean) userLoggedIn;

                    boolean isAdmin = session.getAttribute("role") != null && session.getAttribute("role").equals("admin");
                        if (isLogged) {
                            if (isAdmin) {
                    %>
                            <li class="nav-item">
                                <a class="nav-link text-white" href="${pageContext.request.contextPath}/vols">Vols</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link text-white" href="${pageContext.request.contextPath}/promotions">Promos</a>
                            </li>
                    <% } %>
                            <li class="nav-item">
                                <a class="nav-link text-white" href="${pageContext.request.contextPath}/logout">Déconnexion</a>
                            </li>
                    <%
                        } else {
                    %>
                            <li class="nav-item">
                                <a class="nav-link text-white" href="${pageContext.request.contextPath}/login">Connexion</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link text-white" href="${pageContext.request.contextPath}/signin">Inscription</a>
                            </li>
                    <%
                        }
                    %>
                </ul>
            </div>
        </div>
    </nav>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>