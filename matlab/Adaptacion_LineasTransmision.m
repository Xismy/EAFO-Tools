clear all 
clc 

%Parametros
Zo1 = 50;
Zo2 = 50;
ZS=15-1j*25;
ZL=35+1j*20;

Zin=conj(ZS);
Zin=Zin+1j*0.01;
L1=0;
L2=0;

for l1=0:0.0001:0.5
    for l2=0:0.0001:0.5
        Zx=(Zo2*(ZL+1j*Zo2*tan(2*pi*l2)))/(Zo2+1j*ZL*tan(2*pi*l2));
        Zy=-1j*Zo1*cot(2*pi*l1);
        Zz=(Zx*Zy)/(Zx+Zy); %Paralelo
        if abs(real(Zz))>= abs(real(Zin)*0.99) && abs(real(Zz))<=abs(real(Zin)*1.01)
            if abs(imag(Zz))>= abs(imag(Zin)*0.99) && abs(imag(Zz))<=abs(imag(Zin)*1.01) 
                L1=l1
                L2=l2
                Zz
            end
        end
    end
end
          