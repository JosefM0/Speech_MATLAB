function [X_out] = F_hamming(X_in)
%F_HAMMING provede hamming. oken. na kazdy segment

X_out = zeros(size(X_in,1),size(X_in,2));
for k=1:size(X_in,1)
    seg = X_in(k,:);     
    seg = seg.*hamming(length(seg))'; %okenkování Hammingovou funkcí
    X_out(k,:) = seg;
end
end

