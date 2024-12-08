/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.utp.daoImpl;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import pe.edu.utp.config.Conexion;
import pe.edu.utp.dao.UsuarioDao;
import pe.edu.utp.dto.InicioSesionDTO;
import pe.edu.utp.entity.Usuario;

/**
 *
 * @author Christhian
 */
public class UsuarioDaoImpl implements UsuarioDao {

    private PreparedStatement ps;
    private ResultSet rs;
    private Connection cx;

    @Override
    public List<InicioSesionDTO> login(String dni, String password) {
        List<InicioSesionDTO> lista = new ArrayList<>();

        String SQL = "{call sp_iniciosesion (?,?)}";

        try {
            cx = Conexion.getConection();
            ps = cx.prepareStatement(SQL);
            ps.setString(1, dni);
            ps.setString(2, password);
            rs = ps.executeQuery();

            while (rs.next()) {
                InicioSesionDTO login = new InicioSesionDTO();
                login.setIdUsuario(rs.getInt("idUsuario"));
                login.setNombre(rs.getString("Nombre"));
                login.setApellido(rs.getString("Apellido"));
                login.setDni(rs.getInt("DNI"));
                login.setTipoRol(rs.getString("TipoRol"));

                lista.add(login);
            }

        } catch (SQLException e) {
            System.out.println("Inicio Sesion erroneo: " + e);
        }

        return lista;
    }

    @Override
    public List<Usuario> obtenerMedicosDisponibles() {
        List<Usuario> medicos = new ArrayList<>();
        String sql = "SELECT * FROM usuario WHERE Rol_idRol = 3";

        try {
            cx = Conexion.getConection();
            ps = cx.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Usuario medico = new Usuario();
                medico.setIdUsuario(rs.getInt("idUsuario"));
                medico.setApellido(rs.getString("Apellido"));
                medico.setNombre(rs.getString("Nombre"));
                medicos.add(medico);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return medicos;
    }

    @Override
    public List<Usuario> obtenerMedicosPorServicioYDisponibilidad(int idServicio, LocalDate fechaConv, LocalTime horaObj) {
        List<Usuario> medicos = new ArrayList<>();

        // Rango de tiempo de la nueva cita (inicio y fin)
        LocalTime horaFin = horaObj.plusMinutes(45); // Hora de fin de la nueva cita

        // Convertir la fecha a texto para obtener el día de la semana
        String diaSemanaTexto = convertirDiaSemana(fechaConv);

        String sql = "SELECT DISTINCT u.idUsuario, u.Nombre, u.Apellido "
                + "FROM usuario u "
                + "INNER JOIN Usuario_Servicio us ON u.idUsuario = us.idUsuario "
                + "LEFT JOIN Reserva r ON u.idUsuario = r.Odontologo_idUsuario AND r.DiaReserva = ? "
                + "LEFT JOIN Cita c ON u.idUsuario = c.Odontologo_idUsuario AND c.DiaReserva = ? "
                + "INNER JOIN Usuario_Horario uh ON u.idUsuario = uh.Usuario_idUsuario "
                + "INNER JOIN Horario h ON uh.Horario_idHorario = h.idHorario "
                + "WHERE us.idServicio = ? " // Filtra por servicio
                + "AND us.Disponibilidad = 1 " // Verifica que el médico esté disponible
                + "AND LOWER(h.diaSemana) = ? " // Verifica que el médico trabaje ese día de la semana
                + "AND (r.HoraReserva IS NULL OR NOT (r.HoraReserva BETWEEN ? AND ?)) " // Verifica que no haya reservas en el rango de tiempo
                + "AND (c.HoraReserva IS NULL OR NOT (c.HoraReserva BETWEEN ? AND ?)) " // Verifica que no haya citas en el rango de tiempo
                + "AND (r.HoraReserva IS NULL OR NOT (? BETWEEN r.HoraReserva AND ADDTIME(r.HoraReserva, '00:45:00'))) " // Verifica que el nuevo rango no choque con el fin de la reserva
                + "AND (c.HoraReserva IS NULL OR NOT (? BETWEEN c.HoraReserva AND ADDTIME(c.HoraReserva, '00:45:00')))"; // Verifica que el nuevo rango no choque con el fin de la cita

        try (Connection cx = Conexion.getConection(); PreparedStatement ps = cx.prepareStatement(sql)) {
            System.out.println("ps. "+ps);
            // Asignación de parámetros
            ps.setDate(1, java.sql.Date.valueOf(fechaConv)); // Fecha para la tabla de reservas
            ps.setDate(2, java.sql.Date.valueOf(fechaConv)); // Fecha para la tabla de citas
            ps.setInt(3, idServicio); // ID del servicio
            ps.setString(4, diaSemanaTexto); // Día de la semana en texto (por ejemplo, "lunes")

            // Cálculo del rango de tiempo de la cita (inicio y fin)
            ps.setTime(5, java.sql.Time.valueOf(horaObj)); // Hora inicio para reservas
            ps.setTime(6, java.sql.Time.valueOf(horaFin)); // Hora fin para reservas
            ps.setTime(7, java.sql.Time.valueOf(horaObj)); // Hora inicio para citas
            ps.setTime(8, java.sql.Time.valueOf(horaFin)); // Hora fin para citas
            ps.setTime(9, java.sql.Time.valueOf(horaObj)); // Hora inicio para comparaciones con reservas
            ps.setTime(10, java.sql.Time.valueOf(horaObj)); // Hora fin para comparaciones con reservas

            try (ResultSet rs = ps.executeQuery()) {
                // Procesamiento de resultados
                while (rs.next()) {
                    Usuario medico = new Usuario();
                    medico.setIdUsuario(rs.getInt("idUsuario"));
                    medico.setNombre(rs.getString("Nombre"));
                    medico.setApellido(rs.getString("Apellido"));
                    medicos.add(medico);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return medicos;
    }

    private String convertirDiaSemana(LocalDate fecha) {
        // Convierte el día al nombre en español, por ejemplo, "lunes", "martes", etc.
        switch (fecha.getDayOfWeek()) {
            case MONDAY:
                return "lunes";
            case TUESDAY:
                return "martes";
            case WEDNESDAY:
                return "miércoles";
            case THURSDAY:
                return "jueves";
            case FRIDAY:
                return "viernes";
            case SATURDAY:
                return "sábado";
            case SUNDAY:
                return "domingo";
            default:
                throw new IllegalArgumentException("Día inválido");
        }
    }

    @Override
    public List<Usuario> listarUsuarios() {
        List<Usuario> lista = new ArrayList<>();
        String SQL = "{call sp_listarUsuarios()}";

        try {
            cx = Conexion.getConection();
            ps = cx.prepareStatement(SQL);
            rs = ps.executeQuery();

            while (rs.next()) {
                Usuario usuario = new Usuario();
                usuario.setIdUsuario(rs.getInt("idUsuario"));
                usuario.setNombre(rs.getString("Nombre"));
                usuario.setCorreoElectronico(rs.getString("CorreoElectronico"));
                usuario.setRol(rs.getString("RolN"));
                lista.add(usuario);
            }

        } catch (SQLException e) {
            System.out.println("Error al listar usuarios: " + e);
        }
        return lista;
    }

    @Override
    public boolean registrarUsuario(Usuario usuario) {
        String SQL = "{call sp_insertarUsuario(?,?,?,?,?,?,?,?,?)}";
        boolean resultado = false;

        try {
            cx = Conexion.getConection();
            ps = cx.prepareStatement(SQL);
            ps.setString(1, usuario.getNombre());
            ps.setString(2, usuario.getApellido());
            ps.setInt(3, usuario.getDni());
            ps.setString(4, usuario.getTelefono());
            ps.setString(5, usuario.getCorreoElectronico());
            ps.setString(6, usuario.getDireccion());
            ps.setDate(7, Date.valueOf(usuario.getFechaNacimiento()));
            ps.setString(8, usuario.getClave());
            ps.setInt(9, usuario.getRol_idRol());

            resultado = ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.out.println("Error al registrar usuario: " + e);
        }

        return resultado;
    }

    @Override
    public Usuario obtenerUsuarioPorId(int id) {
        String SQL = "{call sp_obtenerUsuarioPorId(?)}";
        Usuario usuario = null;

        try {
            cx = Conexion.getConection();
            ps = cx.prepareStatement(SQL);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                usuario = new Usuario();
                usuario.setIdUsuario(rs.getInt("idUsuario"));
                usuario.setNombre(rs.getString("Nombre"));
                usuario.setApellido(rs.getString("Apellido"));
                usuario.setDni(rs.getInt("Dni"));
                usuario.setTelefono(rs.getString("Telefono"));
                usuario.setCorreoElectronico(rs.getString("CorreoElectronico"));
                usuario.setDireccion(rs.getString("Direccion"));
                usuario.setFechaNacimiento(rs.getString("FechaNacimiento"));
                usuario.setClave(rs.getString("Clave"));
                usuario.setRol_idRol(rs.getInt("Rol_idRol"));
                usuario.setRol(rs.getString("RolN"));
            }

        } catch (SQLException e) {
            System.out.println("Error al obtener usuario por ID: " + e);
        }

        return usuario;
    }

    @Override
    public boolean actualizarUsuario(Usuario usuario) {
        String SQL = "{call sp_actualizarUsuario(?,?,?,?,?,?,?,?,?,?)}";
        boolean resultado = false;

        try {
            cx = Conexion.getConection();
            ps = cx.prepareStatement(SQL);
            ps.setInt(1, usuario.getIdUsuario());
            ps.setString(2, usuario.getNombre());
            ps.setString(3, usuario.getApellido());
            ps.setInt(4, usuario.getDni());
            ps.setString(5, usuario.getTelefono());
            ps.setString(6, usuario.getCorreoElectronico());
            ps.setString(7, usuario.getDireccion());
            ps.setDate(8, Date.valueOf(usuario.getFechaNacimiento()));
            ps.setString(9, usuario.getClave());
            ps.setInt(10, usuario.getRol_idRol());
            
            resultado = ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.out.println("Error al actualizar usuario: " + e);
        }

        return resultado;
    }

    @Override
    public boolean eliminarUsuario(int id) {
        String SQL = "{call sp_eliminarUsuario(?)}";
        boolean resultado = false;
        try {
            cx = Conexion.getConection();
            ps = cx.prepareStatement(SQL);
            ps.setInt(1, id);
            resultado = ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.out.println("Error al eliminar usuario: " + e);
        }

        return resultado;
    }

}
