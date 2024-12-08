<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Navbar Clínica</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    </head>
    <body>

        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm w-100">
            <div class="container-fluid">
                <!-- Logo -->
                <a class="navbar-brand mx-5" href="index.jsp">
                    <img src="https://logomaker.designfreelogoonline.com/media/productdesigner/logo/resized/0001036_dental_logo_maker_dentist_Logo-02.png" alt="Logo de la empresa" width="50" height="50">
                </a>

                <!-- Botón colapsable para móviles -->
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <!-- Links del navbar -->
                <div class="collapse navbar-collapse justify-content-center" id="navbarNav">
                    <ul class="navbar-nav text-center">
                        <li class="nav-item mx-5">
                            <a class="nav-link active border-bottom border-primary" aria-current="page" href="index.jsp">Inicio</a>
                        </li>
                        <li class="nav-item mx-5">
                            <a class="nav-link" href="ServicioController?action=listar">Servicios</a>
                        </li>
                        <li class="nav-item mx-5">
                            <a class="nav-link" href="nosotros.jsp">Nosotros</a>
                        </li>
                        <li class="nav-item mx-5">
                            <a class="nav-link" href="faq.jsp">FAQ</a>
                        </li>

                    </ul>

                    <!-- Botón de Usuario -->
                    <div class="d-flex justify-content-center me-4">

                        <%
                            HttpSession sesion = request.getSession(false);
                            Integer idUser = (Integer) sesion.getAttribute("idUsuario");
                            String nombre = (String) sesion.getAttribute("Nombre");
                            String tiporol = (String) sesion.getAttribute("TipoRol");

                            if (idUser == null) { %>
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
                                <li><a class="dropdown-item" href="ReservaController?accion=listarReservasPorDia">Panel de Control</a></li>
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
            </div>
        </nav>


        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

    </body>
</html>