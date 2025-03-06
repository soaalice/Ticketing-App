<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Réservation de Vol - Ticketing</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        font-family: 'Roboto', sans-serif;
        background-color: #f4f4f4;
        color: #333;
        display: flex;
        flex-direction: column;
        min-height: 100vh;
    }

    header {
        background-color: #0d6efd;
        padding: 20px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    header .logo h1 {
        color: white;
        font-size: 24px;
    }

    header nav ul {
        list-style: none;
        display: flex;
        gap: 20px;
    }

    header nav ul li a {
        color: white;
        text-decoration: none;
        font-weight: bold;
        transition: color 0.3s;
    }

    header nav ul li a:hover {
        color: #ffbb00;
    }

    .hero {
        background: url('assets/img/landscape.jpg') no-repeat center center/cover;
        height: 90vh;
        display: flex;
        justify-content: center;
        align-items: center;
        color: white;
        text-align: center;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        position: relative;
    }

    .hero::before {
        content: "";
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.5); /* Adjust the opacity here */
        z-index: 1;
    }

    .hero-content {
        position: relative;
        z-index: 2;
    }

    .hero h2 {
        font-size: 40px;
        margin-bottom: 10px;
    }

    .hero p {
        font-size: 18px;
        margin-bottom: 20px;
    }

    .search-form {
        display: grid;
        grid-template-columns: 1fr 1fr 1fr;
        gap: 15px;
        max-width: 800px;
        margin: 0 auto;
        padding: 20px;
        background-color: rgba(255, 255, 255, 0.9);
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    .search-form .form-group {
        display: flex;
        flex-direction: column;
    }

    .search-form label {
        font-weight: bold;
        margin-bottom: 5px;
    }

    .search-form input {
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 5px;
        font-size: 16px;
        box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    .search-form .btn-search {
        grid-column: span 3;
        padding: 12px;
        background-color: #0d6efd;
        border: none;
        border-radius: 5px;
        color: white;
        font-size: 18px;
        cursor: pointer;
        transition: background-color 0.3s, transform 0.3s;
    }

    .search-form .btn-search:hover {
        background-color: #0056b3;
        filter: brightness(0.9);
    }

    footer {
        background-color: #222;
        color: white;
        text-align: center;
        padding: 15px;
        font-size: 14px;
        box-shadow: 0 -4px 8px rgba(0, 0, 0, 0.1);
        margin-top: auto;
    }

    @media (max-width: 768px) {
        .search-form {
            grid-template-columns: 1fr 1fr;
        }
    }

    @media (max-width: 480px) {
        .search-form {
            grid-template-columns: 1fr;
        }
    }

    </style>
</head>
<body>

    <header>
        <div class="logo">
            <h1>FlyBook</h1>
        </div>
        <nav>
            <ul>
                <li><a href="#">Accueil</a></li>
                <li><a href="#">Offres</a></li>
                <li><a href="#">Contact</a></li>
            </ul>
        </nav>
    </header>

    <section class="hero">
        <div class="hero-content">
            <h2>Réservez votre vol facilement</h2>
            <p>Des destinations partout dans le monde, pour tous les budgets.</p>
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

    <footer>
        <p>&copy; 2025 FlyBook. Tous droits réservés.</p>
    </footer>

</body>
</html>