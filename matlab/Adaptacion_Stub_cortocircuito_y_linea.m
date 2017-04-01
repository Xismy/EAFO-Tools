clear all 
clc 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% Adaptacion con linea y Stub en cortocircuito %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Parametros
Zolinea = 50; %Impedancia caracteristica linea
Zostub = 50; %Impendancia caracteristica del stub
ZS=15-1j*25; % Impedancia de fuente
ZL=35+1j*20; % Impedancia de carga
er=2.2;

Zin=conj(ZS); %Impedancia donde tenemos que llegar. Debe ser conjugado de ZS
L1=0; 
L2=0;

for l1=0:0.0001:0.5
    for l2=0:0.0001:0.5
        Zx=(Zolinea*(ZL+1j*Zolinea*tan(2*pi*l2)))/(Zolinea+1j*ZL*tan(2*pi*l2)); % Impedancia al inicio de la linea
        Zy=1j*Zostub*tan(2*pi*l1); %Impedancia del stub (el stub está en cortocircuito)
        Zz=(Zx*Zy)/(Zx+Zy); %Paralelo 
            if abs(real(Zz))>= abs(real(Zin)*0.999) && abs(real(Zz))<=abs(real(Zin)*1.001)
                if abs(imag(Zz))>= abs(imag(Zin)*0.999) && abs(imag(Zz))<=abs(imag(Zin)*1.001)
                    L1=l1 %%% Longitud del Stub
                    w1=fcalcular_w(Zostub,er,L1)  %% Ancho del Stub
                    L2=l2 %%%% Longitud de la linea
                    w2=fcalcular_w(Zolinea,er,L2)  %%% Ancho de la linea
                    Zz % Saldran muchas soluciones, mirad cual se parece más a conj(ZS)
                end
            end
    end
end




          
