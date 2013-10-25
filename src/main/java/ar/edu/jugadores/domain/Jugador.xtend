package ar.edu.jugadores.domain

import java.io.Serializable

class Jugador implements Serializable {
	
	@Property String nombre
	@Property String posicion
	
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