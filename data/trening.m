%  Skript pro natrénování klasifikátoru pomocí dat připravených skriptem
%  PripravData.m
load('data\features.mat');

%nastavení jednotlivých vrstev DNN
VelVstup = size(Xuceni{1},1);
VelSkrytVrstv = 100;
PocRec = PocetRecniku;

layers = [ ...
    sequenceInputLayer(VelVstup, 'Name','vstup')
    lstmLayer(VelSkrytVrstv,'OutputMode','last')
    fullyConnectedLayer(PocRec)
    softmaxLayer
    classificationLayer];

maxEpochs = 10;
miniBatchSize = 32;

%nastavení parametrů pro trénování
options = trainingOptions('adam', ...
    'ExecutionEnvironment','CPU', ...
    'MaxEpochs',maxEpochs, ...
    'MiniBatchSize',miniBatchSize, ...
    'GradientThreshold',1, ...
    'Verbose',false, ...
    'Plots','training-progress');

net = trainNetwork(Xuceni,Yuceni,layers,options);

%% Vyhodnocení
YPred = classify(net,Xverif,'MiniBatchSize',miniBatchSize);

acc = sum(YPred == Yverif)./numel(Yverif)

%matice záměn
figure
C = confusionmat(Yverif,YPred);
cm = confusionchart(Yverif,YPred, ...
    'Title','Matice záměn', ...
    'XLabel','Odhadnutá identita řečníka', ...
    'YLabel','Pravá identita řečníka', ...
    'RowSummary','row-normalized');

%%uložení výsledků:
path_data = 'data\DNN.mat';
save(path_data,'net');
