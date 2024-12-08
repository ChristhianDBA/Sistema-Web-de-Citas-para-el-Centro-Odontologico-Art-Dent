/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package pe.edu.utp.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import pe.edu.utp.dao.PacienteDao;
import pe.edu.utp.daoImpl.PacienteDaoImpl;
import pe.edu.utp.entity.Paciente;

/**
 *
 * @author alex0
 */
@WebServlet(name = "PacienteController", urlPatterns = {"/PacienteController"})
public class PacienteController extends HttpServlet {
    
    PacienteDao pacienteDAO = new PacienteDaoImpl();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("action");
        if ("complet".equals(accion)) {
            completardatos(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("action");
        if ("complet".equals(accion)) {
            completardatos(request, response);
        }
    }

    private void completardatos(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String dni = request.getParameter("dni");

        // Obtener los datos del paciente
        Paciente paciente = pacienteDAO.obtenerPacientePorDNI(dni);

        if (paciente != null) {
            // Seteamos los atributos para el JSP (con valores para los campos)
            request.setAttribute("existe", true);
            request.setAttribute("nombre", paciente.getNombre());
            request.setAttribute("apellido", paciente.getApellido());
            request.setAttribute("correo", paciente.getCorreo());
            request.setAttribute("telefono", paciente.getTelefono());
        } else {
            request.setAttribute("existe", false);
        }

        // Redirigimos a la misma página para actualizar solo los campos de paciente
        request.getRequestDispatcher("reservapersonal.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "PacienteController";
    }
}

