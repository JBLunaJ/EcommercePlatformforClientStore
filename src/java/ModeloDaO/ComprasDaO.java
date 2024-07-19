/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ModeloDaO;

import Config.Conexion;
import Interface.InterfaceCompras;
import Modelo.ClsCarrito;
import Modelo.ClsProducto;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author LENOVO
 */
public class ComprasDaO implements Interface.InterfaceCompras {
    private Connection con;

    public ComprasDaO() {
        Conexion conexion = new Conexion();
        this.con = conexion.getConnection();
    }

    
    @Override
    public List<ClsCarrito> obtenerCarrito(int idCliente) {
     List<ClsCarrito> carrito = new ArrayList<>();
        try {
            String sql = "SELECT c.idProducto, p.nombre, p.descripcion, p.precio, c.cantidad " +
                         "FROM Carrito c JOIN Producto p ON c.idProducto = p.id " +
                         "WHERE c.idCliente = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, idCliente);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ClsProducto producto = new ClsProducto();
                producto.setId(rs.getString("idProducto"));
                producto.setNombre(rs.getString("nombre"));
                producto.setDescripcion(rs.getString("descripcion"));
                producto.setPrecio(rs.getDouble("precio"));

                ClsCarrito item = new ClsCarrito(producto, rs.getInt("cantidad"), (int) rs.getDouble("precio"));
                carrito.add(item);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return carrito;
    }
    
    @Override
    public boolean agregarProductoAlCarrito(int idCliente, String idProducto, int cantidad) {
       try {
            String sql = "INSERT INTO Carrito (idCliente, idProducto, cantidad) VALUES (?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, idCliente);
            ps.setString(2, idProducto);
            ps.setInt(3, cantidad);
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean eliminarProductoDelCarrito(int idCliente, String idProducto) {
          try {
            String sql = "DELETE FROM Carrito WHERE idCliente = ? AND idProducto = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, idCliente);
            ps.setString(2, idProducto);
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }


    @Override
    public boolean actualizarCantidadProducto(int idCliente, String idProducto, int cantidad) {
        try {
            String sql = "UPDATE Carrito SET cantidad = ? WHERE idCliente = ? AND idProducto = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, cantidad);
            ps.setInt(2, idCliente);
            ps.setString(3, idProducto);
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        }
}
