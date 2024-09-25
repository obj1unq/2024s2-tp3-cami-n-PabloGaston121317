import cosas.*

object camion {
	const property cosas = #{}
	const tara = 1000
	const pesoMaximo = 2500

	method totalBultos(){

		return cosas.sum({cosa=> cosa.cantBulto()})
	}

	method pesos(){
		const listCosas = cosas.asList()

		return listCosas.map({cosa=> cosa.peso()})
		
	}

	method cosaMasPesada(){

		return cosas.max({cosa=> cosa.peso()})
	}

	method tieneAlgoQuePesaEntre(min,max){
		

		return cosas.any({cosa=> cosa.peso() > min and cosa.peso() < max})
		
	}

	method puedeCircularEnRuta(nivelMaximoDePeligrosidad){
		return cosas.all({cosa=> cosa.nivelPeligrosidad() <= nivelMaximoDePeligrosidad})
	}

	method objetosMasPeligrososQue(unaCosa){
		return cosas.filter({cosa=> cosa.nivelPeligrosidad() > unaCosa.nivelPeligrosidad()})
	}

	method objetosQueSuperanPeligrosidad(nivel){
		return cosas.filter({cosa=> cosa.nivelPeligrosidad() > nivel})
	}

	method excedidoDePeso(){
		return self.pesoTotal() > pesoMaximo
	}

	method pesoTotal(){

		return tara + self.pesoDeLaCarga()
	}

	method pesoDeLaCarga(){
		
		return cosas.sum{cosa=> cosa.peso()}
	}

	method elDeNivel(nivel){

		return cosas.find({cosa=> cosa.nivelPeligrosidad() == nivel})
	}
	method hayAlgunoQuePesa(peso){
		return cosas.any({cosa=> cosa.peso() == peso})
	}

	method todoPesoPar(){

		return cosas.all({cosa => cosa.peso() % 2 == 0 })
	}


	method descargar(unaCosa){
		cosas.remove(unaCosa)
	}

	method cargar(unaCosa) {
		//if(unaCosa.esConsecuenciaDeCarga()){
		//cosas.forEach({cosa=>cosa.consPorCargarGranel()})
		cosas.add(unaCosa)
		unaCosa.consecuenciaPorCarga()
		//} else cosas.add(unaCosa)

		// el caso comentado es por que entendi que si se cargaba  la arena de granel  cambiaba  todos objetos dentro de la colleccion
		// hasta que lei el caso  del contenedor portuario

	}

	method transportar(destino,camino){
		self.validacionTransporte(destino,camino)
		destino.almacenar(self)
		self.vaciarCarga()
	}

	method vaciarCarga(){
		cosas.removeAll(cosas)
	}

	method validacionTransporte(destino,camino){
		self.validacionPesoCamion()
		self.validacionBulto(destino)
		self.validacionDeCamino(camino)
	}

	method validacionPesoCamion(){
		if (self.excedidoDePeso()) self.error("camion Excedido de peso")
	}

	method validacionBulto(destino){
		if(destino.capacidadMaximaReal() <= self.totalBultos()) self.error("no hay suficiente capacidad en el almacen")
	}

	method validacionDeCamino(camino){
		if(camino.puedeViajar(self)) self.error("no cumple con los requerimientos del camino")
	}


	
}

object almacen {

	const cosasAlmacen = #{}
	var property capacidadMaxima = 3

	method capacidadMaximaReal(){

		return capacidadMaxima - self.cantidadDeBultos()
	}

	method cantidadDeBultos(){

		return cosasAlmacen.sum({cosa=> cosa.cantBulto()})
	}

	method almacenar(camion){
		cosasAlmacen.addAll(camion.cosas())
	}

	method cosasAlmacen() {

		return cosasAlmacen
	}

	method agregar(unaCosa){
		cosasAlmacen.add(unaCosa)
	}
}

object ruta9 {

	const maximoPeligrosidad = 11

	method puedeViajar(camion){
		return camion.puedeCircularEnRuta(maximoPeligrosidad)
	}



}

object caminosVecinales {

	var pesoMaximo = 0

	method puedeViajar(camion){
		return camion.pesoTotal() <= pesoMaximo
	}

	method pesoMaximo(_pesoMaximo){

		pesoMaximo = _pesoMaximo
	}


}
