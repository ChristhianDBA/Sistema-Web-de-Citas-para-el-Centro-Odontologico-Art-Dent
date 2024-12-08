<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Preguntas Frecuentes</title>
        <!-- Bootstrap CSS -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <style>
            /* Cambiar el color de los botones del acorde?n a negro y eliminar el subrayado */
            .accordion-button {
                color: black !important;
                text-decoration: none !important;
                background: none !important; /* Quitar el fondo */
            }

            .accordion-button:focus {
                box-shadow: none !important;
            }

            .accordion-button:not(.collapsed) {
                color: black !important;
            }

            /* Evitar que cambie de color al pasar el rat?n */
            .accordion-button:hover {
                color: black !important;
                background: none !important; /* Sin fondo */
            }

            .accordion-button:focus {
                outline: none !important; /* Eliminar el contorno de enfoque */
            }

            /* Transici?n de aparici?n para el fondo */
            .fade-in {
                opacity: 0;
                animation: fadeInEffect 1.5s ease-in-out forwards;
            }

            /* Transici?n de aparici?n para los encabezados de las preguntas */
            .fade-in-delay-1 {
                animation-delay: 0.5s;
            }

            .fade-in-delay-2 {
                animation-delay: 1s;
            }

            .fade-in-delay-3 {
                animation-delay: 1.5s;
            }

            .fade-in-delay-4 {
                animation-delay: 2s;
            }

            .fade-in-delay-5 {
                animation-delay: 2.5s;
            }

            /* Animaci?n para los elementos */
            @keyframes fadeInEffect {
                from {
                    opacity: 0;
                }

                to {
                    opacity: 1;
                }
            }
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
    </head>

    <body class="m-0 p-0">
        <!-- Header -->
        <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
            <div class="container-fluid">
                <%@include file="header.jsp"%>
            </div>
        </nav>

        <!-- FAQ Section -->
        <div class="position-relative bg-dark text-white fade-in"
             style="background-image: url('https://img.freepik.com/fotos-premium/medicos-pie-pasillo-hospital-brazos-cruzados_958192-31239.jpg');
             background-size: cover; background-position: center; height: 600px;">
            <!-- Capa de superposici?n oscura -->
            <div class="position-absolute top-0 start-0 w-100 h-100 bg-dark opacity-50"></div>

            <!-- Contenedor del contenido sobre la imagen -->
            <div class="container d-flex flex-column justify-content-center align-items-center h-100 position-relative text-center">
                <h1 class="display-4 fade-in fade-in-delay-1">FAQ</h1>
                <p class="text-light fade-in fade-in-delay-2" style="font-size: 25px;">Respondemos a sus preguntas más frecuentes.</p>
            </div>
        </div>

        <!-- Acorde?n de Preguntas Frecuentes -->
        <div class="container mt-5">
            <div class="accordion" id="faqAccordion">
                <!-- Pregunta 1 -->
                <div class="card mb-3 border-0 rounded-lg fade-in fade-in-delay-3">
                    <div class="card-header bg-light border-0 rounded-top" id="headingOne">
                        <h2 class="mb-0">
                            <button class="accordion-button btn btn-link btn-block text-left font-weight-bold"
                                    type="button" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true"
                                    aria-controls="collapseOne">
                                ¿Qué hago si no puedo presentarme a mi cita?
                            </button>
                        </h2>
                    </div>
                    <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#faqAccordion">
                        <div class="card-body">
                            Si no puedes presentarte a tu cita, te recomendamos que contactes a la cl?nica o al
                            consultorio lo antes posible.
                            Generalmente, se puede reprogramar la cita sin problema si se avisa con antelaci?n.
                            Algunos lugares pueden cobrar
                            una tarifa por cancelaciones tardeas o ausencias sin previo aviso, por lo que es
                            importante comunicarte con ellos
                            para evitar cargos adicionales.
                        </div>
                    </div>
                </div>

                <!-- Pregunta 2 -->
                <div class="card mb-3 border-0 rounded-lg fade-in fade-in-delay-4">
                    <div class="card-header bg-light border-0 rounded-top" id="headingTwo">
                        <h2 class="mb-0">
                            <button class="accordion-button btn btn-link btn-block text-left font-weight-bold collapsed"
                                    type="button" data-toggle="collapse" data-target="#collapseTwo"
                                    aria-expanded="false" aria-controls="collapseTwo">
                                ¿Cuel es el costo de una consulta?
                            </button>
                        </h2>
                    </div>
                    <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#faqAccordion">
                        <div class="card-body">
                            El costo de una consulta dental puede variar dependiendo del tipo de servicio y del
                            profesional. En general, una
                            consulta inicial puede costar alrededor de S/ 50.00. Este costo generalmente incluye una
                            evaluación general y
                            recomendaciones iniciales de tratamiento. Para tratamientos especígficos, como limpiezas
                            profundas, empastes o
                            procedimientos quirurgicos, es posible que se apliquen tarifas adicionales.
                        </div>
                    </div>
                </div>

                <!-- Pregunta 3 -->
                <div class="card mb-3 border-0 rounded-lg fade-in fade-in-delay-5">
                    <div class="card-header bg-light border-0 rounded-top" id="headingThree">
                        <h2 class="mb-0">
                            <button class="accordion-button btn btn-link btn-block text-left font-weight-bold collapsed"
                                    type="button" data-toggle="collapse" data-target="#collapseThree"
                                    aria-expanded="false" aria-controls="collapseThree">
                                ¿Con qué frecuencia debo ir al dentista?
                            </button>
                        </h2>
                    </div>
                    <div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#faqAccordion">
                        <div class="card-body">
                            Se recomienda visitar al dentista al menos cada seis meses para una revisión y limpieza
                            dental.
                            Sin embargo, la frecuencia puede variar según las necesidades individuales y la salud
                            bucal. Si
                            tienes problemas dentales específicos, como caries recurrentes o enfermedades de las
                            enc?as, tu
                            dentista puede recomendarte visitas más frecuentes.
                        </div>
                    </div>
                </div>

                <!-- Pregunta 4 -->
                <div class="card mb-3 border-0 rounded-lg fade-in fade-in-delay-6">
                    <div class="card-header bg-light border-0 rounded-top" id="headingFour">
                        <h2 class="mb-0">
                            <button class="accordion-button btn btn-link btn-block text-left font-weight-bold collapsed"
                                    type="button" data-toggle="collapse" data-target="#collapseFour"
                                    aria-expanded="false" aria-controls="collapseFour">
                                ¿Qué hacer si tengo un dolor de muelas intenso?
                            </button>
                        </h2>
                    </div>
                    <div id="collapseFour" class="collapse" aria-labelledby="headingFour" data-parent="#faqAccordion">
                        <div class="card-body">
                            Si experimentas un dolor de muelas intenso, debes contactar a tu dentista lo antes
                            posible. Puedes
                            tomar analgésicos de venta libre para aliviar el dolor temporalmente, pero es
                            fundamental que recibas
                            atención profesional para tratar la causa subyacente. El dolor intenso puede ser señal
                            de una infección
                            o un problema serio que necesita tratamiento inmediato.
                        </div>
                    </div>
                </div>

                <!-- Pregunta 5 -->
                <div class="card mb-3 border-0 rounded-lg fade-in fade-in-delay-7">
                    <div class="card-header bg-light border-0 rounded-top" id="headingFive">
                        <h2 class="mb-0">
                            <button class="accordion-button btn btn-link btn-block text-left font-weight-bold collapsed"
                                    type="button" data-toggle="collapse" data-target="#collapseFive"
                                    aria-expanded="false" aria-controls="collapseFive">
                                ¿Qué es el blanqueamiento dental y es seguro?
                            </button>
                        </h2>
                    </div>
                    <div id="collapseFive" class="collapse" aria-labelledby="headingFive" data-parent="#faqAccordion">
                        <div class="card-body">
                            El blanqueamiento dental es un procedimiento que utiliza agentes blanqueadores para
                            reducir las manchas y
                            la decoloración de los dientes. Cuando se realiza bajo la supervisión de un dentista
                            calificado,
                            es generalmente seguro y efectivo. Es importante seguir las instrucciones del dentista
                            para evitar
                            efectos secundarios, como la sensibilidad dental o el dado a las encías.
                        </div>
                    </div>
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
        <!-- Footer -->
        <%@include file="footer.jsp"%>

        <!-- Bootstrap JS and dependencies -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>

</html>