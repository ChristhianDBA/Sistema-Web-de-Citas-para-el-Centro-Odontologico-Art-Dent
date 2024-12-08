<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Iniciar Sesión</title>
        <!-- Bootstrap CSS -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body class="m-0">
        <div class="container-fluid p-0">
            <div class="row no-gutters vh-100">
                <!-- Imagen a la izquierda (60%) -->
                <div class="col-md-7 p-0 d-flex align-items-center justify-content-center">
                    <img src="https://img.mitula.com/eyJidWNrZXQiOiJwcmQtbGlmdWxsY29ubmVjdC1iYWNrZW5kLWIyYi1pbWFnZXMiLCJrZXkiOiJwcm9wZXJ0aWVzLzUyYjUwMGVkLWJlNDktNDE3NS1hMWEyLWJhNWQzZmJhZjc1NS9lZDM3NDllZi0zMmNmLTQ4NzEtYTVlNC1kZmZkZmZiMTY5ZGMuanBnIiwiYnJhbmQiOiJNSVRVTEEiLCJlZGl0cyI6eyJyZXNpemUiOnsid2lkdGgiOjY1MiwiaGVpZ2h0Ijo0ODksImZpdCI6ImNvdmVyIn19fQ==" class="img-fluid h-100 w-100" alt="Imagen de fondo">
                </div>
                <!-- Formulario de login a la derecha (40%) -->
                <div class="col-md-5 d-flex align-items-center justify-content-center">
                    <form action="InicioSesionController" method="POST" class="w-75">
                        <div class="text-center mb-4">
                            <img style="width: 200px;" src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQUMiM165IHk0VqCysOh7uWnRK5yWnZkuNE_Q&s" class="img-fluid" alt="Imagen">
                        </div>
                        <h2 class="text-center mb-4" style="color: darkgray; font-weight: bold;">Iniciar sesión</h2>
                        <div class="form-group">
                            <label for="document">Nro de Documento</label>
                            <div class="input-group mb-3">
                                <input type="text" class="form-control" id="document" placeholder="Nro de Documento" name="document" style="height: 50px;">
                                <div class="input-group-append">
                                    <span class="input-group-text">
                                        <img src="https://cdn-icons-png.flaticon.com/512/1144/1144760.png" alt="Icono" style="width: 20px;">
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="password">Contraseña</label>
                            <div class="input-group mb-3">
                                <input type="password" class="form-control" id="password" placeholder="Contraseña" name="password" style="height: 50px;">
                                <div class="input-group-append">
                                    <span class="input-group-text">
                                        <img src="https://w7.pngwing.com/pngs/221/536/png-transparent-eye-password-see-view-minimalisticons-icon.png" alt="Icono" style="width: 20px;">
                                    </span>
                                </div>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-primary btn-block" style="height: 50px; font-weight: bold; font-size: 20px;">INICIAR SESIÓN</button>
                        <div class="d-flex justify-content-between align-items-center mt-3">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="rememberMe">
                                <label class="form-check-label" for="rememberMe">Recordar</label>
                            </div>
                            <a href="#" style="text-decoration: underline; color: darkblue;">Me olvidé mi contraseña</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- Bootstrap JS and dependencies -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
