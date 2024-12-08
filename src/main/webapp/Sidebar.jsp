<%-- 
    Document   : Sidebar
    Created on : 13 oct. 2024, 11:33:55 p. m.
    Author     : Fennox
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <!-- Sidebar -->
    <%HttpSession ss = request.getSession();%>
    <div class="text-white p-4 d-flex flex-column" style="width: 400px; background:#2E3E50;">
        <ul class="nav flex-column" style="margin-top: 60px;">
            <li class="nav-item mb-2 pt-4 border-bottom">
                <a class="nav-link text-white" href="ReservaController?accion=listar">Solicitudes</a>
            </li>
            <li class="nav-item mb-2 pt-4 border-bottom" style="margin-top: 30px;">
                <a class="nav-link text-white" href="ReservaController?accion=listarReservasPorDia">Calendario de citas</a>
            </li>
            <li class="nav-item mb-2 pt-4 border-bottom" style="margin-top: 30px;">
                <a class="nav-link text-white" href="HistorialController?accion=ListarHistorialReservas">Historial</a>
            </li>
            <li class="nav-item mb-2 pt-4 border-bottom" style="margin-top: 30px;">
                <a class="nav-link text-white" href="NotificacionesController?accion=listarReservas">Notificaciones</a>
            </li>
            <li class="nav-item mb-2 pt-4 border-bottom" style="margin-top: 30px;">
                <%if ((ss.getAttribute("TipoRol")).equals("Administrador")) {%>
                <a class="nav-link text-white" href="ReporteController?accion=reportead">Reportes</a>
                <%}else if((ss.getAttribute("TipoRol")).equals("Secretaria")){%>
                <a class="nav-link text-white" href="ReporteController?accion=reporte">Reportes</a>
                <%}%>
            </li>
        </ul>

        <!-- Botón de Salir en la parte inferior -->
        <a class="nav-link text-white mt-auto border-top pt-4 text-center" href="CerrarSesionController">Salir</a>
    </div>
</html>
