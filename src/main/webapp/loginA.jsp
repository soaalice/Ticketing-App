<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Connexion - FlyBook</title>
  <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
  <style>
  /* Général */
    body {
    font-family: 'Roboto', sans-serif;
    background-color: #f4f7fa;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    margin: 0;
    }

    .login-container {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100%;
    }

    .login-box {
    background-color: white;
    padding: 40px;
    box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
    border-radius: 8px;
    width: 100%;
    max-width: 400px;
    }

    h2 {
    text-align: center;
    margin-bottom: 20px;
    color: #0d6efd;
    }

    .textbox {
    margin-bottom: 20px;
    position: relative;
    }

    .textbox input {
    width: 80%;
    padding: 8px;
    padding-left: 40px;
    border: 1px solid #ccc;
    border-radius: 5px;
    font-size: 16px;
    }

    .textbox input:focus {
    border-color: #0d6efd;
    }

    .textbox input::placeholder {
    color: #aaa;
    }

    .btn {
    width: 100%;
    padding: 10px;
    background-color: #0d6efd;
    color: white;
    border: none;
    border-radius: 5px;
    font-size: 16px;
    cursor: pointer;
    transition: background-color 0.3s;
    }

    .btn:hover {
    background-color: #0b5ed7;
    }

    .signup {
    text-align: center;
    margin-top: 20px;
    }

    .signup p {
    font-size: 14px;
    }

    .signup a {
    color: #0d6efd;
    text-decoration: none;
    }

    .signup a:hover {
    text-decoration: underline;
    }

  </style>
</head>
<body>
  <div class="login-container">
    <div class="login-box">
      <h2>Connexion</h2>

      <!-- Affichage du message d'erreur si l'utilisateur n'est pas trouvé -->
      <c:if test="${not empty msg}">
        <div style="color: red; text-align: center; margin-bottom: 10px;">
          ${msg}
        </div>
      </c:if>

      <form action="${pageContext.request.contextPath}/loginA" method="post">
        <div class="textbox">
          <input type="text" placeholder="Nom d'utilisateur" name="log.userName" required>
        </div>
        <div class="textbox">
          <input type="password" placeholder="Mot de passe" name="log.password" required>
        </div>
        <button type="submit" class="btn">Se connecter</button>
        <div class="signup">
          <p>Pas encore de compte ? <a href="${pageContext.request.contextPath}/signin">S'inscrire</a></p>
        </div>
      </form>
    </div>
  </div>
</body>
</html>
