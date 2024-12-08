package pe.edu.utp.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import pe.edu.utp.dao.CitaDao;
import pe.edu.utp.dao.ReservaDao;
import pe.edu.utp.daoImpl.CitaDaoImpl;
import pe.edu.utp.daoImpl.ReservaDaoImpl;
import pe.edu.utp.entity.ReporteEstado;
import pe.edu.utp.entity.ReporteMensual; // Asegúrate de tener la clase ReporteMensual

@WebServlet(name = "ReporteController", urlPatterns = {"/ReporteController"})
public class ReporteController extends HttpServlet {

    ReservaDao reservaDao = new ReservaDaoImpl();
    CitaDao citaDao = new CitaDaoImpl();
    GeneradorDeReporte generadorDeReporte = new GeneradorDeReporte(reservaDao, citaDao); // Instancia del generador de reporte

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Puedes mantener este método vacío si no lo necesitas
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        try {
            if ("reporte".equals(accion)) {
                generarReporteMensual(request, response); // Nuevo método para generar el reporte mensual

            } else if ("reportead".equals(accion)) {
                generarReporteMensualAdmin(request, response); // Nuevo método para generar el reporte mensual

            }  else {
                request.getRequestDispatcher("PDCReportes.jsp").forward(request, response); // Página principal
            }

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al listar notificaciones: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }

    }

    // Nuevo método para generar el reporte mensual
    private void generarReporteMensual(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int idUsuario = (int) request.getSession().getAttribute("idUsuario"); // Obtener ID del usuario desde la sesión
        // Generar el reporte
        List<ReporteMensual> reporteMensual = generadorDeReporte.generarReporte(idUsuario);
        request.setAttribute("reporteMensual", reporteMensual); // Enviar el reporte a la JSP
        request.getRequestDispatcher("PDCReportes.jsp").forward(request, response); // Redirigir a la vista del reporte
    }

    private void generarReporteMensualAdmin(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        // Generar el reporte
        List<ReporteMensual> reporteMensual = generadorDeReporte.generarReporteAd();
        request.setAttribute("reporteMensual", reporteMensual); // Enviar el reporte a la JSP
        request.getRequestDispatcher("PDCReportes.jsp").forward(request, response); // Redirigir a la vista del reporte
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
