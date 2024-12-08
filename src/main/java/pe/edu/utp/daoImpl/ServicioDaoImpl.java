/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.utp.daoImpl;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import pe.edu.utp.config.Conexion;
import pe.edu.utp.dao.ServicioDao;
import pe.edu.utp.entity.Servicio;

/**
 *
 * @author Christhian
 */
public class ServicioDaoImpl implements ServicioDao {

    private PreparedStatement ps;
    private ResultSet rs;
    private Connection cx;
    Servicio ser = new Servicio();

    @Override
    public List<Servicio> readAll() {
        List<Servicio> lista = new ArrayList<>();
        String SQL = "{call sp_listarservicios()}";
        try {
            cx = Conexion.getConection();
            ps = cx.prepareStatement(SQL);
            rs = ps.executeQuery();
            while (rs.next()) {
                Servicio servicio = new Servicio();
                servicio.setIdServicio(rs.getInt("idServicio"));
                servicio.setTipoServicio(rs.getString("TipoServicio"));
                servicio.setLema(rs.getString("Lema"));
                servicio.setDescripcion(rs.getString("Descripcion"));
                servicio.setRespuesta(rs.getString("Respuesta"));
                servicio.setCosto(rs.getBigDecimal("Costo"));//dsct
                servicio.setLinkimagen(rs.getString("img"));
                lista.add(servicio);
            }
        } catch (SQLException e) {
            System.out.println("Error al obtener servicios: " + e);
        }
        System.out.println("Total de servicios recuperados: " + lista.size());
        return lista;
    }

    @Override
    public Servicio ListService(int id) {
        Servicio ser = new Servicio();  // Aquí se crea una nueva instancia de Servicio para cada llamada
        String SQL = "SELECT * FROM servicio WHERE IdServicio = ?";
        try {
            cx = Conexion.getConection();
            ps = cx.prepareStatement(SQL);
            ps.setInt(1, id);  // Usar parámetros preparados para evitar SQL Injection
            rs = ps.executeQuery();
            if (rs.next()) {
                ser.setIdServicio(rs.getInt("idServicio"));
                ser.setTipoServicio(rs.getString("TipoServicio"));
                ser.setLema(rs.getString("Lema"));
                ser.setDescripcion(rs.getString("Descripcion"));
                ser.setRespuesta(rs.getString("Respuesta"));
                ser.setLinkimagen(rs.getString("img"));
            }
        } catch (SQLException e) {
            System.out.println("Error al obtener servicio: " + e);
        }
        return ser;  // Retorna el objeto Servicio encontrado
    }

    @Override
    public List<Servicio> listarServicios() {
        List<Servicio> servicios = new ArrayList<>();
        String SQL = "SELECT idServicio, TipoServicio, Costo, img FROM servicio";

        try {
            cx = Conexion.getConection();
            ps = cx.prepareStatement(SQL);
            rs = ps.executeQuery();
            while (rs.next()) {
                Servicio servicio = new Servicio();
                servicio.setIdServicio(rs.getInt("idServicio"));
                servicio.setTipoServicio(rs.getString("TipoServicio"));
                servicio.setCosto(rs.getBigDecimal("Costo"));
                servicio.setLinkimagen(rs.getString("img"));
                servicios.add(servicio);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return servicios;
    }

    @Override
    public Servicio obtenerServicioPorId(int id) {
        Servicio servicio = null;
        String SQL = "{call sp_obtenerServicioPorId(?)}";

        try {
            cx = Conexion.getConection();
            ps = cx.prepareStatement(SQL);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                servicio = new Servicio();
                servicio.setIdServicio(rs.getInt("idServicio"));
                servicio.setTipoServicio(rs.getString("TipoServicio"));
                servicio.setLema(rs.getString("Lema"));
                servicio.setDescripcion(rs.getString("Descripcion"));
                servicio.setRespuesta(rs.getString("Respuesta"));
                servicio.setCosto(rs.getBigDecimal("Costo"));
                servicio.setLinkimagen(rs.getString("img"));
            }
        } catch (SQLException e) {
            System.out.println("Error al obtener usuario por ID: " + e);
        }
        return servicio;
    }

    @Override
    public boolean insertarServicio(Servicio servicio) {
        String SQL = "{call sp_insertarServicio(?,?,?,?,?,?)}";
        try {
            cx = Conexion.getConection();
            ps = cx.prepareStatement(SQL);
            ps.setString(1, servicio.getTipoServicio());
            ps.setString(2, servicio.getLema());
            ps.setString(3, servicio.getDescripcion());
            ps.setString(4, servicio.getRespuesta());
            ps.setBigDecimal(5, servicio.getCosto());
            ps.setString(6, servicio.getLinkimagen());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean actualizarServicio(Servicio servicio) {
        String SQL = "{call sp_actualizarServicio(?,?,?,?,?,?,?)}";
         try {
            cx = Conexion.getConection();
            ps = cx.prepareStatement(SQL);
            ps.setInt(1, servicio.getIdServicio());
            ps.setString(2, servicio.getTipoServicio());
            ps.setString(3, servicio.getLema());
            ps.setString(4, servicio.getDescripcion());
            ps.setString(5, servicio.getRespuesta());
            ps.setBigDecimal(6, servicio.getCosto());
            ps.setString(7, servicio.getLinkimagen());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean eliminarServicio(int id) {
        String SQL = "{call sp_eliminarServicio(?)}";
        boolean resultado = false;
        try {
            cx = Conexion.getConection();
            ps = cx.prepareStatement(SQL);
            ps.setInt(1, id);
            resultado = ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error al eliminar servicio: " + e);
        }
        return resultado;
    }

}
