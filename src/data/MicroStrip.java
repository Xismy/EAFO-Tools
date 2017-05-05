package data;

public class MicroStrip {
	double Er, h, w, vp, Z0;
	
	public MicroStrip(double Z0, double Er){
		double A = Z0/60 * Math.sqrt((Er+1)/2) + (Er-1)/(Er+1) * (0.23+0.11/Er);
		double factor = 8*Math.exp(A)/(Math.exp(2*A)-2);
		this.Er = Er;
		this.Z0 = Z0;
		if(factor >2){
			double B = 377*Math.PI/(2*Z0*Math.sqrt(Er));
			factor = 2/Math.PI * (B-1-Math.log(2*B-1) + (Er-1)/(2*Er) * (Math.log(B-1)+0.39-0.61/Er));
		}
		h = 1;
		w = factor * h;
		System.out.println(factor);
	}
	
	public void setW(double w){
		h = h/this.w*w;
		this.w = w;
		calcula_vp();
	}
	
	public void setH(double h){
		w = w/this.h*h;
		this.h = h;
		calcula_vp();
	}
	
	void calcula_vp(){
		double Ereff = (Er+1)/2 + (Er-1)/(2*Math.sqrt(1+12*h/w));
		vp =3e8/Math.sqrt(Ereff);
	}
	
	double lambdas2mm(double lambdas, double f){
		double lambda = vp/f*1000;
		System.out.println(lambda);
		return lambda*lambdas;
	}
	
	double get_w(){
		return w;
	}
	
	double get_h(){
		return h;
	}
	
	double get_Z0(){
		return Z0;
	}
}
