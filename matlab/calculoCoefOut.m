function [ coef_Out ] = calculoCoefOut( s11,s12,s21,s22,Zs,Zo)
   % Función donde introduces los parámetros S, la fuente Zs y la impedancia característica Zo.

    coefS=(Zs-Zo)/(Zs+Zo); %Coeficiente de reflexión en la fuente.
    coef_Out=s22+((s12*s21*coefS)/(1-s11*coefS));
end
