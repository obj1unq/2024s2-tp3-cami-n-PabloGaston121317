object knightRider {
	method peso() { return 500 }
	method nivelPeligrosidad() { return 10 }
	method cantBulto() = 1
	method consecuenciaPorCarga(){
		return
	}
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
	method cantBulto() = 2

	method transformacion() = transformacion

	method consecuenciaPorCarga(){
		transformacion = robot
	}

	method esConsecuenciaDeCarga() = false
}

object auto {
	method nivelPeligrosidad() = 15
}

object robot {
	method nivelPeligrosidad() = 30
}


class PaqueteDeLadrillo{
		var property cantidadLadrillos = null

	method peso(){
		return 2 * cantidadLadrillos
	} 

	method nivelPeligrosidad() = 2

	method cantBulto(){
		return if (cantidadLadrillos >=1 and cantidadLadrillos <= 100) 1
		 else  if (cantidadLadrillos >=101 and cantidadLadrillos <= 300) 2
		 else 3
	}
	
	method esConsecuenciaDeCarga() = false

	method consecuenciaPorCarga(){
		cantidadLadrillos += 12
	}
}


object arenaDeGranel {

	var property peso = 0

	method nivelPeligrosidad() = 1 

	method cantBulto() = 1

	method esConsecuenciaDeCarga() = true

	method consecuenciaPorCarga(){
		peso += 20
	}
}

object bateriaAntiaerea {

	var property misiles = null
	

	method peso(){
	
	return  if (self.estaConMisiles()) 300 else 200
	}

	method nivelPeligrosidad(){

		return if(self.estaConMisiles()) 100 else 0
	}

	
	method estaConMisiles() = misiles

	method cantBulto() = if (self.estaConMisiles()) 2 else 1

	method esConsecuenciaDeCarga() = false

	method consecuenciaPorCarga() {

		misiles = true
	}
	
}



object contenedorPortuario {

	const pesoPropio = 100
	const cosas = #{}
	const bultoPropio = 1

	method cargar(unaCosa){
		cosas.add(unaCosa)
	}

	method peso(){

		return pesoPropio + self.pesoDelContenido()
	}

	method pesoDelContenido(){

		return cosas.sum({cosa=> cosa.peso()})
	}

	method nivelPeligrosidad(){
		const nivelesPeligrosidad = cosas.map({cosa=>cosa.nivelPeligrosidad()})
		return nivelesPeligrosidad.maxIfEmpty({0})
		//return if (cosas.isEmpty()) 0 else cosas.max({cosa=>cosa.nivelPeligrosidad()})
	}

	method cantBulto() = bultoPropio + self.bultosDeCarga()

	method bultosDeCarga(){
		return cosas.sum({cosa=> cosa.cantBulto()})
	}

	method esConsecuenciaDeCarga() = false

	method consecuenciaPorCarga(){

		cosas.forEach({cosa=> cosa.consecuenciaPorCarga()})
	}

	
}

object residuosRadioactivos {
	
	var property peso = 0

	method nivelPeligrosidad() = 200

	method cantBulto() = 1

	method esConsecuenciaDeCarga() = false

	method consecuenciaPorCarga(){
		peso += 15
	}
}

object embalajeDeSeguridad {

	var  cosa = null

	method embalar(unaCosa){

		cosa = unaCosa
	}

	method peso(){

		return cosa.peso()
	} 

	method nivelPeligrosidad(){

		return cosa.nivelPeligrosidad() / 2
	}

	method cantBulto() = 2

	method esConsecuenciaDeCarga() = false


}




