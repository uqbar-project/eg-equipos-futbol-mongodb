package ar.edu.jugadores.repo

import ar.edu.jugadores.domain.Jugador
import com.mongodb.BasicDBObject
import com.mongodb.MongoClient
import com.mongodb.client.MongoCursor
import com.mongodb.client.MongoDatabase
import java.util.ArrayList
import java.util.List
import org.bson.Document

class RepoJugadoresMongoDB implements RepoJugadores {

	MongoDatabase db

	new() {
		val mongo = new MongoClient("localhost", 27017)
		db = mongo.getDatabase("local")
		println("Conectado a MongoDB. Bases: " + db.listCollectionNames)
	}

	override getJugadores(JugadorBusqueda jugadorBusqueda) {
		val tablaJugadores = db.getCollection("jugadores")
		val List<Jugador> jugadores = new ArrayList<Jugador>
		val searchQuery = new Document
		var MongoCursor<Document> cursor = null

		// 
		if (jugadorBusqueda.equipo != null) {
			searchQuery.put("equipo", jugadorBusqueda.nombreEquipo)
			cursor = tablaJugadores.find(searchQuery).iterator
			while (cursor.hasNext) {
				val equipoDB = cursor.next
				val jugadoresDB = equipoDB.get("jugadores") as ArrayList<Document>
				jugadoresDB.forEach  [ jugadorDB |
					val jugadorJSON = jugadorDB as Document
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
			val result = db.runCommand(cmdBody)
			var jugadoresDB = result.get("result") as List<Document>
			// El query que tira es distinto que el "por equipo"
			jugadoresDB.forEach [ jugadorDB | 
				var jugadorJSON = (jugadorDB as Document).get("jugadores") as Document
				jugadores.add(getJugador(jugadorJSON))
			]
			println("Jugadores DB: " + jugadoresDB)
			println(jugadorBusqueda)
			println("Resultado: " + jugadores)
			println("****************************************")
		}
		jugadores
	}

	def getJugador(Document jugadorJSON) {
		new Jugador(jugadorJSON.get("nombre") as String, jugadorJSON.get("posicion") as String)
	}

}
