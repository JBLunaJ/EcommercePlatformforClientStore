/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package Interface;
import Modelo.ClsCarrito;
import java.util.List;

/**
 *
 * @author LENOVO
 */
public interface InterfaceCompras {
 public List<ClsCarrito> obtenerCarrito(int idCliente);
    public boolean agregarProductoAlCarrito(int idCliente, String idProducto, int cantidad);
    public boolean eliminarProductoDelCarrito(int idCliente, String idProducto);
    public boolean actualizarCantidadProducto(int idCliente, String idProducto, int cantidad);
}