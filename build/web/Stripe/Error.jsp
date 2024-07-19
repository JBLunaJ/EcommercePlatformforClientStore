<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Pago Fallido</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f0f0f0;
        }
        .container {
            text-align: center;
            background-color: #ffffff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 0px 20px rgba(0, 0, 0, 0.1);
            animation: fadeIn 0.5s ease;
            max-width: 400px;
            width: 90%;
        }
        .error-message {
            color: #f44336;
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 20px;
        }
        .animation {
            width: 100%;
            max-width: 200px;
            margin: 0 auto;
        }
        @keyframes fadeIn {
            0% { opacity: 0; }
            100% { opacity: 1; }
        }
        .button {
            display: inline-block;
            background-color: #f44336;
            color: white;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s ease;
            margin-top: 20px;
        }
        .button:hover {
            background-color: #e53935;
        }
        .button.secondary {
            background-color: #555555;
            margin-left: 10px;
        }
        .button.secondary:hover {
            background-color: #444444;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="error-message">¡Pago fallido!</div>
        <img class="animation" src="https://media.giphy.com/media/3o6Zt6ML6BklcajjsA/giphy.gif" alt="Animated Cross">
        <br>
        <a href="../Index.jsp" class="button secondary">Volver a la tienda</a>
        <a href="../Carrito/ListaCarrito.jsp" class="button">Reintentar</a>
    </div>
</body>
</html>
