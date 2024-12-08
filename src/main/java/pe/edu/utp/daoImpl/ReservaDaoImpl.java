/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.utp.daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import pe.edu.utp.config.Conexion;
import pe.edu.utp.dao.ReservaDao;
import pe.edu.utp.entity.Reserva;
import pe.edu.utp.entity.Paciente;
import pe.edu.utp.entity.Usuario;
import pe.edu.utp.entity.VerReserva;

/**
 *
 * @author Christhian
 */
public class ReservaDaoImpl implements ReservaDao {

    private PreparedStatement ps;
    private PreparedStatement ps1;

    private ResultSet rs;

    private Connection cx;

    @Override
    public int createReserva(Paciente p, Reserva r) {
        int x = 0;
        String SQL_1 = "{call sp_registrarusuario (?,?,?,?,?)}";  // Almacenar paciente
        String SQL_2 = "{call sp_crearreserva (?,?,?,?,?,?,?,?)}";  // Almacenar reserva
        try {
            // Obtener conexión
            cx = Conexion.getConection();
            if (cx == null) {
                System.out.println("No se pudo establecer conexión con la base de datos.");
                return x;  // Retorna 0 si no hay conexión
            }

            // Guardar el Paciente
            ps = cx.prepareStatement(SQL_1);
            ps.setString(1, p.getNombre());
            ps.setString(2, p.getApellido());
            ps.setInt(3, p.getDni());
            ps.setInt(4, p.getTelefono());
            ps.setString(5, p.getCorreo());
            x = ps.executeUpdate();  // Ejecutar y guardar paciente
            System.out.println("Inserción de paciente: " + x);

            // Guardar la Reserva
            if (x > 0) {  // Solo intentar guardar la reserva si se insertó el paciente
                ps1 = cx.prepareStatement(SQL_2);
                ps1.setString(1, r.getDiaReserva());
                ps1.setString(2, r.getHoraReserva());
                ps1.setString(3, r.getDescripcion());
                ps1.setDouble(4, r.getImporte());
                ps1.setInt(5, r.getUsuario_idUsuario());
                ps1.setInt(6, r.getEstado_idEstado()); // Este es el parámetro 6
                ps1.setInt(7, r.getServicio_idServicio());
                ps1.setInt(8, r.getOdontologo_idUsuario());

                x = ps1.executeUpdate();
                System.out.println("Inserción de reserva: " + x);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error al insertar " + e);
        } finally {
            // Cerrar recursos
            try {
                if (ps != null) {
                    ps.close();
                }
                if (ps1 != null) {
                    ps1.close();
                }
                if (cx != null) {
                    cx.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return x;
    }

    @Override
    public int updateReserva(int idReserva, String nuevaFecha, String nuevaHora) {
        // Obtener conexión
        cx = Conexion.getConection();
        if (cx == null) {
            System.out.println("No se pudo establecer conexión con la base de datos.");
            return 0;
        }

        // Nombre del procedimiento almacenado para actualizar la cita
        String SQL = "{CALL ps_ReprogramarReserva(?, ?, ?)}";

        try {
            // Preparar el statement con el procedimiento almacenado
            ps = cx.prepareStatement(SQL);
            ps.setInt(1, idReserva);
            ps.setString(2, nuevaFecha);
            ps.setString(3, nuevaHora);

            // Ejecutar la actualización
            int result = ps.executeUpdate();

            return result; // Retorna el número de filas afectadas
        } catch (SQLException e) {
            System.out.println("Error al actualizar la cita: " + e.getMessage());
            return 0;  // Retorna 0 si ocurrió un error
        } finally {
            // Cerrar recursos (PreparedStatement, Connection)
            try {
                if (ps != null) {
                    ps.close();
                }
                if (cx != null) {
                    cx.close();
                }
            } catch (SQLException e) {
                System.out.println("Error al cerrar recursos: " + e.getMessage());
            }
        }
    }

    @Override
    public int updateEstadoReserv(int idReserva, String estadoActual) {
        // Obtener conexión
        cx = Conexion.getConection();
        if (cx == null) {
            System.out.println("No se pudo establecer conexión con la base de datos.");
            return 0;
        }
        String SQL = "UPDATE reserva SET Estado_idEstado = ? WHERE idReserva = ?";
        int nuevoEstado;
        if ("Reprogramado".equalsIgnoreCase(estadoActual)) {
            nuevoEstado = 3;
        } else if ("Confirmado".equalsIgnoreCase(estadoActual)) {
            nuevoEstado = 2;
        } else if ("En espera".equalsIgnoreCase(estadoActual)) {
            nuevoEstado = 3;
        } else {
            System.out.println("El estado actual no es válido para la actualización.");
            return 0;
        }
        try {
            ps = cx.prepareStatement(SQL);
            ps.setInt(1, nuevoEstado);
            ps.setInt(2, idReserva);
            int result = ps.executeUpdate();

            return result;
        } catch (SQLException e) {
            System.out.println("Error al actualizar el estado de la reserva: " + e.getMessage());
            return 0;
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
                if (cx != null) {
                    cx.close();
                }
            } catch (SQLException e) {
                System.out.println("Error al cerrar recursos: " + e.getMessage());
            }
        }
    }

    @Override
    public int updateEstadoCancelado(int idReserva) {
        cx = Conexion.getConection();
        if (cx == null) {
            System.out.println("No se pudo establecer conexión con la base de datos.");
            return 0;
        }
        String SQL = "UPDATE reserva SET Estado_idEstado = 5 WHERE idReserva = ?";

        try {
            ps = cx.prepareStatement(SQL);
            ps.setInt(1, idReserva);
            int result = ps.executeUpdate();

            return result;
        } catch (SQLException e) {
            System.out.println("Error al actualizar el estado de la reserva: " + e.getMessage());
            return 0;
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
                if (cx != null) {
                    cx.close();
                }
            } catch (SQLException e) {
                System.out.println("Error al cerrar recursos: " + e.getMessage());
            }
        }
    }

    @Override
    public int deleteReserva(int idReserva) {
        cx = Conexion.getConection();
        if (cx == null) {
            System.out.println("No se pudo establecer conexión con la base de datos.");
            return 0;
        }
        String SQL = "DELETE FROM reserva WHERE idReserva = ?";

        try {
            ps = cx.prepareStatement(SQL);
            ps.setInt(1, idReserva);
            int result = ps.executeUpdate();

            return result;
        } catch (SQLException e) {
            System.out.println("Error al eliminar la reserva: " + e.getMessage());
            return 0;
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
                if (cx != null) {
                    cx.close();
                }
            } catch (SQLException e) {
                System.out.println("Error al cerrar recursos: " + e.getMessage());
            }
        }
    }

    @Override
    public Reserva readReserva(int id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public int createReservaPacex(Paciente p, Reserva r) {
        int x = 0;
        String SQL_2 = "{call sp_crearreserva (?,?,?,?,?,?,?,?)}";  // Almacenar reserva
        try {
            // Obtener conexión
            cx = Conexion.getConection();
            if (cx == null) {
                System.out.println("No se pudo establecer conexión con la base de datos.");
                return x;  // Retorna 0 si no hay conexión
            }
            ps1 = cx.prepareStatement(SQL_2);
            ps1.setString(1, r.getDiaReserva());
            ps1.setString(2, r.getHoraReserva());
            ps1.setString(3, r.getDescripcion());
            ps1.setDouble(4, r.getImporte());
            ps1.setInt(5, r.getUsuario_idUsuario());
            ps1.setInt(6, r.getEstado_idEstado()); // Este es el parámetro 6
            ps1.setInt(7, r.getServicio_idServicio());
            ps1.setInt(8, r.getOdontologo_idUsuario());

            x = ps1.executeUpdate();
            System.out.println("Inserción de reserva: " + x);
        } catch (SQLException ex) {
            Logger.getLogger(ReservaDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
        }

        return x;
    }

    @Override
    public int verificarExistencia(int dni) {
        // Obtener conexión
        cx = Conexion.getConection();
        if (cx == null) {
            System.out.println("No se pudo establecer conexión con la base de datos.");
            return 0;  // Retorna 0 si no hay conexión
        }
        String sql = "SELECT idPaciente FROM paciente WHERE DNI = ?";
        int idPaciente;

        try {
            ps = cx.prepareStatement(sql);
            ps.setInt(1, dni);
            rs = ps.executeQuery();

            if (rs.next()) {
                return idPaciente = rs.getInt("idPaciente");  // Devuelve el idPaciente si existe
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return 0;  // Devuelve el idPaciente si existe, o 0 si no se encontró
    }

    @Override
    public List<VerReserva> listarReservas(int idUsuario) {
        List<VerReserva> lista = new ArrayList<>();
        String SQL = "{call sp_ListarReservasPorUsuario(?)}";  // Procedimiento almacenado

        try {
            // Obtener la conexión
            cx = Conexion.getConection();
            // Preparar el statement con el procedimiento almacenado
            ps = cx.prepareStatement(SQL);
            ps.setInt(1, idUsuario);  // Pasar el ID del usuario

            // Ejecutar la consulta
            rs = ps.executeQuery();

            // Recorrer los resultados
            while (rs.next()) {
                VerReserva re = new VerReserva();
                re.setIdReserva(rs.getInt("idReserva"));
                re.setDiaReserva(rs.getString("DiaReserva"));
                re.setHoraReserva(rs.getString("HoraReserva"));
                re.setDescripcion(rs.getString("Descripcion"));
                re.setImporte(rs.getDouble("Importe"));
                re.setNombrePaciente(rs.getString("NombrePaciente"));
                re.setApellidoPaciente(rs.getString("ApellidoPaciente"));
                re.setEstado(rs.getString("EstadoReserva"));
                re.setTipoServicio(rs.getString("TipoServicio"));
                re.setNombreUsuario(rs.getString("NombreOdontologo"));
                re.setApellidoUsuario(rs.getString("ApellidoOdontologo"));
                lista.add(re);
            }
        } catch (SQLException e) {
            System.out.println("Error al obtener reservas: " + e.getMessage());
        } finally {
            // Cerrar recursos (ResultSet, PreparedStatement, Connection)
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (cx != null) {
                    cx.close();
                }
            } catch (SQLException e) {
                System.out.println("Error al cerrar recursos: " + e.getMessage());
            }
        }

        System.out.println("Total de reservas recuperadas: " + lista.size());
        return lista;
    }

    @Override
    public List<VerReserva> listarTodasReservas(int idUsuario) {
        List<VerReserva> lista = new ArrayList<>();
        String SQL = "{call sp_ListarReservasReporte(?)}";  // Procedimiento almacenado

        try {
            // Obtener la conexión
            cx = Conexion.getConection();
            // Preparar el statement con el procedimiento almacenado
            ps = cx.prepareStatement(SQL);
            ps.setInt(1, idUsuario);  // Pasar el ID del usuario

            // Ejecutar la consulta
            rs = ps.executeQuery();

            // Recorrer los resultados
            while (rs.next()) {
                VerReserva re = new VerReserva();
                re.setIdReserva(rs.getInt("idReserva"));
                re.setDiaReserva(rs.getString("DiaReserva"));
                re.setHoraReserva(rs.getString("HoraReserva"));
                re.setDescripcion(rs.getString("Descripcion"));
                re.setImporte(rs.getDouble("Importe"));
                re.setNombrePaciente(rs.getString("NombrePaciente"));
                re.setApellidoPaciente(rs.getString("ApellidoPaciente"));
                re.setEstado(rs.getString("EstadoReserva"));
                re.setTipoServicio(rs.getString("TipoServicio"));
                re.setNombreUsuario(rs.getString("NombreOdontologo"));
                re.setApellidoUsuario(rs.getString("ApellidoOdontologo"));
                lista.add(re);
            }
        } catch (SQLException e) {
            System.out.println("Error al obtener reservas: " + e.getMessage());
        } finally {
            // Cerrar recursos (ResultSet, PreparedStatement, Connection)
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (cx != null) {
                    cx.close();
                }
            } catch (SQLException e) {
                System.out.println("Error al cerrar recursos: " + e.getMessage());
            }
        }

        System.out.println("Total de reservas recuperadas: " + lista.size());
        return lista;
    }

    @Override
    public List<VerReserva> listarHistorialReservas(int idUsuario) {
        List<VerReserva> lista = new ArrayList<>();
        String SQL = "{call sp_ListarHistorialReservas(?)}";  // Procedimiento almacenado

        try {
            // Obtener la conexión
            cx = Conexion.getConection();
            // Preparar el statement con el procedimiento almacenado
            ps = cx.prepareStatement(SQL);
            ps.setInt(1, idUsuario);  // Pasar el ID del usuario

            // Ejecutar la consulta
            rs = ps.executeQuery();

            // Recorrer los resultados
            while (rs.next()) {
                VerReserva re = new VerReserva();
                re.setIdReserva(rs.getInt("idReserva"));
                re.setDiaReserva(rs.getString("DiaReserva"));
                re.setHoraReserva(rs.getString("HoraReserva"));
                re.setDescripcion(rs.getString("Descripcion"));
                re.setImporte(rs.getDouble("Importe"));
                re.setNombrePaciente(rs.getString("NombrePaciente"));
                re.setApellidoPaciente(rs.getString("ApellidoPaciente"));
                re.setEstado(rs.getString("EstadoReserva"));
                re.setTipoServicio(rs.getString("TipoServicio"));
                re.setNombreUsuario(rs.getString("NombreOdontologo"));
                re.setApellidoUsuario(rs.getString("ApellidoOdontologo"));
                lista.add(re);
            }
        } catch (SQLException e) {
            System.out.println("Error al obtener reservas: " + e.getMessage());
        } finally {
            // Cerrar recursos (ResultSet, PreparedStatement, Connection)
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (cx != null) {
                    cx.close();
                }
            } catch (SQLException e) {
                System.out.println("Error al cerrar recursos: " + e.getMessage());
            }
        }

        System.out.println("Total de reservas recuperadas: " + lista.size());
        return lista;
    }

    @Override
    public List<VerReserva> DetalleReserva(int idReserva) {
        List<VerReserva> lista = new ArrayList<>();
        String SQL = "{call sp_DetalleReserva(?)}";  // Procedimiento almacenado

        try {
            // Obtener la conexión
            cx = Conexion.getConection();
            // Preparar el statement con el procedimiento almacenado
            ps = cx.prepareStatement(SQL);
            ps.setInt(1, idReserva);  // Pasar el ID del usuario

            // Ejecutar la consulta
            rs = ps.executeQuery();

            // Recorrer los resultados
            while (rs.next()) {
                VerReserva re = new VerReserva();
                re.setIdReserva(rs.getInt("idReserva"));
                re.setDiaReserva(rs.getString("DiaReserva"));
                re.setHoraReserva(rs.getString("HoraReserva"));
                re.setDescripcion(rs.getString("Descripcion"));
                re.setImporte(rs.getDouble("Importe"));
                re.setNombrePaciente(rs.getString("NombrePaciente"));
                re.setApellidoPaciente(rs.getString("ApellidoPaciente"));
                re.setEstado(rs.getString("EstadoReserva"));
                re.setTipoServicio(rs.getString("TipoServicio"));
                re.setNombreUsuario(rs.getString("NombreOdontologo"));
                re.setApellidoUsuario(rs.getString("ApellidoOdontologo"));
                lista.add(re);
            }
        } catch (SQLException e) {
            System.out.println("Error al obtener reservas: " + e.getMessage());
        } finally {
            // Cerrar recursos (ResultSet, PreparedStatement, Connection)
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (cx != null) {
                    cx.close();
                }
            } catch (SQLException e) {
                System.out.println("Error al cerrar recursos: " + e.getMessage());
            }
        }

        System.out.println("Total de reservas recuperadas: " + lista.size());
        return lista;
    }

    @Override
    public List<VerReserva> listarReservasPorDia(String dia_semana) {
        List<VerReserva> lista = new ArrayList<>();
        String SQL = "{call ListarReservasSemanaActual(?)}";  // Procedimiento almacenado

        try {
            cx = Conexion.getConection();
            ps = cx.prepareStatement(SQL);
            ps.setString(1, dia_semana);

            rs = ps.executeQuery();

            while (rs.next()) {
                VerReserva re = new VerReserva();
                re.setIdReserva(rs.getInt("idReserva"));
                re.setDiaReserva(rs.getString("DiaReserva"));
                re.setHoraReserva(rs.getString("HoraReserva"));
                re.setDescripcion(rs.getString("Descripcion"));
                re.setImporte(rs.getDouble("Importe"));
                re.setNombrePaciente(rs.getString("NombrePaciente"));
                re.setApellidoPaciente(rs.getString("ApellidoPaciente"));
                re.setEstado(rs.getString("EstadoReserva"));
                re.setTipoServicio(rs.getString("TipoServicio"));
                re.setNombreUsuario(rs.getString("NombreOdontologo"));
                re.setApellidoUsuario(rs.getString("ApellidoOdontologo"));
                re.setDia_semana(rs.getString("dia_semana"));
                re.setOrden_row(rs.getInt("orden_row"));
                re.setColor(rs.getString("color"));
                lista.add(re);
            }
        } catch (SQLException e) {
            System.out.println("Error al obtener reservas: " + e.getMessage());
        } finally {
            // Cerrar recursos (ResultSet, PreparedStatement, Connection)
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (cx != null) {
                    cx.close();
                }
            } catch (SQLException e) {
                System.out.println("Error al cerrar recursos: " + e.getMessage());
            }
        }

        System.out.println("Total de reservas recuperadas: " + lista.size());
        return lista;
    }

    @Override
    public List<VerReserva> listarReservasPorDiaSemana(String dia_semana, int semanaActual) {
        List<VerReserva> lista = new ArrayList<>();
        String SQL = "{call ListarReservasPorDiaSemana(?, ?)}";

        try {
            cx = Conexion.getConection();
            ps = cx.prepareStatement(SQL);
            ps.setString(1, dia_semana);
            ps.setInt(2, semanaActual);
            System.out.println("dia: " + dia_semana + " semana:" + semanaActual);
            rs = ps.executeQuery();

            while (rs.next()) {
                VerReserva re = new VerReserva();
                re.setIdReserva(rs.getInt("idReserva"));
                re.setDiaReserva(rs.getString("DiaReserva"));
                re.setHoraReserva(rs.getString("HoraReserva"));
                re.setDescripcion(rs.getString("Descripcion"));
                re.setImporte(rs.getDouble("Importe"));
                re.setNombrePaciente(rs.getString("NombrePaciente"));
                re.setApellidoPaciente(rs.getString("ApellidoPaciente"));
                re.setEstado(rs.getString("EstadoReserva"));
                re.setTipoServicio(rs.getString("TipoServicio"));
                re.setNombreUsuario(rs.getString("NombreOdontologo"));
                re.setApellidoUsuario(rs.getString("ApellidoOdontologo"));
                re.setDia_semana(rs.getString("dia_semana"));
                re.setOrden_row(rs.getInt("orden_row"));
                re.setColor(rs.getString("color"));
                lista.add(re);
            }
        } catch (SQLException e) {
            System.out.println("Error al obtener reservas: " + e.getMessage());
        } finally {
            // Cerrar recursos (ResultSet, PreparedStatement, Connection)
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (cx != null) {
                    cx.close();
                }
            } catch (SQLException e) {
                System.out.println("Error al cerrar recursos: " + e.getMessage());
            }
        }

        System.out.println("Total de reservas recuperadas: " + lista.size());
        return lista;
    }

    @Override
    public List<Reserva> listarReservasRecientes() {
        List<Reserva> reservas = new ArrayList<>();
        String SQL = "{CALL sp_listarReservasRecientes()}";

        try {
            cx = Conexion.getConection();
            ps = cx.prepareStatement(SQL);
            rs = ps.executeQuery();

            while (rs.next()) {
                Reserva reserva = new Reserva();
                reserva.setIdReserva(rs.getInt("idReserva"));
                reserva.setDiaReserva("" + rs.getDate("DiaReserva").toLocalDate());
                reserva.setHoraReserva("" + rs.getTime("HoraReserva").toLocalTime());
                reserva.setNombrePaciente(rs.getString("NombrePaciente"));
                reserva.setNombreServicio(rs.getString("NombreServicio"));
                reserva.setEstadoNombre(rs.getString("EstadoNombre"));
                reservas.add(reserva);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reservas;
    }

    @Override
    public List<VerReserva> listarTodasReservasAd() {
        List<VerReserva> lista = new ArrayList<>();
        String SQL = "{call sp_ListarReservasReporteAd}";  // Procedimiento almacenado

        try {
            // Obtener la conexión
            cx = Conexion.getConection();
            // Preparar el statement con el procedimiento almacenado
            ps = cx.prepareStatement(SQL);

            // Ejecutar la consulta
            rs = ps.executeQuery();

            // Recorrer los resultados
            while (rs.next()) {
                VerReserva re = new VerReserva();
                re.setIdReserva(rs.getInt("idReserva"));
                re.setDiaReserva(rs.getString("DiaReserva"));
                re.setHoraReserva(rs.getString("HoraReserva"));
                re.setDescripcion(rs.getString("Descripcion"));
                re.setImporte(rs.getDouble("Importe"));
                re.setNombrePaciente(rs.getString("NombrePaciente"));
                re.setApellidoPaciente(rs.getString("ApellidoPaciente"));
                re.setEstado(rs.getString("EstadoReserva"));
                re.setTipoServicio(rs.getString("TipoServicio"));
                re.setNombreUsuario(rs.getString("NombreOdontologo"));
                re.setApellidoUsuario(rs.getString("ApellidoOdontologo"));
                lista.add(re);
            }
        } catch (SQLException e) {
            System.out.println("Error al obtener reservas: " + e.getMessage());
        } finally {
            // Cerrar recursos (ResultSet, PreparedStatement, Connection)
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (cx != null) {
                    cx.close();
                }
            } catch (SQLException e) {
                System.out.println("Error al cerrar recursos: " + e.getMessage());
            }
        }

        System.out.println("Total de reservas recuperadas: " + lista.size());
        return lista;
    }

    @Override
    public double obtenerTotalIngresos() {
        double total = 0.0;
        String sql = "SELECT (SELECT SUM(Costo) FROM servicio WHERE idServicio IN (SELECT Servicio_idServicio FROM cita)) + (SELECT SUM(importe) FROM reserva) AS Total";
        try (Connection conn = Conexion.getConection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                total = rs.getDouble("Total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }

}
