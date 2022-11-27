function [speech] = F_Nahrej(delka, Fs, IdZarizeni)
%F_Nahrej Nahraje záznam ze vtupního zařízení počítače
% 
% 
% [speech] = F_Nahrej(delka, Fs, IdZarizeni)
% 
% speech    -vrátí hodnoty vzorků jako sloupcový vektor
% delka     -Délka záznamu (ms)
% Fs        -Vzorkovací kmitočet [Hz] např. 16000 Hz
% IdZarizeni   -ID vstupního zařízení



% info = audiodevinfo; %zjisti info o audio vstupech pripojenych k PC
nBits = 16; %Rozlišení převodníku
nChanels = 1; %vyber audio vstupu - zjisteny výše v objektu info
ID = IdZarizeni; 

aro=audiorecorder(Fs,nBits,nChanels,ID); %nastaví parametry záznamu

disp('Nahrávání spuštěno...')
recordblocking(aro, delka/1000); %začne záznam, delka zaznamu je druhy param.
% pause(delka/1000); %pauza pro pronesení řeči v sek.
disp('...Nahrávání ukončeno.')

% play(aro)  %přehraje záznam

speech = getaudiodata(aro); %převede objekt se záznamem na pole vzorků
plot([1:size(speech)]/Fs, speech); %
xlabel('t (s)');
% ylabel('amplituda(dB)');
% title('4:');

%sound(speech, Fs);

% soundsc(speech, Fs); 
%sound(speech/max(abs(speech)))
% file = 'me_long.mat'; %název souboru pro záznam
% save(file, 'speech');   %uloží záznam pod tímto názvem
% file = 'parametrs.mat'; %název souboru pro parametry
% save(file, 'Fs');   %uloží do souboru vzorkovací frekvenci pro další 


end

