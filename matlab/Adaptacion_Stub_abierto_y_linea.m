clear all 
clc 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Adaptacion con linea y Stub en abierto %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Parametros
c=3*10^8; %velocidad de la luz
er=2.5; %permitividad electrica relativa
e0=8.8542*10^-12; %permitividad electrica absoluta
u0=4*pi*10^-7; %permeabilidad magnética;
v=1/sqrt(u0*e0*er); %velocidad

Zolinea = 50; %Impedancia caracteristica linea
Zostub = 50; %Impendancia caracteristica del stub
ZS=15-1j*25; % Impedancia de fuente
ZL=35+1j*20; % Impedancia de carga
f=4*10^9;  % Frecuencia

Zin=conj(ZS); %Impedancia donde tenemos que llegar. Debe ser conjugado de ZS

for l1=0:0.0001:0.5
    for l2=0:0.0001:0.5
        Zx=(Zolinea*(ZL+1j*Zolinea*tan(2*pi*l2)))/(Zolinea+1j*ZL*tan(2*pi*l2)); % Impedancia al inicio de la linea
        Zy=-1j*Zostub*cot(2*pi*l1); %Impedancia del stub (el stub está en abierto)
        Zz=(Zx*Zy)/(Zx+Zy); %Paralelo 
        
        if imag(Zin)>=0
            if real(Zz)>= real(Zin)*0.999 && real(Zz)<=real(Zin)*1.001
                if imag(Zz)>= imag(Zin)*0.999 && imag(Zz)<=imag(Zin)*1.001

                    Lstub=l1*v*100/f %Longitud del stub en cm
                    %Lstub=l1 % Longitud del Stub en Lambda
                    
                    Llinea=l2*v*100/f % Longitud de la linea en cm
                    %Llinea=l2  % Longitud de la linea en Lambda
                    
                    Zz % Saldran muchas soluciones, mirad cual se parece más a conj(ZS)
                end
            end
        else
            if real(Zz)>= real(Zin)*0.999 && real(Zz)<=real(Zin)*1.001
                if imag(Zz)<= imag(Zin)*0.999 && imag(Zz)>=imag(Zin)*1.001

                    Lstub=l1*v*100/f % Longitud del stub en cm
                    %Lstub=l1 % Longitud del Stub en Lambda
                    
                    Llinea=l2*v*100/f % Longitud de la linea en cm
                    %Llinea=l2  % Longitud de la linea en Lambda

                    Zz % Saldran muchas soluciones, mirad cual se parece más a conj(ZS)
                end
            end
        end
    end
end




          
