/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ModeloDaO;
import Config.Conexion;
import Interface.InterfaceCliente;
import Modelo.ClsCliente;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
/**
 
 * @author LENOVO
 */
public class ClienteDaO implements Interface.InterfaceCliente{
private Connection con;

    public ClienteDaO() {
        Conexion conexion = new Conexion();
        this.con = conexion.getConnection();
    }
    @Override
    public ClsCliente autenticarCliente(String email, String password) {
        ClsCliente cliente = null;
        String query = "SELECT * FROM cliente WHERE Email = ? AND Password = ?";

        try {
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, email);
            pst.setString(2, password);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                cliente = new ClsCliente();
                cliente.setIdCliente(rs.getInt("idCliente"));
                cliente.setDni(rs.getString("Dni"));
                cliente.setNombre(rs.getString("Nombre"));
                cliente.setDireccion(rs.getString("Direccion"));
                cliente.setEmail(rs.getString("Email"));
                cliente.setPassword(rs.getString("Password"));
            }

            pst.close();
            rs.close();
        } catch (SQLException e) {
            System.out.println("Error al autenticar el cliente: " + e.getMessage());
            e.printStackTrace();
        }

        return cliente;
    }

    @Override
    public boolean registrarCliente(ClsCliente cliente) {
              String query = "INSERT INTO cliente (Dni, Nombre, Direccion, Email, Password) VALUES (?, ?, ?, ?, ?)";

        try {
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, cliente.getDni());
            pst.setString(2, cliente.getNombre());
            pst.setString(3, cliente.getDireccion());
            pst.setString(4, cliente.getEmail());
            pst.setString(5, cliente.getPassword());

            int filasInsertadas = pst.executeUpdate();
            pst.close();

            return filasInsertadas > 0;
        } catch (SQLException e) {
            System.out.println("Error al registrar el cliente: " + e.getMessage());
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public ClsCliente obtenerDatosClienteAutenticado(int idCliente) {
                ClsCliente cliente = null;
        String query = "SELECT * FROM cliente WHERE idCliente = ?";

        try {
            PreparedStatement pst = con.prepareStatement(query);
            pst.setInt(1, idCliente);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                cliente = new ClsCliente();
                cliente.setIdCliente(rs.getInt("idCliente"));
                cliente.setDni(rs.getString("Dni"));
                cliente.setNombre(rs.getString("Nombre"));
                cliente.setDireccion(rs.getString("Direccion"));
                cliente.setEmail(rs.getString("Email"));
                cliente.setPassword(rs.getString("Password"));
            }

            pst.close();
            rs.close();
        } catch (SQLException e) {
            System.out.println("Error al obtener datos del cliente: " + e.getMessage());
            e.printStackTrace();
        }

        return cliente;
    }


    @Override
    public boolean actualizarCliente(ClsCliente cliente) {
       String query = "UPDATE cliente SET Dni = ?, Nombre = ?, Direccion = ?, Email = ?, Password = ? WHERE idCliente = ?";

        try {
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, cliente.getDni());
            pst.setString(2, cliente.getNombre());
            pst.setString(3, cliente.getDireccion());
            pst.setString(4, cliente.getEmail());
            pst.setString(5, cliente.getPassword());
            pst.setInt(6, cliente.getIdCliente());

            int filasActualizadas = pst.executeUpdate();
            pst.close();

            return filasActualizadas > 0;
        } catch (SQLException e) {
            System.out.println("Error al actualizar el cliente: " + e.getMessage());
            e.printStackTrace();
        }

        return false;
    }
}