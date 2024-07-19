package Controlador;

import Modelo.ClsCliente;
import Modelo.ClsVenta;
import ModeloDaO.VentaDao;
import Interface.InterfaceVenta;

import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Historial")
public class ControladorVenta extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private InterfaceVenta ventaDAO;

    public ControladorVenta() {
        this.ventaDAO = new VentaDao();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener el cliente de la sesión
        ClsCliente cliente = (ClsCliente) request.getSession().getAttribute("cliente");
        if (cliente != null) {
            // Obtener ventas por ID de cliente
            List<ClsVenta> listaVentas = ventaDAO.obtenerVentasPorCliente(cliente.getIdCliente());
            request.setAttribute("listaVentas", listaVentas);
        }

        // Redirigir a la página JSP
        RequestDispatcher dispatcher = request.getRequestDispatcher("/Stripe/Historial.jsp");
        dispatcher.forward(request, response);
    }
}
