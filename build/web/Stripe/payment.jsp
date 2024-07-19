<%@page import="java.util.List"%>
<%@ page import="Modelo.ClsProducto" %>
<%@ page import="Modelo.ClsCliente" %>
<!DOCTYPE html>
<html>
<head>
    <title>Pagar con Stripe</title>
    <script src="https://js.stripe.com/v3/"></script>
    <link rel="stylesheet" type="text/css" href="../css/payment.css">
   
</head>
<body>
     <header class="header">
        <a href="#default" class="logo">
            <img src="../Images/Logo.jpg" alt="CompanyLogo">
        </a>
        <nav>
            <ul class="menu">
                <div class="header-right">
                  
                    <% 
                        if (session.getAttribute("cliente") != null) {
                            ClsCliente cliente = (ClsCliente) session.getAttribute("cliente");
                    %>
                        <a class="home" >
                            <h1><span>Cliente <%= cliente.getNombre() %></span></h1>
                           
            
                            
                        </a>
                       
                    <% } else { %>
                        
                        <a class="home" href="../IniciarSesion/Login.jsp">Iniciar Sesión</a>
                    <% } %>
                </div>
            </ul>
        </nav>
    </header>
    <button2 onclick="window.location.href='../Carrito/ListaCarrito.jsp';">Volver al Carrito</button2>
    
    <div class="container">
        <table>
            <thead>
                <tr>
                    <th>Nombre</th>
                    <th>Descripción</th>
                    <th>Cantidad</th>
                    <th>Precio</th>
                      
                </tr>
            </thead>
            <tbody>
                <% 
                    double totalPrecio = 0.0;
                    List<ClsProducto> carrito = (List<ClsProducto>) session.getAttribute("carrito");
                    if (carrito != null && !carrito.isEmpty()) {
                        for (ClsProducto producto : carrito) {
                            totalPrecio += producto.getPrecio();
                %>
                            <tr>
                                <td><%= producto.getNombre() %></td>
                                <td><%= producto.getDescripcion() %></td>
                                <td><%= producto.getCantidad() %></td>
                                <td><%= producto.getPrecio() %> PEN</td>
                            </tr>
                <% 
                        }
                    } else {
                %>
                        <tr>
                            <td colspan="4">No hay productos en el carrito</td>
                        </tr>
                <% 
                    }
                %>
            </tbody>
            <tfoot>
                <tr>
                    <td colspan="3" style="text-align: right;">Total:</td>
                    <td><%= totalPrecio %> PEN</td>
                    
                </tr>
            </tfoot>
        </table>

        <form id="payment-form" action="../charge" method="post">
            <h2>Pagar con Stripe</h2>
            <% 
                        if (session.getAttribute("cliente") != null) {
                            ClsCliente cliente = (ClsCliente) session.getAttribute("cliente");
                    %>
            <label for="idcliente">ID Cliente:</label>
            <input type="idcliente" id="idcliente" name="idcliente"  value="<%= cliente.getIdCliente() %>" readonly >
            <% } else { %>
             <% } %>
            <label for="email">Correo Electrónico:</label>
            <input type="email" id="email" name="email" placeholder="Correo Electrónico" required>

            <label for="country">País o Región:</label>
            <input type="text" id="country" name="country" placeholder="País o Región" required>

            <label for="amount">Monto:</label>
            <input type="text" id="amount" name="amount" placeholder="Monto en Soles" value="<%= totalPrecio %> " readonly >
            

            <label for="cardholder-name">Nombre del Titular de la Tarjeta:</label>
            <input type="text" id="cardholder-name" name="cardholder-name" placeholder="Nombre del Titular de la Tarjeta" required>

            <label for="card-element">Información de la Tarjeta:</label>
            <div id="card-element"></div>
            <div id="card-errors" role="alert"></div>

            <button type="submit">Pagar</button>
        </form>

      
    </div>

    <script>
        var stripe = Stripe('pk_test_51PJgO4L2xJcfsvy2ZK9D1jjHCZ2svnKcJcfVdtQod2HmLSsMwJgjIhM7IrblfB8yLGibb3Dw9pfTB1Bv3eOtwSyA003sJf0MLH');
        var elements = stripe.elements();
        var card = elements.create('card');
        card.mount('#card-element');

        card.addEventListener('change', function(event) {
            var displayError = document.getElementById('card-errors');
            if (event.error) {
                displayError.textContent = event.error.message;
            } else {
                displayError.textContent = '';
            }
        });

        var form = document.getElementById('payment-form');
        form.addEventListener('submit', function(event) {
            event.preventDefault();
            stripe.createToken(card).then(function(result) {
                if (result.error) {
                    var errorElement = document.getElementById('card-errors');
                    errorElement.textContent = result.error.message;
                } else {
                    stripeTokenHandler(result.token);
                }
            });
        });

        function stripeTokenHandler(token) {
            var form = document.getElementById('payment-form');

            var hiddenInputToken = document.createElement('input');
            hiddenInputToken.setAttribute('type', 'hidden');
            hiddenInputToken.setAttribute('name', 'stripeToken');
            hiddenInputToken.setAttribute('value', token.id);
            form.appendChild(hiddenInputToken);

            form.submit();
        }
    </script>
</body>
</html>
