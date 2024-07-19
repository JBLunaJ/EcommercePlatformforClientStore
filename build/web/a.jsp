<%-- 
    Document   : a
    Created on : 4 jun. 2024, 00:49:45
    Author     : luna3
--%>
<%@ page import="com.stripe.Stripe" %>
<%@ page import="com.stripe.exception.StripeException" %>
<%@ page import="com.stripe.model.PaymentIntent" %>
<%@ page import="com.stripe.param.PaymentIntentCreateParams" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pago con Stripe</title>
    <script src="https://js.stripe.com/v3/"></script>
</head>
<body>
<%
    String clientSecret = null;
    try {
        Stripe.apiKey = "sk_test_51PJgO4L2xJcfsvy2zEjrvHq82kEAFjTTmW00JwjYjVzdmn7mhLDdyXiAmXYNakltohv0lUtfm1h8KK6Ghv6eWthP003bwwoJPY"; // Reemplaza con tu clave secreta de Stripe

        int amount = 1000; // Monto en centavos
        Map<String, Object> params = new HashMap<>();
        params.put("amount", amount);
        params.put("currency", "usd");

        PaymentIntent intent = PaymentIntent.create(params);

        // Guardar el ID del PaymentIntent en una variable oculta
        clientSecret = intent.getClientSecret();
    } catch (StripeException e) {
        e.printStackTrace();
    }
%>

<form id="payment-form" method="post">
    <div id="card-element"></div>
    <button type="submit" id="submit">Pagar</button>
</form>
<div id="payment-message" style="display: none;"></div>

<script>
    const stripe = Stripe('pk_test_51PJgO4L2xJcfsvy2ZK9D1jjHCZ2svnKcJcfVdtQod2HmLSsMwJgjIhM7IrblfB8yLGibb3Dw9pfTB1Bv3eOtwSyA003sJf0MLH'); // Reemplaza con tu clave pública de Stripe
    const elements = stripe.elements();
    const cardElement = elements.create('card');
    cardElement.mount('#card-element');

    const form = document.getElementById('payment-form');
    form.addEventListener('submit', async (event) => {
        event.preventDefault();

        const { error, paymentIntent } = await stripe.confirmCardPayment('<%= clientSecret %>', {
            payment_method: {
                card: cardElement
            }
        });

        if (error) {
            document.getElementById('payment-message').innerText = error.message;
            document.getElementById('payment-message').style.display = 'block';
        } else {
            document.getElementById('payment-message').innerText = 'Pago exitoso!';
            document.getElementById('payment-message').style.display = 'block';
        }
    });
</script>
</body>
</html>
