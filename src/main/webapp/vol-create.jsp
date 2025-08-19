<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.itu16.ticketing.model.Avion" %>
<%@ page import="com.itu16.ticketing.model.Ville" %>

<%
    List<Avion> avions = (List<Avion>) request.getAttribute("avions");
    List<Ville> villes = (List<Ville>) request.getAttribute("villes");
%>

<html>
<head>
    <title>Créer un Vol</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body class="d-flex flex-column min-vh-100 bg-light">
    <%@ include file="assets/inc/header.jsp" %>

    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card shadow-sm">
                    <div class="card-header bg-white py-3">
                        <h1 class="h3 mb-0">Créer un nouveau Vol</h1>
                    </div>
                    <div class="card-body p-4">
                        <form action="${pageContext.request.contextPath}/vols" method="post" class="needs-validation" novalidate>
                            <div class="row g-4">
                                <div class="col-md-6">
                                    <div class="form-floating">
                                        <select name="avion_id" id="avion" class="form-select" required>
                                            <% for (Avion avion : avions) { %>
                                                <option value="<%= avion.getId() %>"><%= avion.getModele().getName() %></option>
                                            <% } %>
                                        </select>
                                        <label for="avion">Avion</label>
                                    </div>
                                </div>
                                
                                <div class="col-md-6">
                                    <div class="form-floating">
                                        <select name="ville_depart_id" id="villeDepart" class="form-select" required>
                                            <% for (Ville ville : villes) { %>
                                                <option value="<%= ville.getId() %>"><%= ville.getName() %></option>
                                            <% } %>
                                        </select>
                                        <label for="villeDepart">Ville de Départ</label>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="form-floating">
                                        <select name="ville_arrivee_id" id="villeArrivee" class="form-select" required>
                                            <% for (Ville ville : villes) { %>
                                                <option value="<%= ville.getId() %>"><%= ville.getName() %></option>
                                            <% } %>
                                        </select>
                                        <label for="villeArrivee">Ville d'Arrivée</label>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="form-floating">
                                        <input type="datetime-local" id="dateDepart" name="dateDepart" 
                                               class="form-control" required>
                                        <label for="dateDepart">Date de Départ</label>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="form-floating">
                                        <input type="datetime-local" id="dateArrivee" name="dateArrivee" 
                                               class="form-control" required>
                                        <label for="dateArrivee">Date d'Arrivée</label>
                                    </div>
                                </div>
                            </div>

                            <div class="d-flex justify-content-end gap-2 mt-4">
                                <a href="${pageContext.request.contextPath}/vols" 
                                   class="btn btn-light btn-lg px-4">
                                    <i class="fas fa-arrow-left me-2"></i>Retour
                                </a>
                                <button type="submit" class="btn btn-primary btn-lg px-4">
                                    <i class="fas fa-check me-2"></i>Créer
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%@ include file="assets/inc/footer.jsp" %>
</body>
</html>
