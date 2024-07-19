<%-- 
    Document   : Mapa
    Created on : 6 jun. 2024, 03:07:27
    Author     : luna3
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Mapa</title>
    <link rel="stylesheet" type="text/css" href="../Estilos/Mapa.css">
</head>
<body>
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
