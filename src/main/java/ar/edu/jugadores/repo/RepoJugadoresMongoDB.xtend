package ar.edu.jugadores.repo

import ar.edu.jugadores.domain.Jugador
import com.mongodb.MongoClient
import com.mongodb.client.AggregateIterable
import com.mongodb.client.MongoCollection
import com.mongodb.client.MongoCursor
import com.mongodb.client.MongoDatabase
import java.util.ArrayList
import java.util.Arrays
import java.util.List
import org.bson.Document

class RepoJugadoresMongoDB implements RepoJugadores {

	MongoDatabase db

	new() {
		val mongo = new MongoClient("localhost", 27017)
		db = mongo.getDatabase("test")
		println("Conectado a MongoDB. Bases: " + db.listCollectionNames.toList)
	}

	override getJugadores(JugadorBusqueda jugadorBusqueda) {
		val jugadores = new ArrayList<Jugador>
		val searchQuery = new Document
		var MongoCursor<Document> cursor = null

		//
		if (jugadorBusqueda.equipo !== null) {
			searchQuery.put("equipo", jugadorBusqueda.nombreEquipo)
			cursor = collectionEquipos.find(searchQuery).iterator
			while (cursor.hasNext) {
				val equipoDB = cursor.next
				val jugadoresDB = equipoDB.get("jugadores") as ArrayList<Document>
				jugadoresDB.forEach [ jugadorDB |
					val jugadorJSON = jugadorDB as Document
					jugadores.add(jugadorJSON.jugador)
				]
			}
			println(jugadorBusqueda)
			println("Resultado: " + jugadores)
			println("****************************************")
		}

		val nombreComienzaCon = jugadorBusqueda.nombreComienzaCon
		if (nombreComienzaCon !== null) {
			val AggregateIterable<Document> jugadoresDB = collectionEquipos.aggregate(Arrays.asList(
				new Document("$unwind", "$jugadores"),
				new Document("$match", new Document("jugadores.nombre", 
						new Document("$regex", nombreComienzaCon + ".*")
				)),
				new Document("$limit", 200),
				new Document("$project",
					new Document("_id", 0).append("nombre", "$jugadores.nombre").append("posicion", "$jugadores.posicion"))
			))

			// El query que tira es distinto que el "por equipo"
			val cursorJugadores = jugadoresDB.iterator
			while (cursorJugadores.hasNext) {
				jugadores.add(cursorJugadores.next.jugador)
			}
			println("Jugadores DB: " + jugadoresDB.size)
			println(jugadorBusqueda)
			println("Resultado: " + jugadores)
			println("****************************************")
 		}
		jugadores
	}
	
	protected def MongoCollection<Document> getCollectionEquipos() {
		db.getCollection("equipos")
	}

	def getJugador(Document jugadorJSON) {
		new Jugador(jugadorJSON.get("nombre") as String, jugadorJSON.get("posicion") as String)
	}

}
