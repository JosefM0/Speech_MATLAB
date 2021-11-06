clear all;
info = audiodevinfo; %zjisti info o audio vstupech pripojenych k PC

Fs = 16000; %Sample Rate
nBits = 16; %Rozlišení převodníku
nChanels = 1; %vyber audio vstupu - zjisteny výše v objektu info
ID = -1; 

aro=audiorecorder(Fs,nBits,nChanels,ID); %nastaví parametry záznamu

disp('Start speaking.')
recordblocking(aro, 4); %začne záznam, delka zaznamu je druhy param.
pause(4); %pauza pro pronesení řeči
disp('Stop recording.')

play(aro)  %přehraje záznam

speech = getaudiodata(aro); %převede objekt se záznamem na pole vzorků
plot([1:size(speech)]/Fs, speech); %

%sound(speech, Fs);

soundsc(speech, Fs); %== sound(speech/max(abs(speech)))
file = 'test_long.mat'; %název souboru pro záznam
save(file, 'speech');   %uloží záznam pod tímto názvem
file = 'parametrs.mat'; %název souboru pro parametry
save(file, 'Fs');   %uloží do souboru vzorkovací frekvenci pro další práci