<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Modelo.ClsProducto" %>
<%@ page import="ModeloDaO.ProductoDaO" %>

<%
    // Obtener los par�metros desde la solicitud
    String productoId = request.getParameter("productoId");
    String cantidadParam = request.getParameter("cantidad");
    String precioParam = request.getParameter("precio");

    // Verificar que los par�metros no sean nulos o vac�os
    if (productoId == null || productoId.isEmpty() ||
        cantidadParam == null || cantidadParam.isEmpty() ||
        precioParam == null || precioParam.isEmpty()) {
        out.println("<script>alert('Datos inv�lidos. Por favor, int�ntelo de nuevo.');window.location.href='" + request.getContextPath() + "/Index.jsp';</script>");
        return;
    }

    try {
        // Convertir los par�metros a los tipos adecuados
        int cantidadSolicitada = Integer.parseInt(cantidadParam);
        double precio = Double.parseDouble(precioParam);
        
        double precioTotal = cantidadSolicitada * precio;

        // Obtener el producto usando el ID
        ProductoDaO productoDao = new ProductoDaO();
        ClsProducto producto = productoDao.obtenerProductoPorId(productoId);

        // Verificar si se pudo obtener el producto
        if (producto != null) {
            int cantidadDisponible = (int) producto.getCantidad();

            if (cantidadSolicitada <= cantidadDisponible) {
                // Obtener el carrito desde la sesi�n
                List<ClsProducto> carrito = (List<ClsProducto>) session.getAttribute("carrito");

                // Verificar si el carrito existe en la sesi�n, si no, crear uno nuevo
                if (carrito == null) {
                    carrito = new ArrayList<>();
                }

                // Establecer la cantidad y el precio total del producto en el carrito
                producto.setCantidad(cantidadSolicitada);
                producto.setPrecio(precioTotal);

                // Agregar el producto al carrito
                carrito.add(producto);

                // Actualizar la sesi�n con el nuevo carrito y el recuento de productos en el carrito
                session.setAttribute("carrito", carrito);
                session.setAttribute("carritoCount", carrito.size());

                // Redirigir a la p�gina de pago o lista de carrito
                response.sendRedirect(request.getContextPath() + "/Carrito/ListaCarrito.jsp");
            } else {
                // Mostrar mensaje de cantidad insuficiente
                out.println("<script>alert('Cantidad insuficiente. Solo quedan " + cantidadDisponible + " unidades disponibles.');window.location.href='" + request.getContextPath() + "/Index.jsp';</script>");
            }
        } else {
            // Mostrar mensaje de producto no encontrado
            out.println("<script>alert('Producto no encontrado.');window.location.href='" + request.getContextPath() + "/Index.jsp';</script>");
        }
    } catch (NumberFormatException e) {
        // Manejar el caso en que los par�metros no sean n�meros v�lidos
        out.println("<script>alert('Datos inv�lidos. Por favor, int�ntelo de nuevo.');window.location.href='" + request.getContextPath() + "/Index.jsp';</script>");
    }
%>
