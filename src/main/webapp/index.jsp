<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Réservation de Vol - FlyBook</title>
    <style>
        .hero {
            background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)), url('assets/img/landscape.jpg');
            background-size: cover;
            background-position: center;
            min-height: 90vh;
            display: flex;
            align-items: center;
        }
        .search-form {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body class="d-flex flex-column min-vh-100">
    <%@ include file="assets/inc/header.jsp" %>

    <section class="hero">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-10 text-center text-white mb-5">
                    <h2 class="display-4 fw-bold mb-4">Réservez votre vol facilement</h2>
                    <p class="lead mb-5">Des destinations partout dans le monde, pour tous les budgets.</p>

                    <%
                        if (isLogged) {
                    %>
                            <div class="alert" role="alert">
                                Bienvenue, vous êtes connecté !
                            </div>
                    <%
                        } else {
                    %>
                            <div class="alert" role="alert">
                                Veuillez vous <a href="${pageContext.request.contextPath}/login" class="link-warning">connecter</a> pour réserver un vol.
                            </div>
                    <%
                        }
                    %>

                    <form class="search-form" id="searchForm" action="${pageContext.request.contextPath}/vols" method="GET">
                        <div class="row g-4">
                            <div class="col-md-4">
                                <div class="form-floating">
                                    <input name="villeDepart" type="text" class="form-control" id="from" 
                                           placeholder="Ville de départ" list="from-cities" required>
                                    <label for="from">Départ</label>
                                    <datalist id="from-cities"></datalist>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-floating">
                                    <input name="villeArrivee" type="text" class="form-control" id="to" 
                                           placeholder="Ville d'arrivée" list="to-cities" required>
                                    <label for="to">Arrivée</label>
                                    <datalist id="to-cities"></datalist>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-floating">
                                    <input name="dateDepart" type="date" class="form-control" id="date" required>
                                    <label for="date">Date de départ</label>
                                </div>
                            </div>
                            <div class="col-12">
                                <button type="submit" class="btn btn-primary btn-lg w-100">
                                    <i class="fas fa-search me-2"></i>Chercher des vols
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </section>

    <%@ include file="assets/inc/footer.jsp" %>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/datatables.net@1.10.24/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/datatables.net-bs5@1.10.24/js/dataTables.bootstrap5.min.js"></script>

    <script>
        let cities = [];

        async function fetchCities() {
            const contextPath = '<%= request.getContextPath() %>';
            const response = await fetch(contextPath + '/api/villes');
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

        function debounce(fn, delay) {
            let timeout;
            return (...args) => {
                clearTimeout(timeout);
                timeout = setTimeout(() => fn.apply(this, args), delay);
            };
        }

        document.getElementById('from').addEventListener('input', debounce(() => updateDatalist('from', 'from-cities'), 300));
        document.getElementById('to').addEventListener('input', debounce(() => updateDatalist('to', 'to-cities'), 300));

        document.getElementById('searchForm').addEventListener('submit', validateForm);

        fetchCities();
    </script>
</body>
</html>
