<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html> 
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@700&family=Open+Sans:wght@400&display=swap" rel="stylesheet">
        <script src="https://www.paypal.com/sdk/js?client-id=Ab76YGp-Kv0PL6XzfwP4zH0OJN4oMfbk4CCxw84dyOsfEGAUWl6JRdgE0r3kUAxkyA45rsjaby4DkcDj&currency=USD&locale=es_ES" data-sdk-integration-source="button-factory"></script>
        <title>Crear Reserva</title>
    </head>
    <body>
        <%@include file="header.jsp"%>

        <h2 class="card-title text-center mb-4" style="color: darkblue;">CREAR RESERVA</h2>
        <div class="container mt-5">
            <div class="row justify-content-center">
                <div class="col-lg-8 col-md-10">
                    <div class="card shadow">               
                        <div class="card-body">                   
                            <form action="CitaController" method="POST">
                                <!-- Fila 1: DNI y Correo -->
                                <div class="row g-3 mb-3">
                                    <div class="col-md-6">
                                        <label for="dni" class="form-label fw-semibold">DNI del Paciente</label>
                                        <input type="text" class="form-control form-control-lg fs-6" id="dni" name="dni" 
                                               placeholder="Ingrese el DNI (8 dígitos)" maxlength="8" 
                                               value="${param.dni}" required 
                                               onkeyup="if (event.keyCode === 13) buscarPaciente();">
                                    </div>

                                    <div class="col-md-6">
                                        <label for="correo" class="form-label fw-semibold">Correo electrónico</label>
                                        <input type="email" class="form-control form-control-lg fs-6" id="correo" name="correo" 
                                               placeholder="correo@ejemplo.com" 
                                               value="${correo}" required>
                                    </div>
                                </div>

                                <!-- Fila 2: Nombre y Apellido -->
                                <div class="row g-3 mb-3">
                                    <div class="col-md-6">
                                        <label for="nombre" class="form-label fw-semibold">Nombre</label>
                                        <input type="text" class="form-control form-control-lg fs-6" id="nombre" name="nombre"
                                               placeholder="Ingrese su nombre" value="${nombre}" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="apellido" class="form-label fw-semibold">Apellido</label>
                                        <input type="text" class="form-control form-control-lg fs-6" id="apellido" name="apellido"
                                               placeholder="Ingrese su apellido" value="${apellido}" required>
                                    </div>
                                </div>

                                <!-- Fila 3: Celular y Servicio -->
                                <div class="row g-3 mb-3">
                                    <div class="col-md-6">
                                        <label for="telefono" class="form-label fw-semibold">Celular</label>
                                        <input type="tel" class="form-control form-control-lg fs-6" id="telefono" name="telefono"
                                               placeholder="Ingrese su celular (9 dígitos)" minlength="9" maxlength="9" 
                                               pattern="[0-9]{9}" value="${telefono}" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="motivo" class="form-label fw-semibold">Motivo (Servicio)</label>
                                        <select class="form-select form-select-lg fs-6" id="motivo" name="motivo" onchange="cargarDoctores();actualizarPrecio();verificarCampos();" required>
                                            <option value="" selected disabled>Seleccionar Servicio</option>
                                            <c:forEach var="servicio" items="${servicios}">
                                                <option value="${servicio.idServicio}" data-costo="${servicio.costo}" data-id="${servicio.idServicio}">
                                                    ${servicio.tipoServicio}
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>

                                <!-- Fila 4: Fecha y Hora de Cita -->
                                <div class="row g-3 mb-3">
                                    <div class="col-md-6">
                                        <label for="fecha" class="form-label fw-semibold">Fecha de Cita</label>
                                        <input type="date" class="form-control form-control-lg fs-6" id="fecha" name="fecha" required onchange="verificarCampos();">
                                    </div>
                                    <div class="col-md-6">
                                        <label for="hora" class="form-label fw-semibold">Hora de Cita</label>
                                        <input type="time" class="form-control form-control-lg fs-6" id="hora" name="hora" onchange="ajustarHora();verificarCampos();" min="08:00" max="22:00" required>
                                    </div>
                                </div>

                                <!-- Fila 5: Médico Asignado (se muestra al elegir servicio, fecha y hora) -->
                                <div class="row g-3 mb-3" id="medico-container" style="display:none;">
                                    <div class="col-12">
                                        <label for="medico" class="form-label fw-semibold text-primary"><i class="fa fa-user-md me-1"></i>Médico Asignado</label>
                                        <select class="form-select form-select-lg fs-6 border-primary" id="medico" name="medico">
                                            <option value="" selected disabled>Seleccionar Médico</option>
                                        </select>
                                    </div>
                                </div>

                                <!-- Fila 6: Total a Pagar Centrado -->
                                <div class="row justify-content-center my-4">
                                    <div class="col-md-6 col-sm-8 text-center">
                                        <div class="p-3 bg-light rounded-3 border">
                                            <label for="pago" class="form-label fw-bold text-muted mb-1 text-uppercase small">Total a pagar</label>
                                            <div class="d-flex justify-content-center align-items-center">
                                                <span class="fs-4 fw-bold text-dark me-2">S/</span>
                                                <input type="number" class="form-control-plaintext text-center fs-3 fw-bold text-primary p-0" id="pago" name="pago" readonly required placeholder="0.00" style="max-width: 140px; display: inline-block;">
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <input type="hidden" name="precio_consulta" id="precio_consulta">
                                <input type="hidden" name="idServicio" id="idServicio">

                                <!-- Botón de envío PayPal Perfectamente Centrado -->
                                <div class="d-flex justify-content-center w-100 mt-3">
                                    <div id="paypal-button-container" class="w-100" style="max-width: 460px;"></div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%@include file="footer.jsp"%>

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
        </script>
        <script>
            fetch('https://api.exchangerate-api.com/v4/latest/USD')
                    .then(response => response.json())
                    .then(data => {
                        const tasaCambio = data.rates.PEN;
                        initPayPalButton(tasaCambio);
                    })
                    .catch(error => {
                        console.error('Error al obtener la tasa de cambio:', error);
                    });
            function initPayPalButton(tasaCambio) {
                paypal.Buttons({
                    style: {
                        shape: 'rect',
                        color: 'gold',
                        layout: 'vertical',
                        label: 'pay',
                    },

                    createOrder: function (data, actions) {
                        // Obtiene el valor del campo pago para el total de la orden
                        const total = (document.getElementById('pago').value / tasaCambio).toFixed(2);

                        return actions.order.create({
                            purchase_units: [{
                                    description: "Pago de consulta médica",
                                    amount: {
                                        currency_code: "USD",
                                        value: total // Utiliza el valor del campo pago
                                    }
                                }]
                        });
                    },

                    onApprove: function (data, actions) {
                        return actions.order.capture().then(function (orderData) {
                            fetch('CitaController', {
                                method: 'POST',
                                headers: {
                                    'Content-Type': 'application/x-www-form-urlencoded'
                                },
                                body: new URLSearchParams({
                                    dni: document.getElementById('dni').value,
                                    correo: document.getElementById('correo').value,
                                    nombre: document.getElementById('nombre').value,
                                    apellido: document.getElementById('apellido').value,
                                    telefono: document.getElementById('telefono').value,
                                    fecha: document.getElementById('fecha').value,
                                    hora: document.getElementById('hora').value,
                                    motivo: document.getElementById('motivo').value,
                                    precio_consulta: document.getElementById('precio_consulta').value,
                                    idServicio: document.getElementById('idServicio').value,
                                    medico: document.getElementById('medico').value,
                                })

                            })
                                    .then(() => {
                                        // Redirige al usuario a una página de confirmación
                                        window.location.href = 'citareservada.jsp';
                                    })
                                    .catch(error => console.error('Error:', error));
                        });
                    }
                    ,

                    onError: function (err) {
                        console.log(err);
                    }
                }).render('#paypal-button-container');
            }
        </script>

         </body>
</html>