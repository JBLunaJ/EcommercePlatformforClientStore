<%-- 
    Document   : ActualizarCarrito
    Created on : 23 jun 2024, 19:55:15
    Author     : LENOVO
--%>
<%@ page import="Controlador.ControladorCompras" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
    // Debes obtener el idCliente de la sesión del cliente
    int idCliente = 1; // Ejemplo: Debes obtener este valor de la sesión del cliente

    // Obtener los parámetros de la solicitud
    String idProducto = request.getParameter("idProducto");
    String cantidadParam = request.getParameter("cantidad");

    // Validar la cantidad antes de convertirla a entero
    int cantidad =  1;
    if (cantidadParam != null && !cantidadParam.isEmpty()) {
        cantidad = Integer.parseInt(cantidadParam);
    } else {
        // Manejar el caso en el que la cantidad no se proporciona correctamente
        out.println("Error: La cantidad del producto no es válida");
        return; // Salir temprano para evitar el procesamiento adicional
    }

    // Crear instancia del controlador de compras
    ControladorCompras controladorCompras = new ControladorCompras();

    // Llamar al método en el controlador para actualizar la cantidad del producto
    controladorCompras.actualizarCantidadProducto(request, response);

    // Redirigir a ListarCarrito.jsp después de la actualización
    response.sendRedirect("ListarCarrito.jsp?idCliente=" + idCliente);
%>
