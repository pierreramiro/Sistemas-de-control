%% identificando temp
run('datos_temp.m')
Ts=4;
%% identificando flujo
run('datos_temp.m')
Ts=0.1;
%% Definimos las funciones de transferencia Gt y Gp
clear
close all
load('tf_temp')
Gt=tf(FuncionDeTransferencia.numerator,FuncionDeTransferencia.denominator);
load('tf_flujo')
Gf=tf(FuncionDeTransferencia.numerator,FuncionDeTransferencia.denominator);
%% Diseñamos el primer controlador (Lazo interno) para la planta de flujo
close all
%Analizamos el LGR
figure
rlocus (Gf)
zero=5;
pol_des=-4;
Gc=(tf('s')+zero);
figure
rlocus(Gc*Gf)
K=-polyval(Gf.den{1},pol_des)*polyval(Gc.den{1},pol_des)/polyval(Gf.num{1},pol_des)/polyval(Gc.num{1},pol_des);
polos=rlocus(Gc*Gf,K);
display(polos)
Gc1=Gc*K;
Kp1=K*zero;
Kd1=K;
figure
step(feedback(Gf*Gc1,1,-1))
%observamos el Ts1
Ts1=0.033;
title('Respuesta escalón unitario Lazo interno')
%% Diseñamos el segundo controlador (Lazo externo) para la planta de temp
close all
Gsys1=feedback(Gf*Gc1,1,-1);
Gla=Gsys1*Gt
figure
rlocus(Gla)
zero=0.08;
s=tf('s');
Gc=(s+zero)/s;
figure
Gs=Gc*Gla;
rlocus(Gs)
pol_des=-0.1;
K=-polyval(Gs.den{1},pol_des)/polyval(Gs.num{1},pol_des);
polos=rlocus(Gs,K);
display(polos)
Gc2=K*Gc;
Kp2=Gc2.num{1}(1);
Ki2=Gc2.num{1}(2);
%Gc2=Kp2+Ki2/s;
figure
step(feedback(Gc2*Gsys1*Gt,1,-1))
%obtenemos Ts2 de la gráfica
Ts2=2.75;
title('Respuesta escalón unitario Lazo externo')
%%
close all