<%-- 
    Document   : Login
    Created on : 22 jun 2024, 03:22:25
    Author     : LENOVO
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Login</title>
    <link href="../Estilos/Login.css" rel="stylesheet" />
    <script src="https://www.google.com/recaptcha/api.js" async defer></script>
</head>
<body>
    <div class="box">
        <div class="container">
            <div class="top-header">
                <span>Login</span>
                <header>Iniciar Sesión</header>
            </div>
            
            <%-- Obtener el mensaje de error de la sesión (si existe) --%>
            <%
                String errorMessage = (String) session.getAttribute("errorMessage");
                session.removeAttribute("errorMessage");
            %>

            <%-- Mostrar mensaje de error si existe --%>
            <% if (errorMessage != null && !errorMessage.isEmpty()) { %>
                <div class="error-message">
                    <%= errorMessage %>
                </div>
            <% } %>

<form action="${pageContext.request.contextPath}/ControladorCliente?action=login" method="post">
    <div class="input-field">
        <input type="text" id="email" name="email" class="input" placeholder="Email" required>
        <i class="bx bx-user"></i>
    </div>
    <div class="input-field">
        <input type="password" id="password" name="password" class="input" placeholder="Contraseña" required>
        <i class="bx bx-lock-alt"></i>
    </div>
    <br>
    <div class="g-recaptcha" data-sitekey="6LdzaQ8oAAAAAFIF3zKdsg8fuitz4cZeT7vI3Pu6"></div>
    <br>
    <div class="input-field">
        <input type="submit" class="submit" value="Inicio">
    </div>
</form>

            <div class="bottom">
                <div class="left">
                    <input type="checkbox" id="check"> <label for="check"> Recordarme</label>
                </div>
                <div class="right">
                    <label><a href="olvidecontrasena.jsp">¿Olvidaste la contraseña?</a></label>
                </div>
            </div>

            <button onclick="location.href='${pageContext.request.contextPath}/IniciarSesion/Registrarse.jsp'" class="register-btn">Registrarse</button>
       
        <%-- Botón para volver al Index.jsp --%>
            <button onclick="location.href='${pageContext.request.contextPath}/Index.jsp'" class="register-btn">Volver al Inicio</button>
            
        </div>
    </div>
</body>
</html>
