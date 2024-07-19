<%-- 
    Document   : Compra
    Created on : 23 jun 2024, 19:54:57
    Author     : LENOVO
--%>
<%@page import="java.util.ArrayList"%>
<%@ page import="java.util.List" %>
<%@ page import="Modelo.ClsProducto" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Controlador.ControladorProducto" %>
<%
    // Obtener el ID del producto desde la solicitud
    String productoId = request.getParameter("productoId");
    int cantidad = Integer.parseInt(request.getParameter("cantidad"));
    double precio = Double.parseDouble(request.getParameter("precio"));

    // Obtener la sesión

    // Obtener el carrito desde la sesión, si no existe, crear uno nuevo
    List<ClsProducto> carrito = (List<ClsProducto>) session.getAttribute("carrito");
    if (carrito == null) {
        carrito = new ArrayList<>();
        session.setAttribute("carrito", carrito);
    }

    // Crear instancia del controlador de productos
    ControladorProducto controladorProducto = new ControladorProducto();

    // Llamar al método público listarProductos del controlador
    controladorProducto.listarProductos(request, response);
    
    // Recuperar la lista de productos del request
    List<ClsProducto> productos = (List<ClsProducto>) request.getAttribute("productos");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Compra de Productos</title>
</head>
<body>
    <h1>Productos Disponibles</h1>
    <table border="1">
        <thead>
            <tr>
                <th>ID</th>
                <th>Nombre</th>
                <th>Precio</th>
                <th>Acción</th>
            </tr>
        </thead>
        <tbody>
            <% for (ClsProducto producto : productos) { %>
                <tr>
                    <td><%= producto.getId() %></td>
                    <td><%= producto.getNombre() %></td>
                    <td><%= producto.getPrecio() %></td>
                    <td>
                        <form action="AñadirAlCarrito.jsp" method="post">
                            <input type="hidden" name="productoId" value="<%= producto.getId() %>">
                            <input type="number" name="cantidad" value="1">
                            <input type="submit" value="Añadir al Carrito">
                        </form>
                    </td>
                </tr>
            <% } %>
        </tbody>
    </table>
</body>
</html>
