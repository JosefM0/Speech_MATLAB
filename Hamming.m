figure(502), hold on

for k=1:nSeg
    seg = segs(k, 1:lSeg)';
    seg = seg.*hamming(lSeg); %okénkovani hammingovou funkcí
    plot(seg)
%     outs(1+(k-1)*w:k*w) = seg; %Rekonstrukce signálu
    segs(k,1:lSeg) = seg; %ulozeni všech segmentů do jedné matice
end

clear k seg

xlabel('n (-)')
ylabel('w_k[n]')
title('Okénkovaný signál Hammingovou funkcí:')
xlim([0 256])
