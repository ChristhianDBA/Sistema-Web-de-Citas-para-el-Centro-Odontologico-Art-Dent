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
            <!-- Sidebar -->
            <%@include file="Sidebar.jsp" %>


            <div class="container p-3 d-flex flex-column flex-grow-1">
                <br><br>
                <div>
                    <h3 style="color: darkblue; font-weight: bold;">Reprogramar Fecha y Hora</h3>
                </div>
                <br>
                <c:choose>
                    <c:when test="${tipoLista == 'DetRe'}">
                        <div class="d-flex justify-content-end">
                            <form action="ReservaController" method="get">
                                <input type="hidden" name="accion" value="listar" />
                                <button class="btn btn-gold pt-2 px-4 mb-3" id="edtInfo">Cancelar</button>
                            </form>
                        </div>
                        <table class="table table-bordered border-gray table-hover  table-responsive" id="">
                            <tr>
                                <th class="text-dark p-3 bg-info-subtle">ID Reserva</th>
                                <td>${VerReserva[0].idReserva}</td>
                            </tr>
                            <tr>
                                <th class="text-dark p-3 bg-info-subtle">Nombres del Paciente</th>
                                <td>${VerReserva[0].nombrePaciente}</td>
                            </tr>
                            <tr>
                                <th class="text-dark p-3 bg-info-subtle" >Apellidos del Paciente</th>
                                <td>${VerReserva[0].apellidoPaciente}</td>
                            </tr>
                            <tr>
                                <th class="text-dark p-3 bg-info-subtle" >Fecha de Reserva</th>
                                <td>${VerReserva[0].diaReserva}</td>
                            </tr>
                            <tr>
                                <th class="text-dark p-3 bg-info-subtle" >Hora de Reserva</th>
                                <td>${VerReserva[0].horaReserva}</td>
                            </tr>
                            <tr>
                                <th class="text-dark p-3 bg-info-subtle" >Descripción</th>
                                <td>${VerReserva[0].descripcion}</td>
                            </tr>
                            <tr>
                                <th class="text-dark p-3 bg-info-subtle" >Servicio</th>
                                <td>${VerReserva[0].tipoServicio}</td>
                            </tr>
                            <tr>
                                <th class="text-dark p-3 bg-info-subtle" >Médico Asignado</th>
                                <td>${VerReserva[0].nombreUsuario} ${VerReserva[0].apellidoUsuario}</td>
                            </tr>
                            <tr>
                                <th class="text-dark p-3 bg-info-subtle" style="background-color: #CFE2FF;">Estado de la Reserva</th>
                                <td>${VerReserva[0].estado}</td>
                            </tr>
                        </table>
                        <h3 class="mt-2">Nueva Fecha y Hora:</h3>

                        <form class="d-flex flex-grow-3" method="post" action="ReprogramacionController">
                            <input type="hidden" name="idReserva" value="${VerReserva[0].idReserva}"> 
                            <div class="mb-3 d-grid me-4">
                                <label for="new-date" class="form-label">Nueva Fecha:</label>
                                <input type="date" class="form-control" id="new-date" name="new-date" required>
                            </div>

                            <div class="mb-3 me-4">
                                <label for="new-time" class="form-label">Nueva Hora:</label>
                                <input type="time" class="form-control" id="new-time" name="new-time" required>
                            </div>
                            <div>
                                <button type="submit" class="btn btn-success mt-4" name="accion" value="UpdateReserva">Confirmar reprogramación</button>
                            </div>
                        </form>


                    </c:when>

                    <c:when test="${tipoLista == 'DetCi'}">
                        <div class="d-flex justify-content-end">
                            <form action="ReservaController" method="get">
                                <input type="hidden" name="accion" value="listarCitas" />
                                <button class="btn btn-gold p-2 px-4 mb-4" id="edtInfo">Cancelar</button>
                            </form>
                        </div>
                        <table class="table table-hover table-bordered border-gray table-responsive" id="">
                            <tr>
                                <th class="text-dark p-3 bg-info-subtle" style="width: 50%;">ID Cita</th>
                                <td style="width: 50%;">${VerCita[0].idCita}</td>
                            </tr>
                            <tr>
                                <th class="text-dark p-3 bg-info-subtle">Nombres del Paciente</th>
                                <td>${VerCita[0].nombrePaciente}</td>
                            </tr>
                            <tr>
                                <th class="text-dark p-3 bg-info-subtle">Apellidos del Paciente</th>
                                <td>${VerCita[0].apellidoPaciente}</td>
                            </tr>
                            <tr>
                                <th class="text-dark p-3 bg-info-subtle">Fecha de Cita</th>
                                <td>${VerCita[0].diaReserva}</td>
                            </tr>
                            <tr>
                                <th class="text-dark p-3 bg-info-subtle">Hora de Cita</th>
                                <td>${VerCita[0].horaReserva}</td>
                            </tr>
                            <tr>
                                <th class="text-dark p-3 bg-info-subtle">Servicio</th>
                                <td>${VerCita[0].tipoServicio}</td>
                            </tr>
                            <tr>
                                <th class="text-dark p-3 bg-info-subtle">Estado de la Cita</th>
                                <td>${VerCita[0].estado}</td>
                            </tr>
                        </table>
                        <h3 class="mt-2">Nueva Fecha y Hora:</h3>

                        <form class="d-flex flex-grow-3" method="post" action="ReprogramacionController">
                            <input type="hidden" name="idCita" value="${VerCita[0].idCita}"> 
                            <div class="mb-3 d-grid me-4">
                                <label for="new-date" class="form-label">Nueva Fecha:</label>
                                <input type="date" class="form-control" id="new-date" name="new-date" required>
                            </div>

                            <div class="mb-3 me-4">
                                <label for="new-time" class="form-label">Nueva Hora:</label>
                                <input type="time" class="form-control" id="new-time" name="new-time" required>
                            </div>
                            <div>
                                <button type="submit" class="btn btn-success mt-4" name="accion" value="UpdateCita">Confirmar reprogramación</button>
                            </div>
                        </form>

                    </c:when>
                </c:choose>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    </body>
</html>
