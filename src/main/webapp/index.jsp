<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Réservation de Vol - FlyBook</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <style>
    <%@ include file="assets/css/styles.css" %>
    </style>
</head>
<body>

    <%@ include file="assets/inc/header.jsp" %>

    <section class="hero">
        <div class="hero-content">
            <h2>Réservez votre vol facilement</h2>
            <p>Des destinations partout dans le monde, pour tous les budgets.</p>

            <%
                Object userLoggedIn = session.getAttribute("authentified");
                if (userLoggedIn != null && (Boolean) userLoggedIn) {
            %>
                    <p>Bienvenue, vous êtes connecté !</p>
            <%
                } else {
            %>
                    <p>Veuillez vous <a href = "${pageContext.request.contextPath}/login"> connecter </a> pour réserver un vol.</p>
            <%
                }
            %>

            <form class="search-form">
                <div class="form-group">
                    <label for="from">Départ :</label>
                    <input type="text" id="from" placeholder="Ville de départ" required>
                </div>
                <div class="form-group">
                    <label for="to">Arrivée :</label>
                    <input type="text" id="to" placeholder="Ville d'arrivée" required>
                </div>
                <div class="form-group">
                    <label for="date">Date de départ :</label>
                    <input type="date" id="date" required>
                </div>
                <button type="submit" class="btn-search">Chercher des vols</button>
            </form>
        </div>
    </section>

    <%@ include file="assets/inc/footer.jsp" %>

</body>
</html>
