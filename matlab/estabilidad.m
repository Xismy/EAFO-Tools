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

%Dibujos

x=cos(angle);
y=sin(angle);
plot(rCES*(x+real(cCES)/rCES),rCES*(y+imag(cCES)/rCES),'-r')
hold on 

plot(rCEE*(x+real(cCEE)/rCEE),rCEE*(y+imag(cCEE)/rCEE),'-g')
hold off
legend('Circulo Unidad', 'CES', 'CEE')
axis ([ -1.5 1.5 -1.5 1.5 ])