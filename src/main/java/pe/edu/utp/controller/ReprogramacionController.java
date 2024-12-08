/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package pe.edu.utp.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import pe.edu.utp.dao.CitaDao;
import pe.edu.utp.dao.ReservaDao;
import pe.edu.utp.daoImpl.CitaDaoImpl;
import pe.edu.utp.daoImpl.ReservaDaoImpl;
import pe.edu.utp.entity.Cita;
import pe.edu.utp.entity.VerCita;
import pe.edu.utp.entity.VerReserva;
import static sun.jvm.hotspot.HelloWorld.e;

/**
 *
 * @author AMD
 */
public class ReprogramacionController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ReprogramacionController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ReprogramacionController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    ReservaDao reservaDao = new ReservaDaoImpl();
    CitaDao citaDao = new CitaDaoImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        try {
            if ("VerReproRe".equals(accion)) {
                ReproRe(request, response);
            } else if ("VerReproCi".equals(accion)) {
                ReproCi(request, response);
            } else {
                request.getRequestDispatcher("PDCCalendario.jsp").forward(request, response); // Página principal
            }

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al listar reservas: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }

    }

    private void ReproRe(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        int idReserva = Integer.parseInt(request.getParameter("id"));
        List<VerReserva> VerReserva = reservaDao.DetalleReserva(idReserva);  // Método que debes implementar en tu ReservaDao
        request.setAttribute("VerReserva", VerReserva);  // Enviamos la lista de reservas a la JSP
        request.setAttribute("tipoLista", "DetRe"); // Agregar tipo de lista
        request.getRequestDispatcher("Reprogramacion.jsp").forward(request, response);
    }

    private void ReproCi(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        int idCita = Integer.parseInt(request.getParameter("id"));
        List<VerCita> VerCita = citaDao.DetalleCita(idCita);
        request.setAttribute("VerCita", VerCita);
        request.setAttribute("tipoLista", "DetCi");
        request.getRequestDispatcher("Reprogramacion.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");
        try {
            if ("UpdateReserva".equals(accion)) {
                UpdateReserva(request, response);
            } else if ("UpdateCita".equals(accion)) {
                UpdateCita(request, response);
            } else if ("updateEstadoConfirmar".equals(accion)) {
                UpdateReservaEstado(request, response);
            } else if ("updateEstadoCompletado".equals(accion)) {
                UpdateReservaEstado(request, response);
            } else if ("updateEstadoConfirmarCita".equals(accion)) {
                UpdateCitaEstado(request, response);
            } else if ("updateEstadoCompletadoCita".equals(accion)) {
                UpdateCitaEstado(request, response);
            } else if ("updateEstadoCancelar".equals(accion)) {
                UpdateReservaCancelado(request, response);
            } else if ("updateEstadoCanceladoCita".equals(accion)) {
                UpdateCitaCancelado(request, response);
            } else if ("deleteReserva".equals(accion)) {
                DeleteReserva(request, response);
            } else if ("deleteCita".equals(accion)) {
                DeleteCita(request, response);
            } else {
                request.getRequestDispatcher("PDCCalendario.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al modificar: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }

    }

    private void UpdateCita(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        // Obtener los parámetros del formulario
        int idCita = Integer.parseInt(request.getParameter("idCita"));
        String nuevaFecha = request.getParameter("new-date");
        String nuevaHora = request.getParameter("new-time");

        // Crear una instancia de CitaDaoImpl
        CitaDao citaDao = new CitaDaoImpl();

        int resultado = citaDao.updateCita(idCita, nuevaFecha, nuevaHora);

        if (resultado > 0) {
            request.getRequestDispatcher("PDCCalendario.jsp").forward(request, response); // Redirige a la página principal
        } else {
            // Si hubo un error en la actualización
            request.getRequestDispatcher("error.jsp").forward(request, response); // Redirige a la página de error
        }
    }

    private void UpdateReserva(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        // Obtener los parámetros del formulario
        int idReserva = Integer.parseInt(request.getParameter("idReserva"));
        String nuevaFecha = request.getParameter("new-date");
        String nuevaHora = request.getParameter("new-time");

        ReservaDao reservaDao = new ReservaDaoImpl();

        int resultado = reservaDao.updateReserva(idReserva, nuevaFecha, nuevaHora);

        if (resultado > 0) {
            request.getRequestDispatcher("PDCCalendario.jsp").forward(request, response); // Redirige a la página principal
        } else {
            request.getRequestDispatcher("error.jsp").forward(request, response); // Redirige a la página de error
        }
    }

    private void UpdateReservaEstado(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        int idReserva = Integer.parseInt(request.getParameter("idReserva"));
        String estadoActual = request.getParameter("estado");
        System.out.println("id " + idReserva);
        System.out.println("estado " + estadoActual);
        ReservaDao reservaDao = new ReservaDaoImpl();
        int resultado = reservaDao.updateEstadoReserv(idReserva, estadoActual);
        if (resultado > 0) {
            response.sendRedirect("ReservaController?accion=listar");
        } else {
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    private void UpdateCitaEstado(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        int idCita = Integer.parseInt(request.getParameter("idCita"));
        String estadoActual = request.getParameter("estado");
        System.out.println("id " + idCita);
        System.out.println("estado " + estadoActual);
        CitaDao CitaDao = new CitaDaoImpl();
        int resultado = CitaDao.updateEstadoCita(idCita, estadoActual);
        if (resultado > 0) {
            response.sendRedirect("ReservaController?accion=listar");
        } else {
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    private void UpdateReservaCancelado(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        int idReserva = Integer.parseInt(request.getParameter("idReserva"));
        System.out.println("id " + idReserva);
        
        int resultado = reservaDao.updateEstadoCancelado(idReserva);
        if (resultado > 0) {
            request.getRequestDispatcher("PDCCalendario.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
    
    private void UpdateCitaCancelado(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        int idCita = Integer.parseInt(request.getParameter("idCita"));
        System.out.println("id " + idCita);
        CitaDao CitaDao = new CitaDaoImpl();
        int resultado = CitaDao.updateEstadoCitaCancelado(idCita);
        if (resultado > 0) {
            request.getRequestDispatcher("PDCCalendario.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
    
    private void DeleteReserva(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        int idReserva = Integer.parseInt(request.getParameter("idReserva"));
        System.out.println("id " + idReserva);
        ReservaDao reservaDao = new ReservaDaoImpl();
        int resultado = reservaDao.deleteReserva(idReserva);
        if (resultado > 0) {
            request.getRequestDispatcher("PDCCalendario.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
    
    private void DeleteCita(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        int idCita = Integer.parseInt(request.getParameter("idCita"));
        System.out.println("id " + idCita);
        CitaDao CitaDao = new CitaDaoImpl();
        int resultado = CitaDao.DeleteCita(idCita);
        if (resultado > 0) {
            request.getRequestDispatcher("PDCCalendario.jsp").forward(request, response);
        } else {
            System.out.println("Error al eliminar la reserva");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
