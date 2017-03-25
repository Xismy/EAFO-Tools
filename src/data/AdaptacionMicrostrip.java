package data;
import data.NumeroComplejo;

public class AdaptacionMicrostrip {
    
	private NumeroComplejo zo1,zo2; //  impedancias de la línea y del stub
	private NumeroComplejo zs,zl;   //  impedancias de fuente e impedancia de carga que se quiere adaptar
	
	private double l1,l2,w1,w2;     // longitud y anchura de la línea de transmisión y el stub

	public AdaptacionMicrostrip(){
		zo1 = new NumeroComplejo(50,0);
		zo2 = new NumeroComplejo(50,0);	
		zs =  new NumeroComplejo(15, -25);
		zl = new NumeroComplejo(35, 20);
	}
	
	public void resolverStub(){
		
		float w1,w2;
		NumeroComplejo Zin, Zx, Zy, Zz, aux1, aux2 = null;
		Zin = zs.conjugado();
	
		
		for (int i = 1000; i<=1000; i++){
			for (int j = 1000; j<=1000; j++){
				
				w2 = (float) (2*Math.PI*j*0.0001);
				w1 = (float) (2*Math.PI*i*0.0001);
				
				aux1 = zo2.suma(((zl.multiplica(new NumeroComplejo(Math.tan(w2),0))).multiplica(new NumeroComplejo(0,1))));
				aux1.imprime();
				aux2 = zl.suma(((zo2.multiplica(new NumeroComplejo(Math.tan(w2),0))).multiplica(new NumeroComplejo(0,1))));
				aux2.imprime();
				
				Zx = zo2.multiplica(aux2.dividir(aux1));
				Zx.imprime();
//				Zx = (zo2.dividir((((zl.multiplica(new NumeroComplejo(Math.tan(w2),0))).multiplica(new NumeroComplejo(0,1))).suma(zo2)))).multiplica(zl.suma(((zo2.multiplica(new NumeroComplejo(Math.tan(2*Math.PI*12),0)))).multiplica(new NumeroComplejo(0, 1))));
						
				Zy = (zo1.multiplica(new NumeroComplejo(1/Math.tan(w1), 0))).multiplica(new NumeroComplejo(0, -1));
				Zy.imprime();
				Zz = (Zx.multiplica(Zy)).dividir(Zx.suma(Zy));
				Zz.imprime();
				
				
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
