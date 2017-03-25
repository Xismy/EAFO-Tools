package data;

public class NumeroComplejo {
	private double x;
	private double y;
	
	NumeroComplejo(){
		x=0;
		y=0;
	}
	NumeroComplejo(double real, double imaginaria){
		x = real;
		y = imaginaria;		
	}
	
	public NumeroComplejo conjugado(){		
		NumeroComplejo conj = new NumeroComplejo();
		
		conj.x = this.x;
		conj.y = -1 * this.y;		
		return conj;
	}
	
	public double real(){
		return x;
	}
	
	public double imag(){
		return y;
	}
	
	public double abs(){
		
		return  Math.sqrt((Math.pow(x,2) + Math.pow(y,2)));
	}
	
	public NumeroComplejo multiplica(NumeroComplejo entrada ){
		
		NumeroComplejo resultado = new NumeroComplejo();
		
		resultado.x = (x*entrada.x + y *entrada.y);
		resultado.y = (x*entrada.y + y*entrada.x);
		
		return resultado;		
	}
	
	public NumeroComplejo suma(NumeroComplejo entrada){
		
		NumeroComplejo resultado = new NumeroComplejo();
		
		resultado.x = (x + entrada.x);
		resultado.y = (y + entrada.y);
		
		return resultado;
	}
	
	public NumeroComplejo resta(NumeroComplejo entrada){
		NumeroComplejo resultado = new NumeroComplejo();
		
		resultado.x = (x - entrada.x);
		resultado.y = (y - entrada.y);
		
		return resultado;
	}
	
	public NumeroComplejo dividir (NumeroComplejo entrada){
		
		NumeroComplejo resultado = new NumeroComplejo();
		
		
		resultado.x = (x*entrada.x + y*entrada.y)/Math.pow(entrada.abs(),2);
		resultado.y = (y*entrada.x - x*entrada.y)/Math.pow(entrada.abs(),2);
		
		return resultado;		
	}
	
	public void imprime(){
		if (y < 0){
			System.out.println(x + " - j" + Math.abs(y));
		}
		else{
			System.out.println(x + " + j" + Math.abs(y));
		}
		
	}
	
	
}




