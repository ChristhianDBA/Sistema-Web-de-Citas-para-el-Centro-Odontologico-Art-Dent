<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Servicios</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
</head>
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
        .sidebar {
            background-color: var(--primary-color);
            min-height: 100vh;
            transition: all 0.3s;
        }
        .sidebar .nav-link {
            color: rgba(255,255,255,.8);
            transition: all 0.3s;
            border-radius: 0.25rem;
            margin-bottom: 0.5rem;
        }
        .sidebar .nav-link:hover, .sidebar .nav-link.active {
            color: #fff;
            background-color: rgba(255,255,255,.1);
        }
        .content {
            padding: 2rem;
        }
        .card {
            border-left: 4px solid var(--primary-color);
            transition: all 0.3s;
            border-radius: 0.5rem;
        }
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
        }
        .card-icon {
            color: var(--primary-color);
            font-size: 2rem;
        }
        .navbar {
            background-color: #fff;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
        }
        .table {
            background-color: #fff;
            border-radius: 0.5rem;
            overflow: hidden;
        }
        .table th {
            background-color: var(--primary-color);
            color: #fff;
        }
        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }
        .btn-primary:hover {
            background-color: #4262c5;
            border-color: #4262c5;
        }
        .form-container {
            background-color: #fff;
            border-radius: 0.5rem;
            padding: 2rem;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
        }
    </style>
<body>
    <%
    HttpSession misesion = request.getSession();
    String usuario = (String) request.getSession().getAttribute("Nombre");
    if (usuario == null) {
        response.sendRedirect("iniciosesionerror.jsp");
    }
    %>

    <%@include file="NavPanel.jsp" %>
    <div class="container-fluid">
        <div class="row">
            <!-- Incluir sidebar aquí -->
            <%@include file="ADMPSlidebar.jsp"%>

            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">Gestión de Servicios</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <button class="btn btn-sm btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#addServiceModal">
                            <i class="bi bi-plus-circle"></i> Nuevo Servicio
                        </button>
                    </div>
                </div>

                <div class="table-responsive">
                    <table class="table table-striped table-sm">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Tipo de Servicio</th>
                                <th>Lema</th>
                                <th>Costo</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="servicio" items="${listServicio}">
                                <tr>
                                    <td><c:out value="${servicio.idServicio}" /></td>
                                    <td><c:out value="${servicio.tipoServicio}" /></td>
                                    <td><c:out value="${servicio.lema}" /></td>
                                    <td><c:out value="${servicio.costo}" /></td>
                                    <td>
                                        <a href="ServicioController?action=edit&id=<c:out value='${servicio.idServicio}' />" class="btn btn-primary btn-sm">
                                            <i class="bi bi-pencil"></i> Editar
                                        </a>
                                        <a href="#" onclick="confirmDelete(${servicio.idServicio})" class="btn btn-danger btn-sm">
                                            <i class="bi bi-trash"></i> Eliminar
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </main>
        </div>
    </div>

    <!-- Add Service Modal -->
    <div class="modal fade" id="addServiceModal" tabindex="-1" aria-labelledby="addServiceModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addServiceModalLabel">Agregar Nuevo Servicio</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="ServicioController?action=insert" method="post">
                        <div class="mb-3">
                            <label for="tipoServicio" class="form-label">Tipo de Servicio</label>
                            <input type="text" class="form-control" id="tipoServicio" name="tipoServicio" required>
                        </div>
                        <div class="mb-3">
                            <label for="lema" class="form-label">Lema</label>
                            <input type="text" class="form-control" id="lema" name="lema" required>
                        </div>
                        <div class="mb-3">
                            <label for="descripcion" class="form-label">Descripción</label>
                            <textarea class="form-control" id="descripcion" name="descripcion" rows="3" required></textarea>
                        </div>
                        <div class="mb-3">
                            <label for="respuesta" class="form-label">Respuesta</label>
                            <textarea class="form-control" id="respuesta" name="respuesta" rows="3" required></textarea>
                        </div>
                        <div class="mb-3">
                            <label for="costo" class="form-label">Costo</label>
                            <input type="number" step="0.01" class="form-control" id="costo" name="costo" required>
                        </div>
                        <div class="mb-3">
                            <label for="img" class="form-label">URL de la Imagen</label>
                            <input type="text" class="form-control" id="img" name="img">
                        </div>
                        <button type="submit" class="btn btn-primary">Guardar Servicio</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function confirmDelete(id) {
            if (confirm("¿Está seguro de que desea eliminar este servicio?")) {
                window.location.href = "ServicioController?action=delete&id=" + id;
            }
        }
    </script>
</body>
</html>

