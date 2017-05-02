%Parámetros:
clear all
tetha=0:0.1:2.1*pi;
x=cos(tetha);
y=sin(tetha);
P=[1,-1];
r=2;
CoefS=-0.5+1j*0.2;
plot(x,y,'-b')
hold on
plot(r*(x+P(1)/r),r*(y+P(2)/r),'-xr')
plot(real(CoefS),imag(CoefS),'-ok')
hold off