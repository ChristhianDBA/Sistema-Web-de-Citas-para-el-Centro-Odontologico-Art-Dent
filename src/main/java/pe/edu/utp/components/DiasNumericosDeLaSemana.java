/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.utp.components;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;

public class DiasNumericosDeLaSemana {

    public Map<Integer, Integer> obtenerDiasNumericosDeEstaSemana(int init) {
        Map<Integer, Integer> dias = new HashMap<>();
        for (int i = 0; i < 7; i++) {
            dias.put(i + 1, init+i); 
        }
        
        return dias;
    }
}
