<%-- 
    Document   : EliminarProducto
    Created on : 23 jun 2024, 19:54:50
    Author     : LENOVO
--%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="Modelo.ClsProducto" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="Modelo.ClsProducto" %>
<%
    // Obtener el ID del producto a eliminar
    String productoId = request.getParameter("productoId");

    // Obtener el carrito de la sesión
    List<ClsProducto> carrito = (List<ClsProducto>) session.getAttribute("carrito");

    // Verificar si el carrito no es nulo y contiene productos
    if (carrito != null && !carrito.isEmpty()) {
        Iterator<ClsProducto> iterator = carrito.iterator();
        while (iterator.hasNext()) {
            ClsProducto producto = iterator.next();
            if (producto.getId().equals(productoId)) {
                iterator.remove();
                break;
            }
        }
        // Actualizar el carrito y el contador en la sesión
        session.setAttribute("carrito", carrito);
        session.setAttribute("carritoCount", carrito.size());
    }

    // Redirigir de vuelta a la página del carrito
    response.sendRedirect("ListaCarrito.jsp");
%>
