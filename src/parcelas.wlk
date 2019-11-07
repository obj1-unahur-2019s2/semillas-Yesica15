import semillas.*

class Parcela{
	var property ancho = 0
	var property largo = 0
	var property horasSol = 0
	var property plantas = #{}
	
	method superficie() = ancho*largo
	method cantMax() {
		return if(ancho>largo){
			self.superficie()/5
		} else { self.superficie()/3 + largo}
	}
	method tieneComplicaciones() {
		return plantas.any({plan => plan.horasDeSol()< horasSol})
	}
	method plantar(plan) {
		if (self.cantPlantas() ==self.cantMax() or plan.horasDeSol()+2 <= horasSol){
			plantas.add(plan)
		}else{self.error("La planta no puede entrar")}
	}
	method superaAltura(alt){
		return plantas.any({plan => plan.altura()<alt})
	}
	method seAsociaBien(plan)
	method cantPlantas() = plantas.size()
	method plantasAsocBien() = plantas.filter({plan => self.seAsociaBien(plan)})
	method porcAsoc() = (self.plantasAsocBien().size()*100) / self.cantPlantas()
}

class ParcelaEco inherits Parcela{
	override method seAsociaBien(plan){
		return not self.tieneComplicaciones() and plan.parcelaIdeal(self)
	}
}

class ParcelaInd inherits Parcela{
	override method seAsociaBien(plan){
		return self.cantPlantas() <= 2 and plan.esFuerte()
	}
}

object inta{
	var property parcelas = #{}
	
	method promedioPlantas() = self.sumaTotalPlantas() / self.cantParcelas()
	method sumaTotalPlantas() = parcelas.sum({par => par.cantPlantas()})
	method cantParcelas() = parcelas.size()
	method parConCuatroPlan() = parcelas.filter({par => par.cantPlantas()>4})
	method masAutosustentable() = self.parConCuatroPlan().max({par => par.porcAsoc()})
}