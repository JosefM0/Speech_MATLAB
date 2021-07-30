clear all;
info = audiodevinfo;

Fs = 16000; %Sample Rate
nBits = 16;
nChanels = 1;
ID = -1; 

aro=audiorecorder(Fs,nBits,nChanels,ID);

disp('Start speaking.')
recordblocking(aro, 3);
disp('Stop recording.')

%play(aro)

speech = getaudiodata(aro);
plot([1:size(speech)]/Fs, speech);

sound(speech, Fs);
pause(3);
soundsc(speech, Fs); %== sound(speech/max(abs(speech)))