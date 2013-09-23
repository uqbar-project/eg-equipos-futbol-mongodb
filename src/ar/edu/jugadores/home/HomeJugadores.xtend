package ar.edu.jugadores.home

import ar.edu.jugadores.domain.Jugador
import java.util.List

interface HomeJugadores {
	
	def List<Jugador> getJugadores(JugadorBusqueda jugadorBusqueda)
	
}