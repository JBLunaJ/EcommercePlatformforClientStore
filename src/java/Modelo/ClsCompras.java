/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Modelo;

/**
 *
 * @author LENOVO
 */
public class ClsCompras {

    public ClsCompras(int idCompras, int idCliente, int idPago, String fechaCompras, double monto, String estado) {
        this.idCompras = idCompras;
        this.idCliente = idCliente;
        this.idPago = idPago;
        this.fechaCompras = fechaCompras;
        this.monto = monto;
        this.estado = estado;
    }

    public ClsCompras() {
    }

    public int getIdCompras() {
        return idCompras;
    }

    public void setIdCompras(int idCompras) {
        this.idCompras = idCompras;
    }

    public int getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(int idCliente) {
        this.idCliente = idCliente;
    }

    public int getIdPago() {
        return idPago;
    }

    public void setIdPago(int idPago) {
        this.idPago = idPago;
    }

    public String getFechaCompras() {
        return fechaCompras;
    }

    public void setFechaCompras(String fechaCompras) {
        this.fechaCompras = fechaCompras;
    }

    public double getMonto() {
        return monto;
    }

    public void setMonto(double monto) {
        this.monto = monto;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }
    private int idCompras;
    private int idCliente;
    private int idPago;
    private String fechaCompras;
    private double monto;
    private String estado;
}
