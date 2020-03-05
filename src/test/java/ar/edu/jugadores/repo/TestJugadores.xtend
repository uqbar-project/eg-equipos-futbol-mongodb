package ar.edu.jugadores.repo

import ar.edu.jugadores.domain.Equipo
import ar.edu.jugadores.domain.Jugador
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test
import static org.junit.jupiter.api.Assertions.assertEquals
import static org.junit.jupiter.api.Assertions.assertFalse
import static org.junit.jupiter.api.Assertions.assertTrue

@DisplayName("Dados varios planteles con jugadores")
class TestJugadores {

	RepoJugadores repoJugadores
	Jugador riquelme
	Jugador palermo
	JugadorBusqueda buscarBoca
	JugadorBusqueda buscarCasta

	@BeforeEach
	def void init() {
		repoJugadores = new RepoJugadoresMongoDB
		riquelme = new Jugador("Riquelme, Juan Román", "Volante")
		palermo = new Jugador("Palermo, Martín", "Delantero")
		buscarBoca = new JugadorBusqueda => [
			equipo = new Equipo => [
				nombre = "Boca"
			]
		]
		buscarCasta = new JugadorBusqueda
		buscarCasta.nombreComienzaCon = "Casta"
	}

	@Test
	@DisplayName("se puede buscar un jugador en base a un equipo")
	def void testRiquelmeEsJugadorDeBoca() {
		val jugadoresBoca = repoJugadores.getJugadores(buscarBoca)
		assertTrue(jugadoresBoca.contains(riquelme))
	}

	@Test
	@DisplayName("un jugador que no está en un equipo no aparece en el plantel")
	def void testPalermoYaNoEsJugadorDeBoca() {
		val jugadoresBoca = repoJugadores.getJugadores(buscarBoca)
		assertFalse(jugadoresBoca.contains(palermo))
	}

	@Test
	@DisplayName("se puede navegar directamente los jugadores a pesar de estar embebidos en los planteles")
	def void testHayDosJugadoresQueComienzanConCasta() {
		val jugadores = repoJugadores.getJugadores(buscarCasta)
		assertEquals(2, jugadores.size)
	}

}
