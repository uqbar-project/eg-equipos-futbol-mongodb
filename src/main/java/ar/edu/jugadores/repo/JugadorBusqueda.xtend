package ar.edu.jugadores.repo

import ar.edu.jugadores.domain.Equipo
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class JugadorBusqueda {
	
	Equipo equipo
	String nombreComienzaCon
	String posicion
	
	new() {
		this(null)	
	}
	
	new(Equipo equipo) {
		this.equipo = equipo
	}
	
	override toString() {
		var result = "Busqueda de jugadores " 
		if (posicion != null) {
			result += " - posicion " + posicion
		}
		if (equipo != null) {
			result += " - equipo " + equipo.nombre
		}
		if (nombreComienzaCon != null) {
			result += " - nombre comienza con " + nombreComienzaCon
		}
		result		
	}
	
}