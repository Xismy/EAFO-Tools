clear all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%    Red de adaptacion RAE   %%%%
%%%%   Lambda 4 o linea y stub  %%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Valores fijos
e0=8.8542*10^-12; %permitividad electrica absoluta
u0=4*pi*10^-7; %permeabilidad magnética;

%Valores que hay que modificar
er=9; %permitividad electrica relativa
Zs=30.83; % Impedancia Zs calculada en el script estabilidad
%ZL=;     % Impendancia ZL calculada en el scrip estabilidad
Zolinea = 50; %Impedancia caracteristica linea
Zostub = 50; %Impendancia caracteristica del stub
f=2.4*10^9; %Frecuencia
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
    v=1/sqrt(u0*e0*ereff); %velocidad

    %Calculo de la línea
    l1=0.25; %linea
    Llinea=l1*v*1000/f; %Longitud de la línea en mm
    
    disp('Red de adaptación: RAE')
    fprintf('Longitud de la línea: %1.3f mm\n', Llinea);
    fprintf('Ancho de la línea: %1.3f mm\n', w);
    disp('----------------------------------------------')
else
    Zin=conj(50); %Impedancia donde tenemos que llegar. 

    %Calculo de er_eff
    %En el caso de que la Zo del stub y de linea sean diferentes, habría que
    %hacer 2 veces esta función y guardar la ereff_linea y ereff_stub.
    A=(Zolinea/60)*sqrt((er+1)/2)+((er-1)/(er+1))*(0.23+(0.11/er));
    B=(377*pi)/(2*Zolinea*sqrt(er));

    wh1=(8*exp(A))/((exp(2*A))-2);
    wh2=(2/pi)*(B-1-log(2*B-1)+((er-1)/(2*er))*(log(B-1)+0.39-(0.61/er)));

    if (wh1 < 2 )
        wh=wh1;
    else
        wh=wh2;
    end
    w=wh*h;
    ereff=((er+1)/2)+((er-1)/(2*sqrt(1+(12/wh))));

    %Calculo de la velocidad de propagación
    v=1/sqrt(u0*e0*ereff); %velocidad


    i=1;
    for l1=0:0.0001:0.5
        for l2=0:0.0001:0.5

            Zx=(Zolinea*(Zs+1j*Zolinea*tan(2*pi*l2)))/(Zolinea+1j*Zs*tan(2*pi*l2)); % Impedancia al inicio de la linea
            Zy=-1j*Zostub*cot(2*pi*l1); %Impedancia del stub (el stub está en abierto)
            Zz=(Zx*Zy)/(Zx+Zy); %Paralelo 

            Lstub=l1*v*1000/f; % Longitud del stub en mm
            %Lstub=l1 % Longitud del Stub en Lambda
            Lstub_v(i)=Lstub;

            Llinea=l2*v*1000/f; %%%% Longitud de la linea en mm
            %Llinea=l2   %%% Longitud de la linea en Lambda
            Llinea_v(i)=Llinea;

            Zz_v(i)=Zz;
            i=i+1;

        end
    end
    
    disp('Red de adaptación: RAE')
    fprintf('El ancho (w) de la línea es: %1.3f mm\n',w);

    %Imprime las soluciones
    v=(Zz_v-Zin)*100; %Vector con el error en porcentaje

    k=1;
    for j=1:1:length(v)
        if abs(v(j))<5  %Esto indica el porcentaje de error. Si no sale nada, aumentar.
           fprintf('Solución %d: \n', k);
           fprintf('Error: %1.3f\n', abs(v(j))); %Error en %
           fprintf('Longitud de la línea: %1.3f mm\n', Llinea_v(j)); 
           fprintf('Longitud del stub: %1.3f mm\n', Lstub_v(j));
           Zz=Zz_v(j);
           Zz
           k=k+1;
        end
    end
    disp('----------------------------------------------')
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Red de Adaptacion RAS %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%In process

