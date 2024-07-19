/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Modelo;

/**
 *
 * @author LENOVO
 */
public class ClsDetalleCompra {

    public ClsDetalleCompra(int idDetalle, String idProducto, int idCompras, int cantidad, double precioCompra) {
        this.idDetalle = idDetalle;
        this.idProducto = idProducto;
        this.idCompras = idCompras;
        this.cantidad = cantidad;
        this.precioCompra = precioCompra;
    }

    public int getIdDetalle() {
        return idDetalle;
    }

    public void setIdDetalle(int idDetalle) {
        this.idDetalle = idDetalle;
    }

    public String getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(String idProducto) {
        this.idProducto = idProducto;
    }

    public int getIdCompras() {
        return idCompras;
    }

    public void setIdCompras(int idCompras) {
        this.idCompras = idCompras;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public double getPrecioCompra() {
        return precioCompra;
    }

    public void setPrecioCompra(double precioCompra) {
        this.precioCompra = precioCompra;
    }

    public ClsDetalleCompra() {
    }
    private int idDetalle;
    private String idProducto;
    private int idCompras;
    private int cantidad;
    private double precioCompra;
 
}
