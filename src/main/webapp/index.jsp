<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@700&family=Open+Sans:wght@400&display=swap"
              rel="stylesheet">
        <link rel="stylesheet" href="/css/style.css">
        <title>Inicio - Art Dent</title>
    </head>

    <body>

        <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
            <div class="container-fluid">
                <%@include file="header.jsp"%>
            </div>
        </nav>

        <div class="bg-dark text-white position-relative" 
             style="background-image: url('https://www.clinicadentalsonriemaslima.com/wp-content/themes/Sonriemas/img/slider2.jpg'); background-size: cover; background-position: center; height: 600px; opacity: 0;
             animation: fadeInEffect 1.5s ease-in-out forwards;">
            <div class="position-absolute top-0 start-0 w-100 h-100 bg-dark opacity-50"></div>
            <div class="container d-flex flex-column justify-content-center h-100 position-relative px-4">
                <div class="container text-start">
                    <div class="row">
                        <div class="col-12">
                            <h1 class="display-4" 
                                style="opacity: 0; animation: fadeInEffect 1s ease-in-out forwards 0.5s;">Art Dent</h1>
                            <h2 class="mb-4" 
                                style="opacity: 0; animation: fadeInEffect 1s ease-in-out forwards 1s;">Ayudándote a sonreír</h2>
                            <p class="lead" 
                               style="opacity: 0; animation: fadeInEffect 1s ease-in-out forwards 1.3s;">Art Dent es una clínica dental que ofrece servicios de odontología general, ortodoncia,
                                cirugía oral y estética dental. Nuestro equipo de profesionales está comprometido con la salud bucal
                                y la satisfacción de nuestros pacientes, y trabaja para ofrecer tratamientos de calidad y resultados
                                duraderos. En Art Dent encontrarás un ambiente cálido y acogedor, donde te sentirás cómodo y seguro
                                durante tu visita. ¡Ven a conocernos y descubre la diferencia de sonreír con Art Dent!</p>
                            <a href="ServicioController?action=formreservaa" class="btn btn-success btn-lg" 
                               style="opacity: 0; animation: fadeInEffect 1s ease-in-out forwards 1.5s;">Reserva tu cita aquí</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Sección de empresas que respaldan -->
        <div class="container my-5 py-5">
            <h3 class="text-center text-black mb-4 fade-in fade-in-delay-1">Empresas que nos respaldan</h3><br>
            <div class="row justify-content-center">
                <!-- Logo de Colgate -->
                <div class="col-6 col-md-2 mb-4 d-flex justify-content-center fade-in fade-in-delay-2">
                    <img src="https://upload.wikimedia.org/wikipedia/commons/3/3f/Colgate.svg" class="img-fluid" alt="Colgate" style="max-height: 80px; object-fit: contain;">
                </div>
                <!-- Logo de Nestlé -->
                <div class="col-6 col-md-2 mb-4 d-flex justify-content-center fade-in fade-in-delay-3">
                    <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTSVfCmOuGgT9LsJlj-ZbzhIBZdjK6UZrq7Ap87lo-mFoQcHsuCNYDhdGDPmZmFDcPCqQ" class="img-fluid" alt="Nestlé" style="max-height: 80px; object-fit: contain;">
                </div>
                <!-- Logo de Sensodyne -->
                <div class="col-6 col-md-2 mb-4 d-flex justify-content-center fade-in fade-in-delay-4">
                    <img src="https://assets.boots.com/content/dam/boots/brands/brand---s/sensodyne/sensodyne_bt/sensodyne_bt_2021-05/2021-05_sensodyne_brand-treatment_horizontal-nav_sensodyne.dam.ts%3D1626850968239.jpg" class="img-fluid" alt="Sensodyne" style="max-height: 80px; object-fit: contain;">
                </div>
                <!-- Logo adicional -->
                <div class="col-6 col-md-2 mb-4 d-flex justify-content-center fade-in fade-in-delay-5">
                    <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQByTHpMwmvqMIdQ-GLSxd6rx6fls7MkQ__KA&s" class="img-fluid" alt="Logo adicional" style="max-height: 80px; object-fit: contain;">
                </div>
            </div>
        </div>

        <style>
            @keyframes fadeInEffect {
                0% {
                    opacity: 0;
                }
                100% {
                    opacity: 1;
                }
            }

            .fade-in {
                opacity: 0;
                animation: fadeInEffect 1s ease-in-out forwards;
            }

            .fade-in-delay-1 {
                animation-delay: 1s;
            }

            .fade-in-delay-2 {
                animation-delay: 1.5s;
            }

            .fade-in-delay-3 {
                animation-delay: 2s;
            }

            .fade-in-delay-4 {
                animation-delay: 2.5s;
            }

            .fade-in-delay-5 {
                animation-delay: 3s;
            }

            .fade-in-delay-6 {
                animation-delay: 3.5s;
            }

            .fade-in-delay-7 {
                animation-delay: 4s;
            }

            .fade-in-delay-8 {
                animation-delay: 4.5s;
            }
            .fade-in-delay-9 {
                animation-delay: 5s;
            }
            .fade-in-delay-10 {
                animation-delay: 5.5s;
            }
            .fade-in-delay-11 {
                animation-delay: 6s;
            }
            .fade-in-delay-12 {
                animation-delay: 6.5s;
            }
            .fade-in-delay-13 {
                animation-delay: 7s;
            }
            .fade-in-delay-14 {
                animation-delay: 7.5s;
            }
            .fade-in-delay-15 {
                animation-delay: 8s;
            }
            .fade-in-delay-16 {
                animation-delay: 8.5s;
            }
            .chat-widget {
                position: fixed;
                bottom: 20px;
                right: 20px;
                width: 350px;
                height: 500px;
                background: linear-gradient(145deg, #ffffff, #f0f0f0);
                border-radius: 20px;
                overflow: hidden;
                box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
                transition: all 0.3s ease;
                z-index: 1000;
            }

            .chat-widget.collapsed {
                height: 60px;
            }

            /* New styles for expanded state */
            .chat-widget:not(.collapsed) {
                width: 400px; /* Increased width when expanded */
                height: 600px; /* Increased height for better proportion */
            }

            .chat-header {
                background: linear-gradient(90deg, #3498db, #2980b9);
                color: #fff;
                padding: 15px;
                cursor: pointer;
                font-weight: bold;
                display: flex;
                align-items: center;
                justify-content: space-between;
            }

            .chat-body {
                height: calc(100% - 120px);
                overflow-y: auto;
                padding: 15px;
                background-color: #f8f9fa;
            }

            .chat-input {
                height: 60px;
                background-color: #fff;
                padding: 10px;
                display: flex;
                align-items: center;
            }

            .chat-input input {
                flex-grow: 1;
                border: none;
                background-color: #f1f3f5;
                color: #333;
                padding: 10px 15px;
                border-radius: 20px;
                margin-right: 10px;
            }

            .chat-input button {
                background-color: #3498db;
                color: #fff;
                border: none;
                border-radius: 50%;
                width: 40px;
                height: 40px;
                display: flex;
                align-items: center;
                justify-content: center;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            .chat-input button:hover {
                background-color: #2980b9;
            }

            .message {
                margin-bottom: 15px;
                padding: 10px 15px;
                border-radius: 20px;
                max-width: 80%;
                animation: fadeIn 0.3s ease;
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(10px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .user-message {
                background-color: #3498db;
                color: #fff;
                align-self: flex-end;
                margin-left: auto;
            }

            .bot-message {
                background-color: #ecf0f1;
                color: #34495e;
            }

            .chat-toggle {
                background: none;
                border: none;
                color: #fff;
                font-size: 1.2em;
            }

            .loading-animation {
                display: none;
                text-align: center;
                padding: 10px;
            }

            .loading-animation span {
                display: inline-block;
                width: 10px;
                height: 10px;
                background-color: #3498db;
                border-radius: 50%;
                margin: 0 5px;
                animation: bounce 1.4s infinite ease-in-out both;
            }

            .loading-animation span:nth-child(1) {
                animation-delay: -0.32s;
            }

            .loading-animation span:nth-child(2) {
                animation-delay: -0.16s;
            }

            @keyframes bounce {
                0%, 80%, 100% {
                    transform: scale(0);
                }
                40% {
                    transform: scale(1.0);
                }
            }

            /* Media query for responsiveness */
            @media (max-width: 480px) {
                .chat-widget, .chat-widget:not(.collapsed) {
                    width: 90%;
                    right: 5%;
                    left: 5%;
                }
            }
        </style>

        <div style="height: 40px;"></div> <!-- Este es el espacio de separación entre las imágenes -->
        <div class="text-center fade-in fade-in-delay-6">
            <h2>Nuestras Sedes</h2>
        </div>
        <br>
        <div class="d-flex justify-content-start align-items-start fade-in fade-in-delay-7" style="min-height: 10vh; background-color: white;">
            <div class="card mb-3" style="max-width: 10000px; height: 500px; margin-left: 20px; border-radius: 20px;">
                <div class="row g-0">
                    <!-- Sección del mapa -->
                    <div class="col-md-7" style="flex: 0 0 60%; display: flex; justify-content: center; align-items: center;">
                        <iframe 
                            src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d4915.00775618888!2d-76.69852092397075!3d-11.936868239866305!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x9105ef0f5e97b5df%3A0xaa9268a039fb2297!2sCentro%20Odontologico%20Integral%20Art%20Dent%20SAC!5e1!3m2!1ses-419!2spe!4v1733294849910!5m2!1ses-419!2spe"
                            width="1300px" 
                            height="500px" 
                            style="border: 0; border-radius: 20px;" 
                            allowfullscreen="" 
                            loading="lazy" 
                            referrerpolicy="no-referrer-when-downgrade">
                        </iframe>
                    </div>
                    <!-- Sección del texto -->
                    <div class="col-md-5" style="flex: 0 0 40%; padding-left: 20px;">
                        <div class="card-body d-flex flex-column justify-content-center fade-in fade-in-delay-8" style="opacity: 0; animation: fadeInEffect 3s ease-in-out forwards 2s;">
                            <h5 class="card-title text-bolder">Sede Chosica</h5>
                            <p class="card-text"><small class="text-body-secondary">Jr. Chiclayo 268, Chosica, Perú</small></p>
                            <p class="card-text"><strong>Teléfono</strong></p>
                            <p class="card-text"><small class="text-body-secondary">(01) 3613634</small></p>
                            <p class="card-text"><strong>Horarios</strong></p>
                            <p class="card-text"><small class="text-body-secondary">
                                    Lunes: 8:00 a. m. - 7:00 p. m.<br>
                                    Martes: 8:00 a. m. - 7:00 p. m.<br>
                                    Miércoles: 8:00 a. m. - 7:00 p. m.<br>
                                    Jueves: 8:00 a. m. - 7:00 p. m.<br>
                                    Viernes: 8:00 a. m. - 7:00 p. m.<br>
                                    Sábado: 8:00 a. m. - 7:00 p. m.<br>
                                    Domingo: <strong>CERRADO</strong>
                                </small></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <br>

        <div class="d-flex justify-content-end align-items-end fade-in fade-in-delay-9" style="min-height: 10vh; background-color: white;">
            <div class="card mb-3" style="max-width: 10000px; height: 500px; margin-left: 20px; border-radius: 20px;">
                <div class="row g-0">
                    <!-- Sección del texto -->
                    <div class="col-md-5" style="flex: 0 0 40%; padding-left: 20px;">
                        <div class="card-body d-flex flex-column justify-content-center fade-in fade-in-delay-10"><br><br>
                            <h5 class="card-title text-bolder">Sede Chaclacayo</h5>
                            <p class="card-text"><small class="text-body-secondary">Las Palmeras 328, Chaclacayo 15472, Perú</small></p>
                            <p class="card-text"><strong>Teléfono</strong></p>
                            <p class="card-text"><small class="text-body-secondary">(01) 3613634</small></p>
                            <p class="card-text"><strong>Horarios</strong></p>
                            <p class="card-text"><small class="text-body-secondary">
                                    Lunes: 8:00 a. m. - 7:00 p. m.<br>
                                    Martes: 8:00 a. m. - 7:00 p. m.<br>
                                    Miércoles: 8:00 a. m. - 7:00 p. m.<br>
                                    Jueves: 8:00 a. m. - 7:00 p. m.<br>
                                    Viernes: 8:00 a. m. - 7:00 p. m.<br>
                                    Sábado: 8:00 a. m. - 7:00 p. m.<br>
                                    Domingo: <strong>CERRADO</strong>
                                </small></p>
                        </div>
                    </div>
                    <!-- Sección del mapa -->
                    <div class="col-md-7" style="flex: 0 0 60%; display: flex; justify-content: center; align-items: center;">
                        <iframe 
                            src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d4915.00775618888!2d-76.69852092397075!3d-11.936868239866305!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x9105ef0f5e97b5df%3A0xaa9268a039fb2297!2sCentro%20Odontologico%20Integral%20Art%20Dent%20SAC!5e1!3m2!1ses-419!2spe!4v1733294849910!5m2!1ses-419!2spe"
                            width="1300px" 
                            height="500px" 
                            style="border: 0; border-radius: 20px;" 
                            allowfullscreen="" 
                            loading="lazy" 
                            referrerpolicy="no-referrer-when-downgrade">
                        </iframe>
                    </div>
                </div>
            </div>
        </div>


        <br><br>

        <div class="text-center fade-in">
            <h2>Nuestros Doctores</h2>
        </div>

        <br><br>

        <div class="d-flex justify-content-center gap-4">
            <div class="card fade-in fade-in-delay-11" style="width: 22rem; height: 30rem;">
                <img src="https://saluddata.com/wp-content/uploads/2024/07/Odontologo-Profesional-p.webp" class="card-img-top" alt="..." style="height: 15.5rem; object-fit: cover;">
                <div class="card-body d-flex flex-column justify-content-between">
                    <p class="card-text text-center"><strong> Luis Miguel Martinez Lozano </strong></p>
                    <p class="card-text text-center"><small class="text-body-secondary"> Odontólogo </small></p>
                    <p class="card-text text-center"><small class="text-body-secondary"> Dr. Luis Miguel es un odontólogo con 10 años de experiencia. Especializado en endodoncia, con una maestría de la Universidad Nacional de Salud.</small></p>
                </div>
            </div>
            <div class="card fade-in fade-in-delay-12" style="width: 22rem; height: 30rem;">
                <img src="https://colderechomedico.com/wp-content/uploads/2020/06/Cual-es-la-importancia-del-secreto-profesional-en-odontologia_colderecho.jpg" class="card-img-top" alt="..." style="height: 15.5rem; object-fit: cover;">
                <div class="card-body d-flex flex-column justify-content-between">
                    <p class="card-text text-center"><strong> Rubén Cuadros </strong></p>
                    <p class="card-text text-center"><small class="text-body-secondary"> Odontólogo </small></p>
                    <p class="card-text text-center"><small class="text-body-secondary"> Dr. Rubén Cuadros es un odontólogo apasionado, con una vasta experiencia en el tratamiento de enfermedades dentales y en la promoción de la salud bucal preventiva.</small></p>
                </div>
            </div>
            <div class="card fade-in fade-in-delay-13" style="width: 22rem; height: 30rem;">
                <img src="https://img.freepik.com/fotos-premium/retrato-hombre-dentista-pulgares-arriba-sonrisa-cuidado-bucal-especialista-felicidad-profesional-cara-hombre-o-empleado-higiene-dental-sector-salud-apoyo-revision_590464-191475.jpg" class="card-img-top" alt="..." style="height: 15.5rem; object-fit: cover;">
                <div class="card-body d-flex flex-column justify-content-between">
                    <p class="card-text text-center"><strong> Juan Gómez </strong></p>
                    <p class="card-text text-center"><small class="text-body-secondary"> Odontólogo </small></p>
                    <p class="card-text text-center"><small class="text-body-secondary"> El Dr. Juan Gómez es un odontólogo que ha desarrollado una habilidad especial para realizar tratamientos que restauran tanto la función como la belleza de la sonrisa.</small></p>
                </div>
            </div>
        </div>

        <br><br><br>

        <div class="container my-5 py-5">
            <h3 class="text-center text-black mb-4">Métodos de pago</h3>
            <div class="row justify-content-center">
                <!-- Logo de PayPal -->
                <div class="col-6 col-md-2 mb-4 d-flex justify-content-center fade-in fade-in-delay-14">
                    <img src="https://martinvalverde.com/wp-content/uploads/2020/06/PayPal-Logo.png" class="img-fluid" alt="PayPal" style="max-height: 80px; object-fit: contain;">
                </div>
                <!-- Logo de Visa -->
                <div class="col-6 col-md-2 mb-4 d-flex justify-content-center fade-in fade-in-delay-15">
                    <img src="https://1000marcas.net/wp-content/uploads/2019/12/VISA-Logo.png" class="img-fluid" alt="Visa" style="max-height: 80px; object-fit: contain;">
                </div>
                <!-- Logo de MasterCard -->
                <div class="col-6 col-md-2 mb-4 d-flex justify-content-center fade-in fade-in-delay-16">
                    <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/b/b7/MasterCard_Logo.svg/2560px-MasterCard_Logo.svg.png" class="img-fluid" alt="MasterCard" style="max-height: 80px; object-fit: contain;">
                </div>
            </div>
        </div>
        <div class="chat-widget collapsed" id="chatWidget">
            <div class="chat-header" id="chatHeader">
                <span><i class="fas fa-tooth"></i> Asistente Virtual de Art Dent</span>
                <button class="chat-toggle" id="chatToggle">
                    <i class="fas fa-chevron-up"></i>
                </button>
            </div>
            <div class="chat-body" id="chat-body">
                <!-- Los mensajes se agregarán aquí dinámicamente -->
            </div>
            <div class="loading-animation" id="loading-animation">
                <span></span>
                <span></span>
                <span></span>
            </div>
            <div class="chat-input">
                <input type="text" id="pregunta" placeholder="Describe tus síntomas o preocupaciones...">
                <button onclick="enviarPregunta()"><i class="fas fa-paper-plane"></i></button>
            </div>
        </div>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const chatWidget = document.getElementById('chatWidget');
                const chatHeader = document.getElementById('chatHeader');
                const chatToggle = document.getElementById('chatToggle');
                const chatBody = document.getElementById('chat-body');

                function toggleChat() {
                    chatWidget.classList.toggle('collapsed');
                    chatToggle.innerHTML = chatWidget.classList.contains('collapsed')
                            ? '<i class="fas fa-chevron-up"></i>'
                            : '<i class="fas fa-chevron-down"></i>';
                }

                chatHeader.addEventListener('click', toggleChat);
                chatToggle.addEventListener('click', function (e) {
                    e.stopPropagation();
                    toggleChat();
                });

                // Mensaje inicial del bot
                agregarMensajeBot('¡Hola! Soy el asistente virtual de Art Dent. ¿En qué puedo ayudarte hoy? Puedes describir tus síntomas o preocupaciones dentales y te recomendaré el servicio más adecuado.');
            });

            async function enviarPregunta() {
                const pregunta = document.getElementById("pregunta").value;
                if (pregunta.trim() === '')
                    return;

                agregarMensajeUsuario(pregunta);
                mostrarAnimacion();

                const response = await fetch('/ArtDent/api/chatbot', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    body: 'pregunta=' + encodeURIComponent(pregunta)
                });

                const data = await response.text();

                ocultarAnimacion();
                agregarMensajeBot(data);

                // Limpiar el campo de entrada
                document.getElementById("pregunta").value = '';
            }

            function agregarMensajeUsuario(mensaje) {
                const chatBody = document.getElementById('chat-body');
                const mensajeDiv = document.createElement('div');
                mensajeDiv.className = 'message user-message';
                mensajeDiv.textContent = mensaje;
                chatBody.appendChild(mensajeDiv);
                scrollToBottom();
            }

            function convertirUrlsAClickables(message) {
                return message.replace(
                        /(\bhttps?:\/\/[^\s<>,;!?()]+(?:[\?&=][^\s<>,;!?()]*|[^\s<>,;!?()]*))/g,
                        '<a href="$1" target="_blank">$1</a>'
                        );
            }

            function agregarMensajeBot(mensaje) {
                const chatBody = document.getElementById('chat-body');
                const mensajeDiv = document.createElement('div');
                mensajeDiv.className = 'message bot-message';

                const mensajeConLinks = convertirUrlsAClickables(mensaje);
                mensajeDiv.innerHTML = mensajeConLinks;

                chatBody.appendChild(mensajeDiv);
                scrollToBottom();
            }

            function scrollToBottom() {
                const chatBody = document.getElementById('chat-body');
                chatBody.scrollTop = chatBody.scrollHeight;
            }

            function mostrarAnimacion() {
                document.getElementById('loading-animation').style.display = 'block';
                scrollToBottom();
            }

            function ocultarAnimacion() {
                document.getElementById('loading-animation').style.display = 'none';
            }
        </script>
        <!-- Espacio para agregar otra imagen -->
        <div style="height: 1px;"></div> <!-- Este es el espacio de separación entre las imágenes -->


        <%@include file="footer.jsp"%>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>

</html>