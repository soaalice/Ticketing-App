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
                if (isLogged) {
            %>
                    <p>Bienvenue, vous êtes connecté !</p>
            <%
                } else {
            %>
                    <p>Veuillez vous <a href="${pageContext.request.contextPath}/login"> connecter </a> pour réserver un vol.</p>
            <%
                }
            %>

            <form class="search-form" id="searchForm">
                <div class="form-group">
                    <label for="from">Départ :</label>
                    <input type="text" id="from" placeholder="Ville de départ" list="from-cities" required>
                    <datalist id="from-cities"></datalist>
                </div>
                <div class="form-group">
                    <label for="to">Arrivée :</label>
                    <input type="text" id="to" placeholder="Ville d'arrivée" list="to-cities" required>
                    <datalist id="to-cities"></datalist>
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

    <script>
        let cities = [];

        async function fetchCities() {
            const contextPath = '<%= request.getContextPath() %>';
            const response = await fetch(contextPath + '/villes');
            cities = await response.json();
        }

        function updateDatalist(inputId, datalistId) {
            const inputValue = document.getElementById(inputId).value.toLowerCase();
            const datalist = document.getElementById(datalistId);
            datalist.innerHTML = '';

            // if (inputValue.length < 2) return;

            const filteredCities = cities.filter(city => city.name.toLowerCase().includes(inputValue));

            filteredCities.forEach(city => {
                const optionElement = document.createElement('option');
                optionElement.value = city.name;
                datalist.appendChild(optionElement);
            });
        }

        function validateForm(event) {
            const fromCity = document.getElementById('from').value;
            const toCity = document.getElementById('to').value;

            const isValidFrom = cities.some(city => city.name === fromCity);
            const isValidTo = cities.some(city => city.name === toCity);

            if (!isValidFrom || !isValidTo) {
                alert('Les villes saisies ne sont pas valides.');
                event.preventDefault();
            }
        }

        document.getElementById('from').addEventListener('input', () => updateDatalist('from', 'from-cities'));
        document.getElementById('to').addEventListener('input', () => updateDatalist('to', 'to-cities'));
        document.getElementById('searchForm').addEventListener('submit', validateForm);

        fetchCities();
    </script>
</body>
</html>
