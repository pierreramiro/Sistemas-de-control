clc;clear;close all;

vel=[0.00 27.06 27.06 27.06 27.06 48.37 65.38 79.05 98.27 114.05 125.33 141.19 154.70 161.64 176.22 183.11 191.33 205.59 212.10 221.11 229.78 233.21 242.88 246.71 252.02 258.98 274.12 272.53 274.12 275.74 285.82 289.35 296.68 289.35 298.57 304.38 300.48 302.42 312.50 327.80 316.72 316.72 321.06 327.80 327.80 318.88 321.06 330.11 334.82 337.23 310.43 332.45 339.67 318.88 342.15 339.67 339.67 339.67 339.67 344.67 318.88 342.15 342.15 344.67 330.11 352.44 352.44 344.67 349.81 344.67 347.22 325.52 352.44 352.44 347.22 349.81 347.22 355.11 352.44 342.15 339.67 349.81 349.81 349.81 349.81 355.11 363.37 349.81 349.81 355.11 349.81 349.81 357.82 330.11 355.11 352.44 344.67 352.44 349.81 342.15 355.11 355.11 352.44 352.44 355.11 355.11 355.11 357.82 357.82 339.67 355.11 352.44 355.11 355.11 357.82 357.82 357.82 355.11 355.11 355.11 347.22 369.09 363.37 357.82 347.22 357.82 355.11 357.82 330.11 360.58 360.58 363.37 357.82 349.81 357.82 357.82 357.82 366.21 347.22 360.58 360.58 360.58 357.82 330.11 366.21 366.21 366.21 360.58 360.58 347.22 360.58 357.82 360.58 363.37 363.37 360.58 360.58 357.82 360.58 357.82 360.58 363.37 355.11 363.37 360.58 363.37 357.82 344.67 360.58 369.09 369.09 360.58 357.82 332.45 360.58 363.37 363.37 363.37 363.37 366.21 347.22 363.37 357.82 360.58 360.58 360.58 369.09 360.58 366.21 360.58 363.37 360.58 363.37 347.22 369.09 366.21 360.58 357.82 360.58 327.80 360.58 363.37 363.37 363.37 363.37 337.23 360.58 357.82 357.82 360.58 357.82 334.82 363.37 360.58 357.82 360.58 360.58 363.37 360.58 366.21 366.21 357.82 334.82 357.82 357.82 357.82 360.58 360.58 360.58 357.82 357.82 357.82 349.81 363.37 363.37 363.37 363.37 334.82 357.82 357.82 357.82 357.82 334.82 363.37 363.37 363.37 357.82 349.81 360.58 357.82 357.82 366.21 344.67 360.58 360.58 360.58 360.58 330.11 366.21 366.21 366.21 360.58 360.58 357.82 360.58 360.58 360.58 363.37 363.37 363.37 360.58 357.82 360.58 360.58 352.44 372.02 363.37 366.21 360.58 360.58 330.11 360.58 363.37 369.09 366.21 369.09 363.37 360.58 360.58 360.58 360.58 363.37 366.21 369.09 363.37 363.37 360.58 363.37 357.82 360.58 369.09 337.23 366.21 363.37 363.37 363.37 363.37 363.37 366.21 347.22 360.58 360.58 360.58 363.37 369.09 363.37 360.58 366.21 366.21 366.21 360.58 363.37 363.37 360.58 363.37 369.09 369.09 369.09 360.58 363.37 363.37 349.81 372.02 363.37 363.37 366.21 369.09 366.21 347.22 363.37 360.58 363.37 360.58 369.09 369.09 344.67 360.58 363.37 360.58 360.58 363.37 363.37 339.67 357.82 360.58 360.58 357.82 360.58 347.22 360.58 366.21 363.37 360.58 360.58 357.82 360.58 360.58 366.21 366.21 339.67 360.58 360.58 357.82 360.58 357.82 366.21 366.21 360.58 360.58 360.58 357.82 357.82 363.37 360.58 363.37 355.11 360.58 357.82 357.82 360.58 360.58 363.37 363.37 363.37 363.37 360.58 337.23 363.37 357.82 360.58 369.09 369.09 360.58 360.58 363.37 360.58 375.00 363.37 363.37 366.21 357.82 363.37 360.58 360.58 360.58 363.37 363.37 369.09 366.21 363.37 363.37 363.37 363.37 363.37 363.37 366.21 369.09 363.37 363.37 363.37 360.58 360.58 360.58 363.37 342.15 363.37 366.21 363.37 363.37 363.37 363.37 360.58 366.21 342.15 363.37 363.37 363.37 363.37 363.37 363.37 363.37 363.37 372.02 360.58 366.21 363.37 366.21 363.37 363.37 366.21 363.37 366.21 334.82 363.37 363.37 363.37 363.37 366.21 363.37 366.21 372.02 372.02 355.11 363.37 360.58 360.58 363.37 366.21 369.09 366.21 357.82 342.15 363.37 363.37 363.37 360.58 372.02 372.02 372.02 355.11 363.37 360.58 363.37 360.58 366.21 363.37 334.82 357.82 363.37 360.58 363.37 360.58 363.37 337.23 366.21 363.37 360.58 360.58 363.37 360.58 360.58 369.09 366.21 369.09 360.58 ];
vel=vel(1,1:500)';
Ts=0.002; %Iempo de muestra: 2 ms
u=3*ones(length(vel),1);
t=0:Ts:(length(vel)-1)*Ts;t=t';
%%
load ('Transfer_Function.mat');
num=tf1.Numerator;
den=tf1.Denominator;
num=num/den(2);
den=den/den(2);
Ps=tf(num,den);
display(Ps)
lsim(Ps,u',t','r')
hold
plot(t,vel);
grid
legend('Modelo','Valores reales')
title('Respuesta del Motor')
xlabel('Tiempo')
ylabel('Velocidad motor [°/seg]')