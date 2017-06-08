%%%%%%%%%%%%%%%%%%%%
%%% Lambda 2 mm %%%%
%%%%%%%%%%%%%%%%%%%%

c=3*10^8; %Valor fijo
er=3.5; %permitividad electrica relativa
Zo = 50; %Impedancia caracteristica linea
ZS=50; % Impedancia de fuente
ZL=25-1j*24; % Impedancia de carga
f=3.5*10^9; %Frecuencia

%Calculamos el ancho de la linea

A = Zo/60 * sqrt((er+1)/2) + (er-1)/(er+1) * (0.23+0.11/er);
factor = 8*exp(A)/(exp(2*A)-2);
if(factor > 2)
    B = 377*pi/(2*Zo*sqrt(er));
    factor = 2/pi * (B-1-log(2*B-1) + (er-1)/(2*er) * (log(B-1)+0.39-0.61/er));
end

w = factor*h;

%Pasamos las longitudes de lamdas a mm
ereff = (er+1)/2 + (er-1)/(2*sqrt(1+12*h/w));
v = c/sqrt(ereff);

l1=0.12; %stub
l2=0.17; %linea
Lstub=l1*v*1000/f %%Longitud del stub en mm
                    %Lstub=l1 %%% Longitud del Stub en Lambda
Llinea=l2*v*1000/f %%%% L