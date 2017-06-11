clear all

% % Calcula oscilador dado el coeficiente gammat y Ztnorm

% % % % % Parámetros S % % % % % %
% 
% s11 = 0.59*exp(1i*(degtorad(-137)));
% s12 = 0.028*exp(1i*(degtorad(44)));
% s21 = 11.13*exp(1i*(degtorad(102)));
% s22 = 0.58*exp(1i*(degtorad(-27)));


s11 = 0.52*exp(1i*(degtorad(-164)));
s12 = 0.023*exp(1i*(degtorad(57)));
s21 = 13.24*exp(1i*(degtorad(92)));
s22 = 0.45*exp(1i*(degtorad(-25)));

% % % % Otros parámetros % % % % %
er=4.5;             % permitividad electrica relativa
e0=8.8542*10^-12;   % permitividad electrica absoluta
u0=4*pi*10^-7;      % permeabilidad magnética;
h=1.6;              % Espesor del dielectrico en mm
Zo = 50;            % Impedancia característica de la línea
f=500*10^6;         % Frecuencia de trabajo del oscilador

% Cálculo de ZL

gammat = 0.773 + j*0.6344;   %%%% coeficiente que eliges inestable viendo la curva CES
Ztnorm = j*3;                %%%% coeficiente que introduces normalizado a la carta de Smith; está asociado a gammat


disp('Los cálculos intermedios son:')

gammaIN=s11+((s12*s21*gammat)/(1-s22*gammat))
Zin = Zo * (1+gammaIN)/(1-gammaIN)

% Ahora se calcula el valor de ZL para que cumpla la condición de arranque

ZL = abs(real(Zin))/3 + -1*j*imag(Zin)

%% Obtención de las componentes de la red terminal (Zt)(lado derecho del circuito)

disp('Las componentes de la Red Terminal son:')

Zt=Zo*Ztnorm;

Rt=real(Zt);              % No se utiliza al ser 0

if(imag(Zt)>0)
    Lt=imag(Zt)/(2*pi*f)
end

if(imag(Zt)<0)
    Ct=1/(2*pi*f*imag(Zt))
end

%% Obtención de los componentes de la red de carga (ZL)(lado izquierdo del circuito)

disp('Las componentes de la red de Carga son:')

ZL=conj(ZL);

R=real(ZL)

if(imag(ZL)>0)
    L=imag(ZL)/(2*pi*f)
end

if(imag(ZL)<0)
    C=abs(1/(2*pi*f*imag(ZL)))
end
