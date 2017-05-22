clear all

% % Calcula oscilador dado el coeficiente gammat 

% % % % % Parámetros S % % % % % %

s11 = 0.50*exp(1i*(degtorad(-88)));
s12 = 0.008*exp(1i*(degtorad(68)));
s21 = 45.64*exp(1i*(degtorad(135)));
s22 = 0.77*exp(1i*(degtorad(-22)));
Zo = 50;

gammat = 0.5957 + 0.8032j;   %%%% coeficiente que eliges inestable viendo la curva CES 

gammaIN=s11+((s12*s21*gammat)/(1-s22*gammat))
Zin = Zo * (1+gammaIN)/(1-gammaIN)

ZL = abs(real(Zin))/3 + -1*j*imag(Zin)