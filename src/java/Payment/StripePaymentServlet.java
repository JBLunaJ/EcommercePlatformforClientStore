package Payment;

import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.Charge;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import java.util.List;
import Config.Conexion;
import Modelo.ClsProducto;

@WebServlet("/charge")
public class StripePaymentServlet extends HttpServlet {
    private Connection con;

    @Override
    public void init() throws ServletException {
        Stripe.apiKey = "sk_test_51PJgO4L2xJcfsvy2zEjrvHq82kEAFjTTmW00JwjYjVzdmn7mhLDdyXiAmXYNakltohv0lUtfm1h8KK6Ghv6eWthP003bwwoJPY";
        Conexion conexion = new Conexion();
        this.con = conexion.getConnection();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String token = request.getParameter("stripeToken");
        String idcliente = request.getParameter("idcliente");
        String amountStr = request.getParameter("amount");
        String email = request.getParameter("email");
        String country = request.getParameter("country");
        double totalPrecio = 0.0;
        int amount;

        try {
            amount = (int) (Double.parseDouble(amountStr) * 100);
        } catch (NumberFormatException e) {
            response.getWriter().write("Monto inválido.");
            return;
        }

        Map<String, Object> params = new HashMap<>();
        params.put("amount", amount);
        params.put("currency", "pen");
        params.put("description", "Pago de ejemplo");
        params.put("source", token);

        try {
            // Crear un nuevo Charge usando el token actual
            Charge charge = Charge.create(params);
            response.getWriter().write("Pago realizado con éxito: " + charge.getId());

            // Insertar los datos de pago en la tabla `stripe`
            String sqlStripe = "INSERT INTO stripe (id, idcliente, Monto, Correo, pais, proceso, fecha_venta) VALUES (?, ?, ?, ?, ?, ?, NOW())";
            try (PreparedStatement psStripe = con.prepareStatement(sqlStripe)) {
                psStripe.setString(1, charge.getId());
                psStripe.setString(2, idcliente);
                psStripe.setString(3, amountStr);
                psStripe.setString(4, email);
                psStripe.setString(5, country);
                psStripe.setString(6, "exitoso");
                psStripe.executeUpdate();
            }

            // Insertar los datos de los productos vendidos en la tabla `Ventas`
            List<ClsProducto> carrito = (List<ClsProducto>) request.getSession().getAttribute("carrito");
            if (carrito != null && !carrito.isEmpty()) {
                String sqlVenta = "INSERT INTO ventas (idStripe, idCliente, idProducto, nombre, descripcion, cantidad, precio) VALUES (?, ?, ?, ?, ?, ?, ?)";
                String sqlUpdateProducto = "UPDATE Producto SET cantidad = cantidad - ? WHERE id = ?";
                String sqlSelectCantidad = "SELECT cantidad FROM Producto WHERE id = ?";
                try (PreparedStatement psVenta = con.prepareStatement(sqlVenta);
                     PreparedStatement psUpdateProducto = con.prepareStatement(sqlUpdateProducto);
                     PreparedStatement psSelectCantidad = con.prepareStatement(sqlSelectCantidad)) {

                    for (ClsProducto producto : carrito) {
                        // Verificar la cantidad disponible
                        psSelectCantidad.setString(1, producto.getId());
                        ResultSet rs = psSelectCantidad.executeQuery();
                        if (rs.next()) {
                            int cantidadDisponible = rs.getInt("cantidad");
                            if (cantidadDisponible >= producto.getCantidad()) {
                                // Insertar en la tabla Ventas
                                psVenta.setString(1, charge.getId());
                                psVenta.setInt(2, Integer.parseInt(idcliente));
                                psVenta.setString(3, producto.getId());
                                psVenta.setString(4, producto.getNombre());
                                psVenta.setString(5, producto.getDescripcion());
                                psVenta.setInt(6, (int) producto.getCantidad()); // Convertir de double a int
                                psVenta.setDouble(7, producto.getPrecio());
                                psVenta.executeUpdate();

                                // Actualizar la cantidad en la tabla Producto
                                psUpdateProducto.setInt(1, (int) producto.getCantidad());
                                psUpdateProducto.setString(2, producto.getId());
                                psUpdateProducto.executeUpdate();
                            } else {
                                response.getWriter().write("Error: La cantidad de " + producto.getNombre() + " excede la cantidad disponible. Quedan " + cantidadDisponible + " unidades.");
                                return;
                            }
                        }
                    }
                }
            }

            request.getSession().removeAttribute("carrito");
            request.getSession().setAttribute("carritoCount", 0);
            
            response.sendRedirect("Stripe/Exito.jsp");
        } catch (StripeException | SQLException e) {
            response.getWriter().write("Error al realizar el pago: " + e.getMessage());
            response.sendRedirect("Stripe/Error.jsp");
        }
    }
}
