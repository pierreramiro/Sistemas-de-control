%% Hallamos la funcion de transferencia
clear;clc;close all
load('ft_Gm')
%     2876
%   ---------
%   s + 25.77
%% Definimos las matrices de estado
%Dw=-polo*w+K*v(t)
%y=w
A=-Gm.den{1}(end);
B=Gm.num{1}(end);
C=1;

%% Realizamos un control de velocidad
%El control a realizar será un servosistema con integrador
%Para ello, hallamos las matrices aumentadas que consideren el error
As=[A 0;-C 0];%A aumentado
Bs=[B;0];%B aumentado
%Definimos los requerimientos del sistema
%Mp=0;
%Tes=1--> Dado que queremos que el sistema tenga este tiempo de
%establecimiento. El polo del sistema de control de velocidad debe tener un
%polo que sea 5 veces al polo deseado de s=4/Tes, es decir, ro=5*4/Tes
Tes=1;
ro=7*4/Tes;%<--------Variar este valor para que el polo deseado s=-4 sea el dominante
%definimos los polos deseados
polos=[-ro;
      -5*ro];
%Obtenemos nuestras matrices discretas
Ts=4/ro/10;%Tiempo de muestreo
display(Ts)
[As_d,Bs_d]=c2d(As,Bs,Ts);
%Realizamos la conversión 
z=exp(Ts*polos);
Kd=acker(As_d,Bs_d,z);
%% Realizamos el control de posicion
close all
%Hallamos la función de transferencia del sistema del lazo interno
Alc=As-Bs*Kd;
Blc=[0;1];
Clc=[1 0];
Dlc=0;
[num,den]=ss2tf(Alc,Blc,Clc,Dlc);
G_est=tf(num,den);
%analizamos el LGR, para ello debemos añadir el integrador para obtener la
%posición
figure
rlocus(G_est/tf('s'))
%basta con un controlador proporcional
%Recordemos que el polo deseado es s=4/Tes
s=-4/Tes;
K=-polyval([den 0],s)/polyval(num,s);
polos_resultantes=rlocus(G_est/tf('s'),K);
fprintf("para el valor de K= "+K+", en el LGR, se tiene que:\n")
display(polos_resultantes)

%% ADICIONALES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Controlador Proporcional
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
num=Gm.num{1};
den=Gm.den{1};
Tes=1.2;
s=-4/Tes;
K0=-polyval(den,s)*s/polyval(num,s);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Realizamos un control por cascada
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%para ello hallamos los parametros Kp y Ki del sistema
%Tes=1.5;
%Mp=0;
%ess=0;
Tes=1;
%Ya se conoce como será el LGR del sistema
    %polo en el origen
    %1 polo ya definido por la planta
    %1 zero a definir
num=Gm.num{1};
den=Gm.den{1};
s=-4/(0.2);
%Establecemos un valor de cero en magnitud
zero=-s+2;
%Hallamos el Kp del LGR con la sgte formula
Kp1=-(s*polyval(den,s))/polyval(num,s)/(s+zero);
%definimos el modelo del controlador para hallar los polos del sistema con
%la funcion rlocus()
s=tf('s');
Gc=(s+zero)/s;
polos_sistema=rlocus(Gc*Gm,Kp1);
%verificamos que el polo -4 sea dominante, para ello el otro polo debe ser
%5 veces mas alejado (referencia: debe ser menos a -20)
%finalmente establecemos el controlados
Ki1=zero*Kp1;
Gc=Kp1+Ki1/s;

s=-4/(Tes+0.25);
Gp=feedback(Gc*Gm,1,-1);
num=Gp.num{1};
den=Gp.den{1};
K1=-polyval(den,s)*s/polyval(num,s);
