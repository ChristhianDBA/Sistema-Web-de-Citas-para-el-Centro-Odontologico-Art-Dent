<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ArtDent - Editar Servicio</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #4e73df;
            --secondary-color: #1cc88a;
            --background-color: #f8f9fc;
            --text-color: #5a5c69;
        }
        body {
            font-family: 'Poppins', sans-serif;
            background-color: var(--background-color);
            color: var(--text-color);
        }
        .content {
            padding: 2rem;
        }
        .form-container {
            background-color: #fff;
            border-radius: 0.5rem;
            padding: 2rem;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
        }
    </style>
</head>
<body>
    <%@include file="NavPanel.jsp" %>

    <div class="container-fluid">
        <div class="row">
            <%@include file="ADMPSlidebar.jsp"%>

            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 content">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">Editar Servicio</h1>
                </div>

                <div class="form-container">
                    <form action="ServicioController?action=update" method="post">
                        <input type="hidden" name="id" value="${servicio.idServicio}">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="tipoServicio" class="form-label">Tipo de Servicio</label>
                                <input type="text" class="form-control" id="tipoServicio" name="tipoServicio" value="${servicio.tipoServicio}" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="lema" class="form-label">Lema</label>
                                <input type="text" class="form-control" id="lema" name="lema" value="${servicio.lema}" required>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="descripcion" class="form-label">Descripción</label>
                            <textarea class="form-control" id="descripcion" name="descripcion" rows="3" required>${servicio.descripcion}</textarea>
                        </div>
                        <div class="mb-3">
                            <label for="respuesta" class="form-label">Respuesta</label>
                            <textarea class="form-control" id="respuesta" name="respuesta" rows="3" required>${servicio.respuesta}</textarea>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="costo" class="form-label">Costo</label>
                                <input type="number" step="0.01" class="form-control" id="costo" name="costo" value="${servicio.costo}" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="img" class="form-label">URL de la Imagen</label>
                                <input type="text" class="form-control" id="img" name="img" value="${servicio.linkimagen}">
                            </div>
                        </div>
                        <button type="submit" class="btn btn-primary">Actualizar Servicio</button>
                        <a href="ServicioController?action=list" class="btn btn-secondary">Cancelar</a>
                    </form>
                </div>
            </main>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>