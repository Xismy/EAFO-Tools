package data;

public class MicroStrip {
	double factor; //   w/h
	
	public MicroStrip(double Z0, double Er){
		double A = Z0/60 * Math.sqrt((Er+1)/2) + (Er-1)/(Er+1) * (0.23+0.11/Er);
		factor = 8*Math.exp(A)/(Math.exp(2*A)-2);
		if(factor >2){
			double B = 377*Math.PI/(2*Z0*Math.sqrt(Er));
			factor = 2/Math.PI * (B-1-Math.log(2*B-1) + (Er-1)/(2*Er) * (Math.log(B-1)+0.39-0.61/Er));
		}
		System.out.println(factor);
	}
	
	double get_w(double h){
		return factor*h;
	}
	
	double get_h(double w){
		return w/factor;
	}
}
