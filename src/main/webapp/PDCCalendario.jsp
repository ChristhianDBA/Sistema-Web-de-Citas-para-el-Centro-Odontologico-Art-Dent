<%@page import="pe.edu.utp.entity.VerReserva"%>
<%@ page import="java.util.Map" %>
<%@ page import="pe.edu.utp.components.DiasNumericosDeLaSemana" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="java.time.LocalDate, java.time.format.DateTimeFormatter, java.util.Locale" %>
<%@ page import="java.time.temporal.WeekFields" %>
<%
    Integer semanaActual = (Integer) request.getAttribute("semanaActual");
    if (semanaActual == null) {
        semanaActual = LocalDate.now().get(WeekFields.of(Locale.getDefault()).weekOfYear());
    }
    LocalDate inicioSemana = LocalDate.now()
            .with(WeekFields.of(Locale.getDefault()).weekOfYear(), semanaActual)
            .with(WeekFields.of(Locale.getDefault()).dayOfWeek(), 1);
    LocalDate finSemana = inicioSemana.plusDays(6);
    Locale localeEspañol = new Locale("es", "ES");
    DateTimeFormatter formatoMes = DateTimeFormatter.ofPattern("MMMM", localeEspañol);

    String mesInicio = inicioSemana.format(formatoMes);

    mesInicio = mesInicio.substring(0, 1).toUpperCase() + mesInicio.substring(1);
    int x = inicioSemana.getDayOfMonth() + 1;
%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Panel de Control - Clínica</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.min.css">
        <style>
            /* Estilos CSS */
            .calendar-wrap {
                container: calendar;
            }

            .calendar {
                --dayHeaderHeight: 75px;
                --hourHeight: 50px;

                display: flex;

                .hours {
                    > ol > li:first-of-type {
                        margin-block-start: var(--dayHeaderHeight);
                    }
                    > ol > li {
                        block-size: var(--hourHeight);
                    }
                    white-space: nowrap;
                    border-inline-end: 1px solid var(--gray);
                    .day-time {
                        padding-block: 0.25rem;
                        padding-inline-end: 0.5rem;
                        border-block-start: 1px solid var(--gray);
                    }
                }

                .days {
                    width: 100%;
                }

                .day-number {
                    font-weight: 300;
                    font-size: 2rem;
                }
                .day-name {
                    text-transform: uppercase;
                    font-weight: 500;
                }

                .events {
                    display: flex;
                    width: 100%;

                    .day-of-events {
                        flex: 1;
                        padding-inline: 0.75rem;
                        display: grid;
                        grid-template-rows: var(--dayHeaderHeight) repeat(48, calc(var(--hourHeight) / 4)); /* 30 minutos */
                        grid-template-columns: 1fr;
                        border-inline-end: 1px solid var(--gray);

                        & dt {
                            grid-row: 1;
                        }
                    }

                    .event {
                        --gray: #555;
                        grid-row: var(--row) / span var(--span, 1);
                        border: 1px solid var(--gray);
                        border-radius: 3px;
                        padding: 0.5rem;
                    }
                }
            }

            /* Container Queries */
            @container calendar (max-width: 690px) {
                .calendar {
                    display: block;
                }
                .hours {
                    display: none;
                }
                .events {
                    display: block;

                    .day-of-events {
                        border: 0;
                        grid-template-columns: 75px 1fr;
                        grid-template-rows: auto;
                        gap: 0.75rem;
                        margin-block-end: 2rem;
                        .event {
                            grid-column: 2;
                            grid-row: auto;
                        }
                    }
                }
            }

            @container calendar (max-width: 350px) {
                .events {
                    .day-of-events {
                        display: block;
                        .event {
                            margin-block-end: 0.25rem;
                        }
                        & dt {
                            display: flex;
                            margin-block-end: 0.25rem;

                            .day-number {
                                font-size: 1.2rem;
                                font-weight: 800;
                                margin-inline-end: 0.25rem;
                            }
                            .day-name {
                                font-size: 1.2rem;
                            }
                        }
                    }
                }
            }

            .info-panel {
                padding: 1rem 2rem;
                container: InfoPanel / inline-size;

                & h1 {
                    font-size: max(7cqi, 24px);
                }
            }

            split-panel {
                background: white;
                padding: 1rem 0.5rem;
            }

            @layer reset {
                * {
                    box-sizing: border-box;
                }
                ol,
                ul,
                dl {
                    list-style: none;
                    padding: 0;
                    margin: 0;
                }
                dd {
                    margin: 0;
                }
                h1 {
                    line-height: 1.1;
                }
            }
        </style>
    </head>
    <body class="d-flex flex-column min-vh-100">
        <%@include file="NavPanel.jsp" %>

        <div class="d-flex flex-grow-1">
            <%@include file="Sidebar.jsp" %>

            <div class="content container-fluid p-4">
                <h3 style="color: darkblue; font-weight: bold;">Calendario de Citas</h3>
                <div class="calendar-controls d-flex justify-content-between align-items-center pb-4 pt-2">
                    <div class="">
                        <span><%= inicioSemana.getYear()%></span><br>
                        <span>Semana: <%= semanaActual%> - Del <%= x%> al <%= finSemana.getDayOfMonth() + 1%> de <%= mesInicio%></span>
                    </div>
                    <div class="d-flex align-items-center">
                        <a class="btn btn-outline-primary me-2" href="#">Hoy</a>
                        <a class="btn btn-primary me-1" href="ReservaController?accion=semanaAnterior"><i class="bi bi-arrow-left"></i></a>
                        <a class="btn btn-primary" href="ReservaController?accion=semanaSiguiente"><i class="bi bi-arrow-right"></i></a>

                    </div>
                </div>

                <div class="calendar-wrap">
                    <div class="calendar">
                        <div class="hours">
                            <ol>
                                <li><div class="day-time">8 a.m.</div></li>
                                <li><div class="day-time">9 a.m.</div></li>
                                <li><div class="day-time">10 a.m.</div></li>
                                <li><div class="day-time">11 a.m.</div></li>
                                <li><div class="day-time">12 p.m.</div></li>
                                <li><div class="day-time">1 p.m.</div></li>
                                <li><div class="day-time">2 p.m.</div></li>
                                <li><div class="day-time">3 p.m.</div></li>
                                <li><div class="day-time">4 p.m.</div></li>
                                <li><div class="day-time">5 p.m.</div></li>
                                <li><div class="day-time">6 p.m.</div></li>
                                <li><div class="day-time">7 p.m.</div></li>
                                <li><div class="day-time">8 p.m.</div></li>
                                <li><div class="day-time">9 p.m.</div></li>
                                <li><div class="day-time">10 p.m.</div></li>
                            </ol>
                        </div>
                        <dl class="events">
                            <%
                                try {
                                    DiasNumericosDeLaSemana dias = new DiasNumericosDeLaSemana();

                                    Map<Integer, Integer> diasNumericos = dias.obtenerDiasNumericosDeEstaSemana(x);
                                    int contador = 1;
                            %>



                            <c:set var="nombresDias" value="Lunes,Martes,Miércoles,Jueves,Viernes,Sábado,Domingo" />
                            <c:forEach var="dia" items="${fn:split(nombresDias, ',')}" varStatus="status">
                                <div class="day-of-events" data-day="${dia}">
                                    <dt>
                                        <div class="day-number">
                                            <%= diasNumericos.get(contador)%>
                                        </div>
                                        <div class="day-name">${dia}</div>
                                    </dt>

                                    <!-- Mostrar Reservas -->
                                    <c:if test="${not empty reservasPorDia[dia]}">
                                        <c:forEach var="reserva" items="${reservasPorDia[dia]}">
                                            <c:set var="horaReserva" value="${reserva.horaReserva}" />
                                            <c:set var="row" value="${reserva.orden_row}" />
                                            <c:set var="color" value="${reserva.color}" />
                                            <dd class="event reserva-event" style="--row: ${row}; --span: 7; background-color: ${color}; color: white; font-weight: bold; cursor: pointer;"
                                                data-bs-toggle="modal" data-bs-target="#reservaModal"
                                                data-id="${reserva.idReserva}"
                                                data-tipo="reserva"
                                                data-hora="${horaReserva}"
                                                data-servicio="${reserva.tipoServicio}"
                                                data-paciente="${reserva.nombrePaciente} ${reserva.apellidoPaciente}"
                                                data-odontologo="${reserva.nombreUsuario} ${reserva.apellidoUsuario}"
                                                data-estado="${reserva.estado}"
                                                data-importe="${reserva.importe}"
                                                data-descripcion="${reserva.descripcion}">
                                                <time>${horaReserva}</time>
                                                <div class="event-title">${reserva.tipoServicio}</div>
                                            </dd>
                                        </c:forEach>
                                    </c:if>

                                    <!-- Mostrar Citas -->
                                    <c:if test="${not empty citasPorDia[dia]}">
                                        <c:forEach var="cita" items="${citasPorDia[dia]}">
                                            <c:set var="horaCita" value="${cita.horaReserva}" />
                                            <c:set var="row" value="${cita.orden_row}" />
                                            <c:set var="color" value="${cita.color}" />
                                            <dd class="event cita-event" style="--row: ${row}; --span: 7; background-color: ${color}; color: white; font-weight: bold; cursor: pointer;"
                                                data-bs-toggle="modal" data-bs-target="#citaModal"
                                                data-id="${cita.idCita}"
                                                data-tipo="cita"
                                                data-hora="${horaCita}"
                                                data-servicio="${cita.tipoServicio}"
                                                data-paciente="${cita.nombrePaciente} ${cita.apellidoPaciente}"
                                                data-odontologo="${cita.nombreUsuario} ${cita.apellidoUsuario}"
                                                data-estado="${cita.estado}"
                                                data-costo="${cita.costo}">
                                                <time>${horaCita}</time>
                                                <div class="event-title">${cita.tipoServicio}</div>
                                            </dd>
                                        </c:forEach>
                                    </c:if>

                                </div>
                                <%
                                    contador++; // Incrementar el contador para el siguiente día
                                %>
                            </c:forEach>

                            <%
                                } catch (Exception e) {
                                    out.println("Error: " + e.getMessage());
                                }
                            %>
                        </dl>
                    </div>
                </div>
                <!-- Modal para Reservas -->
                <div class="modal fade" id="reservaModal" tabindex="-1" aria-labelledby="reservaModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="reservaModalLabel">Detalles de la Reserva</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <p><strong>ID:</strong> <span id="reservaId"></span></p>
                                <p><strong>Hora:</strong> <span id="reservaHora"></span></p>
                                <p><strong>Servicio:</strong> <span id="reservaServicio"></span></p>
                                <p><strong>Paciente:</strong> <span id="reservaPaciente"></span></p>
                                <p><strong>Odontólogo:</strong> <span id="reservaOdontologo"></span></p>
                                <p><strong>Estado:</strong> <span id="reservaEstado"></span></p>
                                <p><strong>Importe:</strong> <span id="reservaImporte"></span></p>
                                <p><strong>Descripción:</strong> <span id="reservaDescripcion"></span></p>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Modal para Citas -->
                <div class="modal fade" id="citaModal" tabindex="-1" aria-labelledby="citaModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="citaModalLabel">Detalles de la Cita</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <p><strong>ID:</strong> <span id="citaId"></span></p>
                                <p><strong>Hora:</strong> <span id="citaHora"></span></p>
                                <p><strong>Servicio:</strong> <span id="citaServicio"></span></p>
                                <p><strong>Paciente:</strong> <span id="citaPaciente"></span></p>
                                <p><strong>Odontólogo:</strong> <span id="citaOdontologo"></span></p>
                                <p><strong>Estado:</strong> <span id="citaEstado"></span></p>
                                <p><strong>Importe:</strong> <span id="citaCosto"></span></p>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                document.querySelectorAll('.reserva-event').forEach(function (element) {
                    element.addEventListener('click', function () {
                        var modal = document.getElementById('reservaModal');
                        modal.querySelector('#reservaId').textContent = this.dataset.id;
                        modal.querySelector('#reservaHora').textContent = this.dataset.hora;
                        modal.querySelector('#reservaServicio').textContent = this.dataset.servicio;
                        modal.querySelector('#reservaPaciente').textContent = this.dataset.paciente;
                        modal.querySelector('#reservaOdontologo').textContent = this.dataset.odontologo;
                        modal.querySelector('#reservaEstado').textContent = this.dataset.estado;
                        modal.querySelector('#reservaImporte').textContent = this.dataset.importe;
                        modal.querySelector('#reservaDescripcion').textContent = this.dataset.descripcion;
                    });
                });

                // Manejar clics en eventos de cita
                document.querySelectorAll('.cita-event').forEach(function (element) {
                    element.addEventListener('click', function () {
                        var modal = document.getElementById('citaModal');
                        modal.querySelector('#citaId').textContent = this.dataset.id;
                        modal.querySelector('#citaHora').textContent = this.dataset.hora;
                        modal.querySelector('#citaServicio').textContent = this.dataset.servicio;
                        modal.querySelector('#citaPaciente').textContent = this.dataset.paciente;
                        modal.querySelector('#citaOdontologo').textContent = this.dataset.odontologo;
                        modal.querySelector('#citaEstado').textContent = this.dataset.estado;
                        modal.querySelector('#citaCosto').textContent = this.dataset.costo;
                    });
                });
            });
        </script>
    </body>
</html>
