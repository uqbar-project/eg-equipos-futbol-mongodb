package ar.edu.jugadores.domain

import java.io.Serializable
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Jugador implements Serializable {
	
	String nombre
	String posicion
	
	new(String nombre, String posicion) {
		this.nombre = nombre
		this.posicion = posicion
	}

	override toString() {
		nombre
	}	
	
	override equals(Object otro) {
		nombre.equals((otro as Jugador).nombre)
	}
	
	override hashCode() {
		nombre.hashCode
	}
	
}