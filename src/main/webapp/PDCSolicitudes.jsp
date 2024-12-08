<%//@include file="WEB-INF/template/libreria.jspf" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Panel de Control - Clínica</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
        <style>
            .btn-gold {
                background-color: #F1D045 !important;
                color: black !important;
                border: none !important;
            }

            .btn-gold:hover {
                background-color: #e5c100 !important;
                color: white !important;
            }

        </style>
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

            <%@include file="Sidebar.jsp" %>

            <!-- Contenido Principal -->
            <div class="container-fluid p-4 d-flex flex-column flex-grow-1 ">
                <br><br>
                <div>
                    <h3 style="color:darkblue; font-weight: bold;">Solicitudes de Reserva y Citas</h3>
                    <p>Aqui se muestran las solicitudes de reserva y citas pendientes de los usuarios</p>
                </div>
                <br>

                <div class="d-flex justify-content-end mb-3">
                    <!-- Formulario para listar reservas -->
                    <form action="ReservaController" method="get">
                        <input type="hidden" name="accion" value="listar" />
                        <button type="submit" class="btn btn-info me-2" style="width: 150px;">Reservas</button>
                    </form>

                    <!-- Formulario para listar citas -->
                    <form action="ReservaController" method="get">
                        <input type="hidden" name="accion" value="listarCitas" />
                        <button type="submit" class="btn btn-info" style="width: 150px;">Citas</button>
                    </form>
                </div>

                <!-- Tabla de Reservas/Citas -->
                <div class="table-responsive flex-grow-1">
                    <table class="table table-bordered p-4">
                        <thead class="table-primary text-center align-middle">
                            <tr>
                                <th>Paciente</th>
                                <th>Fecha y Hora Solicitada</th>
                                <th>Tipo de Servicio</th>
                                <th>Estado</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${tipoLista == 'reserva'}">
                                    <c:forEach var="reserva" items="${VerReserva}">
                                        <tr class="text-center align-middle">
                                            <td>${reserva.nombrePaciente} ${reserva.apellidoPaciente}</td>
                                            <td>${reserva.diaReserva} --- ${reserva.horaReserva}</td>
                                            <td>${reserva.tipoServicio}</td>
                                            <td>${reserva.estado}</td>
                                            <td class="d-flex justify-content-center">
                                                <c:choose>
                                                    <c:when test="${reserva.estado == 'Cancelado'}">
                                                        <form action="ReprogramacionController" method="post">
                                                            <input type="hidden" name="idReserva" value="${reserva.idReserva}" />
                                                            <input type="hidden" name="accion" value="deleteReserva" />
                                                            <button class="btn btn-danger" style="width: 115px;" type="submit">Eliminar</button>
                                                        </form>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:choose>
                                                            <c:when test="${reserva.estado == 'En espera' || reserva.estado == 'Reprogramado'}">
                                                                <form action="ReprogramacionController" method="post">
                                                                    <input type="hidden" name="idReserva" value="${reserva.idReserva}" />
                                                                    <input type="hidden" name="estado" value="${reserva.estado}" />
                                                                    <input type="hidden" name="accion" value="updateEstadoConfirmar" />
                                                                    <button class="btn btn-primary" style="width: 115px;" type="submit">Confirmar</button>
                                                                </form>
                                                            </c:when>
                                                            <c:when test="${reserva.estado == 'Confirmado'}">
                                                                <form action="ReprogramacionController" method="post">
                                                                    <input type="hidden" name="idReserva" value="${reserva.idReserva}" />
                                                                    <input type="hidden" name="estado" value="${reserva.estado}" />
                                                                    <input type="hidden" name="accion" value="updateEstadoCompletado" />
                                                                    <button class="btn btn-gold" type="submit">Completado</button>
                                                                </form>
                                                            </c:when>
                                                        </c:choose>
                                                        <form action="ReprogramacionController" method="get">
                                                            <input type="hidden" name="id" value="${reserva.idReserva}" />
                                                            <input type="hidden" name="accion" value="VerReproRe" />
                                                            <button class="btn btn-info ms-3" style="height: 40px;" type="submit">Reprogramar</button>
                                                        </form>
                                                        <form action="ReprogramacionController" method="post">
                                                            <input type="hidden" name="idReserva" value="${reserva.idReserva}" />
                                                            <input type="hidden" name="accion" value="updateEstadoCancelar" />
                                                            <button class="btn btn-success ms-3" style="width: 115px;" type="submit">Cancelar</button>
                                                        </form>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>

                                <c:when test="${tipoLista == 'cita'}">
                                    <c:forEach var="cita" items="${VerCita}">
                                        <tr class="text-center align-middle">
                                            <td>${cita.nombrePaciente} ${cita.apellidoPaciente}</td>
                                            <td>${cita.diaReserva} --- ${cita.horaReserva}</td>
                                            <td>${cita.tipoServicio}</td>
                                            <td>${cita.estado}</td>
                                            <td class="d-flex justify-content-center">
                                                <c:choose>
                                                    <c:when test="${cita.estado == 'Cancelado'}">
                                                        <form action="ReprogramacionController" method="post">
                                                            <input type="hidden" name="idCita" value="${cita.idCita}" />
                                                            <input type="hidden" name="accion" value="deleteCita" />
                                                            <button class="btn btn-danger" style="width: 115px;" type="submit">Eliminar</button>
                                                        </form>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:choose>
                                                            <c:when test="${cita.estado == 'En espera' || cita.estado == 'Reprogramado'}">
                                                                <form action="ReprogramacionController" method="post">
                                                                    <input type="hidden" name="idCita" value="${cita.idCita}" />
                                                                    <input type="hidden" name="estado" value="${cita.estado}" />
                                                                    <input type="hidden" name="accion" value="updateEstadoConfirmarCita" />
                                                                    <button class="btn btn-primary" style="width: 115px;" type="submit">Confirmar</button>
                                                                </form>
                                                            </c:when>
                                                            <c:when test="${cita.estado == 'Confirmado'}">
                                                                <form action="ReprogramacionController" method="post">
                                                                    <input type="hidden" name="idCita" value="${cita.idCita}" />
                                                                    <input type="hidden" name="estado" value="${cita.estado}" />
                                                                    <input type="hidden" name="accion" value="updateEstadoCompletadoCita" />
                                                                    <button class="btn btn-gold" type="submit">Completado</button>
                                                                </form>
                                                            </c:when>
                                                        </c:choose>
                                                        <form action="ReprogramacionController" method="get">
                                                            <input type="hidden" name="id" value="${cita.idCita}" />
                                                            <input type="hidden" name="accion" value="VerReproCi" />
                                                            <button class="btn btn-info ms-3" style="height: 40px;" type="submit">Reprogramar</button>
                                                        </form>
                                                        <form action="ReprogramacionController" method="post">
                                                            <input type="hidden" name="idCita" value="${cita.idCita}" />
                                                            <input type="hidden" name="accion" value="updateEstadoCanceladoCita" />
                                                            <button class="btn btn-success ms-3" style="width: 115px;" type="submit">Cancelar</button>
                                                        </form>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>

                                <c:otherwise>
                                    <tr>
                                        <td colspan="5" class="text-center">No hay datos disponibles</td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>

            </div>

        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    </body>
</html>
