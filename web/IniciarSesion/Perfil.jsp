<%-- 
    Document   : Perfil
    Created on : 22 jun 2024, 03:22:32
    Author     : LENOVO
--%>

<%@ page import="Modelo.ClsCliente" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Perfil del Cliente</title>
    
    <!-- Enlace a los estilos CSS -->
    <link rel="stylesheet" type="text/css" href="../Estilos/header.css">
    <link rel="stylesheet" type="text/css" href="../Estilos/Perfil.css">
    <link rel="stylesheet" type="text/css" href="../Estilos/styles.css">
    <link rel="stylesheet" type="text/css" href="../Estilos/BackGround.css">
    <link rel="stylesheet" type="text/css" href="../Estilos/Mapa.css">
    <link rel="stylesheet" type="text/css" href="../Estilos/footer.css">

    <!-- Script de Google Maps con tu API Key -->
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
</style>
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
</head>
<body>
    <%-- Verificación de sesión y contenido del perfil --%>
    <% 
    ClsCliente cliente = (ClsCliente) session.getAttribute("cliente");
    if (cliente == null) {
        response.sendRedirect("../IniciarSesion/Login.jsp");
    } else {
    %>
    <header class="header">
        <a class="home" href="#default" class="logo">
            <img src="../Images/Logo.jpg" alt="CompanyLogo">
        </a>
        <nav>
            <ul class="menu">
                <div class="header-right">
                    <a class="home" href="../Index.jsp">Inicio</a>
                    <% if (session.getAttribute("cliente") != null) { %>
                        <a class="home" href="Perfil.jsp">Perfil</a>
                        <a class="home" href="Logout.jsp">Cerrar Sesión</a>
                    <% } else { %>
                        <a class="home" href="IniciarSesion/Login.jsp">Iniciar Sesión</a>
                    <% } %>
                </div>
            </ul>
        </nav>
    </header>

    <!-- Contenido del perfil -->
    <div class="perfil-container">
        <div class="perfil-info">
            <h2>Información del Cliente</h2>
            <p>Nombre: <%= cliente.getNombre() %></p>
            <p>Email: <%= cliente.getEmail() %></p>
            <p>DNI: <%= cliente.getDni() %></p>
            <p>Dirección: <%= cliente.getDireccion() %></p>

            <!-- Botón para editar perfil -->
            <button class="button" onclick="redirectToEditar(<%= cliente.getIdCliente() %>)">Editar</button>
            <a href="../Stripe/Historial.jsp" class="button">Historial de Compras</a>

        </div>
    </div>

    <!-- Contenedor del mapa -->
    <div id="mapa-container">
        <div id="google-map"></div>
    </div>

    <% } %>

    <!-- Script para redireccionar a la página de edición -->
    <script>
        function redirectToEditar(clienteId) {
            window.location.href = "Editar.jsp?idCliente=" + clienteId;
        }
    </script>
    
    
 <footer class="footer">
    <div class="footer-content">
        <div class="footer-section about">
            <h1 class="logo-text"><span>Abarrotes</span>Ross</h1>
            <p>
                Bienvenidos a Abarrotes Ross. Aquí encontrarás los mejores productos de calidad.
            </p>
            <div class="contact">
                <span><i class="fas fa-phone"></i> &nbsp; +51 942784671</span>
                <span><i class="fas fa-envelope"></i> &nbsp; lunaj9652@gmail.com</span>
                <span><i class="fab fa-linkedin"></i> &nbsp; <a href="https://www.linkedin.com/in/juan-brendon-luna-juarez-342a1b25b" target="_blank">Conéctate en LinkedIn</a></span>
            </div>
            <div class="socials">
                <a href="#"><i class="fab fa-facebook"></i></a>
                <a href="#"><i class="fab fa-twitter"></i></a>
                <a href="#"><i class="fab fa-instagram"></i></a>
                <a href="#"><i class="fab fa-youtube"></i></a>
                <a href="https://www.linkedin.com/in/juan-brendon-luna-juarez-342a1b25b" target="_blank"><i class="fab fa-linkedin"></i></a>
            </div>
        </div>

        <div class="footer-section links">
            <h2>Enlaces rápidos</h2>
            <br>
            <ul>
                <a href="#"><li>Inicio</li></a>
                <a href="#"><li>Sobre nosotros</li></a>
                <a href="#"><li>Servicios</li></a>
                <a href="#"><li>Contáctanos</li></a>
                <a href="#"><li>Política de privacidad</li></a>
                <a href="https://www.linkedin.com/in/juan-brendon-luna-juarez-342a1b25b" target="_blank"><li>Ayuda</li></a>
            </ul>
        </div>

        <div class="footer-section contact-form">
            <h2>Contáctanos</h2>
            <br>
            <form action="Index.jsp" method="post">
                <input type="email" name="email" class="text-input contact-input" placeholder="Correo electrónico...">
                <textarea name="message" class="text-input contact-input" placeholder="Mensaje..."></textarea>
                <button type="submit" class="btn btn-big contact-btn">
                    <i class="fas fa-envelope"></i>
                    Enviar
                </button>
            </form>
        </div>
    </div>

    <div class="footer-bottom">
        &copy; repositoriojualunaj.com | Diseñado por JLunaJ
    </div>
</footer>

</body>
</html>
