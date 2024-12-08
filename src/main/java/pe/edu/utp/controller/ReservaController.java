package pe.edu.utp.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.temporal.WeekFields;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import pe.edu.utp.dao.CitaDao;
import pe.edu.utp.dao.ServicioDao;

import pe.edu.utp.dao.ReservaDao;
import pe.edu.utp.daoImpl.CitaDaoImpl;
import pe.edu.utp.entity.Reserva;

import pe.edu.utp.entity.Paciente;
import pe.edu.utp.daoImpl.ReservaDaoImpl;
import pe.edu.utp.daoImpl.ServicioDaoImpl;
import pe.edu.utp.entity.Servicio;
import pe.edu.utp.entity.VerCita;
import pe.edu.utp.entity.VerReserva;

@WebServlet(name = "ReservaController", urlPatterns = {"/ReservaController"})
public class ReservaController extends HttpServlet {

    ReservaDao reservaDao = new ReservaDaoImpl();
    CitaDao citaDao = new CitaDaoImpl();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }
    private ServicioDao servicioDAO;

    @Override
    public void init() {
        servicioDAO = new ServicioDaoImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        try {
            switch (accion) {
                case "listar":
                    listarReservas(request, response);
                    break;
                case "listarCitas":
                    listarCitas(request, response);
                    break;
                case "listarReservasPorDia":
                    listarReservasPorSemana(request, response);
                    break;
                case "semanaAnterior":
                    cambiarSemanaYListarReservasPorSemana(request, response, -1);
                    break;
                case "semanaSiguiente":
                    cambiarSemanaYListarReservasPorSemana(request, response, 1);
                    break;
                case "formcita":
                    formcita(request, response);
                    break;
                default:
                    request.getRequestDispatcher("PDCCalendario.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al listar reservas: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

// Método para listar todas las reservas
    private void listarReservas(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        int idUsuario = (int) request.getSession().getAttribute("idUsuario"); // Obtener ID del usuario desde la sesión
        List<VerReserva> VerReserva = reservaDao.listarReservas(idUsuario);  // Método que debes implementar en tu ReservaDao
        request.setAttribute("VerReserva", VerReserva);  // Enviamos la lista de reservas a la JSP
        request.setAttribute("tipoLista", "reserva"); // Agregar tipo de lista
        request.getRequestDispatcher("PDCSolicitudes.jsp").forward(request, response);
    }

// Método para listar todas las citas
    private void listarCitas(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        int idUsuario = (int) request.getSession().getAttribute("idUsuario"); // Obtener ID del usuario desde la sesión
        List<VerCita> VerCita = citaDao.listarCitas(idUsuario);  // Método que debes implementar en tu ReservaDao
        request.setAttribute("VerCita", VerCita);  // Enviamos la lista de citas a la JSP
        request.setAttribute("tipoLista", "cita"); // Agregar tipo de lista
        request.getRequestDispatcher("PDCSolicitudes.jsp").forward(request, response);
    }

    private void listarReservasPorSemana(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        Integer semanaActual = (Integer) request.getSession().getAttribute("semanaActual");
        if (semanaActual == null) {
            semanaActual = LocalDate.now().get(WeekFields.of(Locale.getDefault()).weekOfYear());
            request.getSession().setAttribute("semanaActual", semanaActual);
        }

        String[] diasSemana = {"Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado", "Domingo"};
        Map<String, List<VerReserva>> reservasPorDia = new HashMap<>();
        Map<String, List<VerCita>> citasPorDia = new HashMap<>();

        for (String dia : diasSemana) {
            List<VerCita> citas = citaDao.listarCitasPorDiaSemana(dia, semanaActual);
            List<VerReserva> reservas = reservaDao.listarReservasPorDiaSemana(dia, semanaActual);
            citasPorDia.put(dia, citas);
            reservasPorDia.put(dia, reservas);
        }

        request.setAttribute("reservasPorDia", reservasPorDia);
        request.setAttribute("citasPorDia", citasPorDia);
        request.setAttribute("tipoListaCitas", "citas");
        request.setAttribute("tipoListaReservas", "reservas");
        request.setAttribute("semanaActual", semanaActual); // Add this line to pass the current week to the JSP

        request.getRequestDispatcher("PDCCalendario.jsp").forward(request, response);
    }

    private void cambiarSemanaYListarReservasPorSemana(HttpServletRequest request, HttpServletResponse response, int cambio)
            throws SQLException, ServletException, IOException {
        Integer semanaActual = (Integer) request.getSession().getAttribute("semanaActual");
        if (semanaActual == null) {
            semanaActual = 1;
        }
        semanaActual += cambio;
        request.getSession().setAttribute("semanaActual", semanaActual);

        listarReservasPorSemana(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        //Datos de Usuario
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        int dni = Integer.parseInt(request.getParameter("dni"));
        int telefono = Integer.parseInt(request.getParameter("telefono"));
        String correo = request.getParameter("correo");
        double precio_servicio = Double.parseDouble(request.getParameter("precio_consulta"));
        int idServicio = Integer.parseInt(request.getParameter("idServicio"));
        int id_odontologo = Integer.parseInt(request.getParameter("medico"));
        
        System.out.println("id_odontologo "+id_odontologo);
        //Datos de Reserva
        String fecha = request.getParameter("fecha");
        String hora = request.getParameter("hora");
        String descripcion = request.getParameter("descripcion");
        System.out.println("Precio del servicio: " + precio_servicio);
        int Usuario_idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
        System.out.println("IdUsuario: " + request.getParameter("idUsuario"));


        /*0
          p_DiaReserva (DATE)
          p_HoraReserva (TIME)
          p_Descripcion (TEXT)
          p_Importe (DECIMAL(10,2))
          p_Usuario_idUsuario (INT)
          p_Estado_idEstado (INT)
          p_Servicio_idServicio (INT)
          p_Odontologo_idUsuario (INT)*/
        int estadoId = 1;  // Asegúrate de que este valor sea válido
        Paciente paciente = new Paciente(0, nombre, apellido, dni, telefono, correo);
        Reserva reserva = new Reserva(0, fecha, hora, descripcion, precio_servicio, Usuario_idUsuario, estadoId, idServicio, id_odontologo);
        int x = reservaDao.verificarExistencia(dni);
        if (x == 0) {
            // Si el paciente no existe, registrar el usuario, la primera cita y la venta
            reservaDao.createReserva(paciente, reserva);
        } else {
            // Si el paciente ya existe, solo registrar la cita y la venta
            reservaDao.createReservaPacex(paciente, reserva);
        }
        

        response.sendRedirect("citareservada.jsp");
    }

    private void formcita(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        List<Servicio> servicios = servicioDAO.listarServicios();

        request.setAttribute("servicios", servicios);
        request.getRequestDispatcher("reservacita.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
