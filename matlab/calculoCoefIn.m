function [ coef_In ] = calculoCoefIn( s11,s12,s21,s22,ZL,Zo)
    % Funci�n donde introduces los par�metros S, la carga ZL y la impedancia caracter�stica.
    
    coefL=(ZL-Zo)/(ZL+Zo); %Coeficiente de reflexi�n en la carga.
    coef_In=s11+((s12*s21*coefL)/(1-s22*coefL));
end

