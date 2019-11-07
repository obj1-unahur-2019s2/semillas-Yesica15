import parcelas.*

class Planta{
	var property anioObtencion = 0
	var property altura = 0
	
	method horasDeSol()
	method esFuerte() = self.horasDeSol() >=10
	method daNuevasSem() = self.esFuerte()
	method espacio()
	method parcelaIdeal(parc)
}

class Menta inherits Planta{
	override method horasDeSol() = 6
	override method daNuevasSem() = super() or altura > 0.4
	override method espacio() = altura * 3 
	override method parcelaIdeal(parc) = parc.superficie()>6
}

class Soja inherits Planta{
	override method horasDeSol() {
		return if(altura<=0.5){6} else { if (altura<=1){7} else{9}}
	}
	override method daNuevasSem() = super() or (anioObtencion>2007 and altura>1)
	override method espacio() = altura /2
	override method parcelaIdeal(parc) = parc.horasSol() == self.horasDeSol()
}

class Quinoa inherits Planta{
	var property horasDeSol = 0
	override method daNuevasSem() = super() or anioObtencion<2005
	override method espacio() = 0.5
	override method parcelaIdeal(parc) = parc.superaAltura(1.5)
}

class SojaTrans inherits Soja{
	override method daNuevasSem() = false
		override method parcelaIdeal(parc) = parc.cantMax() ==1
}

class HierbaBuena inherits Menta{
	override method espacio() = super()*2
}