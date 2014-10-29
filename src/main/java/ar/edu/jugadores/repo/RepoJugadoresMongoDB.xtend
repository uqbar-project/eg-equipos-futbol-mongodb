package ar.edu.jugadores.repo

import ar.edu.jugadores.domain.Jugador
import com.mongodb.BasicDBList
import com.mongodb.BasicDBObject
import com.mongodb.DB
import com.mongodb.DBCursor
import com.mongodb.Mongo
import java.util.ArrayList

class RepoJugadoresMongoDB implements RepoJugadores {

	DB db

	new() {
		val mongo = new Mongo("localhost", 27017)
		db = mongo.getDB("local")
		println("Conectado a MongoDB. Bases: " + db.collectionNames)
	}

	override getJugadores(JugadorBusqueda jugadorBusqueda) {
		val tablaJugadores = db.getCollection("jugadores")
		val jugadores = new ArrayList<Jugador>

		val searchQuery = new BasicDBObject
		var DBCursor cursor = null

		// 
		if (jugadorBusqueda.equipo != null) {
			searchQuery.put("equipo", jugadorBusqueda.equipo.nombre)
			cursor = tablaJugadores.find(searchQuery)
			while (cursor.hasNext) {
				val equipoDB = cursor.next
				val jugadoresDB = equipoDB.get("jugadores") as BasicDBList
				jugadoresDB.forEach  [ jugadorDB |
					val jugadorJSON = jugadorDB as BasicDBObject
					jugadores.add(getJugador(jugadorJSON))
				]
			}
			println(jugadorBusqueda)
			println("Resultado: " + jugadores)
			println("****************************************")
		}

		val nombreComienzaCon = jugadorBusqueda.nombreComienzaCon
		if (nombreComienzaCon != null) {
			val unwind = new BasicDBObject("$unwind", "$jugadores")
			val casta = new BasicDBObject("$regex", nombreComienzaCon + ".*")
			val match = new BasicDBObject("$match", new BasicDBObject("jugadores.nombre", casta))
			val cmdBody = new BasicDBObject("aggregate", "jugadores")
			val pipeline = new ArrayList<BasicDBObject> => [
				add(unwind)
				add(match)
			]
			cmdBody.put("pipeline", pipeline)
			val result = db.command(cmdBody)
			var jugadoresDB = result.get("result") as BasicDBList
			// El query que tira es distinto que el "por equipo"
			jugadoresDB.forEach [ jugadorDB | 
				var jugadorJSON = (jugadorDB as BasicDBObject).get("jugadores") as BasicDBObject
				jugadores.add(getJugador(jugadorJSON))
			]
			println("Jugadores DB: " + jugadoresDB)
			println(jugadorBusqueda)
			println("Resultado: " + jugadores)
			println("****************************************")
		}
		jugadores
	}

	def getJugador(BasicDBObject jugadorJSON) {
		new Jugador(jugadorJSON.get("nombre") as String, jugadorJSON.get("posicion") as String)
	}

}
