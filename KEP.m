%kepstralni analyza kompletne

clear all; close all; clc
load('parametrs.mat');  % načte parametry záznamu ze souboru (Fs)
load('me_ahoj.mat');    % načte záznam ze souboru
% soundsc(speech, Fs); % prehraje načtený záznam
% pause(1.2)

ow = 128; %velikost 1/2 segmentu
lSeg = 2*ow;    %velikost celého segmentu
nSeg = 2*(floor(length(speech)/lSeg))-1; %pocet polovin segmentu
for k=1:nSeg
    seg = speech(1+(k-1)*ow:(ow+k*ow)); %rozdělení signálu na segmenty
        
    
    segs(k,1:lSeg) = seg; %ulozeni vsech segmentu do jedne matice   
end

