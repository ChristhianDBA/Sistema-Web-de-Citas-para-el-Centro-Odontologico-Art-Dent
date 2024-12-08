/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package pe.edu.utp.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import pe.edu.utp.dao.UsuarioDao;
import pe.edu.utp.daoImpl.UsuarioDaoImpl;
import pe.edu.utp.entity.Usuario;

/**
 *
 * @author alex0
 */
@WebServlet("/UsuarioController")
public class UsuarioController extends HttpServlet {

    private UsuarioDao usuarioDAO = new UsuarioDaoImpl();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        switch (action) {
            case "list":
                listUsuarios(request, response);
                break;
            case "add":
                showAddForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteUsuario(request, response);
                break;
            default:
                listUsuarios(request, response);
                break;
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        switch (action) {
            case "add":
                addUsuario(request, response);
                break;
            case "update":
                updateUsuario(request, response);
                break;

            default:
                listUsuarios(request, response);
                break;
        }
    }

    private void listUsuarios(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("ADMPUsuarios.jsp");
        request.setAttribute("usuarios", usuarioDAO.listarUsuarios());
        dispatcher.forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("ADMPUsuarios.jsp");
        dispatcher.forward(request, response);
    }

    private void addUsuario(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        int dni = Integer.parseInt(request.getParameter("dni"));
        String telefono = request.getParameter("telefono");
        String email = request.getParameter("email");
        String direccion = request.getParameter("direccion");
        String fechanacimiento = request.getParameter("fechanacimiento");
        String clave = request.getParameter("clave");
        int rol = Integer.parseInt(request.getParameter("rol"));
        Usuario newUser = new Usuario(0, nombre, apellido, dni, telefono, email, direccion, fechanacimiento, clave, rol);
        System.out.println("datos: " + newUser);
        usuarioDAO.registrarUsuario(newUser);
        response.sendRedirect("UsuarioController?action=list");
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Usuario existingUsuario = getUsuario(id);
        RequestDispatcher dispatcher = request.getRequestDispatcher("ADMPeditarUsuario.jsp");
        request.setAttribute("usuario", existingUsuario);
        dispatcher.forward(request, response);
    }

    private void updateUsuario(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        int dni = Integer.parseInt(request.getParameter("dni"));
        String telefono = request.getParameter("telefono");
        String email = request.getParameter("email");
        String direccion = request.getParameter("direccion");
        String fechanacimiento = request.getParameter("fechanacimiento");
        String clave = request.getParameter("clave");
        int rol = Integer.parseInt(request.getParameter("rol"));
        Usuario updatedUser = new Usuario(id, nombre, apellido, dni, telefono, email, direccion, fechanacimiento, clave, rol);
        usuarioDAO.actualizarUsuario(updatedUser);
        response.sendRedirect("UsuarioController?action=list");
    }

    private Usuario getUsuario(int id) {
        return usuarioDAO.obtenerUsuarioPorId(id);
    }

    private void deleteUsuario(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        usuarioDAO.eliminarUsuario(id);
        response.sendRedirect("UsuarioController?action=list");
    }

}
