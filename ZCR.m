%Pruchody nulou, ZCR zero crossing rating

%SEGMENTACE BEZ PREKRYTI
wz = 160; %velikost segmentu 10 mS
poc = floor(length(speech)/wz); %pocet segmentu
for k=1:poc
    seg = speech(1+(k-1)*wz:k*wz);

    zc = 0;
    for i=1:length(seg)-1
        if seg(i)*seg(i+1) > 0
            zc = zc+0;
        else
            zc = zc+1;
        end
    end
    zcr = zc/length(seg);
    ZCRs(k) = zcr; 
    
    graf(1+(k-1)*wz:k*wz) = zcr;
end
figure(20)
subplot(2, 1, 1)
plot(speech)
subplot(2, 1, 2)
plot(graf)
clear k i zcr wz poc zc graf