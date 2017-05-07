package data;

import javax.swing.JOptionPane;

import data.NumeroComplejo;

public class AdaptacionMicrostrip{
	private NumeroComplejo ZL, ZS;
	private double Z0;
	
	private double lLinea_s1, lLinea_s2, lStub_s1, lStub_s2;     // longitud y anchura de la línea de transmisión y el stub

	public AdaptacionMicrostrip(double RS, double XS, double RL, double XL, double Z0){
		this.Z0  = Z0;
		ZL = new NumeroComplejo(RL, XL);
		ZS = new NumeroComplejo(RS, XS);
	}
	
	public void solucion(){
		NumeroComplejo YS = new NumeroComplejo(1, 0).dividir(ZS);//Admitancia de fuente
		NumeroComplejo YL = new NumeroComplejo(1, 0).dividir(ZL);//Admitancia de carga
		double GS = YS.real(), BS = YS.imag();//Dividimos en conductancia y susceptancia
		double GL = YL.real(), BL = YL.imag();
		
		//Igualando la parte real de la admitancia de una linea de longitud l a la parte real
		//de la admitancia de fuente obtenemos dos ecuaciones, cuyas incognitas son tan(beta*l)
		//y la susceptancia de la linea. Despejando la susceptancia de la linea en ambas e igualando,
		//obtenemos una ecuacion de segundo grado con los siguientes coeficientes:
		double a = YL.abs2()*GS*Z0*Z0-GL;
		double b = -2*Z0*GS*BL;
		double c = GS-GL;
		
		//Solucion1
		double tanBl1_s1 = (-b+Math.sqrt(b*b-4*a*c))/(2*a);
		double Blinea_s1 = (GS*(1-Z0*BL*tanBl1_s1)-GL)/(Z0*GL*tanBl1_s1); 
		//La longitud del stub debe ser tal que Ystub+Ylinea=Ys* 
		double tanBl2_s1 = -Z0*(BS+Blinea_s1);
		
		//Solucion2
		double tanBl1_s2 = (-b-Math.sqrt(b*b-4*a*c))/(2*a);
		double Blinea_s2 = (GS*(1-Z0*BL*tanBl1_s2)-GL)/(Z0*GL*tanBl1_s2); 
		double tanBl2_s2 = -Z0*(BS+Blinea_s2);
		
		lLinea_s1 = Math.atan(tanBl1_s1)/(2*Math.PI);
		lStub_s1 = Math.atan(tanBl2_s1)/(2*Math.PI);
		if(lLinea_s1 < 0)
			lLinea_s1 = lLinea_s1+0.5;
		if(lStub_s1 < 0)
			lStub_s1 = lStub_s1+0.5;
		
		lLinea_s2 = Math.atan(tanBl1_s2)/(2*Math.PI);
		lStub_s2 = Math.atan(tanBl2_s2)/(2*Math.PI);
		if(lLinea_s2 < 0)
			lLinea_s2 = lLinea_s2+0.5;
		if(lStub_s2 < 0)
			lStub_s2 = lStub_s2+0.5;
		
		
	}
	
	public void solucion(MicroStrip uStrip, double freq){
		Z0 = uStrip.get_Z0();
		solucion();
		JOptionPane.showMessageDialog(null, "Solucion1\n"+
				"Linea: "+ uStrip.lambdas2mm(lLinea_s1, freq)+"mm\n"+
				"Stub: "+ uStrip.lambdas2mm(lStub_s1, freq)+"mm\nSolucion2\n"+
				"Linea: "+ uStrip.lambdas2mm(lLinea_s2, freq)+"mm\n"+
				"Stub: "+ uStrip.lambdas2mm(lStub_s2, freq)+"mm");
	}
}
