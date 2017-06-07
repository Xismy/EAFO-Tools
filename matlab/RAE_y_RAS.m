clear all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%    Red de adaptacion RAE   %%%%
%%%%   Lambda 4 o linea y stub  %%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Valores fijos
c=3*10^8;

%Valores que hay que modificar
er=9; %permitividad electrica relativa
Zs=10.7031 - 11.8591*1i; % Impedancia Zs calculada en el script estabilidad
ZL=18.367 + 33.5671*1i;  % Impendancia ZL calculada en el scrip estabilidad
Zo = 50; %Impedancia caracteristica
f=5*10^9; %Frecuencia
h=1; %Espesor del dielectrico en mm

if imag(Zs)== 0
    disp('Hacemos una adaptacion lambda/4')
    %Calculo Impedancia Caracteristica
    Zi = sqrt(50*Zs);

    %Calculo de er_eff
    A=(Zi/60)*sqrt((er+1)/2)+((er-1)/(er+1))*(0.23+(0.11/er));
    B=(377*pi)/(2*Zi*sqrt(er));

    wh1=(8*exp(A))/((exp(2*A))-2);
    wh2=(2/pi)*(B-1-log(2*B-1)+((er-1)/(2*er))*(log(B-1)+0.39-(0.61/er)));

    if (wh1 < 2 )
        wh=wh1;
    else
        wh=wh2;
    end

    w=wh*h;
    ereff=((er+1)/2)+((er-1)/(2*sqrt(1+(12/wh))));

    %Calculo de la velocidad
    v=c/sqrt(ereff); %velocidad

    %Calculo de la l�nea
    l1=0.25; %linea
    Llinea=l1*v*1000/f; %Longitud de la l�nea en mm
    
    disp('Red de adaptaci�n: RAE')
    fprintf('Longitud de la l�nea: %1.3f mm\n', Llinea);
    fprintf('Ancho de la l�nea: %1.3f mm\n', w);
    disp('----------------------------------------------')
else
    [Llinea, Lstub, w] = adaptalinea(50,Zs, Zo, er, h, f);
    
    disp('Red de adaptaci�n: RAE')
    fprintf('Longitud de la l�nea: %1.3f mm\n', Llinea);
    fprintf('Longitud del stub: %1.3f mm\n', Lstub);
    fprintf('Ancho de la l�nea: %1.3f mm\n', w);
    disp('----------------------------------------------')
    
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Red de Adaptacion RAS %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[Llinea, Lstub, w] = adaptalinea(50,ZL, Zo, er, h, f);
    
disp('Red de adaptaci�n: RAS')
fprintf('Longitud de la l�nea: %1.3f mm\n', Llinea);
fprintf('Longitud del stub: %1.3f mm\n', Lstub);
fprintf('Ancho de la l�nea: %1.3f mm\n', w);

