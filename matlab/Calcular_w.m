%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Diseño de u-strip %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%

zo=100; %Impedancia Caracteristica
h=0.137; %cm
er=2.2;
f=2.4; %GHz

% Queremos calcular w %

A=(zo/60)*sqrt((er+1)/2)+((er-1)/(er+1))*(0.23+(0.11/er));
B=(377*pi)/(2*zo*sqrt(er));

wh1=(8*exp(A))/((exp(2*A))-2);
wh2=(2/pi)*(B-1-log(2*B-1)+((er-1)/(2*er))*(log(B-1)+0.39-(0.61/er)));

if (wh1 < 2 )
    wh=wh1;
else
    wh=wh2;
end

wh %w/h
w=wh*h