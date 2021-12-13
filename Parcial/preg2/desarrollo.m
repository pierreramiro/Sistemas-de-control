%Pregunta 2. Desarrollo
%% Hallamos la nueva funcion de transferencia
clear;
load('ft_Gm')
%     2876
%   ---------
%   s + 25.77
num=Gm.num{1}/180*pi*120;
den=Gm.den{1};
KI=den(end)/num(end);
Jm=KI/Gm.num{1}(end);
n=1/120;
JL=0.25;
Jeq=Jm+n^2*JL;
%nueva Funcion de transferencia: Gs
s=tf('s');
Gs=n*KI*180/pi/Jeq/(s+KI^2/Jeq);
%% Diseñamos el controlador
close all
figure
rlocus(Gs/tf('s'))
title('LGR Gs/s')
figure
rlocus(Gs)
title('LGR Gs')
%Realizaremos un control en cascada
%Dado que el polo esta muy cercano al eje imaginario, lo moveremos con un
%proporcional hasta un polo de -10. Para luego implementar un controlador PD
%al sistema reaimentado de Gs con el proporcional y un polo.
%El valor de -10 es para poder tenerlo 10 veces mas alejado al polo deseado
%de -1 para lograr un Tes de 4 seg.
polo_des=-10;
K=-polyval(Gs.den{1},polo_des)/polyval(Gs.num{1},polo_des);
polos=rlocus(Gs,K);
display(polos)
figure
step(feedback(Gs*K,1,-1))
title('Respuesta escalon de sistema de control Gs')
%De la grafica se observa que Ts_w=0.0391
Ts_w=0.0391;
Gsys=feedback(Gs*K,1,-1)/s;
figure
rlocus(Gsys)
title('LGR Gsys')
%Gsys tiene un único polo en -10. Añadimos un PD
Tes=4;
polo_des=-4/Tes;
%control PI
zero=4;
s=tf('s');
Gc=(s+zero);
Gla=Gc*Gsys;
figure
rlocus(Gla)
title('LGR Gla')
Kd=-polyval(Gla.den{1},polo_des)/polyval(Gla.num{1},polo_des);
polos=rlocus(Gla,Kd);
display(polos)
Gc=Kd*Gc;
Kp=Kd*zero;
figure
step(180*feedback(Gc*Gsys,1,-1))
title('Respuesta escalon del sistema de control')
grid
%De la gráfica vemos que Ts_theta=0.2061
Ts_theta=0.2061;
fprintf('Primer controlador (P)\n')
display(K)
fprintf('Segundo controlador (PD)\n')
display(Kp)
display(Kd)
%%
close all