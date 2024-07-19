/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ModeloDaO;
import Modelo.ClsProducto;
import Config.Conexion;
import java.sql.*;
import java.util.List;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.sql.DriverManager;

/**
 *
 * @author LENOVO
 */
public class ProductoDaO implements Interface.InterfaceProducto {
    private Conexion cn = new Conexion();
    private Connection con;

    public ProductoDaO() {
        this.con = cn.getConnection();
    }
    @Override
    public ClsProducto obtenerProductoPorId(String id) {
         ClsProducto producto = null;
        String query = "SELECT * FROM producto WHERE id = ?";
        try {
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, id);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                producto = new ClsProducto();
                producto.setId(rs.getString("id"));
                producto.setNombre(rs.getString("nombre"));
                producto.setDescripcion(rs.getString("descripcion"));
                producto.setCantidad(rs.getDouble("cantidad"));
                producto.setPrecioU(rs.getDouble("precio_u"));
                producto.setFoto(rs.getString("foto"));
            }
            rs.close();
            pst.close();
        } catch (SQLException e) {
            System.out.println("Error al obtener el producto: " + e.getMessage());
            e.printStackTrace();
        }
        return producto;
    }


    @Override
    public List<ClsProducto> listarProductos() {
   List<ClsProducto> productos = new ArrayList<>();
        String query = "SELECT * FROM producto";

        try {
            PreparedStatement pst = con.prepareStatement(query);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                ClsProducto producto = new ClsProducto();
                producto.setId(rs.getString("id"));
                producto.setNombre(rs.getString("nombre"));
                producto.setDescripcion(rs.getString("descripcion"));
                producto.setPrecio(rs.getDouble("precio"));
                producto.setFoto(rs.getString("foto"));

                productos.add(producto);
            }

            rs.close();
            pst.close();
        } catch (SQLException e) {
            System.out.println("Error al listar los productos: " + e.getMessage());
            e.printStackTrace();
        }

        return productos;
    }

    @Override
    public List<ClsProducto> listarProductosPorCategoria(String categoriaId) {
        List<ClsProducto> productos = new ArrayList<>();
        String sql = "SELECT * FROM producto WHERE categoria = ?";

        try {
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, categoriaId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                ClsProducto producto = new ClsProducto();
                producto.setId(rs.getString("id"));
                producto.setCategoria(rs.getString("categoria"));
                producto.setNombre(rs.getString("nombre"));
                producto.setCantidad(rs.getDouble("cantidad"));
                producto.setUnidadMedida(rs.getString("unidad_medida"));
                producto.setPrecioU(rs.getDouble("precio_u"));
                producto.setFechaC(rs.getTimestamp("fecha_c").toLocalDateTime());
                producto.setFechaV(rs.getTimestamp("fecha_v").toLocalDateTime());
                producto.setPeso(rs.getString("peso"));
                producto.setFoto(rs.getString("foto"));
                producto.setDescripcion(rs.getString("Descripcion"));
                producto.setStock(rs.getInt("Stock"));
                producto.setPrecio(rs.getDouble("Precio"));

                productos.add(producto);
            }

            stmt.close();
            rs.close();
        } catch (SQLException e) {
            System.out.println("Error al listar los productos por categoría: " + e.getMessage());
            e.printStackTrace();
        }

        return productos;
    }

}