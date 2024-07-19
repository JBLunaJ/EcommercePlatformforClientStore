/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Modelo;

import java.time.LocalDateTime;

/**
 *
 * @author LENOVO
 */
public class ClsProducto {

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public double getCantidad() {
        return cantidad;
    }

    public void setCantidad(double cantidad) {
        this.cantidad = cantidad;
    }

    public String getUnidadMedida() {
        return unidadMedida;
    }

    public void setUnidadMedida(String unidadMedida) {
        this.unidadMedida = unidadMedida;
    }

    public double getPrecioU() {
        return precioU;
    }

    public void setPrecioU(double precioU) {
        this.precioU = precioU;
    }

    public LocalDateTime getFechaC() {
        return fechaC;
    }

    public void setFechaC(LocalDateTime fechaC) {
        this.fechaC = fechaC;
    }

    public LocalDateTime getFechaV() {
        return fechaV;
    }

    public void setFechaV(LocalDateTime fechaV) {
        this.fechaV = fechaV;
    }

    public String getPeso() {
        return peso;
    }

    public void setPeso(String peso) {
        this.peso = peso;
    }

    public String getFoto() {
        return foto;
    }

    public void setFoto(String foto) {
        this.foto = foto;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public double getPrecio() {
        return precio;
    }

    public void setPrecio(double precio) {
        this.precio = precio;
    }

    public ClsProducto(String id, String categoria, String nombre, double cantidad, String unidadMedida, double precioU, LocalDateTime fechaC, LocalDateTime fechaV, String peso, String foto, String descripcion, int stock, double precio) {
        this.id = id;
        this.categoria = categoria;
        this.nombre = nombre;
        this.cantidad = cantidad;
        this.unidadMedida = unidadMedida;
        this.precioU = precioU;
        this.fechaC = fechaC;
        this.fechaV = fechaV;
        this.peso = peso;
        this.foto = foto;
        this.descripcion = descripcion;
        this.stock = stock;
        this.precio = precio;
    }

    public ClsProducto() {
    }
        private String id;
    private String categoria;
    private String nombre;
    private double cantidad;
    private String unidadMedida; // Cambiado a camel case
    private double precioU; // Cambiado a camel case
    private LocalDateTime fechaC; // Cambiado a LocalDateTime para representar la fecha y hora
    private LocalDateTime fechaV; // Cambiado a LocalDateTime para representar la fecha y hora
    private String peso;
    private String foto;
    private String descripcion;
    private int stock;
    private double precio;
}
