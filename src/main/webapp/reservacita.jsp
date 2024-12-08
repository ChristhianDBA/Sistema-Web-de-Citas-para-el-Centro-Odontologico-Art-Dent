<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <title>Reserva cita</title>
    </head>
    <body class="d-flex flex-column min-vh-100">

        <%@include file="header.jsp" %> <!-- Incluye la cabecera -->

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
                            <input type="text" class="form-control" id="nombre" name="nombre"
                                   placeholder="Ingrese su nombre" value="${nombre}" required>
                        </div>
                        <div class="col-md-6">
                            <label for="apellido" class="form-label">Apellido</label>
                            <input type="text" class="form-control" id="apellido" name="apellido"
                                   placeholder="Ingrese su apellido" value="${apellido}" required>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="dni" class="form-label">DNI</label>
                            <input type="text" class="form-control" id="dni" name="dni" 
                                   placeholder="Ingrese el DNI" maxlength="8" 
                                   value="${param.dni}" required 
                                   onkeyup="if (event.keyCode === 13)
                                                           buscarPaciente();">
                        </div>
                        <div class="col-md-6">
                            <label for="telefono" class="form-label">Celular</label>
                            <input type="tel" class="form-control" id="telefono" name="telefono"
                                   placeholder="Ingrese su celular" minlength="9" maxlength="9" 
                                   pattern="\d{9}" value="${telefono}" required>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="email" class="form-label">Correo electronico</label>
                        <input type="email" class="form-control" id="correo" name="correo" 
                               placeholder="Ingrese el correo electrónico" 
                               value="${correo}">
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="fecha" class="form-label">Fecha de la reserva</label>
                            <input type="date" class="form-control" id="fecha" name="fecha" required>
                        </div>
                        <script>
                            const fechaHoy = new Date();
                            fechaHoy.setDate(fechaHoy.getDate());
                            const fechaSiguiente = fechaHoy.toISOString().split('T')[0];
                            document.getElementById('fecha').setAttribute('min', fechaSiguiente);
                        </script>
                        <div class="col-md-3">
                            <label for="hora" class="form-label">Hora de Cita</label>
                            <input type="time" class="form-control" id="hora" name="hora" onchange="ajustarHora()" min="08:00" max="22:00">
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="motivo" class="form-label">Motivo (Servicio)</label>
                        <select class="form-select" id="motivo" name="motivo" onchange="cargarDoctores();actualizarPrecio();
                                verificarCampos();" required>
                            <option value="" selected disabled>Seleccionar</option>
                            <c:forEach var="servicio" items="${servicios}">
                                <option value="${servicio.idServicio}" data-costo="${servicio.costo}" data-id="${servicio.idServicio}">
                                    ${servicio.tipoServicio}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <input type="hidden" name="precio_consulta" id="precio_consulta">
                    <input type="hidden" name="idServicio" id="idServicio">

                    <div class="mb-3">
                        <label for="pago" class="form-label">Total a pagar</label>
                        <input type="number" class="form-control" id="pago" name="pago" readonly required>
                    </div>
                    <div class="mb-3" id="medico-container" style="display:none;">
                        <label for="medico" class="form-label">Médico Asignado</label>
                        <select class="form-select" id="medico" name="medico">
                            <option value="" selected disabled>Seleccionar</option>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label for="descripcion" class="form-label">Descripcion</label>
                        <textarea class="form-control" id="descripcion" name="descripcion" rows="3" placeholder="Agregue una descripcion"></textarea>
                    </div>
                    <div class="form-check mb-3">
                        <input class="form-check-input" type="checkbox" id="aceptar-condiciones" name="aceptar-condiciones" required>
                        <label class="form-check-label" for="aceptar-condiciones">
                            Acepto los terminos y condiciones en linea
                        </label>
                    </div>

                    <button type="submit" class="btn btn-success w-100">Reservar y Pagar</button>
                </form>
            </div>

            <script>
                // Funcion para actualizar el precio y los campos ocultos automaticamente
                function actualizarPrecio() {
                    const motivoSelect = document.getElementById("motivo");
                    const selectedOption = motivoSelect.options[motivoSelect.selectedIndex];
                    const costo = selectedOption.getAttribute("data-costo");
                    const idServicio = selectedOption.getAttribute("data-id");
                    const pagoField = document.getElementById("pago");
                    const precioConsultaField = document.getElementById("precio_consulta");
                    const idServicioField = document.getElementById("idServicio");

                    // Asignar precio y id solo si se ha seleccionado un servicio valido
                    if (costo) {
                        pagoField.value = parseFloat(costo).toFixed(2);
                        precioConsultaField.value = costo; // Actualiza el campo oculto
                        idServicioField.value = idServicio; // Actualiza el campo oculto
                    } else {
                        pagoField.value = ""; // Vaciar el campo si no se ha seleccionado un motivo valido
                        precioConsultaField.value = ""; // Vaciar el campo oculto
                        idServicioField.value = ""; // Vaciar el campo oculto
                    }
                }
            </script>
        </div>

        <%@include file="footer.jsp" %> <!-- Incluye el pie de página -->

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <script>
                // Esta función se ejecuta cuando cambia la hora o fecha
                function verificarCampos() {
                    var motivo = document.getElementById('motivo').value;
                    var fecha = document.getElementById('fecha').value;
                    var hora = document.getElementById('hora').value;

                    // Limpiar el campo de selección de médicos
                    var medicoSelect = document.getElementById('medico');
                    medicoSelect.innerHTML = '<option value="" selected disabled>Seleccionar</option>';  // Reiniciar médicos

                    // Si el motivo, fecha y hora están seleccionados, mostramos el selector de médicos
                    if (motivo && fecha && hora) {
                        cargarDoctores();  // Llamar la función que carga los médicos basados en la nueva hora, fecha y motivo
                        document.getElementById('medico-container').style.display = 'block';  // Mostrar el selector de médicos
                    } else {
                        document.getElementById('medico-container').style.display = 'none';  // Ocultar el selector de médicos
                    }
                }

                // Resetear el médico cuando se cambia la hora
                document.getElementById('hora').addEventListener('change', function () {
                    // Limpiar el select de médicos cuando se cambie la hora
                    var medicoSelect = document.getElementById('medico');
                    medicoSelect.value = "";  // Resetear el valor del select de médicos

                    verificarCampos();  // Llamar a verificarCampos para que se actualicen los demás campos
                });

                // Llamar a verificarCampos cuando se cambien la fecha o el motivo
                document.getElementById('fecha').addEventListener('change', verificarCampos);
                document.getElementById('motivo').addEventListener('change', verificarCampos);
        </script>
        <script>
            function cargarDoctores() {
                var idServicio = document.getElementById('motivo').value;
                var fecha = document.getElementById('fecha').value;
                var hora = document.getElementById('hora').value;
                console.log('dia=' + fecha);
                console.log('hora=' + hora);
                if (hora == "" || fecha == "") {
                    alert("Elije una hora ");
                    return;
                }
                if (idServicio) {
                    var xhr = new XMLHttpRequest();
                    xhr.open('GET', 'ServicioController?action=cargarDoctores&motivo=' + idServicio + '&hora=' + hora + '&fecha=' + fecha, true);
                    console.log('ServicioController?action=cargarDoctores&motivo=' + idServicio + '&hora=' + hora + '&fecha=' + fecha);
                    xhr.onreadystatechange = function () {
                        if (xhr.readyState === 4 && xhr.status === 200) {
                            var doctoresSelect = document.getElementById('medico');
                            console.log('medico' + doctoresSelect);
                            doctoresSelect.innerHTML = '<option value="" selected disabled>Seleccione</option>'; // Reiniciar las opciones

                            // Agregar las opciones recibidas desde el servidor
                            doctoresSelect.innerHTML += xhr.responseText;
                        }
                    };
                    xhr.send();
                }
            }
        </script>
        <script>
            function buscarPaciente() {
                const dni = document.getElementById('dni').value;
                console.log("DNI ingresado: ", dni);
                if (dni.length === 8) {
                    const xhr = new XMLHttpRequest();
                    xhr.open('GET', `PacienteController?action=complet&dni=` + dni, true);
                    xhr.onreadystatechange = function () {
                        if (xhr.readyState == 4 && xhr.status == 200) {
                            const response = xhr.responseText;

                            const parser = new DOMParser();
                            const doc = parser.parseFromString(response, 'text/html');

                            const nombre = doc.getElementById('nombre').value;
                            const apellido = doc.getElementById('apellido').value;
                            const correo = doc.getElementById('correo').value;
                            const telefono = doc.getElementById('telefono').value;

                            document.getElementById('nombre').value = nombre;
                            document.getElementById('apellido').value = apellido;
                            document.getElementById('correo').value = correo;
                            document.getElementById('telefono').value = telefono;
                        }
                    };
                    xhr.send();
                }
            }

        </script>
        <script>
            function ajustarHora() {
                var horaInput = document.getElementById('hora');
                var valorHora = horaInput.value;

                if (!valorHora)
                    return;

                var partesHora = valorHora.split(':');
                var horas = parseInt(partesHora[0]);
                var minutos = parseInt(partesHora[1]);

                minutos = Math.round(minutos / 15) * 15;

                if (minutos === 60) {
                    minutos = 0;
                    horas++;
                }
                if (minutos < 10) {
                    minutos = '0' + minutos;
                }
                if (horas < 10) {
                    horas = '0' + horas;
                }
                if (horas >= 8 && horas < 18) {
                    horaInput.value = horas + ':' + minutos;
                } else {
                    alert("La hora seleccionada debe estar entre las 08:00 y las 18:00.");
                    horaInput.value = "";
                }
            }

            function actualizarPrecio() {
                const select = document.getElementById('motivo');
                const selectedOption = select.options[select.selectedIndex];

                const costo = selectedOption.getAttribute('data-costo');
                const idServicio = selectedOption.getAttribute('data-id');

                document.getElementById('precio_consulta').value = costo;
                document.getElementById('idServicio').value = idServicio;
                document.getElementById('pago').value = costo;
            }
            document.addEventListener('keydown', function (event) {
                if (event.key === 'Enter' && event.target.tagName === 'INPUT') {
                    event.preventDefault(); // Previene el comportamiento predeterminado
                }
            });

        </script>
    </body>
</html>
