<%-- 
    Document   : Registrarse
    Created on : 22 jun 2024, 03:22:37
    Author     : LENOVO
--%>

<%@ page import="java.util.*" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registrarse</title>
     <link rel="stylesheet" type="text/css" href="../Estilos/Registrarse.css">
    <link rel="stylesheet" type="text/css" href="../Estilos/BackGround.css">
    <link rel="stylesheet" type="text/css" href="../Estilos/Mapa.css">
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCebE2GvD5WYsPAj1wmG_dCRMBgiKndH6g&callback=initMap" async defer></script>
</head>
<body>
    <center><h7>Registrarse</h7></center>
    <form action="${pageContext.request.contextPath}/ControladorCliente?action=register" method="post">
        <label for="dni">DNI:</label>
        <input type="text" id="dni" name="dni" required><br>
        <label for="nombre">Nombre:</label>
        <input type="text" id="nombre" name="nombre" required><br>
        <label for="direccion">Dirección:</label>
        <input type="text" id="direccion" name="direccion" required><br>
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required><br>
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required><br>
        <button type="submit">Registrarse</button>
    </form>

    <% 
        String success = request.getParameter("success");
        String error = request.getParameter("error");

        if ("1".equals(success)) {
            out.println("<p>Registro exitoso. Ahora puede iniciar sesión.</p>");
        } else if ("1".equals(error)) {
            out.println("<p>Error al registrarse. Intente de nuevo.</p>");
        }
    %>

    <div id="mapa-container">
        <div id="google-map"></div>
    </div>

    <script>
        var marker;

        function initMap() {
            var tacnaCoordinates = { lat: -18.035861, lng: -70.246639 };
            var map = new google.maps.Map(document.getElementById('google-map'), {
                center: tacnaCoordinates,
                zoom: 17
            });

            marker = new google.maps.Marker({
                position: tacnaCoordinates,
                map: map,
                draggable: true
            });

            google.maps.event.addListener(marker, 'dragend', function () {
                var lat = marker.getPosition().lat();
                var lng = marker.getPosition().lng();
                document.getElementById('direccion').value = lat + ', ' + lng;
            });

            map.addListener('click', function (event) {
                var lat = event.latLng.lat();
                var lng = event.latLng.lng();
                document.getElementById('direccion').value = lat + ', ' + lng;
                marker.setPosition({ lat: lat, lng: lng });
            });
        }
    </script>
</body>
</html>