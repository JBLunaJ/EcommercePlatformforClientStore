<%@page import="Modelo.ClsVenta"%>
<%@page import="java.util.List"%>
<%@page import="Modelo.ClsCliente"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Historial de Compras</title>
    
    <link rel="stylesheet" type="text/css" href="../Estilos/header.css">
    <link rel="stylesheet" type="text/css" href="../Estilos/Perfil.css">
    <link rel="stylesheet" type="text/css" href="../Estilos/styles.css">
    <link rel="stylesheet" type="text/css" href="../Estilos/BackGround.css">
    <link rel="stylesheet" type="text/css" href="../Estilos/Perfil.css">
    <link rel="stylesheet" type="text/css" href="../Estilos/Mapa.css">

    <style>
    .button {
        display: inline-block;
        padding: 10px 20px;
        font-size: 16px;
        cursor: pointer;
        text-align: center;
        text-decoration: none;
        color: #fff;
        background-color: #8c54fa;
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
            <h2>Historial de Compra</h2>
            <form action="${pageContext.request.contextPath}/ControladorCliente?action=updateProfile" method="post">
                <% 
                    ClsCliente cliente = (ClsCliente) session.getAttribute("cliente");
                    if (cliente != null) {
                %>
                <input value="<%= cliente.getIdCliente() %>" readonly >
                <a href="../IniciarSesion/Perfil.jsp" class="button">Volver</a>
                <% } %>
            </form>
        </div>
        
      <div class="historial-compras">
    <h3>Listado de Ventas</h3>
    <table border="1">
        <thead>
            <tr>
                <th>ID Venta</th>
                <th>ID Stripe</th>
                <th>ID Producto</th>
                <th>Nombre</th>
                <th>Descripción</th>
                <th>Cantidad</th>
                <th>Precio</th>
            </tr>
        </thead>
        <tbody>
            <% 
                List<ClsVenta> ventas = (List<ClsVenta>) request.getAttribute("listaVentas");
                if (ventas != null) {
                    for (ClsVenta venta : ventas) {
            %>
            <tr>
                <td><%= venta.getIdVenta() %></td>
                <td><%= venta.getIdStripe() %></td>
                <td><%= venta.getIdProducto() %></td>
                <td><%= venta.getNombre() %></td>
                <td><%= venta.getDescripcion() %></td>
                <td><%= venta.getCantidad() %></td>
                <td><%= venta.getPrecio() %></td>
            </tr>
            <% 
                    }
                } else {
            %>
            <tr>
                <td colspan="7">No se encontraron ventas</td>
            </tr>
            <% } %>
        </tbody>
    </table>
</div>
    </div>

    <!-- Contenedor del mapa -->
    <div id="mapa-container">
        <div id="google-map"></div>
    </div>
</body>
</html>
