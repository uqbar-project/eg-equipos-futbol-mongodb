package ar.edu.jugadores.home

import ar.edu.jugadores.domain.Equipo
import ar.edu.jugadores.domain.Jugador
import org.junit.Assert
import org.junit.Before
import org.junit.Test

class TestJugadores {

	HomeJugadores homeJugadores
	Jugador riquelme
	Jugador palermo
	JugadorBusqueda buscarBoca
	JugadorBusqueda buscarCasta

	@Before
	def void init() {
		homeJugadores = new HomeJugadoresMongoDB
		riquelme = new Jugador("Riquelme, Juan Román", "Volante")
		palermo = new Jugador("Palermo, Martín", "Delantero")
		buscarBoca = new JugadorBusqueda(new Equipo("Boca"))
		buscarCasta = new JugadorBusqueda
		buscarCasta.nombreComienzaCon = "Casta"
	}

	@Test
	def void testRiquelmeEsJugadorDeBoca() {
		val jugadoresBoca = homeJugadores.getJugadores(buscarBoca)
		Assert.assertTrue(jugadoresBoca.contains(riquelme))
	}

	@Test
	def void testPalermoYaNoEsJugadorDeBoca() {
		val jugadoresBoca = homeJugadores.getJugadores(buscarBoca)
		Assert.assertFalse(jugadoresBoca.contains(palermo))
	}

	@Test
	def void testHayDosJugadoresQueComienzanConCasta() {
		val jugadores = homeJugadores.getJugadores(buscarCasta)
		Assert.assertEquals(2, jugadores.size)
	}

}
