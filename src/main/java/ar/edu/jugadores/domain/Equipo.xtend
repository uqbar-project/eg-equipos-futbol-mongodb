package ar.edu.jugadores.domain

import java.io.Serializable
import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Equipo implements Serializable {
	
	String nombre
	List<Jugador> jugadores
	
	new() {
		this("")
	}
	
	new(String nombre) {
		this.nombre = nombre
		this.jugadores = new ArrayList<Jugador>
	}
	
}