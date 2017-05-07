package data;

public class RedAdaptacion {
	private float rs, rl; //Parte real de las impedancias de generador y carga.
	private float xs, xl; //Parte imaginaria de las impedancias de generador y carga.
	private float[] a, b; //Z1 = ja, Z2=-jb    (Hay dos soluciones)
	
	public RedAdaptacion(){
		a = new float[4];
		b = new float[4];
	}
	
	/*********************************************************
	 * Resuelve los valores de a y b para la adaptacion en L.
	 *********************************************************/
	public void resolverL1(){
		float A, B, C;
		float r_disc;
		
		A = rl*rl+xl*xl;
		B = 2*xl;
		C = 1-rl/rs;
		
		r_disc = (float)Math.sqrt(B*B-4*A*C);
		
		b[0] = (-B+r_disc)/(2*A);
		b[1] = (-B-r_disc)/(2*A);
		
		for(int i = 0; i<2; i++)
			a[i] = (b[i]*A-xl)/(b[i]*b[i]*A-2*xl*b[i]+1)-xs;
	}
	
	public void resolverL2(){
		float A, B, C;
		float r_disc;
		
		A = 1;
		B = 2*xl;
		C = rl*rl+xl*xl-(rl/rs)*(rs*rs+xs*xs);
		
		r_disc = (float)Math.sqrt(B*B-4*A*C);
		
		a[2] = (-B+r_disc)/(2*A);
		a[3] = (-B-r_disc)/(2*A);
		
		for(int i = 2; i<4; i++)
			b[i] = xs/(rs*rs+xs*xs)+(a[i]+xl)/(a[i]*a[i]+2*xl*a[i]+rl*rl+xl*xl);
	}
	
	public void setParam(float rs, float xs, float rl, float xl){
		this.rs = rs;
		this.xs = xs;
		this.rl = rl;
		this.xl = xl;
	}
	
	public float[] getSol(int n){
		return new float[]{a[n], -1/b[n]};
	}
}
