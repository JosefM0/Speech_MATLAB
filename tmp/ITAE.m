close all, clc, clear all
G=tf([1],[6 11 6 1]);
Gr=5+tf([0.1],[1 0]);
G0=Gr*G;
Ge=feedback(1,G0,-1);
[e,t]=step(Ge);
plot(t,e);
% iTae=sum(abs(e).*t)*(t(2)-t(1))

figure
[Gm,Pm,Wf,Wr]=margin(G0)
