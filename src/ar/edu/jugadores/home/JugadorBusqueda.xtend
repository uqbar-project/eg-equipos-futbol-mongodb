package ar.edu.jugadores.home

import ar.edu.jugadores.domain.Equipo

class JugadorBusqueda {
	
	@Property Equipo equipo
	@Property String nombreComienzaCon
	@Property String posicion
	
	new() {
		this(null)	
	}
	
	new(Equipo equipo) {
		this.equipo = equipo
	}
	
}