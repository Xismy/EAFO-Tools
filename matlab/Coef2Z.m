function [ ZL ] = Coef2Smith( Coef, Zo )
%   Función que te permite pasar del coeficiente de reflexión a la
%   resistencia.
%   Parametros de entrada:
%       - Coeficiente de reflexión
%       - Impedancia carateristica

    ZL=Zo*(1+Coef)/(1-Coef);
end

