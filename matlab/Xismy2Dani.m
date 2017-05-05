c=3*10^8; %Valor fijo
er=3.5; %permitividad electrica relativa
e0=8.8542*10^-12; %permitividad electrica absoluta
u0=4*pi*10^-7; %permeabilidad magnética;
v=1/sqrt(u0*e0*er); %velocidad

Zolinea = 50; %Impedancia caracteristica linea
Zostub = 50; %Impendancia caracteristica del stub
ZS=50; % Impedancia de fuente
ZL=25-1j*24; % Impedancia de carga
f=3.5*10^9; %Frecuencia

Zin=conj(ZS); %Impedancia donde tenemos que llegar. Debe ser conjugado de ZS
l1=0.12; %stub
l2=0.17; %linea
Lstub=l1*v*1000/f %%Longitud del stub en mm
                    %Lstub=l1 %%% Longitud del Stub en Lambda
Llinea=l2*v*1000/f %%%% L