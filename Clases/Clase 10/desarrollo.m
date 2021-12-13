%% Hallamos la funcion de transferencia
clear;
load('ft_Gm')
%     2876
%   ---------
%   s + 25.77
%%
A=-25.77;
B=2876;
C=1;

Aa=[A 0;-C 0];%A aumentado
Ba=[B;0];%B aumentado

Ts=0.05;%Tiempo de muestreo
Tes=0.5;
ro=4/Tes;

s1=-ro;
s2=5*s1;

[Aad,Bad]=c2d(Aa,Ba,Ts);
z=exp(Ts*[s1 s2]);
Kd=acker(Aad,Bad,z);
%%
Alc=Aa-Ba*Kd;
Blc=[0;1];
Clc=[1 0];
Dlc=0;
[num,den]=ss2tf(Alc,Blc,Clc,Dlc);
G_est=tf(num,den);
rlocus(G_est/tf('s'))
K=1.32;