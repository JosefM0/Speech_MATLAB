
clear all;close all;clc;

a3 = 1;
a2 = 16.1;
a1 = 71.68;
a0 = 56.58;
b0 = 0.3;
citatel = [b0];
jmenovatel = [a3 a2 a1 a0];

%% A
%převod z vnějšího popisu na vnitřní:
[A,B,C,D]=tf2ss(citatel,jmenovatel);

%převod na frobeniův tvar:
FROA = rot90(A,2)
FROB = flipud(B)
FROC = fliplr(C)
FROD = D

% převod na Jordanův tvar
[residua,poly,k]=residue(citatel,jmenovatel)
JORA=diag(poly)
JORB=ones(size(poly,1),1)
JORC=residua'
if isempty(k)
    JORD=0
else
    JORD=k
end

figure, step(JORA,JORB,JORC,JORD)
title('Přechodová charakteristika - Jordanův tvar')
figure, step(FROA,FROB,FROC,FROD)
title('Přechodová charakteristika - Frobeniův tvar')

%% B
%obraz prechodove matice - homogení
syms s;
I = eye(3);
Fi_s = inv(s*I-JORA);
fi_t = ilaplace(Fi_s);
x0 = [1;2;3];
Xsh = Fi_s*x0
xth = ilaplace(Xsh)
%vykresleni
figure
ezplot(xth(1),[0 8])
hold on
ezplot(xth(2),[0 8])
ezplot(xth(3),[0 8])
axis auto
legend('x_1(t)','x_2(t)','x_3(t)')
grid on
title('Průběh stavoých veličin bez buzení')

%obraz prechodove matice - úplná
Us = 2/s;
Xsu = Fi_s*(x0+JORB+Us)
xtu = ilaplace(Xsu)
%vykresleni
figure
ezplot(xtu(1),[0 6])
hold on
ezplot(xtu(2),[0 6])
ezplot(xtu(3),[0 6])
axis auto
legend('x_1(t)','x_2(t)','x_3(t)')
grid on
title('Průběh stavoých veličin se vstupním signálem u(t)')

%% C
%riditelnost dosazitelnost systemu:
Co = ctrb(JORA, JORB);  %vr8t9 matici 5iditelnosti
rCo = rank(Co) %vrati pocet lin. nezavislych radku. System je dosazitelny a riditelny, pokud tento pocet odpovida radu systemu

%poyorovatelnost>
Ob = obsv(JORA, JORC);
rOb = rank(Ob)

%% D
%zásoba stability ve fázi a v amplitudě:
Gs = tf(citatel,jmenovatel);
Gr = pidtune(Gs,'PID');
Gr.Kd = 20; %soustava nebyla stabilní, tak jsem ponížil derivační složku
G0 = series(Gs,Gr); %přenos otevřené smyčky
figure, margin(G0)
%Nyquistovo kritérium stability
figure, nyquist(G0)
%Michaljovo kritérium stability
Gw = feedback(G0,1,-1); %přenos uzavřené smyčky
[numGw,denGw]=tfdata(Gw);
w=0:0.001:1000;
Gjw=1./polyval(denGw{1,1},1i*w);
figure
plot(real(Gjw),imag(Gjw))
grid on;
ylabel('Im'), xlabel('Re')
title('Michailovo kriterium stability');

%Kvalita regulace
stepinfo(Gw)
figure, step(Gw), grid on

%% E
Ge = feedback(1,G0,-1);
[e_t,t] = step(Ge,10);
e_inf = e_t(length(e_t)); %hodnota odchylky po ustálení
t_st = t(2)-t(1);   %vzorkovaci perioda pri prevodu na numericky vypocet pomoci step()
%Integrální kvadratické kritérium:
Ik = sum((e_t-e_inf).^2*t_st)
%ITAE:
ITAE = sum((abs(e_t-e_inf)).*t*t_st)

%% F
%uložení průběhu frekvenční charakteristiky:
[ReGs,ImGs,omegGs] = nyquist(Gs,{0.001, 10000});
omegGs = omegGs';
for n=1:length(omegGs)
    ReGs1(n) = ReGs(:,:,n);
    ImGs1(n) = ImGs(:,:,n);
end
%Aproximace přechodové charakteristiky z frekvenční hodnot charakteristiky:
time = 0:0.01:8;
for k=1:length(time)
   h_aprx(k) =  2/pi*trapz(omegGs,(ReGs1./omegGs).*sin(omegGs*time(k)));
end
figure, plot(time, h_aprx,'r');
hold on
step(Gs,time)

%% G
Td = Gr.Kd/Gr.Kp;
Ti = Gr.Kp/Gr.Ki;
Tz = min(abs(roots(jmenovatel)))/10; %vzorkovaci perioda je alespon 10 mesnsi nez nejmensi cas. konst. reg soustavz
% Tz = 0.001;
q0 = Gr.Kp*(1+Tz/Ti+Td/Tz);
q1 = -Gr.Kp*(1+2*Td/Tz);
q2 = Gr.Kp*Td/Tz;

%% H
poly = roots(jmenovatel); %poly sledovaného systému
poly_poz = 5.*poly; %poly pozorovatele: tak, aby casove konst. byly 5 x rýchlejší
L=[-9058.27; -5903.49; 17718.4]
Ap = A-L*JORC;




