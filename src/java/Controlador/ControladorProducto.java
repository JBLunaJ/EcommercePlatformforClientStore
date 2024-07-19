/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controlador;

import Modelo.ClsProducto;
import ModeloDaO.ProductoDaO;
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
public class ControladorProducto extends HttpServlet {
    private ProductoDaO productoDaO;

    public ControladorProducto() {
        this.productoDaO = new ProductoDaO();
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
        response.setContentType("text/html;charset=UTF-8");

          String action = request.getParameter("action");
        if (action == null) {
            action = "listar"; // Acción por defecto
        }

        switch (action) {
            case "listar":
                listarProductos(request, response);
                break;
            case "obtener":
                obtenerProducto(request, response);
                break;
            case "listarPorCategoria":
                listarProductosPorCategoria(request, response);
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

    public void listarProductos(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<ClsProducto> productos = productoDaO.listarProductos();
    request.setAttribute("productos", productos);
    request.getRequestDispatcher("Index.jsp").forward(request, response);
}
    
 


    private void obtenerProducto(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       String id = request.getParameter("id");
        ClsProducto producto = productoDaO.obtenerProductoPorId(id);
        request.setAttribute("producto", producto);
        request.getRequestDispatcher("producto.jsp").forward(request, response);
    }
    
    private void listarProductosPorCategoria(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String categoriaId = request.getParameter("categoria");
        List<ClsProducto> productos = productoDaO.listarProductosPorCategoria(categoriaId);
        request.setAttribute("productos", productos);
        request.getRequestDispatcher("Index.jsp").forward(request, response);
    }
}