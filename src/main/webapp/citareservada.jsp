<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@700&family=Open+Sans:wght@400&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="/css/style.css">
        <title>Reserva cita</title>
    </head>

    <body>

        <%@include file="header.jsp"%>
        <div class="container my-5">
            <h1 class="text-center" style="color: darkblue;">Cita Reservada</h1>

            <div class="d-flex align-items-center">
                <p class="fs-5 flex-grow-1">
                    ¡Su cita ha sido reservada con éxito! En breves momentos le llegará un correo con los datos de la cita y el boucher que deberá presentar el día de su cita.
                </p>
                <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSd_sY3lepDSDeBVnqjZh3k_3vyiGmBqPC0HFibHJoSRTg2ImiCkb06-4Dd_XXB29-Q3AI&usqp=CAU" 
                     class="img-fluid ms-3" alt="Imagen confirmación de cita" style="max-width: 150px;">
            </div>
        </div>
        <%@include file="footer.jsp"%>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>


</html>