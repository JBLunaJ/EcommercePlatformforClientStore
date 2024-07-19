<%-- 
    Document   : Index
    Created on : 20 jun 2024, 11:10:58
    Author     : LENOVO
--%>
<%@ page import="Modelo.ClsProducto" %>
<%@ page import="Modelo.ClsCliente" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="ModeloDaO.ProductoDaO" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Abarrotes Ross</title>
    <link rel="stylesheet" type="text/css" href="../Estilos/styles.css">
    <link rel="stylesheet" type="text/css" href="Estilos/header.css">
    <link rel="stylesheet" type="text/css" href="Estilos/Productos.css">
    <link rel="stylesheet" type="text/css" href="Estilos/ComboPro.css"> <!-- Enlace al estilo ComboPro.css -->
    <link rel="stylesheet" type="text/css" href="Estilos/BackGround.css"> <!-- Enlace al estilo BackGround.css -->
     <link rel="stylesheet" type="text/css" href="Estilos/footer.css">
</head>
<body>
<header class="header">
    <a class="home" href="#default" class="logo">
        <img src="Images/Logo.jpg" alt="CompanyLogo">
    </a>
  
    <nav>
        <ul class="menu">
            <div class="header-right">
                <a class="home" href="Index.jsp">Inicio</a>
    
                <%-- Verificar si el usuario ha iniciado sesión y mostrar botones correspondientes --%>
                <% 
                    ClsCliente cliente = (ClsCliente) session.getAttribute("cliente");
                    if (cliente != null) {
                %>
                    <a class="home"><span>Bienvenido <%= cliente.getNombre() %></span></a>
                    <a href="IniciarSesion/Perfil.jsp" class="home perfil-btn">Perfil</a>
                <% } else { %>
                    <a href="IniciarSesion/Login.jsp" class="home iniciar-sesion-btn">Iniciar Sesión</a>
                <% } %>
                
                <a class="home">
                    <form method="get" action="Index.jsp">
                        <select name="categoria" id="categoria-select" class="styled-select" onchange="this.form.submit()">
                            <option value="C001">Galletas</option>
                            <option value="C002">Frutas</option>
                            <option value="C003">Verduras</option>
                            <option value="C004">Carnes</option>
                            <option value="C005">Arroz</option>
                            <option value="C006">Azúcar</option>
                            <option value="C007">Menestras</option>
                            <option value="C008">Comida para perros</option>
                            <option value="C009">Bebidas</option>
                            <option value="C010">Útiles escolares</option>
                            <option value="C011">Lácteos</option>
                            <option value="C012">Higiene personal</option>
                            <option value="C013">Cuidado del hogar</option>
                            <option value="C014">Snacks</option>
                        </select>
                    </form>
                </a>
              
                <a class="home" href="Carrito/ListaCarrito.jsp">Carrito (<span id="carrito-count"><%= session.getAttribute("carritoCount") != null ? session.getAttribute("carritoCount") : 0 %></span>)</a>
            </div>
        </ul>
    </nav>
</header>

<h7>Bienvenidos a Abarrotes Ross</h7>
<div id="productos-container">
    <%-- Lógica para mostrar productos --%>
    <% 
        String categoriaSeleccionada = request.getParameter("categoria");
        ProductoDaO productoDao = new ProductoDaO();
        List<ClsProducto> productos = new ArrayList<>();
        
        if (categoriaSeleccionada != null && !categoriaSeleccionada.equals("todos")) {
            productos = productoDao.listarProductosPorCategoria(categoriaSeleccionada);
        } else {
            productos = productoDao.listarProductos();
        }

        for (ClsProducto producto : productos) {
    %>
        <div class="producto">
            <h2><%= producto.getNombre() %></h2>
            <img src="<%= producto.getFoto() %>" alt="Imagen del Producto">
            <p><%= producto.getDescripcion() %></p>
            <p class="precio">Precio: <%= producto.getPrecio() %></p>
            
            <form action="Carrito/AgregarCarrito.jsp" method="get">
                <input type="hidden" name="productoId" value="<%= producto.getId() %>">
                <input type="hidden" name="precio" value="<%= producto.getPrecio() %>">
                <input type="number" name="cantidad" value="1" min="1">
                <button type="submit" class="agregar-carrito-btn" <% if (cliente == null) { %> onclick="mostrarMensajeIniciarSesion(); return false;" <% } %>>Agregar al Carrito</button>
            </form>

           <form action="Carrito/AgregarYComprar.jsp" method="post">
                <input type="hidden" name="productoId" value="<%= producto.getId() %>">
                <input type="hidden" name="precio" value="<%= producto.getPrecio() %>">
                <input type="number" name="cantidad" value="1" min="1">
                <button type="submit" class="comprar-btn" <% if (cliente == null) { %> onclick="mostrarMensajeIniciarSesion(); return false;" <% } %>>Comprar</button>
            </form>
        </div>
    <% } %>
</div>

<script>
    function mostrarMensajeIniciarSesion() {
        alert("Por favor, inicia sesión para agregar productos al carrito o realizar compras.");
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
