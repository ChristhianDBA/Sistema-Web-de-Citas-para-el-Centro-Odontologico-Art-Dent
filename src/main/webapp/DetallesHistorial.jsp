<%//@include file="WEB-INF/template/libreria.jspf" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Detalles</title>
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
            .border-gray{
               border-color: #B4BFCD; 
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
            <div class=" text-white p-4 d-flex flex-column " style="width: 400px; background:#2E3E50;">
                <ul class="nav flex-column " style="margin-top: 60px;">
                    <li class="nav-item mb-2 pt-4 border-bottom">
                        <a class="nav-link text-white " href="ReservaController?accion=listar">Solicitudes</a>
                    </li>
                    <li class="nav-item mb-2 pt-4 border-bottom" style="margin-top: 30px;">
                        <a class="nav-link text-white " href="PDCCalendario.jsp">Calendario de citas</a>
                    </li>
                    <li class="nav-item mb-2 pt-4 border-bottom" style="margin-top: 30px;">
                        <a class="nav-link text-white " href="HistorialController?accion=ListarHistorialReservas">Historial</a>
                    </li>
                    <li class="nav-item mb-2 pt-4 border-bottom" style="margin-top: 30px;">
                        <a class="nav-link text-white " href="PDCNotificaciones.jsp">Notificaciones</a>
                    </li>
                    <li class="nav-item mb-2 pt-4 border-bottom"style="margin-top: 30px;">
                        <a class="nav-link text-white " href="PDCReportes.jsp">Reportes</a>
                    </li>
                </ul>

                <!-- Botón de Salir en la parte inferior -->
                <a class="nav-link text-white mt-auto border-top p-2 px-4 text-center" href="iniciosesion.html">Salir</a>
            </div>

            <div class="container p-4 d-flex flex-column flex-grow-1">
                <br><br>
                <div>
                    <h3 style="color: darkblue; font-weight: bold;">Detalles</h3>
                </div>
                <br>
                <c:choose>
                    <c:when test="${tipoLista == 'DetRe'}">
                        <div class="d-flex justify-content-end">
                            <form action="HistorialController" method="get">
                                <input type="hidden" name="accion" value="ListarHistorialReservas" />
                                <button class="btn btn-gold p-2 mb-4" id="edtInfo">Regresar</button>
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
                    </c:when>

                    <c:when test="${tipoLista == 'DetCi'}">
                        <div class="d-flex justify-content-end">
                            <form action="HistorialController" method="get">
                                <input type="hidden" name="accion" value="ListarHistorialCitas" />
                                <button class="btn btn-gold p-2 mb-4" id="edtInfo">Regresar</button>
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
                    </c:when>
                </c:choose>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    </body>

</html>
