%%%%%%%%%%%%%%%%%%%%%
%%%%%% u-strip %%%%%%
%%%%%%%%%%%%%%%%%%%%%

%Calcular er

%Parametros:
zo=50;
h=0.137;
w=h/3;
f=2.4;

wh=w/h;

if ( wh <=1)
    rerff=(60/zo)*log(((8*h)/w)+(w/(4*h)));
else
    rerff=(120*pi)/(zo*(wh+1.393+0.667*log(wh+1.444)));
end

erff=rerff*rerff;

raiz=sqrt(1+12*(1/wh));

er=(2*erff*raiz-raiz+1)/(raiz+1)
    