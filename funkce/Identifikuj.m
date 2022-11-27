function [Y] = Identifikuj(cesta_wav)

%Funkce identifikuje řečníka
% funkce načte zvukový soubor, provede extrakci příznaků, jejich
% klasifikaci a vrátí nejpravděpodobnější identitu řečníka
% 
% function [Y] = Identifikuj(cesta_wav)
% cesta_wav -celá sesta k analyzovanému zvukovému souboru
% Y         -predikovaný identita řečníka pro každý segment


%% Načtení předučené DNN
load('data\DNN.mat');

%% Extrakce příznaků
Tseg = 25;   %Veliokost segmentu (ms)
Tow = 10;     %Veliokost překrytí segmentu (ms)
SpID=0; 
 
data = F_ExtFeatures(cesta_wav, SpID, Tseg, Tow ); %vrátí [SpId ENE INTEN ZCR MFCC(0)...MFCC(10), F0_ACF, F0_KEP]
[data] = F_Selekce(data, 2, 1);
data=data';
X=cell(size(data,2),1);
for i=1:size(data,2)
    X(i) = {data(2:end,i)};
end

%% Vyhodnocení dat
% Y = classify(net,X,'MiniBatchSize',32);
Y = classify(net,X);
% bar(countcats(Y))

end
