package data;

import data.NumeroComplejo;

public class AdaptacionMicrostrip{
    
	private NumeroComplejo zo1,zo2; //  impedancias de la línea y del stub
	private NumeroComplejo zs,zl;   //  impedancias de fuente e impedancia de carga que se quiere adaptar
	private NumeroComplejo Z0, ZL, ZS;
	
	private double l1=Double.NaN, l2=Double.NaN,w1,w2;     // longitud y anchura de la línea de transmisión y el stub

	public AdaptacionMicrostrip(double RS, double XS, double RL, double XL, double Z0){
		this.Z0  = new NumeroComplejo(Z0, 0);
		ZL = new NumeroComplejo(RL, XL);
		ZS = new NumeroComplejo(RS, XS);
	}
	
	
	/*
	 * Funcion a minimizar: |conj(Zs)-Zin|
	 */
	private double fMin(double lLinea, double lStub){  
		NumeroComplejo num = ZL.suma(Z0.multiplica(new NumeroComplejo(0,Math.tan(2*Math.PI*lLinea))));
		NumeroComplejo den = Z0.suma(ZL.multiplica(new NumeroComplejo(0,Math.tan(2*Math.PI*lLinea))));
		NumeroComplejo ZinLinea = Z0.multiplica(num).dividir(den);
		NumeroComplejo ZinStub = Z0.dividir(new NumeroComplejo(0, Math.tan(2*Math.PI*lStub)));
		NumeroComplejo Zin = ZinLinea.multiplica(ZinStub).dividir(ZinLinea.suma(ZinStub));
		return ZS.conjugado().resta(Zin).abs();
	}
	
	/*
	 * Implementacion del algoritmo de descenso de gradiente
	 */
	private void minimizar(double lLinea, double lStub){
		final double DIFF = 0.00001;
		final double U = 0.00001;
		final double UMBRAL = ZS.abs()*0.05;
		final double MAX_IT = 10000;
		
		double fMin, gra_fMin_linea, gra_fMin_stub;
		int i = 0;
		do{
			fMin = fMin(lLinea, lStub);
			gra_fMin_linea = (fMin(lLinea+DIFF, lStub)-fMin)/DIFF;
			gra_fMin_stub = (fMin(lLinea, lStub+DIFF)-fMin)/DIFF;
			lLinea -= U*gra_fMin_linea;
			lStub -= U*gra_fMin_stub;
		}while(fMin > UMBRAL && ++i < MAX_IT);
		
		System.out.println("Longitud línea: "+ lLinea+", longitud stub: "+lStub+", err: "+fMin*100/ZS.abs()+"%");
	}
	
	public void calculaLongitudes(){
		double l1 = Math.PI/2, l2 = 3*l1;
		minimizar(l1, l1);
		minimizar(l1, l2);
		minimizar(l2, l1);
		minimizar(l2, l2);
	}
	
	public void resolverStub(){
		
		float w1,w2;
		NumeroComplejo Zin, Zx, Zy, Zz, aux1, aux2 = null;
		Zin = zs.conjugado();
	
		
		for (int i = 1; i<=10000; i++){
			for (int j = 1; j<=10000; j++){
				
				w2 = (float) (2*Math.PI*j*0.0001);
				w1 = (float) (2*Math.PI*i*0.0001);
				
				aux1 = zo2.suma(((zl.multiplica(new NumeroComplejo(0, Math.tan(w2))))));
				//aux1.imprime();
				aux2 = zl.suma(((zo2.multiplica(new NumeroComplejo(0,Math.tan(w2))))));
				//aux2.imprime();
				
				Zx = zo2.multiplica(aux2.dividir(aux1));
				//Zx.imprime();
//				Zx = (zo2.dividir((((zl.multiplica(new NumeroComplejo(Math.tan(w2),0))).multiplica(new NumeroComplejo(0,1))).suma(zo2)))).multiplica(zl.suma(((zo2.multiplica(new NumeroComplejo(Math.tan(2*Math.PI*12),0)))).multiplica(new NumeroComplejo(0, 1))));
						
				Zy = (zo1.multiplica(new NumeroComplejo(1/Math.tan(w1), 0))).multiplica(new NumeroComplejo(0, -1));
				//Zy.imprime();
				Zz = (Zx.multiplica(Zy)).dividir(Zx.suma(Zy));
				//Zz.imprime();
				
				
				if ((Math.abs(Zz.real()) >= Math.abs(Zin.real())*0.95) && (Math.abs(Zz.real()) <= Math.abs(Zin.real())*1.05)){
					if ((Math.abs(Zz.imag()) >= Math.abs(Zin.imag())*0.95) && (Math.abs(Zz.imag()) <= Math.abs(Zin.imag())*1.05)){
						l1 = i*0.0001;
						l2 = j*0.0001;
						
						
					}
				}
			}
		}
		
		System.out.println("La longitud 1 es:"+l1);
		System.out.println("La longitud 2 es:"+l2);		
	}
}
