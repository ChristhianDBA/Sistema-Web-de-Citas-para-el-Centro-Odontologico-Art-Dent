<!DOCTYPE html>
<html lang="es">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Acerca de Nosotros</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <style>
         @keyframes fadeInEffect {
                0% {
                    opacity: 0;
                    transform: translateY(20px);
                }
                100% {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            /* Aplicar animaciones */
            .fade-in {
                opacity: 0;
                animation: fadeInEffect 1.5s ease-in-out forwards;
            }

            .fade-in-delay-1 {
                animation-delay: 0.5s;
            }

            .fade-in-delay-2 {
                animation-delay: 1s;
            }

            .fade-in-delay-3 {
                animation-delay: 1.5s;
            }

            /* Transici?n suave para el texto */
            .text-transition {
                transition: opacity 0.5s ease, transform 0.5s ease;
            }

            /* Transici?n suave para la imagen */
            .img-transition {
                transition: transform 0.5s ease-in-out;
            }

            /* Efecto de hover en la imagen */
            .img-transition:hover {
                transform: scale(1.05); /* Aumenta ligeramente el tama?o al pasar el rat?n */
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
    <body>
        <!-- Header -->
        <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
            <div class="container-fluid">
                <%@include file="header.jsp"%>
            </div>
        </nav>

        <!-- Secci?n con Imagen de Fondo y Texto Centrado -->
        <div class="bg-dark text-white position-relative" 
             style="background-image: url('https://www.flowww.es/hubfs/Q32024%20Septiembre/Blog/historia-clinica-dental-atencion-eficiente-paciente-clinicas-odontologicas.webp');
             background-size: cover; background-position: center; height: 600px; animation: fadeInEffect 1.5s ease-in-out forwards;">
            <!-- Capa oscura superpuesta -->
            <div class="position-absolute top-0 start-0 w-100 h-100 bg-dark opacity-50"></div>

            <!-- Contenido centrado -->
            <div class="container d-flex flex-column justify-content-center h-100 position-relative px-4">
                <div class="text-center fade-in fade-in-delay-1">
                    <h1 class="display-4 font-weight-bold text-transition">Acerca de Nosotros</h1>
                    <p class="lead fade-in fade-in-delay-2 text-transition">Estamos aquí para brindar el servicio que necesitan tus dientes.</p>
                </div>
            </div>
        </div>

        <!-- Sección de Contenido -->
        <main class="py-5">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-md-6"><br>
                        <h2 class="display-6" style="font-weight: bold;">Nuestro sue?o es ayudar a tu sonrisa</h2><br>
                        <p class="mt-4">En nuestra cl?nica dental, nos dedicamos a mejorar la salud bucal de cada uno de nuestros
                            pacientes, porque creemos que una sonrisa saludable puede transformar vidas. Con un equipo de
                            expertos comprometidos y una atenci?n personalizada, trabajamos d?a a d?a para brindarte los
                            mejores tratamientos y hacer que te sientas c?modo y seguro. Nuestro sue?o es ayudarte a
                            recuperar y mantener la confianza en tu sonrisa, ofreci?ndote siempre el cuidado que necesitas
                            con la calidez y profesionalismo que mereces.</p>
                    </div>
                    <div class="col-md-6 position-relative d-inline-block">
                        <!-- Imagen con borde redondeado -->
                        <img src="https://odontologiaespecializadasevilla.com/wp-content/uploads/2018/07/dentista-sevilla.jpg"
                             class="img-fluid rounded img-transition" alt="Imagen de dentista" style="border-radius: 20px;">
                    </div>
                </div>
            </div>
        </main>
        <main class="py-5">
            <div class="container">
                <div class="row align-items-center">
                    <!-- Columna de imagen a la izquierda -->
                    <div class="col-md-6 position-relative d-inline-block">
                        <!-- Imagen con borde redondeado -->
                        <img src="https://vital.com.co/wp-content/uploads/2019/02/15-Dise%C3%B1o-De-Sonrisa-Seguro-Y-Confiable.jpg"
                             class="img-fluid rounded img-transition" alt="Imagen de dentista" style="border-radius: 20px;">
                    </div>

                    <!-- Columna de texto a la derecha -->
                    <div class="col-md-6">
                        <h2 class="display-6" style="font-weight: bold;" class="text-transition">Tu sonrisa, nuestra misión</h2>
                        <p class="mt-4 text-transition">En nuestra clínica, tu bienestar y salud dental son nuestra prioridad. Sabemos que cada sonrisa es única, y por eso nos esforzamos en ofrecerte un servicio personalizado que se ajuste a tus necesidades. Con un equipo de profesionales dedicados y utilizando las ?ltimas tecnolog?as, buscamos no solo cuidar de tu salud bucal, sino tambi?n brindarte una experiencia agradable y sin estr?s. Conf?a en nosotros para mejorar tu sonrisa y devolverle la seguridad que te mereces. ?Juntos haremos que sonr?as con confianza!</p>
                    </div>
                </div>
            </div>
        </main>
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
        <!-- Footer -->
        <%@include file="footer.jsp"%>


        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    </body>

</html>