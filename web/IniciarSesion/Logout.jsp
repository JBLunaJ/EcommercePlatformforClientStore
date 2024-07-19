<%-- 
    Document   : Logout
    Created on : 22 jun 2024, 04:21:52
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.io.IOException"%>
<%
    // Supongamos que tienes una conexión llamada "con"
    Connection con = (Connection) session.getAttribute("connection");

    // Invalida la sesión si existe
    if (session != null) {
        session.invalidate();
    }

    // Cierra la conexión si existe
    if (con != null) {
        try {
            con.close();
        } catch (SQLException e) {
            out.println("Error al cerrar la conexión: " + e.getMessage());
        }
    }

    // Redirige al usuario a la página de inicio de sesión
    try {
        response.sendRedirect("Login.jsp");
    } catch (IOException e) {
        out.println("Error al redirigir: " + e.getMessage());
    }
%>

