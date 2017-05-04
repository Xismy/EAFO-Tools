clear all 
clc 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Adaptacion con linea y Stub en abierto %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Parametros
c=3*10^8; %velocidad de la luz
er=3.5; %permitividad electrica relativa
e0=8.8542*10^-12; %permitividad electrica absoluta
u0=4*pi*10^-7; %permeabilidad magnética;
v=1/sqrt(u0*e0*er); %velocidad

Zolinea = 50; %Impedancia caracteristica linea
Zostub = 50; %Impendancia caracteristica del stub
ZS=50; % Impedancia de fuente
ZL=25+1j*50; % Impedancia de carga
f=4*10^9;  % Frecuencia

Zin=conj(ZS); %Impedancia donde tenemos que llegar. Debe ser conjugado de ZS

Lstub_vector =[];
Llinea_vector = [];
Zz_vector = [];
contador = 1;

for l1=0:0.0001:0.5
    for l2=0:0.0001:0.5
        Zx=(Zolinea*(ZL+1j*Zolinea*tan(2*pi*l2)))/(Zolinea+1j*ZL*tan(2*pi*l2)); % Impedancia al inicio de la linea
        Zy=-1j*Zostub*cot(2*pi*l1); %Impedancia del stub (el stub está en abierto)
        Zz=(Zx*Zy)/(Zx+Zy); %Paralelo 
        
        if imag(Zin)>=0

            Lstub=l1*v*100/f ;%Longitud del stub en cm
            Lstub_vector(contador) = Lstub; 
            %Lstub=l1 % Longitud del Stub en Lambda

            Llinea=l2*v*100/f; % Longitud de la linea en cm
            %Llinea=l2  % Longitud de la linea en Lambda
            Llinea_vector(contador) = Llinea; 
            Zz; % Saldran muchas soluciones, mirad cual se parece más a conj(ZS)

            Zz_vector(contador) = Zz;
            contador = contador +1;

        else

            Lstub=l1*v*100/f ;% Longitud del stub en cm
            %Lstub=l1 % Longitud del Stub en Lambda
            Lstub_vector(contador) = Lstub; 
            Llinea=l2*v*100/f; % Longitud de la linea en cm
            %Llinea=l2  % Longitud de la linea en Lambda
            Llinea_vector(contador) = Llinea; 

            Zz; % Saldran muchas soluciones, mirad cual se parece más a conj(ZS)
            Zz_vector(contador) = Zz;
            contador = contador+1;

        end
    end
end

[A B]=min(Zz_vector-Zin);

disp('La impedancia que se obtiene es:')

Zz_vector(B)

disp('La longitud del stub es:')

Lstub_vector(B)

disp('La longitud de la línea es:')
Llinea_vector(B)


          
