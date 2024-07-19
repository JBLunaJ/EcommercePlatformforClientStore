/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controlador;

import Modelo.ClsCarrito;
import ModeloDaO.ComprasDaO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author LENOVO
 */
public class ControladorCompras extends HttpServlet {
   private ComprasDaO comprasDaO;

    // Constructor del controlador que inicializa ComprasDaO
    public ControladorCompras() {
        this.comprasDaO = new ComprasDaO();
    }
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       // Obtener la acción desde los parámetros de la solicitud
        String action = request.getParameter("action");

        if (action == null) {
            action = "";
        }

        // Llamar al método correspondiente según la acción
        switch (action) {
            case "listarCarrito":
                listarCarrito(request, response);
                break;
            case "agregarProducto":
                agregarProductoAlCarrito(request, response);
                break;
            case "eliminarProducto":
                eliminarProductoDelCarrito(request, response);
                break;
            case "actualizarCantidad":
                actualizarCantidadProducto(request, response);
                break;
            default:
                response.sendRedirect("index.jsp");
                break;
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Controlador para gestionar el carrito de compras";
    }// </editor-fold>

    private void listarCarrito(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idCliente = Integer.parseInt(request.getParameter("idCliente"));
        List<ClsCarrito> carrito = comprasDaO.obtenerCarrito(idCliente);
        request.setAttribute("carrito", carrito);
        request.getRequestDispatcher("carrito.jsp").forward(request, response);
    }


    private void agregarProductoAlCarrito(HttpServletRequest request, HttpServletResponse response) throws IOException {
         int idCliente = Integer.parseInt(request.getParameter("idCliente"));
        String idProducto = request.getParameter("idProducto");
        int cantidad = Integer.parseInt(request.getParameter("cantidad"));

        boolean resultado = comprasDaO.agregarProductoAlCarrito(idCliente, idProducto, cantidad);
        if (resultado) {
            response.sendRedirect("ControladorCompras?action=listarCarrito&idCliente=" + idCliente);
        } else {
            response.sendRedirect("error.jsp");
        }
    }


    private void eliminarProductoDelCarrito(HttpServletRequest request, HttpServletResponse response) throws IOException {
         int idCliente = Integer.parseInt(request.getParameter("idCliente"));
        String idProducto = request.getParameter("idProducto");

        boolean resultado = comprasDaO.eliminarProductoDelCarrito(idCliente, idProducto);
        if (resultado) {
            response.sendRedirect("ControladorCompras?action=listarCarrito&idCliente=" + idCliente);
        } else {
            response.sendRedirect("error.jsp");
        }
    }

    public void actualizarCantidadProducto(HttpServletRequest request, HttpServletResponse response) throws IOException {
         int idCliente = Integer.parseInt(request.getParameter("idCliente"));
    String idProducto = request.getParameter("idProducto");
    int cantidad = Integer.parseInt(request.getParameter("cantidad"));

    // Llamar al DAO para actualizar la cantidad del producto
    comprasDaO.actualizarCantidadProducto(idCliente, idProducto, cantidad);

    // Redirigir a ListarCarrito.jsp después de la actualización
    response.sendRedirect("ControladorCompras?action=listarCarrito&idCliente=" + idCliente);
    }
}
