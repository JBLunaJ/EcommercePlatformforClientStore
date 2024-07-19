<%-- 
    Document   : Editar
    Created on : 22 jun 2024, 04:21:45
    Author     : LENOVO
--%>
<%@page import="Modelo.ClsCliente"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Editar Perfil del Cliente</title>
    
    <link rel="stylesheet" type="text/css" href="../Estilos/header.css">
    <link rel="stylesheet" type="text/css" href="../Estilos/Perfil.css">
    <link rel="stylesheet" type="text/css" href="../Estilos/styles.css">
    <link rel="stylesheet" type="text/css" href="../Estilos/BackGround.css">
    <link rel="stylesheet" type="text/css" href="../Estilos/Perfil.css">
    <link rel="stylesheet" type="text/css" href="../Estilos/Mapa.css">

    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCebE2GvD5WYsPAj1wmG_dCRMBgiKndH6g&callback=initMap" async defer></script>
 <style>
    .button {
    display: inline-block;
    padding: 10px 20px;
    font-size: 16px;
    cursor: pointer;
    text-align: center;
    text-decoration: none;
    color: #fff;
    background-color: #8c54fa;;
    border: none;
    border-radius: 5px;
}

.button:hover {
    background-color: #8c54fa;
}

        /* Estilos adicionales para el contenedor del mapa */
        #mapa-container {
            margin-top: 20px;
        }
        #google-map {
            height: 400px; /* Ajusta la altura del mapa según tus necesidades */
            width: 100%; /* Opcional: ajusta el ancho del mapa */
        }
    </style>
</head>
<body>
    <header class="header">
        <a class="home" href="${pageContext.request.contextPath}/Index.jsp" class="logo">
            <img src="${pageContext.request.contextPath}/Images/Logo.jpg" alt="CompanyLogo">
        </a>
        <nav>
            <ul class="menu">
                <div class="header-right">
                    <a class="home" href="${pageContext.request.contextPath}/Index.jsp">Inicio</a>
                    <% if (session.getAttribute("cliente") != null) { %>
                        <a class="home" href="${pageContext.request.contextPath}/Perfil.jsp">Perfil</a>
                        <a class="home" href="${pageContext.request.contextPath}/Logout.jsp">Cerrar Sesión</a>
                    <% } else { %>
                        <a class="home" href="${pageContext.request.contextPath}/IniciarSesion/Login.jsp">Iniciar Sesión</a>
                    <% } %>
                </div>
            </ul>
        </nav>
    </header>

    <div class="perfil-container">
        <div class="perfil-info">
            <h2>Editar Perfil del Cliente</h2>
            <form action="${pageContext.request.contextPath}/ControladorCliente?action=updateProfile" method="post">
                <% 
                    // Obtener el cliente de la sesión
                    ClsCliente cliente = (ClsCliente) session.getAttribute("cliente");
                    if (cliente != null) {
                %>
                    <label for="dni">DNI:</label>
                    <input type="text" id="dni" name="dni" value="<%= cliente.getDni() %>" required><br>
                    <label for="nombre">Nombre:</label>
                    <input type="text" id="nombre" name="nombre" value="<%= cliente.getNombre() %>" required><br>
                    <label for="direccion">Dirección:</label>
                    <input type="text" id="direccion" name="direccion" value="<%= cliente.getDireccion() %>" required><br>
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" value="<%= cliente.getEmail() %>" required><br>
                    <label for="password">Password:</label>
                    <input type="password" id="password" name="password" required><br>
                    <!-- Campo oculto para almacenar la ubicación -->
                    <input type="hidden" id="ubicacion" name="ubicacion">
                    <button class="button"type="submit">Guardar Cambios</button>
                    <a href="Perfil.jsp" class="button">Volver</a>
                <% } %>
            </form>
            
            <% 
                // Lógica para mostrar mensajes de éxito o error
                String successMessage = request.getParameter("successMessage");
                String errorMessage = request.getParameter("errorMessage");

                if (successMessage != null) {
            %>
                    <p class='success-message'><%= successMessage %></p>
            <% 
                }

                if (errorMessage != null) {
            %>
                    <p class='error-message'><%= errorMessage %></p>
            <% 
                }
            %>
        </div>
    </div>

    <!-- Contenedor del mapa -->
    <div id="mapa-container">
        <div id="google-map"></div>
    </div>

    <!-- Script JavaScript para inicializar el mapa y el marcador -->
    <script>
        // Función de inicialización del mapa de Google
        function initMap() {
            var tacnaCoordinates = { lat: -18.035861, lng: -70.246639 };
            var map = new google.maps.Map(document.getElementById('google-map'), {
                center: tacnaCoordinates,
                zoom: 17
            });

            // Marcador inicial en Tacna
            var marker = new google.maps.Marker({
                position: tacnaCoordinates,
                map: map,
                draggable: true // Permitir que el marcador sea arrastrable
            });

            // Evento para obtener coordenadas al mover el marcador
            google.maps.event.addListener(marker, 'dragend', function () {
                var lat = marker.getPosition().lat();
                var lng = marker.getPosition().lng();
                document.getElementById('ubicacion').value = lat + ', ' + lng;
            });

            // Evento para obtener coordenadas al hacer clic en el mapa
            map.addListener('click', function (event) {
                var lat = event.latLng.lat();
                var lng = event.latLng.lng();
                document.getElementById('ubicacion').value = lat + ', ' + lng;
                marker.setPosition({ lat: lat, lng: lng });
            });
        }
    </script>
</body>
</html>