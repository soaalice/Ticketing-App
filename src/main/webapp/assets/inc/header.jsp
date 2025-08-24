<%@ page contentType="text/html;charset=UTF-8" %>
    <!-- Roboto: 400 (regular), 700 (bold) -->
    <!-- <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet"> -->
    
    <!-- Montserrat: 400 (regular), 600, 700, italic 400 -->
    <!-- <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,400;1,400;0,600;0,700&display=swap"
        rel="stylesheet"> -->


    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        :root, [data-bs-theme=light] {
            --bs-primary-rgb: 0, 178, 202;
        }
        .btn-primary {
            --bs-btn-bg: #00B2CA;
            --bs-btn-border-color: #00B2CA;
            --bs-btn-hover-bg: #0092A8;
            --bs-btn-hover-border-color: #0092A8;
            --bs-btn-active-bg: #007C90;
            --bs-btn-active-border-color: #007C90;
        }
        .btn-outline-primary {
            --bs-btn-color: #00B2CA;
            --bs-btn-border-color: #00B2CA;
            --bs-btn-bg: transparent;

            --bs-btn-hover-color: #ffffff;
            --bs-btn-hover-bg: #0092A8;
            --bs-btn-hover-border-color: #0092A8;

            --bs-btn-active-color: #ffffff;
            --bs-btn-active-bg: #007C90;
            --bs-btn-active-border-color: #007C90;

            --bs-btn-disabled-color: #b3e6ec;
            --bs-btn-disabled-border-color: #b3e6ec;
            --bs-btn-disabled-bg: transparent;
        }

    </style>
    
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
                                <a class="nav-link text-white" href="${pageContext.request.contextPath}/reservations">Réservations</a>
                            </li>
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