<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Pago Exitoso</title>
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
        .success-message {
            color: #4CAF50;
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
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s ease;
            margin-top: 20px;
        }
        .button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="success-message">¡Pago realizado con éxito!</div>
        <img class="animation" src="https://media.giphy.com/media/xTkcEISFBEnpKyNDDi/giphy.gif" alt="Animated Checkmark">
        <br>
        <a href="../Index.jsp" class="button">Volver a la tienda</a>
    </div>
</body>
</html>
