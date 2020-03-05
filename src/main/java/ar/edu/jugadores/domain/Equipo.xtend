package ar.edu.jugadores.domain

import java.io.Serializable
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

class Equipo implements Serializable {
	
	@Accessors
	String nombre
	
	@Accessors(PUBLIC_GETTER)
	List<Jugador> jugadores
	
	new() {
		this.nombre = ""
		this.jugadores = newArrayList
	}
	
}