<%-- 
    Document   : NavPanel
    Created on : 1 oct. 2024, 5:55:59 p. m.
    Author     : Christhian
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%HttpSession sesion = request.getSession();
        Integer idUser = (Integer) sesion.getAttribute("idUsuario");
        String nombre = (String) sesion.getAttribute("Nombre");
        String tiporol = (String) sesion.getAttribute("TipoRol");

    %>
    <nav class="navbar bg-info-subtle" style="height:100px;">
        <div class="container d-flex justify-content-between align-items-center">
            <a class="navbar-brand" href="#">
                <img src="https://logomaker.designfreelogoonline.com/media/productdesigner/logo/resized/0001036_dental_logo_maker_dentist_Logo-02.png" alt="Logo de la empresa" width="50" height="50">
            </a>
            <div class="flex-grow-1 text-center">
                <h1 class="m-0" style="font-weight: bold;">Panel de Control - Clí­nica</h1>
            </div>
            <!-- Botón de Usuario -->
            <div class="d-flex justify-content-center me-4">

                <%if (idUser == null) { %>
                <!-- Botón de Iniciar Sesión si no está autenticado -->
                <a href="iniciosesion.jsp" class="btn btn-primary rounded-pill px-3 mx-5">
                    Iniciar Sesión
                </a>
                <% } else {%>
                <!-- Menú desplegable si el usuario está autenticado -->
                <div class="dropdown">
                    <button class="btn btn-primary rounded-pill px-3 mx-5 dropdown-toggle" type="button" id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="fa-regular fa-user"></i>
                        <strong><%= nombre%></strong>
                    </button>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                        <li><a class="dropdown-item" href="index.jsp">Menú principal</a></li>
                        <%if (tiporol.equals("Administrador")) {%>
                                    <li><a class="dropdown-item" href="ReservaController?accion=listarReservasPorDia">Panel de Control</a></li>
                                <%}%>
                        <%if (tiporol.equals("Administrador")) {%>
                                    <li><a class="dropdown-item" href="DashboardController?action=dashboard">Panel de Administrador</a></li>
                                <%}%>
                                    
                        <li><a class="dropdown-item" href="ReservaController?accion=formcita">Crear reserva</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="CerrarSesionController">Cerrar sesión</a></li>
                    </ul>
                </div>
                <% }%>
            </div>
        </div>
    </nav>


</html>
