/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package pe.edu.utp.controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import pe.edu.utp.daoImpl.CitaDaoImpl;
import pe.edu.utp.entity.Cita;
import pe.edu.utp.entity.Paciente;
import pe.edu.utp.entity.Venta;

/**
 *
 * @author Andrea
 */
@WebServlet(name = "CitaController", urlPatterns = {"/CitaController"})
public class CitaController extends HttpServlet {

    private CitaDaoImpl citaDao = new CitaDaoImpl();

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CitaController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CitaController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Obtener los datos del formulario
        String dniStr = request.getParameter("dni");
        int dni = Integer.parseInt(dniStr); // Convertimos el DNI a entero
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String correo = request.getParameter("correo");
        String telefonoStr = request.getParameter("telefono");
        int telefono = Integer.parseInt(telefonoStr);
        double precio_servicio = Double.parseDouble(request.getParameter("precio_consulta"));
         int idServicio = Integer.parseInt(request.getParameter("idServicio"));
        String fecha = request.getParameter("fecha");
        String hora = request.getParameter("hora");
        //String motivo = request.getParameter("motivo");  // ID del servicio en este caso - Falta implmentar el servicio dependiendo el ID
        //String estadoStr = request.getParameter("estado");  // ID del estado de la cita
        //int estado = Integer.parseInt(estadoStr); Siempre es 1 por defecto
        //double costo = Double.parseDouble(request.getParameter("motivo")); 

        //Retorna el ID, si existe la persona sino el valor 0
        int x = citaDao.verificarExistencia(dni);
        // Crear los objetos necesarios para las entidades
        Paciente paciente = new Paciente(x, nombre, apellido, dni, telefono, correo);
        Cita cita = new Cita(0, fecha, hora, idServicio, x, 1, 3); // ID del paciente es el DNI en este caso
        Venta venta = new Venta(0, precio_servicio, "", x);  // Ejemplo de importe, ajustar según necesidad

        if (x == 0) {
            // Si el paciente no existe, registrar el usuario, la primera cita y la venta
            citaDao.createCitasilapersonaesnueva(paciente, cita, venta);
        } else {
            // Si el paciente ya existe, solo registrar la cita y la venta
            citaDao.createCitasilapersonayaexiste(paciente, cita, venta);
        }

        // Redireccionar o enviar mensaje de éxito
        response.sendRedirect("citareservada.jsp");  // Ajusta la ruta según tu estructura
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
