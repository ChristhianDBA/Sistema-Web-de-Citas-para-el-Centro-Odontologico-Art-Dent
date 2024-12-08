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


            <!-- Contenido Principal -->
            <div class="container-fluid p-4 d-flex flex-column flex-grow-1 ">
                <br><br>
                <div>
                    <h3 style="color: darkblue; font-weight: bold;">Historial de Reservas</h3>
                </div>
                <br>

                <div class="d-flex justify-content-end mb-3">
                    <!-- Formulario para listar reservas -->
                    <form action="HistorialController" method="get">
                        <input type="hidden" name="accion" value="ListarHistorialReservas" />
                        <button type="submit" class="btn btn-info me-2" style="width: 150px;">Reservas</button>
                    </form>

                    <!-- Formulario para listar citas -->
                    <form action="HistorialController" method="get">
                        <input type="hidden" name="accion" value="ListarHistorialCitas" />
                        <button type="submit" class="btn btn-info" style="width: 150px;">Citas</button>
                    </form>
                </div>

                <!-- Tabla de Reservas -->
                <div class="table-responsive flex-grow-1">
                    <table class="table table-bordered p-4">
                        <thead class="table-primary text-center align-middle">
                            <tr>
                                <th>Paciente</th>
                                <th>Fecha de Cita</th>
                                <th>Estado</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${tipoLista == 'hisRe'}">
                                    <c:forEach var="reserva" items="${VerReserva}">
                                        <tr class="text-center align-middle">          
                                            <td>${reserva.nombrePaciente} ${reserva.apellidoPaciente}</td>
                                            <td>${reserva.diaReserva}</td>
                                            <td>${reserva.estado}</td>
                                            <td class="d-flex justify-content-center">
                                                <form action="HistorialController" method="get">
                                                    <input type="hidden" name="id" value="${reserva.idReserva}" />
                                                    <input type="hidden" name="accion" value="VerDetalleRe" />
                                                    <button class="btn btn-gold p-2 px-4 text-dark">Ver Detalles</button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:when test="${tipoLista == 'hisCi'}">
                                    <c:forEach var="cita" items="${VerCita}">
                                        <tr class="text-center align-middle">          
                                            <td>${cita.nombrePaciente} ${cita.apellidoPaciente}</td>
                                            <td>${cita.diaReserva}</td>
                                            <td>${cita.estado}</td>
                                            <td class="d-flex justify-content-center">
                                                <form action="HistorialController" method="get">
                                                    <input type="hidden" name="id" value="${cita.idCita}" />
                                                    <input type="hidden" name="accion" value="VerDetalleCi" />
                                                    <button class="btn btn-gold p-2 px-4 text-dark" data-bs-toggle="modal" data-bs-target="#ModalDet">Ver Detalles</button>
                                                </form>
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