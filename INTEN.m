%Kratkodoba intenzita

%SEGMENTACE BEZ PREKRYTI
wz = 128; %velikost segmentu
poc = floor(length(speech)/wz); %pocet segmentu
for k=1:poc
    seg = speech(1+(k-1)*wz:k*wz);

    ener = 0;
    for i=1:length(seg)-1
        ener = ener + abs(seg(i));    %výpočet intenzity
    end
    INTENs(k) = ener; 
    
    graf(1+(k-1)*wz:k*wz) = ener;
end
figure(11)
subplot(2, 1, 1)
plot(speech)
plot(speech)
xlabel('n (-)')
ylabel('w[n]')
title('Řečový signál (vzorkovací kmitočet je 16 kHz):')

subplot(2, 1, 2)
plot(graf)
xlabel('n (-)')
ylabel('Y[n]')
title('Krátkodobá intenzita (velikost segmentu je 128 vzorků):')

clear k i wz poc graf ener