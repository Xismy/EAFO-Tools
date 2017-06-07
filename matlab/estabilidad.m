clear all
close all

% Como entrada se dan los par�metros S

% s11 = 0.5033*exp(1i*(degtorad(158.5)));
% s12 = 0.0720*exp(1i*(degtorad(52.7)));
% s21 = 5.659*exp(1i*(degtorad(49.3)));
% s22 = 0.1973*exp(1i*(degtorad(-119.3)));

% Oscilador 1 GHz

s11 = 0.4879*exp(1i*(degtorad(146.4)));
s12 = 0.0945*exp(1i*(degtorad(25.9)));
s21 = 4.027*exp(1i*(degtorad(30)));
s22 = 0.243*exp(1i*(degtorad(-119.7)));
Zo = 50;

angle=0:pi/64:2.1*pi;
% plot(cos(angle),sin(angle),'k');
[lineseries,hsm] = smithchart(1);
hold on;

Delta = s11*s22 - s21*s12; 

%%Curva de estabilidad a la salida

cCES = (conj(Delta)*s11 - conj(s22))/(abs(Delta)^2 - abs(s22)^2);
rCES = (abs(s12*s21))/(abs(abs(Delta)^2-abs(s22)^2));

% Curva de estabilidad a la entrada

cCEE = (conj(Delta)*s22 - conj(s11))/(abs(Delta)^2 - abs(s11)^2);
rCEE = (abs(s12*s21))/(abs(abs(Delta)^2-abs(s11)^2));

% Constante de rollet

K = (1 - abs(s11)^2 - abs(s22)^2 + abs(Delta)^2)/(2*abs(s12*s21));

%%% Comprobaci�n de estabilidad con la constante de rollet
if (K > 1 && abs(Delta) < 1)
   disp('Estabilidad incondicional')
end

if (K > 1 && abs(Delta) > 1)
   disp('Estabilidad condiciona ')
end

if (K < 1  && K > -1)
   disp('Estabilidad condicional')
end

if (K < -1)
   disp('Incondicionalmente inestable')
end

%%% Determinaci�n de la estabilidad en las regiones calculadas

if (abs(s11) < 1)
    disp('gammaL = 0 es estable')

else
    disp('gammaL = 0 es inestable')
end

if (abs(s22) < 1)
    disp('gammaS = 0 es estable')

else
    disp('gammaS = 0 es inestable')
end

%MAG

MAG=abs(s21/s12)*(K-sqrt(K^2-1));
MAGdB=10*log10(MAG);

%MSG

MSG=abs(s21/s12);
MSGdB=10*log10(MSG);

%Curvas de ganancia de potencia constante:

if (K > 1 && abs(Delta) < 1)
    Gp = MAG;   
else
    Gp = MSG;
end

gp=Gp/abs(s21)^2;

Cp = gp*conj(s22-Delta*conj(s11))/(1+gp*(abs(s22)^2-abs(Delta)^2)); %Centro
rp=sqrt(1-2*K*abs(s12*s21)*gp+(abs(s12*s21)^2)*gp^2)/(1+gp*(abs(s22)^2-abs(Delta)^2)); %radio

%Curvas de ganancia disponible constante (CEA):


if (K > 1 && abs(Delta) < 1)
    Ga = MAG;   
else
    Ga = MSG;
end

ga=Ga/abs(s21)^2;

Ca = ga*conj(s11-Delta*conj(s22))/(1+ga*(abs(s11)^2-abs(Delta)^2)); %Centro
ra = sqrt(1-2*K*abs(s12*s21)*ga+(abs(s12*s21)^2)*ga^2)/(1+ga*(abs(s11)^2-abs(Delta)^2)); %radio

%Curvas de Figura de ruido constante:
%Datos dado por el fabricante:
Rn_norm=0.1;
Coefopt = 0.24*exp(1i*(degtorad(180)));
FmindB=0.96; %en dB
Fmin=10^(FmindB/10); %En lineal

Fi=Fmin;
Fi2dB=FmindB+0.3;
Fi2=10^(Fi2dB/10);
Ni=((Fi-Fmin)*abs(1+Coefopt)^2)/(4*Rn_norm);
Ni2=((Fi2-Fmin)*abs(1+Coefopt)^2)/(4*Rn_norm);
rn=sqrt(Ni^2+Ni*(1-abs(Coefopt)^2))/(1+Ni);
rn2=sqrt(Ni2^2+Ni2*(1-abs(Coefopt)^2))/(1+Ni2);
Cn=Coefopt/(1+Ni);
Cn2=Coefopt/(1+Ni2);

Fi3dB=FmindB+0.6;
Fi4dB = FmindB + 1;
Fi4=10^(Fi4dB/10);
Fi3=10^(Fi3dB/10);
Ni3=((Fi3-Fmin)*abs(1+Coefopt)^2)/(4*Rn_norm);
Ni4=((Fi4-Fmin)*abs(1+Coefopt)^2)/(4*Rn_norm);
rn3=sqrt(Ni3^2+Ni3*(1-abs(Coefopt)^2))/(1+Ni3);
rn4=sqrt(Ni4^2+Ni4*(1-abs(Coefopt)^2))/(1+Ni4);
Cn3=Coefopt/(1+Ni3);
Cn4=Coefopt/(1+Ni4);

%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Impedancia Zs y ZL %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%

CoefS=-0.54; %Fijarla nosotros
Zs=Coef2Z(CoefS,Zo)
CoefOut=calculoCoefOut(s11,s12,s21,s22,Zs,Zo);
CoefL=conj(CoefOut);
ZL=Coef2Z(CoefL,Zo);

% se dibuja tambi�n otras curvas de ganancia 

GpdB = 10*log10(Ga);
GpdB2 = GpdB - 5;
GpdB3 = GpdB - 10;

Ga2 = 10^(GpdB2/10);
Ga3 = 10^(GpdB3/10);

ga2=Ga2/abs(s21)^2;
Ca2 = ga2*conj(s11-Delta*conj(s22))/(1+ga2*(abs(s11)^2-abs(Delta)^2)); %Centro
ra2 = sqrt(1-2*K*abs(s12*s21)*ga2+(abs(s12*s21)^2)*ga2^2)/(1+ga2*(abs(s11)^2-abs(Delta)^2)); %radio

ga3=Ga3/abs(s21)^2;
Ca3 = ga3*conj(s11-Delta*conj(s22))/(1+ga3*(abs(s11)^2-abs(Delta)^2)); %Centro
ra3 = sqrt(1-2*K*abs(s12*s21)*ga3+(abs(s12*s21)^2)*ga3^2)/(1+ga3*(abs(s11)^2-abs(Delta)^2)); %radio

%Dibujos

x=cos(angle);
y=sin(angle);
plot(rCES*(x+real(cCES)/rCES),rCES*(y+imag(cCES)/rCES),'-r')
hold on 

plot(rCEE*(x+real(cCEE)/rCEE),rCEE*(y+imag(cCEE)/rCEE),'-g')
plot(ra*(x+real(Ca)/ra),ra*(y+imag(Ca)/ra),'-xb')
plot(ra2*(x+real(Ca2)/ra2),ra2*(y+imag(Ca2)/ra2),'-b')
plot(ra3*(x+real(Ca3)/ra3),ra3*(y+imag(Ca3)/ra3),'-b')
plot(real(Cn),imag(Cn),'ok')
plot(rn2*(x+real(Cn2)/rn2),rn2*(y+imag(Cn2)/rn2),'-k')
plot(rn3*(x+real(Cn3)/rn3),rn3*(y+imag(Cn3)/rn3),'-k')
plot(rn4*(x+real(Cn4)/rn4),rn4*(y+imag(Cn4)/rn4),'-k')
plot(x,y)
plot(real(CoefL), imag(CoefL),'xb')
hold off
legend('Circulo Unidad', 'CES', 'CEE','Ga MSG','Ga -5dB','Ga -10dB', 'Fig R min', 'Fig R + 0.3 dB', 'Fig R + 0.6 dB', 'Fig R + 1 dB', 'Unidad', 'CoefL')
axis ([ -1.5 1.5 -1.5 1.5 ])