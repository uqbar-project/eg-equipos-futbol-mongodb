package ar.edu.jugadores.domain

import java.io.Serializable
import org.eclipse.xtend.lib.annotations.Data

@Data
class Jugador implements Serializable {
	
	String nombre
	String posicion
	
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