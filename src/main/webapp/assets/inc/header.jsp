<%@ page contentType="text/html; charset=UTF-8" %>
    <header>
        <div class="logo">
            <h1>FlyBook</h1>
        </div>
        <nav>
            <ul>
                <li><a href="#">Accueil</a></li>

                    <%
                    Object userLoggedIn = session.getAttribute("authentified");
                    boolean isLogged = userLoggedIn != null && (Boolean) userLoggedIn;
                        if (isLogged) {
                    %>
                <li><a href="${pageContext.request.contextPath}/logout">Déconnexion</a></li>
                    <%
                        } else {
                    %>
                <li><a href="${pageContext.request.contextPath}/login">Connexion</a></li>
                <li><a href="${pageContext.request.contextPath}/signin">Inscription</a></li>
                    <%
                        }
                    %>
            </ul>
        </nav>
    </header>