clear all
close all

% Como entrada se dan los parámetros S

s11 = 0.65*exp(1i*(degtorad(-95)));
s12 = 0.035*exp(1i*(degtorad(40)));
s21 = 5*exp(1i*(degtorad(115)));
s22 = 0.81*exp(1i*(degtorad(-35)));

angle=0:pi/64:2*pi;
plot(cos(angle),sin(angle),'k');
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

Gp=140;   %Ganancia deseada menor que el MSG en caso de inestabilidad condicionada.
          % 140 equivale a 21,46 dB
gp=Gp/abs(s21)^2;

Cp = gp*conj(s22-Delta*conj(s11))/(1+gp*(abs(s22)^2-abs(Delta)^2)); %Centro
rp=sqrt(1-2*K*abs(s12*s21)*gp+(abs(s12*s21)^2)*gp^2)/(1+gp*(abs(s22)^2-abs(Delta)^2)); %radio

%Curvas de ganancia disponible constante:

Ga=140;  %Ganancia deseada menor que el MSG en caso de...
ga=Ga/abs(s21)^2;

Ca = ga*conj(s11-Delta*conj(s22))/(1+ga*(abs(s11)^2-abs(Delta)^2)); %Centro
ra = sqrt(1-2*K*abs(s12*s21)*ga+(abs(s12*s21)^2)*ga^2)/(1+ga*(abs(s11)^2-abs(Delta)^2)); %radio

%Dibujos

x=cos(angle);
y=sin(angle);
plot(rCES*(x+real(cCES)/rCES),rCES*(y+imag(cCES)/rCES),'-r')
hold on 

plot(rCEE*(x+real(cCEE)/rCEE),rCEE*(y+imag(cCEE)/rCEE),'-g')
plot(ra*(x+real(Ca)/ra),ra*(y+imag(Ca)/ra),'-b')
hold off
legend('Circulo Unidad', 'CES', 'CEE','Ga 21,46 dB')
axis ([ -1.5 1.5 -1.5 1.5 ])