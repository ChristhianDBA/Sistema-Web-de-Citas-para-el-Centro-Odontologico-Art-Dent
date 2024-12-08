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
                <div>
                    <h3 style="color: darkblue; font-weight: bold;">Reportes</h3>
                </div>
                <br>
                <!-- Tabla de Reservas -->
                <!-- Botón para mostrar u ocultar la tabla -->
                <button id="toggleButton" class="btn btn-primary mb-3">Mostrar/Ocultar Reportes</button>

                <!-- Div que contiene la tabla -->
                <div id="tablaDiv" class="table-responsive flex-grow-1" style="display: none;">
                    <table class="table table-bordered p-4 text-center">
                        <thead class="table-primary text-center align-middle">
                            <tr>
                                <th>Mes</th>
                                <th>Reservas Completadas</th>
                                <th>Reservas En Espera</th>
                                <th>Reservas Reprogramadas</th>
                                <th>Reservas Confirmadas</th>
                                <th>Reservas Canceladas</th>
                                <th>Total de Reservas</th>
                                <th>Citas Completadas</th>                                 
                                <th>Citas En Espera</th>
                                <th>Citas Reprogramadas</th>
                                <th>Citas Confirmadas</th>
                                <th>Citas Canceladas</th>
                                <th>Total Citas</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="reporte" items="${reporteMensual}"> 
                                <tr>
                                    <td>${reporte.mes}</td>
                                    <td>${reporte.reservasCompletadas}</td>
                                    <td>${reporte.reservasEnEspera}</td>
                                    <td>${reporte.reservasReprogramadas}</td>
                                    <td>${reporte.reservasConfirmadas}</td>
                                    <td>${reporte.reservasCanceladas}</td>
                                    <td style="font-weight: bold;">${reporte.totalReservas}</td>
                                    <td>${reporte.citasCompletadas}</td>
                                    <td>${reporte.citasEnEspera}</td>
                                    <td>${reporte.citasReprogramadas}</td>
                                    <td>${reporte.citasConfirmadas}</td>
                                    <td>${reporte.citasCanceladas}</td>
                                    <td style="font-weight: bold;">${reporte.totalCitas}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="container mt-5">
                    <h5 class="text-center">Gráficos de Reservas y Citas</h5>
                    <div class="d-flex justify-content-around">
                        <!-- Gráfico de Barras -->
                        <div style="width: 45%;">
                            <h6 class="text-center">Gráfico de Barras - Total de Reservas y Citas</h6>
                            <canvas id="barChart"></canvas>
                        </div>
                        <!-- Gráfico Lineal -->
                        <div style="width: 45%;">
                            <h6 class="text-center">Gráfico Lineal - Comparación de Reservas y Citas</h6>
                            <canvas id="lineChart"></canvas>
                        </div>
                    </div>
                </div>

                <div class="container mt-5">
                    <h5 class="text-center">Gráfico de Atención al Cliente</h5>
                    <div class="d-flex justify-content-around">
                        <!-- Gráfico Circular -->
                        <div style="width: 45%;">
                            <h6 class="text-center">Proporción de Citas Atendidas y No Atendidas</h6>
                            <canvas id="pieChart"></canvas>
                        </div>
                        <!-- Gráfico de Línea para Citas -->
                        <div style="width: 45%;">
                            <h6 class="text-center">Tendencias de Citas</h6>
                            <canvas id="trendLineChart"></canvas>
                        </div>
                    </div>
                </div>





            </div>
        </div>


        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script>
            // Datos dinámicos desde el servidor
            const meses = [];
            const totalReservas = [];
            const totalCitas = [];

            <c:forEach var="reporte" items="${reporteMensual}">
            meses.push("${reporte.mes}");
            totalReservas.push(${reporte.totalReservas});
            totalCitas.push(${reporte.totalCitas});
            </c:forEach>;

            console.log("a:", meses);
            console.log("b:", totalReservas);
            console.log("c:", totalCitas);



            // Gráfico de Barras
            const ctxBar = document.getElementById('barChart').getContext('2d');
            new Chart(ctxBar, {
                type: 'bar',
                data: {
                    labels: meses,
                    datasets: [{
                            label: 'Total de Reservas',
                            data: totalReservas,
                            backgroundColor: 'rgba(75, 192, 192, 0.2)',
                            borderColor: 'rgba(75, 192, 192, 1)',
                            borderWidth: 1
                        }, {
                            label: 'Total de Citas',
                            data: totalCitas,
                            backgroundColor: 'rgba(153, 102, 255, 0.2)',
                            borderColor: 'rgba(153, 102, 255, 1)',
                            borderWidth: 1
                        }]
                },
                options: {
                    responsive: true,
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });

            // Gráfico Lineal
            const ctxLine = document.getElementById('lineChart').getContext('2d');
            new Chart(ctxLine, {
                type: 'line',
                data: {
                    labels: meses,
                    datasets: [{
                            label: 'Total de Reservas',
                            data: totalReservas,
                            borderColor: 'rgba(75, 192, 192, 1)',
                            fill: false
                        }, {
                            label: 'Total de Citas',
                            data: totalCitas,
                            borderColor: 'rgba(153, 102, 255, 1)',
                            fill: false
                        }]
                },
                options: {
                    responsive: true,
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });

            // Datos adicionales desde el servidor
            const citasCompletadas = [];
            const citasNoAtendidas = []; // Total de citas - Completadas
            const citasCanceladas = [];

            <c:forEach var="reporte" items="${reporteMensual}">
            citasCompletadas.push(${reporte.citasCompletadas});
            citasCanceladas.push(${reporte.citasCanceladas});
            citasNoAtendidas.push(${reporte.totalCitas} - ${reporte.citasCompletadas});
            </c:forEach>;

// Gráfico Circular (Pie Chart)
            const ctxPie = document.getElementById('pieChart').getContext('2d');
            new Chart(ctxPie, {
                type: 'pie',
                data: {
                    labels: ['Citas Atendidas', 'Citas No Atendidas'],
                    datasets: [{
                            data: [
                                citasCompletadas.reduce((a, b) => a + b, 0),
                                citasNoAtendidas.reduce((a, b) => a + b, 0)
                            ],
                            backgroundColor: ['rgba(75, 192, 192, 0.7)', 'rgba(255, 99, 132, 0.7)'],
                            hoverBackgroundColor: ['rgba(75, 192, 192, 1)', 'rgba(255, 99, 132, 1)']
                        }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: {
                            position: 'bottom'
                        }
                    }
                }
            });

// Gráfico de Línea para Tendencias
            const ctxTrendLine = document.getElementById('trendLineChart').getContext('2d');
            new Chart(ctxTrendLine, {
                type: 'line',
                data: {
                    labels: meses,
                    datasets: [
                        {
                            label: 'Citas Atendidas',
                            data: citasCompletadas,
                            borderColor: 'rgba(75, 192, 192, 1)',
                            fill: false
                        },
                        {
                            label: 'Citas No Atendidas',
                            data: citasNoAtendidas,
                            borderColor: 'rgba(255, 99, 132, 1)',
                            fill: false
                        },
                        {
                            label: 'Citas Canceladas',
                            data: citasCanceladas,
                            borderColor: 'rgba(255, 206, 86, 1)',
                            fill: false
                        }
                    ]
                },
                options: {
                    responsive: true,
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });

            // Datos dinámicos desde la base de datos
            const razones = [];
            const frecuencia = [];

            <c:forEach var="razon" items="${reporteNoCompletadas}">
            razones.push("${razon.descripcion}");
            frecuencia.push(${razon.cantidad});
            </c:forEach>;


// Gráfico de Razones para Servicios No Completados
            const ctxReason = document.getElementById('reasonChart').getContext('2d');
            new Chart(ctxReason, {
                type: 'bar',
                data: {
                    labels: razones,
                    datasets: [{
                            label: 'Frecuencia de No Asistencia',
                            data: frecuencia,
                            backgroundColor: 'rgba(255, 99, 132, 0.7)',
                            borderColor: 'rgba(255, 99, 132, 1)',
                            borderWidth: 1
                        }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: {
                            display: false
                        },
                        title: {
                            display: true,
                            text: 'Razones para Servicios No Completados'
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });

            // Datos dinámicos de estados desde el servidor
            const estados = ['Completadas', 'Canceladas', 'En Espera', 'Reprogramadas', 'No Asistieron'];
            const metricas = [
            ${reporteEstados.completadas},
            ${reporteEstados.canceladas},
            ${reporteEstados.enEspera},
            ${reporteEstados.reprogramadas},
            ${reporteEstados.noAsistieron}
            ];

// Gráfico de Métricas Clave (Circular)
            const ctxMetrics = document.getElementById('keyMetricsChart').getContext('2d');
            new Chart(ctxMetrics, {
                type: 'pie',
                data: {
                    labels: estados,
                    datasets: [{
                            data: metricas,
                            backgroundColor: [
                                'rgba(75, 192, 192, 0.7)',
                                'rgba(255, 99, 132, 0.7)',
                                'rgba(255, 206, 86, 0.7)',
                                'rgba(153, 102, 255, 0.7)',
                                'rgba(54, 162, 235, 0.7)'
                            ],
                            hoverBackgroundColor: [
                                'rgba(75, 192, 192, 1)',
                                'rgba(255, 99, 132, 1)',
                                'rgba(255, 206, 86, 1)',
                                'rgba(153, 102, 255, 1)',
                                'rgba(54, 162, 235, 1)'
                            ]
                        }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: {
                            position: 'bottom'
                        },
                        title: {
                            display: true,
                            text: 'Distribución de Estados de Citas'
                        }
                    }
                }
            });
            // Función para alternar la visibilidad


        </script>
        <script>const toggleButton = document.getElementById("toggleButton");
            const tablaDiv = document.getElementById("tablaDiv");

            toggleButton.addEventListener("click", function () {
                if (tablaDiv.style.display === "none") {
                    tablaDiv.style.display = "block"; // Mostrar la tabla
                } else {
                    tablaDiv.style.display = "none"; // Ocultar la tabla
                }
            });</script>
    </body>

</html>