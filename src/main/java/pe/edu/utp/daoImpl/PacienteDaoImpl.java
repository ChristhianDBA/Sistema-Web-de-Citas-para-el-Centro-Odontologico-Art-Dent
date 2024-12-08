/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.utp.daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import pe.edu.utp.config.Conexion;
import pe.edu.utp.dao.PacienteDao;
import pe.edu.utp.entity.Paciente;

/**
 *
 * @author
 */
public class PacienteDaoImpl implements PacienteDao {

    private PreparedStatement ps;
    private ResultSet rs;
    private Connection cx;

    @Override
    public Paciente obtenerPacientePorDNI(String dni) {
        Paciente paciente = null;
        String SQL = "SELECT * FROM paciente WHERE DNI = ?";
        
        try {
            cx = Conexion.getConection();
            ps = cx.prepareStatement(SQL);
            ps.setString(1, dni);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                paciente = new Paciente();
                paciente.setIdPaciente(rs.getInt("idPaciente"));
                paciente.setNombre(rs.getString("Nombre"));
                paciente.setApellido(rs.getString("Apellido"));
                paciente.setDni(rs.getInt("DNI"));
                paciente.setTelefono(rs.getInt("Telefono"));
                paciente.setCorreo(rs.getString("Correo"));
            }
            
        } catch (SQLException e) {
            System.out.println("Error al obtener el paciente: " + e);
        }
        
        return paciente;
    }
}
