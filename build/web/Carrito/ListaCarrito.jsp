<%-- 
    Document   : ListaCarrito
    Created on : 23 jun 2024, 19:54:27
    Author     : LENOVO
--%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="Modelo.ClsProducto" %>
<%@ page import="Modelo.ClsCliente" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <link rel="stylesheet" type="text/css" href="../Estilos/styles.css">
    <link rel="stylesheet" type="text/css" href="../Estilos/header.css">
    <link rel="stylesheet" type="text/css" href="../Estilos/Productos.css">
    <link rel="stylesheet" type="text/css" href="../Estilos/ComboPro.css">
    <link rel="stylesheet" type="text/css" href="../Estilos/BackGround.css">
    <link rel="stylesheet" type="text/css" href="../Estilos/Perfil.css">
    <link rel="stylesheet" type="text/css" href="../Estilos/footer.css">
    <meta charset="UTF-8">
    <title>Lista de Carrito</title>
    <style>
        .table-container, .form-container {
            width: 45%;
        }

        .table-container {
            margin-right: 40px; /* Añadir margen a la derecha del contenedor de la tabla */
            max-height: 400px; /* Ajusta la altura máxima de la tabla */
            overflow-y: auto; /* Agrega una barra de desplazamiento vertical si es necesario */
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        table, th, td {
            border: 1px solid #d1d1d1;
        }

        th, td {
            padding: 4px; /* Ajusta el relleno para reducir la altura de las celdas */
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <header class="header">
        <a href="#default" class="logo">
            <img src="../Images/Logo.jpg" alt="CompanyLogo">
        </a>
        <nav>
            <ul class="menu">
                <div class="header-right">
                    <a class="home" href="../Index.jsp">Inicio</a>
                    <% 
                        if (session.getAttribute("cliente") != null) {
                            ClsCliente cliente = (ClsCliente) session.getAttribute("cliente");
                    %>
                        <a class="home" href="../IniciarSesion/Perfil.jsp">
                            <span>Bienvenido <%= cliente.getNombre() %></span>
                        </a>
                        <a class="home" href="../IniciarSesion/Perfil.jsp">Perfil</a>
                    <% } else { %>
                        <a>
                            <span>Carrito (<span id="carrito-count"><%= session.getAttribute("carritoCount") != null ? session.getAttribute("carritoCount") : 0 %></span>)</span>
                        </a>
                        <a class="home" href="../IniciarSesion/Login.jsp">Iniciar Sesión</a>
                    <% } %>
                </div>
            </ul>
        </nav>
    </header>
    <div class="perfil-container">
        <div class="perfil-info">
            <h1>Carrito de Compras</h1>
            <div class="carrito-container">
                <table>
                    <thead>
                        <tr>
                            <th>Nombre</th>
                            <th>Descripción</th>
                            <th>Cantidad</th>
                            <th>Precio</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            double totalPrecio = 0.0;
                            List<ClsProducto> carrito = (List<ClsProducto>) session.getAttribute("carrito");
                            boolean hayProductos = carrito != null && !carrito.isEmpty();
                            if (hayProductos) {
                                for (ClsProducto producto : carrito) {
                                    totalPrecio += producto.getPrecio();
                        %>
                                    <tr>
                                        <td><%= producto.getNombre() %></td>
                                        <td><%= producto.getDescripcion() %></td>
                                        <td><%= producto.getCantidad() %></td>
                                        <td><%= producto.getPrecio() %> PEN</td>
                                        <td><button onclick="eliminarProducto('<%= producto.getId() %>')">Eliminar</button></td>
                                    </tr>
                        <% 
                                }
                            } else {
                        %>
                                <tr>
                                    <td colspan="5">No hay productos en el carrito</td>
                                </tr>
                        <% 
                            }
                        %>
                    </tbody>
                    <tfoot>
                        <tr>
                            <td colspan="3">Total:</td>
                            <td><%= totalPrecio %> PEN</td>
                            <td>
                                <form action="../Stripe/payment.jsp" method="post">
                                    <input type="hidden" name="amount" value="<%= totalPrecio %>">
                                    <button type="submit" <%= !hayProductos ? "disabled" : "" %>>Pagar</button>
                                </form>
                            </td>
                        </tr>
                    </tfoot>
                </table>
            </div>
        </div>
    </div>

    <script>
        function eliminarProducto(productoId) {
            // Enviar solicitud AJAX para eliminar el producto
            const xhr = new XMLHttpRequest();
            xhr.open("POST", "EliminarProducto.jsp", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    // Recargar la página para actualizar la lista de productos y el contador del carrito
                    location.reload();
                }
            };
            xhr.send("productoId=" + productoId);
        }
</script>
    
 
    <div class="es">
        &copy; repositoriojualunaj.com | Diseñado por JLunaJ
    </div>

    
</body>

</html>