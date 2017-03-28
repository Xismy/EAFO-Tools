
%Parametros
Zo1 = 50;
Zo2 = 50;
ZS=15-1j*25;
ZL=35+1j*20;

Zin=conj(ZS);
L1=0;
L2=0;

for l1=0:0.01:0.5
    for l2=0:0.01:0.5
        Zx=(Zo2*(ZL+1j*Zo2*tan(2*pi*l2)))/(Zo2+1j*ZL*tan(2*pi*l2));
        Zy=-1j*Zo1*cot(2*pi*l1);
        Yx=1/Zx;
        Yy=1/Zy;
        Yz=Yx+Yy;
        Zz=1/Yz;
        if abs(real(Zz))>= abs(real(Zin)*0.98) && abs(real(Zz))<=abs(real(Zin)*1.02)
            if abs(imag(Zz))>= abs(imag(Zin)*0.98) && abs(imag(Zz))<=abs(imag(Zin)*1.02) 
                L1=l1
                L2=l2
                Zz
            end
        end
    end
end
          
