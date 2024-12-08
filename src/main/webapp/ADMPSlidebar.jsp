<%-- 
    Document   : ADMPSlidebar
    Created on : 28 nov. 2024, 12:28:34 a. m.
    Author     : alex0
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <nav class="col-md-3 col-lg-2 d-md-block sidebar collapse">
        <div class="position-sticky pt-3">
            <ul class="nav flex-column">
                <li class="nav-item">
                    <a class="nav-link active" href="DashboardController?action=dashboard">
                        <i class="bi bi-speedometer2 me-2"></i>
                        Inicio
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="UsuarioController?action=list">
                        <i class="bi bi-people me-2"></i>
                        Usuarios
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="ServicioController?action=list">
                        <i class="bi bi-calendar-check me-2"></i>
                        Servicios
                    </a>
                </li>
            </ul>
        </div>
    </nav>
</html>
