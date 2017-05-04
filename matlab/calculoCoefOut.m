function [ coef_Out ] = calculoCoefOut( s11,s12,s21,s22,Zs,Zo)
   % Funci�n donde introduces los par�metros S, la fuente Zs y la impedancia caracter�stica Zo.

    coefS=(Zs-Zo)/(Zs+Zo); %Coeficiente de reflexi�n en la fuente.
    coef_Out=s22+((s12*s21*coefS)/(1-s11*coefS));
end
