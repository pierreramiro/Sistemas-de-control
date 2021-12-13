clear;clc;close all
run('Robot1GDL_DataFile1.m')
%% Diseñando el control PD
clc
s=tf('s');
Gp=182/(0.05*s+1)/s;
Tes=1; %Variando este valor, variamos los valores de k1 y k2
polos_des=[-4/Tes;-24/Tes];
poly_des=poly(polos_des);
%Ec caracteristica= 0.05s^2+(182k2+1)s+182k1=0
k1=poly_des(end)*0.05/182;
k2=(poly_des(end-1)*0.05-1)/182;
display(k1)
display(k2)
fprintf("Los polos obtenidos del sistema de control son:\n")
Gsys=feedback(Gp*(k1+k2*s),1,-1);
polos_sist=rlocus(Gp*(k1+k2*s),1);
display(polos_sist)
Ts=0.05;
%% Control PD + compensación
clc
km=182;
Tm=0.05;
ue=1.958;
s=tf('s');  
Gp=182/(0.05*s+1)/s;
Tes=1; %Variando este valor, variamos los valores de k1 y k2
polos_des=[-4/Tes;-24/Tes];
poly_des=poly(polos_des);
%Ec caracteristica= s^2+(km*k2/Tm-1/Tm)s+km*k1/Tm
k1=poly_des(end)*Tm/km;
k2=(poly_des(end-1)*Tm-1)/km;
display(k1)
display(k2)
Ts=0.05;

