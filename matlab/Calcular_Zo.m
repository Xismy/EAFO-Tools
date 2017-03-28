%%%%%%%%%%%%%%%%%%%%%
%%%%%% u-strip %%%%%%
%%%%%%%%%%%%%%%%%%%%%

%Calcular Zo

%Parametros:
h=0.137; %cm
w=0.1228; %cm
er=2.2;
f=2.4; %GHz

wh=w/h;

ereff = ((er+1)/2)+((er-1)/(2*sqrt(1+12*(1/wh))));

if wh <= 1
    Zo=(60/sqrt(ereff))*log(((8*h)/w)+(w/(4*h)));
else
    Zo=(120*pi)/(sqrt(ereff)*(wh+1.393+0.667*log(wh+1.444)));
end

Zo