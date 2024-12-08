package pe.edu.utp.config;

import java.sql.Connection;
import java.sql.DriverManager;

public class Conexion {
    public static Connection getConection() {
        Connection conn = null;
        try {
            // Cargar el driver manualmente
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Ajusta los parámetros de conexión según tu base de datos
            String url = "jdbc:mysql://localhost:3306/db_artdent?serverTimezone=America/Lima";
            String user = "root";
            String password = "root";
            conn = DriverManager.getConnection(url, user, password);
            System.out.println("Conexión correcta");
        } catch (Exception e) {
            System.out.println("error de conexion");
            e.printStackTrace();
        }
        return conn;
    }
}
