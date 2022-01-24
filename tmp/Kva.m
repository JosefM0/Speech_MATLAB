clear all
G=tf([1],[6 11 6 1])
Gr=5+tf([0.05],[1 0])
Ge=feedback(1,G*Gr,-1)
[e,t]=step(Ge);

J=sum(e.*e)*(t(2)-t(1))
[Gm,Pm,Wf,Wr]=margin(G*Gr)
