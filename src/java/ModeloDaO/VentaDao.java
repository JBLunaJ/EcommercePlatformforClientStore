package ModeloDaO;

import Modelo.ClsVenta;
import Config.Conexion;
import Interface.InterfaceVenta;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class VentaDao implements InterfaceVenta {
    private Conexion cn = new Conexion();
    private Connection con;

    public VentaDao() {
        this.con = cn.getConnection();
    }

    @Override
    public List<ClsVenta> obtenerVentasPorCliente(int idCliente) {
        List<ClsVenta> ventas = new ArrayList<>();
        String query = "SELECT * FROM ventas WHERE idCliente = ?";

        try {
            PreparedStatement pst = con.prepareStatement(query);
            pst.setInt(1, idCliente);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                ClsVenta venta = new ClsVenta(
                    rs.getInt("idVenta"),
                    rs.getString("idStripe"),
                    rs.getInt("idCliente"),
                    rs.getString("idProducto"),
                    rs.getString("nombre"),
                    rs.getString("descripcion"),
                    rs.getInt("cantidad"),
                    rs.getDouble("precio"),
                    rs.getDate("FechaCompra")
                );
                ventas.add(venta);
            }

            rs.close();
            pst.close();
        } catch (SQLException e) {
            System.out.println("Error al obtener las ventas por cliente: " + e.getMessage());
            e.printStackTrace();
        }

        return ventas;
    }
}
