<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>FlyBook - Réservez vos vols au meilleur prix</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css">
    <style>
        .hero {
            background: linear-gradient(rgba(0, 0, 0, -0.5), rgba(0, 0, 0, 0.7)), url('assets/img/landscape.jpg');
            background-size: cover;
            background-position: center;
            min-height: 95vh;
            display: flex;
            align-items: center;
            position: relative;
        }
        .search-form {
            /* background: rgba(255, 255, 255, 0.95); */
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            margin-top: 2rem;
        }
        
        .search-input-group {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }
        
        .search-input-wrapper {
            width: 100%;
        }
        
        .search-button {
            height: 58px;
            padding: 0 30px;
            white-space: nowrap;
            transition: all 0.3s ease;
            width: 100%;
        }
        
        .search-button .button-text {
            display: inline;
        }
        
        @media (min-width: 992px) {
            .search-input-group {
                flex-direction: row;
                align-items: stretch;
                gap: 10px;
            }

            .search-input-wrapper {
                flex: 1;
                min-width: 0;
            }

            .search-button {
                width: auto;
            }

            .search-button .button-text {
                display: none;
            }

            .button-text {
                display: inline;
            }
        }

        .form-floating > .form-control {
            border-radius: 8px;
        }

        .feature-card {
            border: none;
            transition: transform 0.3s ease;
            border-radius: 12px;
            overflow: hidden;
        }
        .feature-card:hover {
            transform: translateY(-10px);
        }
        .feature-icon {
            font-size: 2.5rem;
            /* color: #0d6efd; */
            color: #00B2CA;
        }
        .destination-card {
            position: relative;
            overflow: hidden;
            border-radius: 12px;
            cursor: pointer;
            /* height: 100% */
        }
        .destination-card img {
            transition: transform 0.3s ease;
        }
        .destination-card:hover img {
            transform: scale(1.1);
        }
        .destination-overlay {
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            padding: 20px;
            background: linear-gradient(transparent, rgba(0,0,0,0.8));
            color: white;
        }
        .promo-badge {
            position: absolute;
            top: 20px;
            right: 20px;
            background: #dc3545;
            color: white;
            padding: 5px 15px;
            border-radius: 20px;
            font-weight: bold;
        }
        .hero-cta {
            background: linear-gradient(rgba(0, 0, 0, 0.367), rgba(0, 0, 0, 0.4)), 
                        url('assets/img/plane-hero.avif');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            padding: 120px 0;
            position: relative;
            margin-top: 2rem;
        }
        .hero-cta::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: radial-gradient(circle at center, rgba(0,0,0,0) 0%, rgba(0,0,0,0.2) 100%);
        }
        .cta-content {
            position: relative;
            z-index: 1;
        }
        .btn-cta {
            padding: 15px 40px;
            font-size: 1.2rem !important;
            text-transform: uppercase;
            letter-spacing: 4px;
            background: linear-gradient(45deg, #0d6efd, #0dcaf0);
            border: none;
            transition: all 0.3s ease;
            font-family: "Montserrat", sans-serif !important;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
        }
        .btn-cta:hover {
            transform: translateY(-3px);
            background: linear-gradient(45deg, #0b5ed7, #0bacbe);
            color: white !important;
        }
        .price-tag {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(5px);
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 0.9rem;
            margin-top: 1rem;
            display: inline-block;
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
                                <a href="${pageContext.request.contextPath}/login" class="link-warning">Connectez-vous</a> pour réserver un vol.
                            </div>
                    <%
                        }
                    %>

                    <form class="search-form" id="searchForm" action="${pageContext.request.contextPath}/vols" method="GET">
                        <div class="search-input-group">
                            <div class="search-input-wrapper">
                                <div class="form-floating">
                                    <input name="villeDepart" type="text" class="form-control" id="from" 
                                           placeholder="Ville de départ" list="from-cities">
                                    <label style="color: var(--bs-gray-600);" for="from">Départ</label>
                                    <datalist id="from-cities"></datalist>
                                </div>
                            </div>
                            <div class="search-input-wrapper">
                                <div class="form-floating">
                                    <input name="villeArrivee" type="text" class="form-control" id="to" 
                                           placeholder="Ville d'arrivée" list="to-cities">
                                    <label style="color: var(--bs-gray-600);" for="to">Arrivée</label>
                                    <datalist id="to-cities"></datalist>
                                </div>
                            </div>
                            <div class="search-input-wrapper">
                                <div class="form-floating">
                                    <input name="dateDepart" type="date" class="form-control" id="date">
                                    <label for="date">Date de départ</label>
                                </div>
                            </div>
                            <button type="submit" class="btn btn-primary search-button">
                                <i class="fas fa-search"></i>
                                <span class="button-text ms-2">Rechercher des vols</span>
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <div class="container">
        <div class="row mt-5">
            <div class="col-md-4 mb-4">
                <div class="card h-100 bg-white bg-opacity-90 feature-card">
                    <div class="card-body text-center p-4">
                        <i class="fas fa-shield-alt feature-icon mb-3"></i>
                        <h4>Réservation Sécurisée</h4>
                        <p class="text-muted">Protection des données et paiements sécurisés garantis.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="card h-100 bg-white bg-opacity-90 feature-card">
                    <div class="card-body text-center p-4">
                        <i class="fas fa-tag feature-icon mb-3"></i>
                        <h4>Meilleurs Prix</h4>
                        <p class="text-muted">Trouvez les meilleures offres et promotions exclusives.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="card h-100 bg-white bg-opacity-90 feature-card">
                    <div class="card-body text-center p-4">
                        <i class="fas fa-headset feature-icon mb-3"></i>
                        <h4>Support 24/7</h4>
                        <p class="text-muted">Notre équipe est à votre service à tout moment.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Popular Destinations -->
    <section class="py-5 bg-light">
        <div class="container">
            <h2 class="text-center mb-5">Destinations Populaires</h2>
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="destination-card shadow-sm">
                        <img src="assets/img/Paris.avif" class="img-fluid" alt="Paris">
                        <div class="destination-overlay">
                            <h4 class="mb-0">Paris</h4>
                            <p class="mb-0">À partir de 500,000 Ar</p>
                        </div>
                        <span class="promo-badge">-20%</span>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="destination-card shadow-sm">
                        <img src="assets/img/Dubai.avif" class="img-fluid" alt="Dubai">
                        <div class="destination-overlay">
                            <h4 class="mb-0">Dubai</h4>
                            <p class="mb-0">À partir de 800,000 Ar</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="destination-card shadow-sm">
                        <img src="assets/img/Londres.avif" class="img-fluid" alt="Londres">
                        <div class="destination-overlay">
                            <h4 class="mb-0">Londres</h4>
                            <p class="mb-0">À partir de 750,000 Ar</p>
                        </div>
                        <span class="promo-badge">-15%</span>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Why Choose Us -->
    <section class="py-5">
        <div class="container">
            <h2 class="text-center mb-5">Pourquoi Choisir FlyBook ?</h2>
            <div class="row g-4">
                <div class="col-md-3">
                    <div class="text-center">
                        <i class="fas fa-plane-departure mb-3 feature-icon"></i>
                        <h5>+500 Destinations</h5>
                        <p class="text-muted">Voyagez partout dans le monde</p>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="text-center">
                        <i class="fas fa-money-bill-wave mb-3 feature-icon"></i>
                        <h5>Prix Compétitifs</h5>
                        <p class="text-muted">Garantie du meilleur tarif</p>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="text-center">
                        <i class="fas fa-clock mb-3 feature-icon"></i>
                        <h5>Réservation Rapide</h5>
                        <p class="text-muted">En quelques clics seulement</p>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="text-center">
                        <i class="fas fa-star mb-3 feature-icon"></i>
                        <h5>Service Premium</h5>
                        <p class="text-muted">Satisfaction garantie</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Call to Action Section -->
    <section class="hero-cta">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8 text-center cta-content">
                    <h2 class="display-4 text-white mb-4" style="font-weight: 700;">
                        Des voyages inoubliables à prix exceptionnels !
                    </h2>
                    <p class="lead text-white mb-4">
                        Profitez de nos offres spéciales pour vos prochaines aventures
                    </p>
                    <a href="${pageContext.request.contextPath}/vols" 
                       class="btn btn-cta btn-lg">
                        <i class="fas fa-plane-up me-2"></i>
                        Réservez Maintenant
                    </a>
                </div>
            </div>
        </div>
    </section>

    <%@ include file="assets/inc/footer.jsp" %>
</body>
</html>
