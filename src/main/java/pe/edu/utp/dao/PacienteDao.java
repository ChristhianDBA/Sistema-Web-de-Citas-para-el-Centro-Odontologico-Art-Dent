/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.utp.dao;
import pe.edu.utp.entity.Paciente;

/**
 *
 * @author alex0
 */
public interface PacienteDao {
    Paciente obtenerPacientePorDNI(String dni);
}
