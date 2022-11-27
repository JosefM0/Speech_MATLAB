function [] = F_graf(X)
%F_GRAF zobrazí graf jednotlyvých segmentu matice X za sebou

for k=1:size(X,1)
    graf(1+(k-1)*size(X,2):k*size(X,2)) = X(k,:);
end
figure
plot(graf)
end

