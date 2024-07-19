 /*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controlador;

import Modelo.ClsCliente;
import ModeloDaO.ClienteDaO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author LENOVO
 */
public class ControladorCliente extends HttpServlet {

        private ClienteDaO clienteDAO;

    @Override
    public void init() throws ServletException {
        clienteDAO = new ClienteDaO();
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
       String action = request.getParameter("action");

        if (action == null) {
            action = "";
        }

        switch (action) {
            case "login":
                autenticarCliente(request, response);
                break;
            case "register":
                registrarCliente(request, response);
                break;
            case "updateProfile":
                actualizarCliente(request, response);
                break;
            case "viewProfile":
                verPerfilCliente(request, response);
                break;
            default:
                response.sendRedirect("Index.jsp");
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
        return "Short description";
    }// </editor-fold>

    private void autenticarCliente(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
String email = request.getParameter("email");
    String password = request.getParameter("password");

    ClsCliente cliente = clienteDAO.autenticarCliente(email, password);

    if (cliente != null) {
        request.getSession().setAttribute("cliente", cliente);
        response.sendRedirect(request.getContextPath() + "/Index.jsp");
    } else {
        request.getSession().setAttribute("errorMessage", "Credenciales incorrectas. Intente de nuevo.");
        response.sendRedirect(request.getContextPath() + "/IniciarSesion/Login.jsp");
    }
}

    private void registrarCliente(HttpServletRequest request, HttpServletResponse response) throws IOException {
           String dni = request.getParameter("dni");
    String nombre = request.getParameter("nombre");
    String direccion = request.getParameter("direccion");
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    ClsCliente cliente = new ClsCliente();
    cliente.setDni(dni);
    cliente.setNombre(nombre);
    cliente.setDireccion(direccion);
    cliente.setEmail(email);
    cliente.setPassword(password);

    if (clienteDAO.registrarCliente(cliente)) {
        response.sendRedirect(request.getContextPath() + "/IniciarSesion/Login.jsp?success=1");
    } else {
        response.sendRedirect(request.getContextPath() + "/IniciarSesion/Registrarse.jsp?error=1");
    }
}

    private void verPerfilCliente(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        ClsCliente cliente = (ClsCliente) request.getSession().getAttribute("cliente");

        if (cliente != null) {
            int idCliente = cliente.getIdCliente();
            ClsCliente clienteObtenido = clienteDAO.obtenerDatosClienteAutenticado(idCliente);

            if (clienteObtenido != null) {
                request.setAttribute("cliente", clienteObtenido);
                request.getRequestDispatcher("Perfil.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMessage", "No se pudo obtener el perfil del cliente.");
                request.getRequestDispatcher("Index.jsp").forward(request, response);
            }
        } else {
            response.sendRedirect("Login.jsp");
        }
    }


    private void actualizarCliente(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    ClsCliente cliente = (ClsCliente) request.getSession().getAttribute("cliente");

    if (cliente != null) {
        String dni = request.getParameter("dni");
        String nombre = request.getParameter("nombre");
        String direccion = request.getParameter("direccion");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        cliente.setDni(dni);
        cliente.setNombre(nombre);
        cliente.setDireccion(direccion);
        cliente.setEmail(email);
        cliente.setPassword(password);

        if (clienteDAO.actualizarCliente(cliente)) {
            request.getSession().setAttribute("cliente", cliente);
            response.sendRedirect(request.getContextPath() + "/IniciarSesion/Editar.jsp?successMessage=Perfil actualizado con Exito");
        } else {
            response.sendRedirect(request.getContextPath() + "/IniciarSesion/Editar.jsp?errorMessage=Error al actualizar el perfil. Intente de nuevo.");
        }
    } else {
        response.sendRedirect(request.getContextPath() + "/IniciarSesion/Login.jsp");
    }
}
}