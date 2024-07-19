<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Pagar con Stripe</title>
    <script src="https://js.stripe.com/v3/"></script>
    <link rel="stylesheet" type="text/css" href="css/frontStripe.css">
</head>
<body>
    <form class="payment-form" id="payment-form" action="charge" method="post">
        <h2 style="text-align: center;">Detalles de Pago</h2>
        
        <div class="form-group">
            <label for="cardNumber" class="form-label">Número de Tarjeta</label>
            <input type="text" id="cardNumber" name="cardNumber" class="form-input" placeholder="**** **** **** ****" maxlength="19" required>
        </div>
        
        <div class="form-group">
            <label for="cardName" class="form-label">Nombre del Propietario</label>
            <input type="text" id="cardName" name="cardName" class="form-input" placeholder="Nombre Apellido" required>
        </div>
        
        <div class="form-group">
            <label for="expiryDate" class="form-label">Fecha de Expiración</label>
            <input type="text" id="expiryDate" name="expiryDate" class="form-input" placeholder="MM/YY" maxlength="5" required>
        </div>
        
        <div class="form-group">
            <label for="cvv" class="form-label">CVV</label>
            <input type="text" id="cvv" name="cvv" class="form-input" placeholder="123" maxlength="4" required>
        </div>
        
        <div class="form-group">
            <label for="email" class="form-label">Correo Electrónico</label>
            <input type="email" id="email" name="email" class="form-input" placeholder="usuario@ejemplo.com" required>
        </div>
        
        <div class="form-group">
            <label for="country" class="form-label">País</label>
            <select id="country" name="country" class="form-input" required>
                <option value="">Selecciona tu país</option>
                <option value="US">Estados Unidos</option>
                <option value="CA">Canadá</option>
                <option value="MX">México</option>
                <option value="PE">Perú</option>
                <!-- Agrega más opciones según sea necesario -->
            </select>
        </div>
        
        <div class="form-group">
            <label for="region" class="form-label">Región / Estado</label>
            <input type="text" id="region" name="region" class="form-input" placeholder="Región o Estado" required>
        </div>
        
        <div class="form-group form-checkbox">
            <input type="checkbox" id="saveCard" name="saveCard">
            <label for="saveCard">Guardar esta tarjeta para futuras compras</label>
        </div>

      
        
        <button type="submit" class="form-submit-button">Pagar</button>
    </form>

    <script src="frontStripe.js"></script>
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
            if (validateForm()) {
                stripe.createToken(card).then(function(result) {
                    if (result.error) {
                        var errorElement = document.getElementById('card-errors');
                        errorElement.textContent = result.error.message;
                    } else {
                        stripeTokenHandler(result.token);
                    }
                });
            }
        });

        function stripeTokenHandler(token) {
            var form = document.getElementById('payment-form');
            var hiddenInput = document.createElement('input');
            hiddenInput.setAttribute('type', 'hidden');
            hiddenInput.setAttribute('name', 'stripeToken');
            hiddenInput.setAttribute('value', token.id);
            form.appendChild(hiddenInput);
            form.submit();
        }

        function validateForm() {
            var cardNumber = document.getElementById('cardNumber').value.replace(/\s/g, ''); // Eliminar espacios en blanco
            var cardName = document.getElementById('cardName').value;
            var expiryDate = document.getElementById('expiryDate').value;
            var cvv = document.getElementById('cvv').value;

            var cardNumberRegex = /^\d{16}$/;
            var expiryDateRegex = /^(0[1-9]|1[0-2])\/\d{2}$/;
            var cvvRegex = /^\d{3,4}$/;

            if (!cardNumberRegex.test(cardNumber)) {
                alert("El número de tarjeta debe contener exactamente 16 dígitos numéricos.");
                return false;
            }

            if (!expiryDateRegex.test(expiryDate)) {
                alert("La fecha de expiración debe tener el formato MM/YY.");
                return false;
            }

            if (!cvvRegex.test(cvv)) {
                alert("El CVV debe contener 3 o 4 dígitos numéricos.");
                return false;
            }

            return true;
        }
    </script>
</body>
</html>
