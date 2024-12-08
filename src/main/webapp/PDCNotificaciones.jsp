<%//@include file="WEB-INF/template/libreria.jspf" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="es">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Panel de Control - Clínica</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    </head>

    <body class="d-flex flex-column min-vh-100">
        <%HttpSession misesion = request.getSession();
            String usuario = (String) request.getSession().getAttribute("Nombre");
            if (usuario == null) {
                response.sendRedirect("iniciosesionerror.jsp");
            }
        %>

        <%@include file="NavPanel.jsp" %>

        <!-- Contenido de la Página -->
        <div class="d-flex flex-grow-1">
            <!-- Sidebar -->
            <%@include file="Sidebar.jsp" %>


            <!-- Contenido Principal -->
            <div class="container-fluid p-4 d-flex flex-column flex-grow-1">
                <br><br>
                <h3 class="text-dark fs-3 fw-bold">Notificaciones</h3>
                <div class="d-flex justify-content-end mb-3">
                    <!-- Formulario para listar reservas -->
                    <form action="NotificacionesController" method="get">
                        <input type="hidden" name="accion" value="listarReservas" />
                        <button type="submit" class="btn btn-info me-2" style="width: 150px;">Reservas</button>
                    </form>

                    <!-- Formulario para listar citas -->
                    <form action="NotificacionesController" method="get">
                        <input type="hidden" name="accion" value="listarCitas" />
                        <button type="submit" class="btn btn-info" style="width: 150px;">Citas</button>
                    </form>
                </div>
                <div class="content">
                    <div class="container-fluid p-4">
                        <c:choose>
                            <c:when test="${tipoLista == 'reserva'}">                        
                                <c:forEach var="reserva" items="${VerReserva}">
                                    <c:choose>
                                        <c:when test="${reserva.estado == 'En espera'}">
                                            <div class="alert alert-warning d-flex align-items-start justify-content-between w-100 mb-3 p-4" role="alert">
                                                <i class="bi bi-clock-fill me-3 fs-4"></i>
                                                <div class="col">
                                                    <strong class="fs-4">Reserva en Espera</strong><br>
                                                    ${reserva.nombrePaciente} ${reserva.apellidoPaciente} ha solicitado una cita para el ${reserva.diaReserva}.
                                                    <br>
                                                    <a class="fw-bold">${reserva.horaReserva}</a>
                                                </div>
                                                <img class="ms-auto float-end" src="https://cdn-icons-png.flaticon.com/512/1436/1436388.png" width="60px">
                                            </div>
                                        </c:when>

                                        <c:when test="${reserva.estado == 'Completado'}">
                                            <div class="alert alert-success d-flex align-items-start justify-content-between w-100 mb-3 p-4" role="alert">
                                                <i class="bi bi-check-circle-fill me-3 fs-4"></i>
                                                <div class="col">
                                                    <strong class="fs-4">Reserva Completada</strong><br>
                                                    ${reserva.nombrePaciente} ${reserva.apellidoPaciente} completó su cita el ${reserva.diaReserva}.
                                                    <br>
                                                    <a class="fw-bold">${reserva.horaReserva}</a>
                                                </div>
                                                <img class="ms-auto float-end" src="https://cdn-icons-png.flaticon.com/512/1436/1436388.png" width="60px">
                                            </div>
                                        </c:when>

                                        <c:when test="${reserva.estado == 'Confirmado'}">
                                            <div class="alert alert-primary d-flex align-items-start justify-content-between w-100 mb-3 p-4" role="alert">
                                                <i class="bi bi-bell-fill me-3 fs-4"></i>
                                                <div class="col">
                                                    <strong class="fs-4">Reserva Confirmada</strong><br>
                                                    ${reserva.nombrePaciente} ${reserva.apellidoPaciente} ha confirmado su cita para el ${reserva.diaReserva}.
                                                    <br>
                                                    <a class="fw-bold">${reserva.horaReserva}</a>
                                                </div>
                                                <img class="ms-auto float-end" src="https://cdn-icons-png.flaticon.com/512/1436/1436388.png" width="60px">
                                            </div>
                                        </c:when>

                                        <c:when test="${reserva.estado == 'Reprogramado'}">
                                            <div class="alert alert-info d-flex align-items-start justify-content-between w-100 mb-3 p-4" role="alert">
                                                <i class="bi bi-arrow-repeat me-3 fs-4"></i>
                                                <div class="col">
                                                    <strong class="fs-4">Reserva Reprogramada</strong><br>
                                                    ${reserva.nombrePaciente} ${reserva.apellidoPaciente} ha reprogramado su cita para el ${reserva.diaReserva}.
                                                    <br>
                                                    <a class="fw-bold">${reserva.horaReserva}</a>
                                                </div>
                                                <img class="ms-auto float-end" src="https://cdn-icons-png.flaticon.com/512/1436/1436388.png" width="60px">
                                            </div>
                                        </c:when>

                                        <c:when test="${reserva.estado == 'Cancelado'}">
                                            <div class="alert alert-danger d-flex align-items-start justify-content-between w-100 mb-3 p-4" role="alert">
                                                <i class="bi bi-x-circle-fill me-3 fs-4"></i>
                                                <div class="col">
                                                    <strong class="fs-4">Reserva Cancelada</strong><br>
                                                    ${reserva.nombrePaciente} ${reserva.apellidoPaciente} canceló su cita para el ${reserva.diaReserva}.
                                                    <br>
                                                    <a class="fw-bold">${reserva.horaReserva}</a>
                                                </div>
                                                <img class="ms-auto float-end" src="https://cdn-icons-png.flaticon.com/512/1436/1436388.png" width="60px">
                                            </div>
                                        </c:when>
                                    </c:choose>
                                </c:forEach>
                            </c:when > 
                            <c:when test="${tipoLista == 'cita'}">
                                <c:forEach var="cita" items="${VerCita}">
                                    <c:choose>
                                        <c:when test="${cita.estado == 'En espera'}">
                                            <div class="alert alert-warning d-flex align-items-start justify-content-between w-100 mb-3 p-4" role="alert">
                                                <i class="bi bi-clock-fill me-3 fs-4"></i>
                                                <div class="col">
                                                    <strong class="fs-4">Cita en Espera</strong><br>
                                                    ${cita.nombrePaciente} ${cita.apellidoPaciente} ha solicitado una cita para el ${cita.diaReserva}.
                                                    <br>
                                                    <a class="fw-bold">${cita.horaReserva}</a>
                                                </div>
                                                <img class="ms-auto float-end" src="https://cdn-icons-png.flaticon.com/512/1436/1436388.png" width="60px">
                                            </div>
                                        </c:when>

                                        <c:when test="${cita.estado == 'Completado'}">
                                            <div class="alert alert-success d-flex align-items-start justify-content-between w-100 mb-3 p-4" role="alert">
                                                <i class="bi bi-check-circle-fill me-3 fs-4"></i>
                                                <div class="col">
                                                    <strong class="fs-4">Cita Completada</strong><br>
                                                    ${cita.nombrePaciente} ${cita.apellidoPaciente} completó su cita el ${cita.diaReserva}.
                                                    <br>
                                                    <a class="fw-bold">${cita.horaReserva}</a>
                                                </div>
                                                <img class="ms-auto float-end" src="https://cdn-icons-png.flaticon.com/512/1436/1436388.png" width="60px">
                                            </div>
                                        </c:when>

                                        <c:when test="${cita.estado == 'Confirmado'}">
                                            <div class="alert alert-primary d-flex align-items-start justify-content-between w-100 mb-3 p-4" role="alert">
                                                <i class="bi bi-bell-fill me-3 fs-4"></i>
                                                <div class="col">
                                                    <strong class="fs-4">Cita Confirmada</strong><br>
                                                    ${cita.nombrePaciente} ${cita.apellidoPaciente} ha confirmado su cita para el ${cita.diaReserva}.
                                                    <br>
                                                    <a class="fw-bold">${cita.horaReserva}</a>
                                                </div>
                                                <img class="ms-auto float-end" src="https://cdn-icons-png.flaticon.com/512/1436/1436388.png" width="60px">
                                            </div>
                                        </c:when>

                                        <c:when test="${cita.estado == 'Reprogramado'}">
                                            <div class="alert alert-info d-flex align-items-start justify-content-between w-100 mb-3 p-4" role="alert">
                                                <i class="bi bi-arrow-repeat me-3 fs-4"></i>
                                                <div class="col">
                                                    <strong class="fs-4">Cita Reprogramada</strong><br>
                                                    ${cita.nombrePaciente} ${cita.apellidoPaciente} ha reprogramado su cita para el ${cita.diaReserva}.
                                                    <br>
                                                    <a class="fw-bold">${cita.horaReserva}</a>
                                                </div>
                                                <img class="ms-auto float-end" src="https://cdn-icons-png.flaticon.com/512/1436/1436388.png" width="60px">
                                            </div>
                                        </c:when>

                                        <c:when test="${cita.estado == 'Cancelado'}">
                                            <div class="alert alert-danger d-flex align-items-start justify-content-between w-100 mb-3 p-4" role="alert">
                                                <i class="bi bi-x-circle-fill me-3 fs-4"></i>
                                                <div class="col">
                                                    <strong class="fs-4">Cita Cancelada</strong><br>
                                                    ${cita.nombrePaciente} ${cita.apellidoPaciente} canceló su cita para el ${cita.diaReserva}.
                                                    <br>
                                                    <a class="fw-bold">${cita.horaReserva}</a>
                                                </div>
                                                <img class="ms-auto float-end" src="https://cdn-icons-png.flaticon.com/512/1436/1436388.png" width="60px">
                                            </div>
                                        </c:when>
                                    </c:choose>
                                </c:forEach>

                            </c:when > 
                        </c:choose>

                    </div>
                </div>
            </div>

            <!-- Agrega Bootstrap Icons a tu proyecto -->
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.min.css">

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
                    integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
    </body>

</html>