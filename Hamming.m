figure(502), hold on

for k=1:nSeg
    seg = segs(k, 1:lSeg)';
    seg = seg.*hamming(lSeg); %okenkovani hammingovou funkci
    plot(seg)
%     outs(1+(k-1)*w:k*w) = seg; %Rekonstrukce signalu
    segs(k,1:lSeg) = seg; %ulozeni vsech segmentu do jedne matice
end

clear k seg
