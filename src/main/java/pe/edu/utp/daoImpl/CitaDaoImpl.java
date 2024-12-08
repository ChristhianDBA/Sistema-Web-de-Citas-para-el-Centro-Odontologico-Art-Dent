package pe.edu.utp.daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import pe.edu.utp.config.Conexion;
import pe.edu.utp.dao.CitaDao;
import pe.edu.utp.entity.Cita;
import pe.edu.utp.entity.Paciente;
import pe.edu.utp.entity.Venta;
import pe.edu.utp.entity.VerCita;

/**
 *
 * @author Andrea
 */
public class CitaDaoImpl implements CitaDao {

    private PreparedStatement ps;
    private PreparedStatement ps1;

    private ResultSet rs;

    private Connection cx;

    @Override
    public int createCitasilapersonaesnueva(Paciente p, Cita c, Venta v) {
        try {
            // Obtener conexión
            cx = Conexion.getConection();
            if (cx == null) {
                System.out.println("No se pudo establecer conexión con la base de datos.");
                return 0;  // Retorna 0 si no hay conexión
            }
            // Llamar a sp_registrarusuario
            ps = cx.prepareStatement("{CALL sp_registrarusuario(?, ?, ?, ?, ?)}");
            ps.setString(1, p.getNombre());
            ps.setString(2, p.getApellido());
            ps.setInt(3, p.getDni());
            ps.setInt(4, p.getTelefono());
            ps.setString(5, p.getCorreo());
            ps.executeUpdate();
            ps.close();

            // Llamar a sp_registrarprimeracita
            ps = cx.prepareStatement("{CALL sp_registrarprimeracita(?, ?, ?, ?, ?)}");
            ps.setString(1, c.getDiaReserva());
            ps.setString(2, c.getHoraReserva());
            ps.setInt(3, c.getId_Servicio());
            ps.setInt(4, c.getId_Estado());
            ps.setInt(5, c.getOdontologo_idUsuario());
            ps.executeUpdate();
            ps.close();

            // Llamar a sp_ventas
            ps = cx.prepareStatement("{CALL sp_ventas(?)}");
            ps.setDouble(1, v.getImporte());
            ps.executeUpdate();
            ps.close();

            return 1; // Éxito
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return 0; // Error
    }

    @Override
    public int createCitasilapersonayaexiste(Paciente p, Cita c, Venta v) {
        try {
            // Obtener conexión
            cx = Conexion.getConection();
            if (cx == null) {
                System.out.println("No se pudo establecer conexión con la base de datos.");
                return 0;  // Retorna 0 si no hay conexión
            }
            System.out.println("dni q ="+p.getDni());
            // Llamar a sp_registrarcita
            ps = cx.prepareStatement("{CALL sp_registrarcita(?, ?, ?, ?, ?, ?)}");
            ps.setString(1, c.getDiaReserva());
            ps.setString(2, c.getHoraReserva());
            ps.setInt(3, c.getId_Servicio());
            ps.setString(4, "" + p.getIdPaciente());
            ps.setInt(5, c.getId_Estado());
            ps.setInt(6, c.getOdontologo_idUsuario());
            ps.executeUpdate();
            ps.close();

            // Llamar a sp_ventas
            ps = cx.prepareStatement("{CALL sp_ventas(?)}");
            ps.setDouble(1, v.getImporte());
            ps.executeUpdate();
            ps.close();

            return 1; // Éxito
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return 0; // Error
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
    public int updateCita(int idCita, String nuevaFecha, String nuevaHora) {
        // Obtener conexión
        cx = Conexion.getConection();
        if (cx == null) {
            System.out.println("No se pudo establecer conexión con la base de datos.");
            return 0;
        }

        // Nombre del procedimiento almacenado para actualizar la cita
        String SQL = "{CALL ps_ReprogramarCita(?, ?, ?)}";

        try {
            // Preparar el statement con el procedimiento almacenado
            ps = cx.prepareStatement(SQL);
            ps.setInt(1, idCita);
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
    public Cita readCita(int id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public List<VerCita> listarCitas(int idUsuario) {
        List<VerCita> lista = new ArrayList<>();
        String SQL = "{call sp_ListarCitasPorUsuario(?)}";  // Procedimiento almacenado

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
                VerCita re = new VerCita();
                re.setIdCita(rs.getInt("idCita"));
                re.setDiaReserva(rs.getString("DiaReserva"));
                re.setHoraReserva(rs.getString("HoraReserva"));
                re.setNombrePaciente(rs.getString("NombrePaciente"));
                re.setApellidoPaciente(rs.getString("ApellidoPaciente"));
                re.setEstado(rs.getString("Estado"));
                re.setTipoServicio(rs.getString("TipoServicio"));

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
    public List<VerCita> listarHistorialCitas(int idUsuario) {
        List<VerCita> lista = new ArrayList<>();
        String SQL = "{call sp_ListarHisotialCitas(?)}";  // Procedimiento almacenado

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
                VerCita re = new VerCita();
                re.setIdCita(rs.getInt("idCita"));
                re.setDiaReserva(rs.getString("DiaReserva"));
                re.setHoraReserva(rs.getString("HoraReserva"));
                re.setNombrePaciente(rs.getString("NombrePaciente"));
                re.setApellidoPaciente(rs.getString("ApellidoPaciente"));
                re.setEstado(rs.getString("Estado"));
                re.setTipoServicio(rs.getString("TipoServicio"));
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
    public List<VerCita> listarTodasCitas(int idUsuario) {
        List<VerCita> lista = new ArrayList<>();
        String SQL = "{call sp_ListarTodasCitas(?)}";  // Procedimiento almacenado

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
                VerCita re = new VerCita();
                re.setIdCita(rs.getInt("idCita"));
                re.setDiaReserva(rs.getString("DiaReserva"));
                re.setHoraReserva(rs.getString("HoraReserva"));
                re.setNombrePaciente(rs.getString("NombrePaciente"));
                re.setApellidoPaciente(rs.getString("ApellidoPaciente"));
                re.setEstado(rs.getString("Estado"));
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
    public List<VerCita> listarTodasCitasAd() {
        List<VerCita> lista = new ArrayList<>();
        String SQL = "{call sp_ListarTodasCitasAd}";  // Procedimiento almacenado

        try {
            // Obtener la conexión
            cx = Conexion.getConection();
            // Preparar el statement con el procedimiento almacenado
            ps = cx.prepareStatement(SQL);

            // Ejecutar la consulta
            rs = ps.executeQuery();

            // Recorrer los resultados
            while (rs.next()) {
                VerCita re = new VerCita();
                re.setIdCita(rs.getInt("idCita"));
                re.setDiaReserva(rs.getString("DiaReserva"));
                re.setHoraReserva(rs.getString("HoraReserva"));
                re.setNombrePaciente(rs.getString("NombrePaciente"));
                re.setApellidoPaciente(rs.getString("ApellidoPaciente"));
                re.setEstado(rs.getString("Estado"));
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
    public List<VerCita> DetalleCita(int idCita) {
        List<VerCita> lista = new ArrayList<>();
        String SQL = "{call sp_DetalleCita(?)}";  // Procedimiento almacenado

        try {
            // Obtener la conexión
            cx = Conexion.getConection();
            // Preparar el statement con el procedimiento almacenado
            ps = cx.prepareStatement(SQL);
            ps.setInt(1, idCita);  // Pasar el ID del usuario

            // Ejecutar la consulta
            rs = ps.executeQuery();

            // Recorrer los resultados
            while (rs.next()) {
                VerCita re = new VerCita();
                re.setIdCita(rs.getInt("idCita"));
                re.setDiaReserva(rs.getString("DiaReserva"));
                re.setHoraReserva(rs.getString("HoraReserva"));
                re.setNombrePaciente(rs.getString("NombrePaciente"));
                re.setApellidoPaciente(rs.getString("ApellidoPaciente"));
                re.setEstado(rs.getString("Estado"));
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
    public int DeleteCita(int idCita) {
        // Obtener conexión
        cx = Conexion.getConection();
        if (cx == null) {
            System.out.println("No se pudo establecer conexión con la base de datos.");
            return 0;
        }
        String SQL = "UPDATE cita SET Estado_idEstado = 6 WHERE idCita = ?";
        try {
            ps = cx.prepareStatement(SQL);
            ps.setInt(1, idCita);
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
    public List<VerCita> listarCitasPorDia(String dia_semana) {
        List<VerCita> lista = new ArrayList<>();
        String SQL = "{call ListarCitasSemanaActual(?)}";  // Procedimiento almacenado

        try {
            cx = Conexion.getConection();
            ps = cx.prepareStatement(SQL);
            ps.setString(1, dia_semana);

            rs = ps.executeQuery();

            while (rs.next()) {
                VerCita re = new VerCita();
                re.setIdCita(rs.getInt("idCita"));
                re.setDiaReserva(rs.getString("DiaReserva"));
                re.setHoraReserva(rs.getString("HoraReserva"));
                re.setNombrePaciente(rs.getString("NombrePaciente"));
                re.setApellidoPaciente(rs.getString("ApellidoPaciente"));
                re.setEstado(rs.getString("EstadoReserva"));
                re.setTipoServicio(rs.getString("TipoServicio"));
                re.setNombreUsuario(rs.getString("NombreOdontologo"));
                re.setApellidoUsuario(rs.getString("ApellidoOdontologo"));
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
    public List<VerCita> listarCitasPorDiaSemana(String dia_semana, int semanaActual) {
        List<VerCita> lista = new ArrayList<>();
        String SQL = "{call ListarCitasPorDiaSemana(?, ?)}";

        try {
            cx = Conexion.getConection();
            ps = cx.prepareStatement(SQL);
            ps.setString(1, dia_semana);
            ps.setInt(2, semanaActual);

            rs = ps.executeQuery();

            while (rs.next()) {
                VerCita re = new VerCita();
                re.setIdCita(rs.getInt("idCita"));
                re.setDiaReserva(rs.getString("DiaReserva"));
                re.setHoraReserva(rs.getString("HoraReserva"));
                re.setNombrePaciente(rs.getString("NombrePaciente"));
                re.setApellidoPaciente(rs.getString("ApellidoPaciente"));
                re.setEstado(rs.getString("EstadoReserva"));
                re.setTipoServicio(rs.getString("TipoServicio"));
                re.setNombreUsuario(rs.getString("NombreOdontologo"));
                re.setApellidoUsuario(rs.getString("ApellidoOdontologo"));
                re.setCosto(rs.getDouble("Costo"));
                re.setOrden_row(rs.getInt("orden_row"));
                re.setColor(rs.getString("color"));
                lista.add(re);
                System.out.println("COSSTOOOO: " + rs.getDouble("Costo"));
            }
        } catch (SQLException e) {
            System.out.println("Error al obtener citas: " + e.getMessage());
        } finally {
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

        System.out.println("Total de citas recuperadas: " + lista.size());
        return lista;
    }

    @Override
    public int updateEstadoCita(int idCita, String estadoActual) {
        // Obtener conexión
        cx = Conexion.getConection();
        if (cx == null) {
            System.out.println("No se pudo establecer conexión con la base de datos.");
            return 0;
        }
        String SQL = "UPDATE cita SET Estado_idEstado = ? WHERE idCita = ?";
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
            ps.setInt(2, idCita);
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
    public int updateEstadoCitaCancelado(int idCita) {
        // Obtener conexión
        cx = Conexion.getConection();
        if (cx == null) {
            System.out.println("No se pudo establecer conexión con la base de datos.");
            return 0;
        }
        String SQL = "UPDATE cita SET Estado_idEstado = 5 WHERE idCita = ?";
        try {
            ps = cx.prepareStatement(SQL);
            ps.setInt(1, idCita);
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
    public List<Cita> listarCitasRecientes() {
        List<Cita> citas = new ArrayList<>();
        String SQL = "{CALL sp_listarCitasRecientes()}";

        try {
            cx = Conexion.getConection();
            ps = cx.prepareStatement(SQL);
            rs = ps.executeQuery();

            while (rs.next()) {
                Cita cita = new Cita();
                cita.setIdCita(rs.getInt("idCita"));
                cita.setDiaReserva(""+rs.getDate("DiaReserva").toLocalDate());
                cita.setHoraReserva(""+rs.getTime("HoraReserva").toLocalTime());
                cita.setNombrePaciente(rs.getString("NombrePaciente"));
                cita.setNombreServicio(rs.getString("NombreServicio"));
                cita.setEstadoNombre(rs.getString("EstadoNombre"));
                citas.add(cita);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return citas;
    }
    
    @Override
    public int obtenerTotalCitasReservas() {
        int total = 0;
        String sql = "SELECT (SELECT COUNT(idCita) FROM cita) + (SELECT COUNT(idReserva) FROM reserva) AS TotalContado";
        try (Connection conn = Conexion.getConection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                total = rs.getInt("TotalContado");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }
    
}
