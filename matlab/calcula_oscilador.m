clear all

% % Calcula oscilador dado el coeficiente gammat 

% % % % % Par?metros S % % % % % %

s11 = 0.59*exp(1i*(degtorad(-137)));
s12 = 0.028*exp(1i*(degtorad(44)));
s21 = 11.13*exp(1i*(degtorad(102)));
s22 = 0.58*exp(1i*(degtorad(-27)));

% % % % Otros parametros % % % % %
er=4.5; %permitividad electrica relativa
e0=8.8542*10^-12; %permitividad electrica absoluta
u0=4*pi*10^-7; %permeabilidad magn?tica;
h=1.6; %Espesor del dielectrico en mm
Zo = 50;
f=500*10^6;

% C?lculo de ZL

gammat = 0.9239+1*i*0.3827;   %%%% coeficiente que eliges inestable viendo la curva CES

gammaIN=s11+((s12*s21*gammat)/(1-s22*gammat))
Zin = Zo * (1+gammaIN)/(1-gammaIN);

ZL = abs(real(Zin))/3 + -1*j*imag(Zin)

disp('Para adaptar sacamos el conjugado de Zl y sus correspondientes componentes')

ZL=conj(ZL)

R=real(ZL)

if(imag(ZL)>0)
    L=imag(ZL)/(2*pi*f)
end

if(imag(ZL)<9)
    C=1/(2*pi*f*imag(ZL))
end
