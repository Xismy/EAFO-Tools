clear all
close all


% Como entrada se dan los parámetros S



s11 = 0.65*cos(degtorad(-95))+ j*0.65*sin(degtorad(-95));
s12 = 0.035*cos(degtorad(40))+ j*0.035*sin(degtorad(40));
s21 = 5*cos(degtorad(115))+ j*5*sin(degtorad(115));
s22 = 0.8*cos(degtorad(-35))+ j*0.8*sin(degtorad(-35));

angle=0:pi/64:2*pi;
plot(cos(angle),sin(angle),'k');
hold on;

%%Curva de estabilidad a la salida

Delta = s11*s22 - s21*s12;
cCES = (Delta*s11 - conj(s22))/(abs(Delta)^2 - abs(s22)^2);
rCES = (abs(s12*s21))/(abs(Delta^2-s22^2));

% Curva de estabilidad a la entrada

cCEE = (Delta*s22 - conj(s11))/(Delta^2 - s11^2);
rCEE = (abs(s12*s21))/(abs(Delta^2-s11^2));

% Constante de rollet

K = (1 - abs(s11)^2 - abs(s22)^2 + abs(Delta)^2)/(2*abs(s12s21));

x = rCES * cos(angle) + real(cCES);
y = rCES * sin(angle) + imag(cCES);
plot(x, y);

hold on 

x = rCEE * cos(angle) + real(cCEE);
y = rCEE * sin(angle) + imag(cCEE);
plot(x, y ,'g');

hold off

% Curva de ganancia 



