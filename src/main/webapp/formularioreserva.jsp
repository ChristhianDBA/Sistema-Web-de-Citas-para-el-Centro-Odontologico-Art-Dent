<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    HttpSession sesion = request.getSession(false);
    Integer idUser = (Integer) sesion.getAttribute("idUsuario");
%>
<body class="d-flex flex-column min-vh-100">

    <div class="container flex-grow-1">
        <br>
        <h1 style="color: darkblue" class="text-center mb-4">Reservar cita</h1>
        <p class="text-center">Nuestros clientes son importantes para nosotros, por lo que ahora pueden generar una
            reserva de cita y pagarlo online.</p>
        <div class="mx-auto bg-white p-4 rounded shadow-sm mt-4">
            <form action="ReservaController" method="POST">
                <input type="hidden" name="idUsuario" id="idUsuario" value="<%= idUser%>">
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="nombre" class="form-label">Nombre</label>
                        <input type="text" class="form-control" id="nombre" name="nombre" placeholder="Ingrese su nombre" required>
                    </div>
                    <div class="col-md-6">
                        <label for="apellido" class="form-label">Apellido</label>
                        <input type="text" class="form-control" id="apellido" name="apellido" placeholder="Ingrese su apellido" required>
                    </div>
                </div>
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="dni" class="form-label">DNI</label>
                        <input type="text" class="form-control" id="dni" name="dni" placeholder="Ingrese su DNI" minlength="8" maxlength="8" pattern="\d{8}" required>
                    </div>
                    <div class="col-md-6">
                        <label for="telefono" class="form-label">Celular</label>
                        <input type="tel" class="form-control" id="telefono" name="telefono" placeholder="Ingrese su celular" minlength="9" maxlength="9" pattern="\d{9}" required>
                    </div>
                </div>
                <div class="mb-3">
                    <label for="email" class="form-label">Correo electrónico</label>
                    <input type="email" class="form-control" id="email" name="email" placeholder="Ingrese su correo electrónico" required>
                </div>
                <div class="mb-3">
                    <label for="motivo" class="form-label">Motivo (Servicio)</label>
                    <select class="form-select" id="motivo" name="motivo" onchange="actualizarPrecio()" required>
                        <option value="">Seleccionar</option>
                        <%@page import="java.sql.*"%>
                        <%@page import="pe.edu.utp.config.Conexion"%>
                        <%
                            Connection conn2 = null;
                            Statement stmt2 = null;
                            ResultSet rs2 = null;
                            try {
                                conn2 = Conexion.getConection();
                                String sql2 = "SELECT idServicio, TipoServicio, Costo FROM servicio";
                                stmt2 = conn2.createStatement();
                                rs2 = stmt2.executeQuery(sql2);
                                while (rs2.next()) {
                        %>
                        <option value="<%= rs2.getString("TipoServicio")%>" data-costo="<%= rs2.getDouble("Costo")%>" data-id="<%= rs2.getInt("idServicio")%>">
                            <%= rs2.getString("TipoServicio")%>
                        </option>
                        <%
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                                out.println("<p>Error al cargar los servicios: " + e.getMessage() + "</p>");
                            }
                        %>
                    </select>
                </div>

                <input type="hidden" name="precio_consulta" id="precio_consulta">
                <input type="hidden" name="idServicio" id="idServicio">

                <div class="mb-3">
                    <label for="pago" class="form-label">Total a pagar</label>
                    <input type="number" class="form-control" id="pago" name="pago" readonly required>
                </div>
                <div class="mb-3">
                    
                    <label for="medico" class="form-label">Médico Asignado</label>
                    <select class="form-select" id="medico" name="medico">
                        <%
                            Connection conn = null;
                            Statement stmt = null;
                            ResultSet rs = null;
                            try {
                                conn = Conexion.getConection();
                                String sql = "SELECT * FROM usuario WHERE Rol_idRol = 3";
                                stmt = conn.createStatement();
                                rs = stmt.executeQuery(sql);
                                while (rs.next()) {
                        %>
                        <option value="dr_mendoza"><%=rs.getString("Apellido") +", " + rs.getString("Nombre")%></option>
                        <!-- Agrega más opciones si es necesario -->
                        <%
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                                out.println("<p>Error al cargar los Doctores Disponibles " + e.getMessage() + "</p>");
                            }
                        %>
                    </select>
                </div>
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="fecha" class="form-label">Fecha de la reserva</label>
                        <input type="date" class="form-control" id="fecha" name="fecha" required>
                    </div>
                    <div class="col-md-6">
                        <label for="hora" class="form-label">Hora de la reserva</label>
                        <input type="time" class="form-control" id="hora" name="hora" required>
                    </div>
                </div>
                <div class="mb-3">
                    <label for="descripcion" class="form-label">Descripción</label>
                    <textarea class="form-control" id="descripcion" name="descripcion" rows="3" placeholder="Agregue una descripción"></textarea>
                </div>
                <div class="form-check mb-3">
                    <input class="form-check-input" type="checkbox" id="aceptar-condiciones" name="aceptar-condiciones" required>
                    <label class="form-check-label" for="aceptar-condiciones">
                        Acepto los términos y condiciones en línea
                    </label>
                </div>

                <button type="submit" class="btn btn-success w-100">Reservar y Pagar</button>
            </form>
        </div>

        <script>
            // Función para actualizar el precio y los campos ocultos automáticamente
            function actualizarPrecio() {
                const motivoSelect = document.getElementById("motivo");
                const selectedOption = motivoSelect.options[motivoSelect.selectedIndex];
                const costo = selectedOption.getAttribute("data-costo");
                const idServicio = selectedOption.getAttribute("data-id");
                const pagoField = document.getElementById("pago");
                const precioConsultaField = document.getElementById("precio_consulta");
                const idServicioField = document.getElementById("idServicio");

                // Asignar precio y id solo si se ha seleccionado un servicio válido
                if (costo) {
                    pagoField.value = parseFloat(costo).toFixed(2);
                    precioConsultaField.value = costo; // Actualiza el campo oculto
                    idServicioField.value = idServicio; // Actualiza el campo oculto
                } else {
                    pagoField.value = ""; // Vaciar el campo si no se ha seleccionado un motivo válido
                    precioConsultaField.value = ""; // Vaciar el campo oculto
                    idServicioField.value = ""; // Vaciar el campo oculto
                }
                
                
            }
        </script>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
