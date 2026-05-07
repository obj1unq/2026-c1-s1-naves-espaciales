class Nave {

	var property velocidad = 0

	method propulsate() {
		self.aumentaVelocidad(20000)
	}

	method frenate() {
		velocidad = 0
	}

	method preparateParaElViaje() {
		self.aumentaVelocidad(15000)
	}

	method aumentaVelocidad(aceleracion) {
		velocidad = (velocidad + aceleracion).min(300000)
	}

	method encontrateConElEnemigo() {
		self.recibirAmenaza()
		self.propulsate()
	}

	method recibirAmenaza()
}

class NaveLoca inherits Nave { }

// const nave = new Nave()

class NaveDeCarga inherits Nave {

	var property carga = 0


	method sobrecargada() = carga > 100000

	method excedidaDeVelocidad() = velocidad > 100000

	method recibirAmenaza() {
		carga = 0
	}

}

class NaveDeResiduos inherits NaveDeCarga {
	var estaAlVacio = false

	override method recibirAmenaza() {
		self.frenate()
	}

	override method preparateParaElViaje() {
		super()
		estaAlVacio = true
	}
}

class NaveDePasajeros inherits Nave {

	var property alarma = false
	const cantidadDePasajeros = 0

	method tripulacion() = cantidadDePasajeros + 4

	method velocidadMaximaLegal() = 300000 / self.tripulacion() - if (cantidadDePasajeros > 100) 200 else 0

	method estaEnPeligro() = velocidad > self.velocidadMaximaLegal() or alarma

	method recibirAmenaza() {
		alarma = true
	}

}

class NaveDeCombate inherits Nave {

	var property modo = reposo
	const property mensajesEmitidos = []

	method emitirMensaje(mensaje) {
		mensajesEmitidos.add(mensaje)
	}
	
	method ultimoMensaje() = mensajesEmitidos.last()

	method estaInvisible() = velocidad < 10000 and modo.invisible()

	method recibirAmenaza() {
		modo.recibirAmenaza(self)
	}

	override method preparateParaElViaje() {
		super()
		modo.prepararViajePara(self)
	}

}

object reposo {

	method invisible() = false

	method recibirAmenaza(nave) {
		nave.emitirMensaje("¡RETIRADA!")
	}

	method prepararViajePara(nave) {
		nave.emitirMensaje("Saliendo en misión")
		nave.modo(ataque)
	}
}

object ataque {

	method invisible() = true

	method recibirAmenaza(nave) {
		nave.emitirMensaje("Enemigo encontrado")
	}

	method prepararViajePara(nave) {
		nave.emitirMensaje("Volviendo a la base")
	}

}

