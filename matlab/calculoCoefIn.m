function [ coef_In ] = calculoCoefIn( s11,s12,s21,s22,ZL,Zo)
    % Función donde introduces los parámetros S, la carga ZL y la impedancia característica.
    
    coefL=(ZL-Zo)/(ZL+Zo); %Coeficiente de reflexión en la carga.
    coef_In=s11+((s12*s21*coefL)/(1-s22*coefL));
end

