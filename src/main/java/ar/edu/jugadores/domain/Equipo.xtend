package ar.edu.jugadores.domain

import java.io.Serializable
import java.util.ArrayList
import java.util.List

class Equipo implements Serializable {
	
	@Property String nombre
	@Property List<Jugador> jugadores
	
	new() {
		this("")
	}
	
	new(String nombre) {
		this.nombre = nombre
		this.jugadores = new ArrayList<Jugador>
	}
	
}