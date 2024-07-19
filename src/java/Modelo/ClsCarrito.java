/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Modelo;

/**
 *
 * @author LENOVO
 */
public class ClsCarrito {
    private ClsProducto producto;
    private int cantidad;
     int precio;

    public ClsCarrito() {
    }

    public ClsProducto getProducto() {
        return producto;
    }

    public void setProducto(ClsProducto producto) {
        this.producto = producto;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public int getPrecio() {
        return precio;
    }

    public void setPrecio(int precio) {
        this.precio = precio;
    }

    public ClsCarrito(ClsProducto producto, int cantidad, int precio) {
        this.producto = producto;
        this.cantidad = cantidad;
        this.precio = precio;
    }

    public double getTotal() {
        return producto.getPrecio() * cantidad;
    }

}

