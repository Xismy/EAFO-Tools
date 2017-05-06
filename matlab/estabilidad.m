clear all
close all

% Como entrada se dan los parámetros S

s11 = 0.5388*exp(1i*(degtorad(-112.505)));
s12 = 0.0384*exp(1i*(degtorad(38.969)));
s21 = 12.5471*exp(1i*(degtorad(98.325)));
s22 = 0.586984*exp(1i*(degtorad(-61.197)));
Zo=50;

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

%%% Comprobación de estabilidad con la constante de rollet
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

%%% Determinación de la estabilidad en las regiones calculadas

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

Gp=MSG;   %Curva justo en el MSG que será la máxima ganancia que se puede conseguir.
         
gp=Gp/abs(s21)^2;

Cp = gp*conj(s22-Delta*conj(s11))/(1+gp*(abs(s22)^2-abs(Delta)^2)); %Centro
rp=sqrt(1-2*K*abs(s12*s21)*gp+(abs(s12*s21)^2)*gp^2)/(1+gp*(abs(s22)^2-abs(Delta)^2)); %radio

%Curvas de ganancia disponible constante (CEA):

Ga=316.228; %25 dB. Ganancia deseada menor que el MSG en caso de...
if(Ga>MSG)
    disp('Error: Has elegido una ganancia mayor de la disponible, se te cambia al MSG')
    Ga=MSG;
end

ga=Ga/abs(s21)^2;

Ca = ga*conj(s11-Delta*conj(s22))/(1+ga*(abs(s11)^2-abs(Delta)^2)); %Centro
ra = sqrt(1-2*K*abs(s12*s21)*ga+(abs(s12*s21)^2)*ga^2)/(1+ga*(abs(s11)^2-abs(Delta)^2)); %radio

%Curvas de Figura de ruido constante:
%Datos dado por el fabricante:
Rn_norm=0.47;
Coefopt = 0.65*exp(1i*(degtorad(-80)));
FmindB=0.7; %en dB
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

%CoefS=-0.2372; %Fijarla nosotros
%Zs=Coef2Z(CoefS,Zo)
%CoefOut=calculoCoefOut(s11,s12,s21,s22,Zs,Zo);
%CoefL=conj(CoefOut);
%ZL=Coef2Z(CoefL,Zo);

% se dibuja también otras curvas de ganancia 

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
plot(ra*(x+real(Ca)/ra),ra*(y+imag(Ca)/ra),'-b')
plot(real(Cn),imag(Cn),'ok')
plot(rn2*(x+real(Cn2)/rn2),rn2*(y+imag(Cn2)/rn2),'-k')
plot(real(CoefL),imag(CoefL),'ob')
hold off
legend('Circulo Unidad', 'CES', 'CEE','Ga 25dB', 'Fig R min', 'Fig R + 0.3 dB', 'CoefZ')
axis ([ -1.5 1.5 -1.5 1.5 ])