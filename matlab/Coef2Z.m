function [ ZL ] = Coef2Smith( Coef, Zo )
%   Funci�n que te permite pasar del coeficiente de reflexi�n a la
%   resistencia.
%   Parametros de entrada:
%       - Coeficiente de reflexi�n
%       - Impedancia carateristica

    ZL=Zo*(1+Coef)/(1-Coef);
end

