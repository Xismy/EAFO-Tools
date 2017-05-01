clear all 
clc 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Adaptacion con linea y Stub en abierto %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Parametros
c=3*10^8; %Valor fijo
er=3.5; %permitividad electrica relativa
e0=8.8542*10^-12; %permitividad electrica absoluta
u0=4*pi*10^-7; %permeabilidad magnética;
v=1/sqrt(u0*e0*er); %velocidad

Zolinea = 50; %Impedancia caracteristica linea
Zostub = 50; %Impendancia caracteristica del stub
ZS=50; % Impedancia de fuente
ZL=25-1j*24; % Impedancia de carga
f=4*10^9; %Frecuencia

Zin=conj(ZS); %Impedancia donde tenemos que llegar. Debe ser conjugado de ZS

for l1=0:0.0001:0.5
    for l2=0:0.0001:0.5
        Zx=(Zolinea*(ZL+1j*Zolinea*tan(2*pi*l2)))/(Zolinea+1j*ZL*tan(2*pi*l2)); % Impedancia al inicio de la linea
        Zy=-1j*Zostub*cot(2*pi*l1); %Impedancia del stub (el stub está en abierto)
        Zz=(Zx*Zy)/(Zx+Zy); %Paralelo 
        
        if imag(Zin)>0
            if real(Zz)>= real(Zin)*0.99 && real(Zz)<=real(Zin)*1.01
                if imag(Zz)>= imag(Zin)*0.99 && imag(Zz)<=imag(Zin)*1.01
                    Lstub=l1*v*1000/f %%Longitud del stub en mm
                    %Lstub=l1 %%% Longitud del Stub en Lambda
                    
                    Llinea=l2*v*1000/f %%%% Longitud de la linea en mm
                    %Llinea=l2   %%% Longitud de la linea en Lambda
                    
                    Zz % Saldran muchas soluciones, mirad cual se parece más a conj(ZS)
                    disp('----------------------------------------------------------------------------------------')
                end
            end
        elseif imag(Zin)<0 
            if real(Zz)>= real(Zin)*0.99 && real(Zz)<=real(Zin)*1.01
                if imag(Zz)<= imag(Zin)*0.99 && imag(Zz)>=imag(Zin)*1.01
                    Lstub=l1*v*1000/f %%Longitud del stub en mm
                    %Lstub=l1 %%% Longitud del Stub en Lambda
                    
                    Llinea=l2*v*1000/f %%%% Longitud de la linea en mm
                    %Llinea=l2   %%% Longitud de la linea en Lambda
                    
                    Zz % Saldran muchas soluciones, mirad cual se parece más a conj(ZS)
                    disp('----------------------------------------------------------------------------------------')
                end
            end
        else
            if real(Zz)>= real(Zin)*0.95 && real(Zz)<=real(Zin)*1.05
                if imag(Zz)<=0.1 && imag(Zz)>=0.0001
                    
                    Lstub=l1*v*1000/f %%Longitud del stub en mm
                    %Lstub=l1 %%% Longitud del Stub en Lambda
                    
                    Llinea=l2*v*1000/f %%%% Longitud de la linea en mm
                    %Llinea=l2   %%% Longitud de la linea en Lambda
                    
                    Zz % Saldran muchas soluciones, mirad cual se parece más a conj(ZS)
                    disp('----------------------------------------------------------------------------------------')
                end
            end
        end
    end
end




          
