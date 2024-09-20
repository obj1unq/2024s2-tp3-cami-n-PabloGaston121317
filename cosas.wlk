object knightRider {
	method peso() { return 500 }
	method nivelPeligrosidad() { return 10 }
}

object bumblebee {
	var transformacion = null

	method peso() = 800
	method nivelPeligrosidad(){
		return transformacion.nivelPeligrosidad()
	}

	method transformacion(_transformacion){
		transformacion = _transformacion
	}
}

object auto {
	method nivelPeligrosidad() = 15
}

object robot {
	method nivelPeligrosidad() = 30
}

object paqueteDeLadrillos {

	var property cantidadLadrillos = 0

	method peso(){
		return 2 * cantidadLadrillos
	} 

	method nivelPeligrosidad() = 2
}

object arenaDeGranel {

	var property peso = 0

	method nivelPeligrosidad() = 1 
}


