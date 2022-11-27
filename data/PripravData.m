% Skript pro extrakci příznaků z databáze řečníků.
%
% Načte postupně každou nahrávku od každého řečníka, nasegmentuje, vypočítá
% i-vektor, oddělí ticho a na závěr sestavý trénovací a testovací data. 
% Data uloží do .../data/features.mat.  

clear DATA,

Nfile = 15; %počet zvukových souborů k trénování od každého řečníká
Tseg = 25;   %Veliokost segmentu (ms)
Tow = 10;     %Veliokost překrytí segmentu (ms)

%%výpočet počtu registrovaných řečníků
cesta=strcat(pwd,'\nahravani\speakers\');   %vytvoří cestu k složce řečníka
[Nrecniku tmp] = (size(dir(cesta)));
Nrecniku = Nrecniku - 2; 
%%

%%extrakce
    h = waitbar(0,'Extrakce příznaků...'), progres=0; %zobrazí progresbar
    for SpID = 1:Nrecniku  %počet řečníků
        cesta = strcat(pwd,'\nahravani\speakers\',string(SpID));    %vytvoří cestu ke složce vybraného řečníka
        for file=1:Nfile  %počet zvukových souborů k trénování
           cesta_wav = strcat(cesta,'\',string(file),'.wav');
           display(cesta_wav)     
           data = F_ExtFeatures(cesta_wav, SpID, Tseg, Tow ); %vrátí [SpId ENE INTEN ZCR MFCC(0)...MFCC(10), F0_ACF, F0_KEP]
           [data] = F_Selekce(data, 2, 1);
           if (SpID==1)&&(file==1)  %při první iteraci inicializuje promennou DATA
               DATA=data';
           else
               DATA = horzcat(DATA,data');
           end
           progres= progres+1; waitbar(progres / (Nrecniku*Nfile) )    %aktualiyuje stav progresbaru       
        end
    end
    close(h), clear progres    %zavře okno progresbar
    R_DATA = DATA(:,randperm(size(DATA, 2)));

    p80=round(size(R_DATA,2)*0.8);
    Yuceni = categorical((R_DATA(1,1:p80))');
    Yverif = categorical((R_DATA(1,p80+1:end))');
    Xuceni = cell(p80,1);
    for i=1:p80
        Xuceni(i) = {R_DATA(2:end,i)};
    end
    Xverif = cell(size(R_DATA,2)-p80,1);
    for i=p80+1:size(R_DATA,2)
        Xverif(i-p80) = {R_DATA(2:end,i)};
    end


%%uložení výsledků:
path_data = 'data\features.mat';
PocetRecniku = SpID;
save(path_data,'PocetRecniku','Xuceni','Xverif','Yuceni','Yverif');