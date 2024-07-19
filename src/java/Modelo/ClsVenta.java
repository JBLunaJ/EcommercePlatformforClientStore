package Modelo;

import java.util.Date;

public class ClsVenta {
    private int idVenta;
    private String idStripe;
    private int idCliente;
    private String idProducto;
    private String nombre;
    private String descripcion;
    private int cantidad;
    private double precio;
    private Date fecha; // Supongamos que `fecha` es un campo de tipo `Date`

    public ClsVenta() {
    }
    
    
    public ClsVenta(int idVenta, String idStripe, int idCliente, String idProducto, String nombre, String descripcion, int cantidad, double precio, Date fecha) {
        this.idVenta = idVenta;
        this.idStripe = idStripe;
        this.idCliente = idCliente;
        this.idProducto = idProducto;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.cantidad = cantidad;
        this.precio = precio;
        this.fecha = fecha;
    }

    public int getIdVenta() {
        return idVenta;
    }

    public void setIdVenta(int idVenta) {
        this.idVenta = idVenta;
    }

    public String getIdStripe() {
        return idStripe;
    }

    public void setIdStripe(String idStripe) {
        this.idStripe = idStripe;
    }

    public int getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(int idCliente) {
        this.idCliente = idCliente;
    }

    public String getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(String idProducto) {
        this.idProducto = idProducto;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public double getPrecio() {
        return precio;
    }

    public void setPrecio(double precio) {
        this.precio = precio;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public double getTotal() {
        return cantidad * precio;
    }

    
}
