/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package Interface;
import Modelo.ClsVenta;
import java.util.List;
/**
 *
 * @author luna3
 */
public interface InterfaceVenta {
    List<ClsVenta> obtenerVentasPorCliente(int idCliente);
    
}
