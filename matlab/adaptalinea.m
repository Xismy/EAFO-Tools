function [ lLinea_s1, lStub_s1, w ] = adaptalinea( ZS, ZL, Z0, Er, h, f)

    YS = 1/ZS;
    YL = 1/ZL;
    GS = real(YS);
    BS = imag(YS);
    GL = real(YL);
    BL = imag(YL);

    % 		Igualando la parte real de la admitancia de una linea de longitud l a la parte real
    % 		de la admitancia de fuente obtenemos dos ecuaciones, cuyas incognitas son tan(beta*l)
    % 		y la susceptancia de la linea. Despejando la susceptancia de la linea en ambas e igualando,
    % 		obtenemos una ecuacion de segundo grado con los siguientes coeficientes:
    a = abs(YL)^2*GS*Z0*Z0-GL;
    b = -2*Z0*GS*BL;
    c = GS-GL;

    % 		Solucion1
    tanBl1_s1 = (-b+sqrt(b*b-4*a*c))/(2*a);
    Blinea_s1 = (GS*(1-Z0*BL*tanBl1_s1)-GL)/(Z0*GL*tanBl1_s1); 
    % 		La longitud del stub debe ser tal que Ystub+Ylinea=Ys* 
    tanBl2_s1 = -Z0*(BS+Blinea_s1);

    % 		Solucion2
    tanBl1_s2 = (-b-sqrt(b*b-4*a*c))/(2*a);
    Blinea_s2 = (GS*(1-Z0*BL*tanBl1_s2)-GL)/(Z0*GL*tanBl1_s2); 
    tanBl2_s2 = -Z0*(BS+Blinea_s2);
    
    lLinea_s1 = atan(tanBl1_s1)/(2*pi);
    lStub_s1 = atan(tanBl2_s1)/(2*pi);
    lLinea_s1=-1*lLinea_s1;
    lStub_s1=-1*lStub_s1;
    
    if(lLinea_s1 < 0)
        lLinea_s1 = lLinea_s1 + 0.5;
    end
    if(lStub_s1 < 0)
        lStub_s1 = lStub_s1 + 0.5;
    end
    
    lLinea_s2 = atan(tanBl1_s2)/(2*pi);
    lStub_s2 = atan(tanBl2_s2)/(2*pi);
    lLinea_s2=-1*lLinea_s2;
    lStub_s2=-1*lStub_s2;
    
    if(lLinea_s2 < 0)
        lLinea_s2 = lLinea_s2 + 0.5;
    end
    if(lStub_s2 < 0)
        lStub_s2 = lStub_s2 + 0.5;
    end

%     lLinea_s1 = atan(tanBl1_s1)/(2*pi);
%     lStub_s1 = atan(tanBl2_s1)/(2*pi);
%     if(lLinea_s1 < 0)
%         lLinea_s1 = atan(tanBl1_s1+2*pi)/(2*pi);
%     end
%     if(lStub_s1 < 0)
%         lStub_s1 = atan(tanBl2_s1+2*pi)/(2*pi);
%     end
% 
%     lLinea_s2 = atan(tanBl1_s2)/(2*pi);
%     lStub_s2 = atan(tanBl2_s2)/(2*pi);
%     if(lLinea_s2 < 0)
%         lLinea_s2 = atan(tanBl1_s2+2*pi)/(2*pi);
%     end
%     if(lStub_s2 < 0)
%         lStub_s2 = atan(tanBl2_s2+2*pi)/(2*pi);
%     end

    %Calculamos el ancho de la linea

    A = Z0/60 * sqrt((Er+1)/2) + (Er-1)/(Er+1) * (0.23+0.11/Er);
    factor = 8*exp(A)/(exp(2*A)-2);
    if(factor >2)
        B = 377*pi/(2*Z0*sqrt(Er));
        factor = 2/pi * (B-1-log(2*B-1) + (Er-1)/(2*Er) * (log(B-1)+0.39-0.61/Er));
    end

    w = factor*h;

    %Pasamos las longitudes de lamdas a mm
    Ereff = (Er+1)/2 + (Er-1)/(2*sqrt(1+12*h/w));
    vp =3e8/sqrt(Ereff);
    lambda = vp/f*1000;

    lLinea_s1 = lLinea_s1*lambda;
    lStub_s1 = lStub_s1*lambda;
    lLinea_s2 = lLinea_s2*lambda;
    lStub_s2 = lStub_s2*lambda;
    
end




