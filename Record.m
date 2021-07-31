clear all;
info = audiodevinfo;

Fs = 16000; %Sample Rate
nBits = 16;
nChanels = 1;
ID = -1; 

aro=audiorecorder(Fs,nBits,nChanels,ID);

disp('Start speaking.')
recordblocking(aro, 1);
pause(1);
disp('Stop recording.')

%play(aro)

speech = getaudiodata(aro);
plot([1:size(speech)]/Fs, speech);

%sound(speech, Fs);

soundsc(speech, Fs); %== sound(speech/max(abs(speech)))
file = 'zena_a.mat';
save(file, 'speech');
file = 'parametrs.mat';
save(file, 'Fs');