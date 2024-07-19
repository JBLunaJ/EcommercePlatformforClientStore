/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package Interface;

import Modelo.ClsProducto;
import java.util.List;

/**
 *
 * @author LENOVO
 */
public interface InterfaceProducto {
    ClsProducto obtenerProductoPorId(String id);
    List<ClsProducto> listarProductos();
    List<ClsProducto> listarProductosPorCategoria(String categoriaId);
}
