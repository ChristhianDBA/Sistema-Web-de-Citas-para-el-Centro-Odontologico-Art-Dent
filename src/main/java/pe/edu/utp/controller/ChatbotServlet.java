package pe.edu.utp.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.json.Json;
import javax.json.JsonObject;
import javax.json.JsonReader;
import java.io.StringReader;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.StringJoiner;
import pe.edu.utp.config.Conexion;

@WebServlet("/api/chatbot")
public class ChatbotServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");

        String pregunta = request.getParameter("pregunta");

        String serviciosInfo = obtenerServiciosDeBaseDeDatos();
        // Construir el mensaje a enviar a la API de OpenAI
        String mensajeParaGPT = "Eres un chatbot integrado en la plataforma de Art Dent, una clínica dental. "
                + "Tu tarea es recomendar servicios dentales basados en los síntomas o preocupaciones que el usuario mencione. "
                + "Utiliza la siguiente información sobre los servicios disponibles para hacer tus recomendaciones:\\n" + serviciosInfo
                + "\\nEl usuario pregunta: " + pregunta
                + "\\nResponde de manera amable y profesional, explicando por qué recomiendas cierto servicio basado en los síntomas mencionados. "
                + "Si el usuario pregunta por el costo, inclúyelo en tu respuesta. "
                + "Si el usuario solicita algo no relacionado con servicios dentales, responde cortésmente y trata de redirigir la conversación hacia la salud dental. "
                + "Usa '\\n' para los saltos de línea en tu respuesta. "
                + "Si mencionas un servicio específico, incluye un enlace en este formato: (http://localhost:8089/ArtDent/ServicioController?action=cargar&id=IdDelServicio) "
                + "donde reemplazas IdDelServicio con el id correspondiente del servicio del que estás hablando.";

        System.out.println(mensajeParaGPT);

        if (pregunta == null || pregunta.trim().isEmpty()) {
            response.getWriter().write("Por favor, describe tus síntomas o preocupaciones dentales.");
            return;
        }

        String apiKey = "API DE OPEN IA";

        HttpClient client = HttpClient.newHttpClient();
        String body = String.format(
                "{ \"model\": \"gpt-4o\", "
                + "\"messages\": [ "
                + "{ \"role\": \"user\", "
                + "\"content\": \"%s\" } ] }",
                mensajeParaGPT.replace("\"", "\\\"")
        );

        HttpRequest requestApi = HttpRequest.newBuilder()
                .uri(URI.create("https://api.openai.com/v1/chat/completions"))
                .header("Content-Type", "application/json")
                .header("Authorization", "Bearer " + apiKey)
                .POST(HttpRequest.BodyPublishers.ofString(body))
                .build();

        try {
            HttpResponse<String> apiResponse = client.send(requestApi, HttpResponse.BodyHandlers.ofString());

            JsonReader jsonReader = Json.createReader(new StringReader(apiResponse.body()));
            JsonObject jsonResponse = jsonReader.readObject();
            jsonReader.close();

            if (jsonResponse.containsKey("choices") && !jsonResponse.getJsonArray("choices").isEmpty()) {
                JsonObject messageObject = jsonResponse.getJsonArray("choices").getJsonObject(0).getJsonObject("message");
                if (messageObject != null && messageObject.containsKey("content")) {
                    String content = messageObject.getString("content");
                    PrintWriter out = response.getWriter();
                    out.print(content);
                    out.flush();
                } else {
                    throw new Exception("La respuesta de la API no contiene el campo 'content' esperado");
                }
            } else {
                throw new Exception("La respuesta de la API no contiene el campo 'choices' esperado");
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Error en la consulta a la API: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private String obtenerServiciosDeBaseDeDatos() {
        StringJoiner servicios = new StringJoiner("\\n");
        String sql = "SELECT * FROM servicio";

        try (Connection conn = Conexion.getConection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("idServicio");
                String tipoServicio = rs.getString("TipoServicio");
                String lema = rs.getString("Lema");
                double costo = rs.getDouble("Costo");
                servicios.add(String.format("ID: %d, Tipo: %s, Lema: %s, Costo: %.2f", 
                                            id, tipoServicio, lema, costo));
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "Error al obtener los servicios: " + e.getMessage();
        }

        return servicios.toString();
    }
}