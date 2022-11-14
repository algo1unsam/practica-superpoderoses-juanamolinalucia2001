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
		return poderes.max({poder=>poder.capacidadBatalla(self)})
	}
	
	method soyInmune(){
		return poderes.any({poder=>poder.otorgarInmunidad().equals(true)})
	}
	
	method superaPeligro(peligro){
		return peligro.esCapazDeVencer(self)
	}
}
class  Metahumano inherits Personaje{
	
	override method capacidadBatalla(){
		return super()*2
	}
	
	override method soyInmune(){
		return true
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
	
	method otorgarInmunidad()
}

class Velocidad inherits Poder {

	const property rapidez

	override method agilidad(personaje) {
		return personaje.estrategia() * rapidez
	}

	override method fuerza(personaje) {
		return personaje.espiritualidad() * rapidez
	}
		override method otorgarInmunidad(){
		return false
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
	
		override method otorgarInmunidad(){
		return alturaMaxima>200
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
	
	override method otorgarInmunidad(){
		return true
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
	
	method peligroSensato(peligro) {
		return personajes.all({ personaje => personaje.superaPeligro(peligro) })
	}
	
	
}

class Peligro{
	var property nivelComplejidad
	var property capacidadDebatalla
	var property desechosRadiactivos
	var property cantidad	

	
	method esCapazDeVencer(personaje){
		return personaje.capacidadBatalla() > capacidadDebatalla
	}
	
	
	
	}
