clear; close all
vel=[88.95 105.57 118.97 130.21 145.12 156.77 163.33 174.26 181.69 192.90 199.47 206.50 211.15 219.04 225.36 229.78 240.38 239.16 248.02 248.02 253.38 258.98 267.86 264.83 269.40 269.40 277.37 285.82 275.74 279.02 292.97 285.82 291.15 291.15 300.48 296.68 285.82 302.42 302.42 296.68 312.50 312.50 302.42 292.97 304.38 308.39 312.50 314.60 312.50 314.60 316.72 316.72 314.60 318.88 325.52 318.88 318.88 321.06 318.88 325.52 321.06 321.06 321.06 321.06 316.72 323.28 325.52 325.52 318.88 325.52 318.88 312.50 327.80 330.11 323.28 325.52 321.06 304.38 332.45 327.80 327.80 323.28 330.11 332.45 330.11 321.06 330.11 330.11 332.45 332.45 330.11 330.11 334.82 334.82 323.28 330.11 330.11 323.28 337.23 334.82 330.11 323.28 332.45 337.23 334.82 316.72 330.11 334.82 332.45 325.52 332.45 332.45 323.28 332.45 334.82 332.45 323.28 330.11 332.45 337.23 332.45 332.45 330.11 323.28 332.45 332.45 332.45 332.45 332.45 332.45 325.52 332.45 332.45 332.45 327.80 334.82 332.45 323.28 332.45 332.45 337.23 325.52 330.11 332.45 332.45 339.67 337.23 330.11 325.52 332.45 339.67 332.45 332.45 330.11 332.45 337.23 330.11 332.45 332.45 323.28 332.45 337.23 332.45 318.88 332.45 332.45 337.23 332.45 332.45 332.45 321.06 334.82 332.45 332.45 334.82 332.45 334.82 327.80 334.82 332.45 325.52 334.82 337.23 334.82 332.45 332.45 337.23 339.67 337.23 332.45 316.72 334.82 339.67 330.11 337.23 334.82 327.80 337.23 339.67 325.52 334.82 334.82 330.11 337.23 334.82 327.80 334.82 332.45 339.67 339.67 337.23 337.23 337.23 334.82 330.11 337.23 334.82 330.11 334.82 339.67 332.45 337.23 334.82 327.80 337.23 342.15 323.28 334.82 334.82 334.82 337.23 337.23 327.80 334.82 337.23 334.82 339.67 334.82 337.23 334.82 337.23 344.67 339.67 337.23 334.82 334.82 330.11 342.15 342.15 310.43 334.82 339.67 337.23 339.67 337.23 337.23 334.82 337.23 337.23 334.82 337.23 334.82 334.82 339.67 339.67 337.23 318.88 334.82 334.82 316.72 339.67 337.23 318.88 337.23 344.67 342.15 334.82 334.82 337.23 337.23 342.15 337.23 337.23 330.11 337.23 337.23 321.06 337.23 334.82 312.50 334.82 339.67 318.88 332.45 337.23 316.72 342.15 337.23 332.45 334.82 332.45 337.23 342.15 342.15 334.82 334.82 339.67 339.67 334.82 334.82 337.23 325.52 337.23 337.23 334.82 332.45 332.45 334.82 332.45 339.67 337.23 323.28 334.82 342.15 318.88 337.23 334.82 330.11 337.23 342.15 339.67 334.82 342.15 337.23 339.67 337.23 337.23 337.23 337.23 334.82 337.23 339.67 337.23 316.72 337.23 342.15 342.15 342.15 330.11 334.82 339.67 312.50 344.67 337.23 342.15 337.23 332.45 337.23 337.23 337.23 337.23 330.11 337.23 339.67 321.06 337.23 337.23 337.23 342.15 330.11 339.67 337.23 337.23 339.67 332.45 337.23 337.23 339.67 334.82 332.45 344.67 339.67 337.23 337.23 330.11 347.22 342.15 342.15 337.23 327.80 342.15 344.67 344.67 339.67 321.06 337.23 339.67 339.67 337.23 339.67 339.67 332.45 339.67 342.15 342.15 337.23 332.45 339.67 339.67 344.67 337.23 330.11 337.23 339.67 339.67 337.23 325.52 339.67 339.67 337.23 342.15 327.80 337.23 330.11 337.23 344.67 334.82 339.67 337.23 337.23 342.15 337.23 339.67 337.23 339.67 337.23 332.45 342.15 337.23 316.72 337.23 342.15 344.67 342.15 330.11 337.23 337.23 339.67 342.15 349.81 337.23 337.23 337.23 339.67 342.15 337.23 337.23 316.72 337.23 337.23 339.67 342.15 327.80 337.23 337.23 334.82 339.67 337.23 344.67 337.23 355.11 344.67 334.82 327.80 337.23 339.67 339.67 339.67 332.45 339.67 330.11 337.23 342.15 332.45 337.23 337.23 337.23 344.67 339.67 337.23 337.23 337.23 339.67 325.52 339.67 339.67 339.67 339.67 337.23 342.15 ];
vel2=[0 0 0 0 0 vel(1:end-5)];
t= 0: 0.002 : 0.999;
u= 3*ones(1,500);
%%
close all
load('Funciones_de_transferencia')
num=tf1.numerator;
den=tf1.denominator;
s=tf('s');
Gm1=tf(num/den(end),den/den(end));
figure(1)
rlocus(Gm1/s)
num=tf2.numerator;
den=tf2.denominator;
Gm2=tf(num/den(end),den/den(end));
title('LGR Gm1')
figure (2)
rlocus(Gm2/s)
title('LGR Gm2')
figure (3)
hold
step(3*Gm1,1)
plot(t,vel)
grid
title('Gm1 y modelo real')
hold off
figure (4)
hold
step(3*Gm2,1)
plot(t,vel)
grid
title('Gm2 y modelo real')
%Escogemos Gm1
Gm=Gm1;
%% Controlador Proporcional
close all
num=Gm.num{1};
den=Gm.den{1};
Tes=1.2;
s=-4/Tes;
K0=-polyval(den,s)*s/polyval(num,s);
%hallamos los polos y verificamos la dominancia
polos=rlocus(Gm*tf(1,[1 0]),K0);
display(polos)
%cumple la dominancia. Prodecemos a simular.
    %Ver simulación
rlocus(Gm*tf(1,[1 0]))
%% Realizamos un control por cascada
close all
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
rlocus(Gc*Gm);
polos_sistema=rlocus(Gc*Gm,Kp1);
%verificamos que el polo -4 sea dominante, para ello el otro polo debe ser
%5 veces mas alejado (referencia: debe ser menos a -20)
display(polos_sistema)
%finalmente establecemos el controlados
Ki1=zero*Kp1;
Gc=Kp1+Ki1/s;
display(Kp1)
display(Ki1)

s=-4/(Tes+0.25);
Gp=feedback(Gc*Gm,1,-1);
num=Gp.num{1};
den=Gp.den{1};
K1=-polyval(den,s)*s/polyval(num,s);
display(K1)
%hallamos los polos y verificamos la dominancia
polos=rlocus(Gp/tf('s'),K1);
display(polos)
figure
rlocus(Gp/tf('s'))
%% controlador PI
close all
Tes=2;
%el LGR será
    %polo en origen, para obtener la posicion
    %polo en origen por PI
    %polo debido a la planta
    %zero debido al controlador PI
    
    %Debemos admitir polos complejo
    %Segun el valor del cero definiremos la tendencia de la rama
sigma=-4/Tes;
zero=-(roots(Gm.den{1})-2*sigma);
zero=1.5;
figure
rlocus(Gm*(tf('s')+zero)/tf('s')/tf('s'));
% s=sigma+100*1j;
% num=Gm.num{1};
% den=[Gm.den{1} 0];
% 
% Kp=-(s*polyval(den,s))/polyval(num,s)/(s+zero);
%definimos el modelo del controlador para hallar los polos del sistema con
%la funcion rlocus()
Kp2=0.0656;
s=tf('s');
Gc=(s+zero)/s;
polos_sistema=rlocus(Gc*Gm/tf('s'),Kp2);
%verificamos que el polo -4 sea dominante, para ello el otro polo debe ser
%5 veces mas alejado (referencia: debe ser menos a -20)
display(polos_sistema)
%finalmente establecemos el controlados
Ki2=zero*Kp2;
Gc=Kp2+Ki2/s;
display(Kp2);
display(Ki2);
