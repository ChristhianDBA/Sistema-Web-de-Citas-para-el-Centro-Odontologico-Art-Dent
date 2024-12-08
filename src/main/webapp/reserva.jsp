<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="/css/style.css">
        <title>Reserva cita</title>
    </head>
    <body class="d-flex flex-column min-vh-100">

        <%@include file="header.jsp" %> <!-- Incluye la cabecera -->

        <div class="container flex-grow-1">

            <!-- Aquí incluyes el formulario de reserva, que ya estará cargado con los servicios -->
            <jsp:include page="formularioreserva.jsp" />

        </div>

        <%@include file="footer.jsp" %> <!-- Incluye el pie de página -->

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
