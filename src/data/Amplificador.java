package data;

public class Amplificador {
	private NumeroComplejo[][] param_S = new NumeroComplejo[2][2];
	private NumeroComplejo delta, cCES, cCEE;
	private double rCES, rCEE;
	private boolean int_CES, int_CEE;
	
	Amplificador(NumeroComplejo s11, NumeroComplejo s12, NumeroComplejo s21, NumeroComplejo s22){
		param_S[0][0] = s11;
		param_S[0][1] = s12;
		param_S[1][0] = s21;
		param_S[1][1] = s22;
		
		delta = s11.multiplica(s22).resta(s21.multiplica(s12));
		
		cCES = delta.conjugado().multiplica(s11).resta(s22.conjugado()).dividir(delta.abs2()-s22.abs2());
		rCES = s12.multiplica(s21).abs()/(delta.abs2()-s22.abs2());
		
		cCEE = delta.conjugado().multiplica(s22).resta(s11.conjugado()).dividir(delta.abs2()-s11.abs2());
		rCEE = s12.multiplica(s21).abs()/(delta.abs2()-s11.abs2());
		
		boolean gammaL_0_estable = s11.abs() < 1;
		boolean gammaS_0_estable = s22.abs() < 1;
		boolean CEScontiene0 = cCES.abs() < rCES;
		boolean CEEcontiene0 = cCEE.abs() < rCEE;
		
		int_CES = gammaL_0_estable ^ CEScontiene0;
		int_CEE = gammaS_0_estable ^ CEEcontiene0;
	}
	
	public NumeroComplejo get_cCES(){
		return cCES;
	}
	
	public NumeroComplejo get_cCEE(){
		return cCEE;
	}
	
	public double getrCES() {
		return rCES;
	}
	
	public double getrCEE() {
		return rCEE;
	}	
}
