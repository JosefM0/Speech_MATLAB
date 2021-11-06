
%% SEGMENTACE BEZ PREKRYTI %%
% w = 256; %velikost segmentu
% nSeg = floor(length(speech)/w); %pocet segmentu
% figure(500);
% hold on
% for k=1:nSeg
%     seg = speech(1+(k-1)*w:k*w);
%     seg = seg.*hamming(w); %okenkovani hammingovou funkci
%     plot(seg)
% %     outs(1+(k-1)*w:k*w) = seg; %Rekonstrukce signalu
%     segs(k,1:w) = seg; %ulozeni vsech segmentu do jedne matice
% end


%% SEGMENTACE S 50% PREKRYTIM %%
ow = 128; %velikost 1/2 segmentu
lSeg = 2*ow;    %velikost celého segmentu
nSeg = 2*(floor(length(speech)/lSeg))-1; %pocet polovin segmentu
figure(501); hold on
for k=1:nSeg
    seg = speech(1+(k-1)*ow:(ow+k*ow)); %rozdělení signálu na segmenty
    plot(seg)
%     outs(1+(k-1)*w:k*w) = seg; %Rekonstrukce signalu-
    segs(k,1:lSeg) = seg; %ulozeni vsech segmentu do jedne matice
end
clear k ow segment seg

xlabel('n (-)')
ylabel('w_k[n]')
title('Segmentovaný signál (velikost segmentu je 256 vzorků):')
axis([0 256 -0.06 0.1]);