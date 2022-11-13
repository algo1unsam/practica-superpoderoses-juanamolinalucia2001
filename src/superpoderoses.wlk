class Personaje {

	const property estrategia
	const property espiritualidad
	const property poderes = []

	method capacidadBatalla() {
		return poderes.sum({ poder => poder.capacidadBatalla(self)})
	}
	

	
	method agregarPoder(poder){
		poderes.add(poder)
	}
	
	method mejorPoder(){
		return poderes.max({poder=>poder.capacidadBatalla()})
	}
}

class Poder {

	method capacidadBatalla(personaje) {
		return (self.agilidad(personaje) + self.fuerza(personaje)) * self.habilidadEspecial(personaje)
	}

	method agilidad(personaje)

	method fuerza(personaje)

	method habilidadEspecial(personaje) {
		return personaje.espiritualidad() + personaje.estrategia()
	}

}

class Velocidad inherits Poder {

	const property rapidez

	override method agilidad(personaje) {
		return personaje.estrategia() * rapidez
	}

	override method fuerza(personaje) {
		return personaje.espiritualidad() * rapidez
	}

}

class Vuelo inherits Poder {

	const property alturaMaxima
	const property energiaParaDespegue

	override method agilidad(personaje) {
		return personaje.estrategia() * alturaMaxima / energiaParaDespegue
	}

	override method fuerza(personaje) {
		return personaje.espiritualidad() + alturaMaxima - energiaParaDespegue
	}

}

class PoderAmplificador inherits Poder {

	const property poderBase
	const property amplificador

	override method agilidad(personaje) {
		return poderBase.agilidad(personaje)
	}

	override method fuerza(personaje) {
		return poderBase.fuerza(personaje)
	}

	override method habilidadEspecial(personaje) {
		return poderBase.habilidadEspecial(personaje) * amplificador
	}

}

class Equipo{
	var property personajes=[]
	
	method agregarPersonajes(personejes){
		personajes.add(personejes)
	}
	
	method masVuelnerable(){
		return personajes.min({personaje=> personaje.capacidadBatalla()})
	}
	
	method calidad(){
		return self.totalCapacidad() / personajes.size()
	}
	
	method totalCapacidad(){
		return personajes.sum({personaje => personaje.capacidadBatalla()})
	}
	method mejoresPoderes(){
	 return	personajes.map({personaje=>personaje.mejorPoder()})
	}
	

}

class Peligro{
	var property capacidadDebatalla
	var property desechosRadiactivos
	
	method puedeSerAfrontado(personaje){
		return self.esCapazDeVencer(personaje) and self.desechosRadiactivos()
	}
	
	method esCapazDeVencer(personaje){
		return personaje.capacidadDeBatalla() > capacidadDebatalla
	}
	
	method esCapazManejarRadioactividad(personaje){
			if(desechosRadiactivos) personaje.esInmune()
	}
	}
