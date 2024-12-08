/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package pe.edu.utp.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import pe.edu.utp.dao.UsuarioDao;
import pe.edu.utp.daoImpl.UsuarioDaoImpl;
import pe.edu.utp.dto.InicioSesionDTO;

/**
 *
 * @author Christhian
 */
public class InicioSesionController extends HttpServlet {

    private UsuarioDao udao = new UsuarioDaoImpl();

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

        String dni = request.getParameter("document");
        String clave = request.getParameter("password");

        HttpSession sesion = request.getSession();
        List<InicioSesionDTO> login = udao.login(dni, clave);
        if (!login.isEmpty()) {
            sesion.setAttribute("idUsuario", login.get(0).getIdUsuario());
            sesion.setAttribute("Nombre", login.get(0).getNombre());
            sesion.setAttribute("Apellido", login.get(0).getApellido());
            sesion.setAttribute("Dni", login.get(0).getDni());
            sesion.setAttribute("TipoRol", login.get(0).getTipoRol());
            if (login.get(0).getTipoRol().equals("Administrador")) {
                response.sendRedirect("DashboardController?action=dashboard");
            } else {
                response.sendRedirect("ReservaController?accion=listarReservasPorDia");
            }

        } else {
            request.getRequestDispatcher("iniciosesionerror.jsp").forward(request, response);

        }
//Terminar redes rapido luego hacer que guarde la sesion de los atribuos en la pagina y luego hacer el crud de citas (miercoles)
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

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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
