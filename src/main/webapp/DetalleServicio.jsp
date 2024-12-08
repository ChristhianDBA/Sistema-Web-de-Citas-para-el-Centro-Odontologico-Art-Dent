<%@page import="pe.edu.utp.entity.Servicio"%>
<%@page import="java.util.List"%>
<%@page import="pe.edu.utp.daoImpl.ServicioDaoImpl"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>DetalleServicio</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@700&family=Open+Sans:wght@400&display=swap"
              rel="stylesheet">
    </head>
    <style>
        .fade-in {
                opacity: 0;
                animation: fadeIn 1s ease-in-out forwards;
            }

            /* Retardo de la animaci?n para cada elemento */
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
            .fade-in-delay-6 {
                animation-delay: 3s;
            }
            

            @keyframes fadeIn {
                to {
                    opacity: 1;
                }
            }
    </style>
    <body>
        <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
            <div class="container-fluid">
                <%@include file="header.jsp"%>
            </div>
        </nav>

    <c:if test="${not empty servicio}">
        <!-- Fondo de imagen -->
        <div class="bg-dark text-white position-relative fade-in"
             style="background-image: url('${servicio.linkimagen}'); background-size: cover; background-position: center; height: 500px;">
            <div class="position-absolute top-0 start-0 w-100 h-100 bg-dark opacity-50"></div>
            <div class="container d-flex flex-column justify-content-center align-items-center h-100 text-center position-relative">
                <h1 class="display-4 fade-in fade-in-delay-1">${servicio.tipoServicio}</h1>
                <p class="lead fade-in fade-in-delay-2">${servicio.lema}</p>
            </div>
        </div>

        <!-- Contenido del servicio -->
        <div class="container mt-5 pb-4 mb-4">
            <main>
                <article class="mb-4">
                    <h2 style="color: darkblue" class="mb-4 fade-in fade-in-delay-3">¿Qué es?</h2>
                    <p class="fade-in fade-in-delay-4">${servicio.descripcion}</p> <!-- Mostrar la descripci?n del servicio -->
                </article>

                <article class="mb-4">
                    <h2 style="color: darkblue" class="mb-4 fade-in fade-in-delay-5">¿Necesito llevar aparato de dientes?</h2>
                    <p class="fade-in fade-in-delay-6">${servicio.respuesta}</p>
                </article>
            </main>
        </div>

    </c:if>

</body>
     <%@include file="footer.jsp"%>


</html>