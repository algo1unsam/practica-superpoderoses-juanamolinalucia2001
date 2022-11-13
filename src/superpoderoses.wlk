class Feria{
const property puestos=[]

method agregarPuesto(puesto){
	puestos.add(puesto)
}

method cualesPuedeVisitar(persona) {
		return puestos.filter({ puesto => puesto.puedeSerUsado(persona) })
	}
	
	
method usoAlgunPuesto(persona){
	return puestos.any({puesto=>puesto.fueVisitadoPor(persona)})
}

}
class Puesto{
//Todos los puestos tienen un municipio que los apadrina
const property padrino
var property visitantes=[]

method puedeSerUsado(persona)	


method validaPuedeSerUsado(persona){
	if(not self.puedeSerUsado(persona)){
		self.error("este puesto no puede ser usado")
	}
	
}

method usar(persona){
	self.validaPuedeSerUsado(persona)
	visitantes.add(persona)
}

method fueVisitadoPor(persona){
	return visitantes.contains(persona)
}


}


class PuestoComercial inherits Puesto{
	const costo
	
	override method puedeSerUsado(persona){
		return persona.dinero()> costo
	}
	
	override method usar(persona){
	super(persona)
	persona.gastarDinero(costo)
}

	
}

class PuestoInfantil inherits Puesto{
	override method puedeSerUsado(persona){
	return persona.edad() < 18
	}
	
	override method usar(persona){
	super(persona)
	persona.ganarDinero()
}
}

class PuestoImpositivo inherits Puesto{
	//que al ser usado, un visitante pagará toda o parte de su deuda municipal.
	
	//El visitante debe residir en el mismo municipio que apadrina el puesto impositivo.
	
	override method puedeSerUsado(persona){
		return self.esRecidente(persona) and persona.tieneDeuda() and persona.puedePagar()
		
	}
	
	override method usar(persona){
		super(persona)
		persona.pagarDeuda()
	}
	
	method esRecidente(persona){
		return persona.municipioRecidencia().equals(padrino)
	}

}


class Visitante{
	var property edad
	var property dinero
	const property municipioRecidencia
	var property deudaMunicipal
	
	method gastarDinero(costo){
		dinero-=costo
	}
	
	method ganarDinero(){
		dinero+=10
	}
	method esMayorQue(numero){
		return edad>=numero
	}
	method tieneDeuda(){
		return deudaMunicipal>0
	}
	
	method puedePagar(){
		return dinero>=deudaMunicipal
	}
	
	method pagarDeuda() {
		const monto = municipioRecidencia.montoExigible(self)
		self.gastarDinero(monto)
		deudaMunicipal -= monto
	}
	
}

class Municipio{
		var recaudado=0
		method montoExigible(persona){
		return self.montoBruto(persona) - self.montoProrrogable(persona)
	}
	
	
	method montoBruto(persona){
		return persona.deudaMunicipal()
	}
	method montoProrrogable(persona){
		return if (self.condicionEdad(persona)) self.montoBruto(persona) * 0.1 else 0
	}

	method condicionEdad(persona){
		return persona.esMayorQue(75)
	}
	
	method recibirPago(persona) {
		recaudado += self.montoExigible(persona)
	}
	
}

//Para los municipios relajados el monto bruto es el número menor de entre la deuda
// y el dinero disponible, mientras que el monto prorrogable es igual que los municipios normales.
class Relajado inherits Municipio{
	
	override method montoBruto(persona){
		if(self.cualEsMenor(persona)){
			return persona.dinero()		
		}else{
			return persona.deudaMunicipal()
		}
	}
	
	method cualEsMenor(persona){
		return persona.deudaMunicipal()>persona.dinero()
		
	}
	
	
		
}
	

//Para los municipios hiperrelajados, el monto bruto es el 80% del bruto que calcularía un municipio relajado y el monto prorrogable es el doble que el del resto de los municipios. 
//Pero además, la edad para saber si corresponde o no baja a 60 años.
class HiperRelajado inherits Relajado{
	
	override method montoBruto(persona) {
		return super(persona) * 0.8
	}

	override method montoProrrogable(persona) {
		return super(persona) * 2
	}
	
		override method condicionEdad(persona){
		return persona.esMayorQue(60)
	}
}


