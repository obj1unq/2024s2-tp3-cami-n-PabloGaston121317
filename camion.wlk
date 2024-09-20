import cosas.*

object camion {
	const property cosas = #{}
	const tara = 1000
	const pesoMaximo = 2500

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

		return cosas.find({cosa=> cosa.nivelPeligrosidad() == 10})
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
		cosas.add(unaCosa)
	}

}
