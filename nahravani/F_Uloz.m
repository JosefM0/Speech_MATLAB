function [FileName] = F_Uloz(speech, Fs, SpeakerId)
%F_Uloz Uloži záznam pro zadaneho recnika
% 
% 
% [FileName] = F_Uloz(speech, Fs, SpeakerId)
% 
% FileName      - název uloženého souboru
% speech        - hodnoty vzorků řečového záznamu jako sloupcový vektor
% Fs            -Vzorkovací kmitočet [Hz]
% SpeakerId     -Identifikační číslo řečníka

% speech = [1;2;3;4;1;2]
% Fs=16000
% SpeakerId=3

cesta=strcat(pwd,'\nahravani\speakers\',string(SpeakerId));   %vytvoří cestu k složce řečníka
[pocet b] = (size(dir(cesta)));   %spočítá kolik již je nahrávek ve složce
cesta = strcat(cesta,'\',string(pocet-2),'.wav');  %vytvoří cestu k novému souboru x.wav, 
audiowrite(cesta,speech,Fs)
display(strcat('Záznam řečníka:',string(SpeakerId),' byl uložen do souboru:',string(pocet-2),'.wav'))

FileName = strcat(string(pocet-2),'.wav');
end

