clear all

% % Calcula oscilador dado el coeficiente gammat 

% % % % % Parámetros S % % % % % %

s11 = 0.50*exp(1i*(degtorad(-88)));
s12 = 0.008*exp(1i*(degtorad(68)));
s21 = 45.64*exp(1i*(degtorad(135)));
s22 = 0.77*exp(1i*(degtorad(-22)));

% % % % Otros parametros % % % % %
er=4.5; %permitividad electrica relativa
e0=8.8542*10^-12; %permitividad electrica absoluta
u0=4*pi*10^-7; %permeabilidad magnética;
h=1.6; %Espesor del dielectrico en mm
Zo = 50;
f=100*10^6;

% Cálculo de ZL

gammat = 0.5957 + 0.8032j;   %%%% coeficiente que eliges inestable viendo la curva CES

gammaIN=s11+((s12*s21*gammat)/(1-s22*gammat));
Zin = Zo * (1+gammaIN)/(1-gammaIN);

ZL = abs(real(Zin))/3 + -1*j*imag(Zin)

% Red de adaptación para ZL

Zent=conj(50); %Impedancia donde tenemos que llegar. 

%Calculo de er_eff
    
A=(Zo/60)*sqrt((er+1)/2)+((er-1)/(er+1))*(0.23+(0.11/er));
B=(377*pi)/(2*Zo*sqrt(er));

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

        Zx=(Zo*(ZL+1j*Zo*tan(2*pi*l2)))/(Zo+1j*ZL*tan(2*pi*l2)); % Impedancia al inicio de la linea
        Zy=-1j*Zo*cot(2*pi*l1); %Impedancia del stub (el stub está en abierto)
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

fprintf('El ancho (w) de la línea es: %1.3f mm\n',w);

%Imprime las soluciones
v=(Zz_v-Zent)*100; %Vector con el error en porcentaje

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