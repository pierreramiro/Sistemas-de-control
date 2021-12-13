close all
load('Funciones_de_transferencia')
num=tf1.numerator;
den=tf1.denominator;
Gm=tf(num/den(end),den/den(end));

T=0.0633;
T_act=0.024;