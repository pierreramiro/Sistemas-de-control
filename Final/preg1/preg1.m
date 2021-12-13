%% Sistema
Gk=[0.6839 -0.7547;-0.2535 0.2798];
Hk=[-0.01109;-0.01179];
Hw=H;
C=[21.53 -20.25];
D=0;
%% Diseño de controlador
Ts=0.4;
Tes=8;%menor o igual a 10seg
Mp=0;%menor o igual a 10
ess=0;%efecto de un integrador
%Hallamos las matrices extendidas
Gk_v=[Gk Hk;0 0 0];
Hk_v=[0;0;1];
%verificamos controlabilidad
M_co_v=[Hk_v Gk_v*Hk_v Gk_v^2*Hk_v];
if rank(M_co_v)
    fprintf("Es controlable\n")
else
    fprintf("No es controlable")
end
polos=[-4/Tes;-20/Tes;-20/Tes];
polos=exp(polos*Ts);
K_v=acker(Gk_v,Hk_v,polos);
K_21=(K_v+[0 0 1])*inv([Gk-eye(2) Hk;C*Gk C*Hk]);
K2=K_21(1:end-1);
K1=K_21(end);
%% Diseñamos el observador
%verficamos observabilidad
M_ob=[C;C*Gk];
if rank(M_ob)==length(M_ob)
    fprintf("Observable\n")
else
    fprintf("No observable\n")
end
polos=[-4/Tes;-20/Tes];
polos=exp(polos*5);
L=acker(Gk',C',polos)';