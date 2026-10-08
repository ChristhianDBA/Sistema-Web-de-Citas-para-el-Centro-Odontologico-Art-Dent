<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.util.Iterator"%>
<%@page import="pe.edu.utp.daoImpl.ServicioDaoImpl"%>
<%@page import="pe.edu.utp.entity.Servicio"%>
<%@page import="java.util.List"%>
<%@page import="pe.edu.utp.dao.ServicioDao"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="es">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Servicios</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@700&family=Open+Sans:wght@400&display=swap"
              rel="stylesheet">
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

            /* Clase reutilizable */
            .fade-in {
                opacity: 0;
                animation: fadeInEffect 1.5s ease-in-out forwards;
            }

            /* Retrasos personalizados */
            .fade-in-delay-1 { animation-delay: 0.5s; }
            .fade-in-delay-2 { animation-delay: 1s; }
            .fade-in-delay-3 { animation-delay: 1.5s; }
            
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

        <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
            <div class="container-fluid">
                <%@include file="header.jsp"%>
            </div>
        </nav>
                <!-- Sección con fondo de imagen -->
        <section class="py-5 text-white fade-in fade-in-delay-1 position-relative" 
                 style="background-image: url('https://images.unsplash.com/photo-1629909613654-28e377c37b09?auto=format&fit=crop&w=1920&q=80'); background-size: cover; background-position: center; min-height: 420px; display: flex; align-items: center;">
            <!-- Capa oscura superpuesta para legibilidad -->
            <div class="position-absolute top-0 start-0 w-100 h-100 bg-dark" style="opacity: 0.55; z-index: 1;"></div>

            <!-- Contenido principal -->
            <div class="container position-relative text-center px-4 py-5" style="z-index: 2;">
                <h1 class="display-4 fw-bold fade-in fade-in-delay-2 text-white mb-3">Nuestros Servicios</h1>
                <p class="lead fade-in fade-in-delay-3 text-white mx-auto" style="max-width: 850px; font-size: 1.25rem;">
                    En nuestra clínica dental, ofrecemos una amplia gama de servicios para cuidar de tu salud bucodental. 
                    Nuestro equipo de profesionales está comprometido con brindarte la mejor atención en un ambiente cómodo y seguro.
                </p>
            </div>
        </section>
        <!-- Sección de servicios con tarjetas animadas -->
        <section class="py-5">
            <div class="container">
                <div class="row">
                    <c:set var="itemsToDisplay" value="${not empty listServicio ? listServicio : servicios}" />
                    <c:forEach var="servicio" items="${itemsToDisplay}">
                        <div class="col-md-6 col-lg-3 mb-4 fade-in fade-in-delay-1">
                            <div class="card h-100 shadow-sm border-0 rounded-3 overflow-hidden">
                                <img src="${servicio.linkimagen}" 
                                     onerror="fallbackDentalImg(this, '${servicio.tipoServicio}');" 
                                     class="card-img-top img-fluid card-image" 
                                     style="height: 200px; object-fit: cover; width: 100%;" 
                                     alt="${servicio.tipoServicio}">
                                <div class="card-body d-flex flex-column p-4">
                                    <h5 class="card-title fw-bold text-dark mb-2">${servicio.tipoServicio}</h5>
                                    <p class="card-text text-muted flex-grow-1">
                                        <c:choose>
                                            <c:when test="${fn:length(servicio.descripcion) > 110}">
                                                ${fn:substring(servicio.descripcion, 0, 110)}...
                                            </c:when>
                                            <c:otherwise>
                                                ${servicio.descripcion}
                                            </c:otherwise>
                                        </c:choose>
                                    </p>
                                    <a href="ServicioController?action=cargar&id=${servicio.idServicio}" class="btn btn-primary rounded-pill mt-3 py-2">Leer más</a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </section>

        <script>
        function fallbackDentalImg(img, title) {
            img.onerror = null;
            var t = (title || '').toLowerCase();
            if (t.indexOf('blanqueamiento') !== -1) {
                img.src = 'https://img.freepik.com/foto-gratis/primer-plano-mujer-dientes-blancos-perfectos_186202-4573.jpg';
            } else if (t.indexOf('caries') !== -1) {
                img.src = 'https://img.freepik.com/foto-gratis/dentista-examinando-dientes-paciente-femenino-espejo-bucal_23-2149176709.jpg';
            } else if (t.indexOf('endodoncia') !== -1) {
                img.src = 'https://img.freepik.com/foto-gratis/dentista-tratando-paciente-clinica_23-2149176729.jpg';
            } else if (t.indexOf('prótesis') !== -1 || t.indexOf('protesis') !== -1) {
                img.src = 'https://img.freepik.com/foto-gratis/dentista-sosteniendo-protesis-dental_23-2149176719.jpg';
            } else if (t.indexOf('cirug') !== -1) {
                img.src = 'https://img.freepik.com/foto-gratis/medico-examinando-dientes-paciente-femenino-usando-herramientas-dentales_23-2149176721.jpg';
            } else if (t.indexOf('ortodoncia') !== -1) {
                img.src = 'https://img.freepik.com/foto-gratis/paciente-femenina-que-muestra-sus-nuevos-frenillos-dental-clinica_23-2149301072.jpg';
            } else if (t.indexOf('2.0') !== -1) {
                img.src = 'https://img.freepik.com/foto-gratis/dentista-realizando-higiene-bucal-paciente_23-2149176715.jpg';
            } else {
                img.src = 'https://img.freepik.com/foto-gratis/primer-plano-dentista-limpiando-dientes-paciente_23-2149176713.jpg';
            }
        }
        </script>

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

                // Enviar mensaje al presionar Enter
                const preguntaInput = document.getElementById('pregunta');
                if(preguntaInput){
                    preguntaInput.addEventListener('keypress', function (e) {
                        if (e.key === 'Enter') {
                            e.preventDefault();
                            enviarPregunta();
                        }
                    });
                }

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

                mensajeDiv.innerHTML = mensaje;

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
        <%@include file="footer.jsp"%>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>

</html>