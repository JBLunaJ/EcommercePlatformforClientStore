/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package Interface;
import Modelo.ClsCliente;
import java.util.*;
/**
 *
 * @author LENOVO
 */
public interface InterfaceCliente {
    public ClsCliente autenticarCliente(String email, String password);
    public boolean registrarCliente(ClsCliente cliente);
     public ClsCliente obtenerDatosClienteAutenticado(int idCliente);
    public boolean actualizarCliente(ClsCliente cliente);
}
