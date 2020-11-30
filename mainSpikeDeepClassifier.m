
clear;clc

%-------------------SpikeDeeptector------------------------
unsortedDataNEV=openNEV('C:\Users\muhammad.saif\Desktop\Recording3\Recording3.nev');
batchSize=20;
trainedModelCNN=load ('trainedModelCNNNew03.mat');
electrodes=sort(unsortedDataNEV.Data.Spikes.Electrode);
electrodesIds=unique(electrodes);
scanChannels=[electrodesIds(1),electrodesIds(end)];
channelLabelSession = scanChannelsForNeuralData(unsortedDataNEV, batchSize, trainedModelCNN, scanChannels);

percentageThreshold=85;
[neuralChannels,artifactsChannels, brokenChannels] =  giveNeuralChannels(channelLabelSession, percentageThreshold,scanChannels);

%---------------- Artifact Rejection-------------------------------------

[waveforms, channelsId]= getWaveformsWithChannelsIds(unsortedDataNEV);

load trainedNetPretrainedCNNsHumanNHPPlexon2.mat;

waveformsCompCNNs = makeTestdataWaveformsCompCNN(waveforms);

YPred=classify(trainedNet,waveformsCompCNNs);
%----------get the result of single channel---------------------------------

thresholdDist=5.5;
timeStamps=unsortedDataNEV.Data.Spikes.TimeStamp; 
for ii=1: numel(neuralChannels)
channelofInterest=neuralChannels(ii)
totalClusters=3;

[waveformsSingleChannel,yPredSingleChannel,timeStampsChannel]= getFeatureVectorsLabelofSingleChannel(waveforms,YPred,timeStamps,channelofInterest, channelsId);

% % % % 
% % % % ----------Extract feature vectors for Clustering algortihm----------------
% % % % 
% % % % ---------------------PCA features-----------------------------------------

% % % As per matlab Buit in PCA Function: row of featureVector matrix
% % % reprsents observation and column represents variable (features).

waveformsPCAComp=waveformsSingleChannel';
variabilityIntact=0.85;

dimRedPCA=DimRedPCAForClusteringAndFeatRed(waveformsPCAComp);

featVectClusMethod=dimRedPCA.featureReductionForClusteringMethod(variabilityIntact);

yPredSingleChannel=grp2idx(yPredSingleChannel);

spikeClassLabel=1;

[featVectClusMethodSpikes, timeStampsSpikes] = getWaveformsOrfeatVectselectedClass(featVectClusMethod, yPredSingleChannel,timeStampsChannel, spikeClassLabel);
[waveformSpikes,timeStampsSpikes]=getWaveformsOrfeatVectselectedClass(waveformsPCAComp, yPredSingleChannel,timeStampsChannel, spikeClassLabel);
waveformSpikesNorm=normalize(waveformSpikes);
artifactsLabels=2;
[featVectArtifacts, timeStampsArtifacts] = getWaveformsOrfeatVectselectedClass(featVectClusMethod, yPredSingleChannel,timeStampsChannel, artifactsLabels);
[waveformArtifacts,timeStampsArtifacts] =getWaveformsOrfeatVectselectedClass(waveformsPCAComp, yPredSingleChannel,timeStampsChannel, artifactsLabels);

% % % --------------------------------------------------------------------------
% % % 
% % % ---------- K-mean clustering----------------------------------------------

assignedLabelsKmeansidx = kmeans(featVectClusMethodSpikes,totalClusters);

%%%%%-----------Plot results---------------------------------------------------
close all;
% figure;
figure('units','normalized','outerposition',[0 0 1 1])

 % - Build title axes and title.
%  axes( 'Position', [0, 0.95, 1, 0.05] ) ;
%  set( gca, 'Color', 'None', 'XColor', 'White', 'YColor', 'White' ) ;
%  text( 0.5, 0, 'My Nice Title', 'FontSize', 14', 'FontWeight', 'Bold', ...
%       'HorizontalAlignment', 'Center', 'VerticalAlignment', 'Bottom' ) ;
  
  
subplot(4,5,1);
pltArtifactRejection=PlotArtifactRejectionResults(waveformsPCAComp,featVectClusMethod,timeStampsChannel,yPredSingleChannel);
pltArtifactRejection.rawWaveforms();
xlabel('Time(Samples)');
ylabel('Micro-volts');
x=sprintf('Raw waveforms of channel No.%d',channelofInterest);
title(x);

subplot(4,5,2);
pltArtifactRejection.rawScatter2D();
xlabel('PC 1');
ylabel('PC 2');
x=sprintf('PCA space of channel No. %d',channelofInterest);
title(x);


subplot(4,5,3);
pltArtifactRejection.waveformsPredictedSpikes();
hold on;
pltArtifactRejection.waveformsPredictedArtifacts();
xlabel('Time(Samples)');
ylabel('Micro-volts');
x=sprintf('Output: Artifact Rejection Algo (waveforms)');
title(x);

subplot(4,5,4);
pltArtifactRejection.scatter2DPredictedSpikes();
hold on;
pltArtifactRejection.scatter2DPredictedArtifacts();
aH=gca;
xLimScatter=aH.XLim;
yLimScatter=aH.YLim;
xlabel('PC 1');
ylabel('PC 2');
x=sprintf('Output: Artifact Rejection Algo (PCA Space)');
title(x);


subplot(4,5,5);%Waveforms Predicted as Spikes
pltArtifactRejection.waveformsPredictedSpikes();
hold on;
pltArtifactRejection.meanWaveformsPredictedSpikes();
xlabel('Time(Samples)');
ylabel('Micro-volts');
x=sprintf('Waveforms: predicted as Neural');
title(x);

subplot(4,5,6);%Scatter plot Spikes
pltArtifactRejection.scatter2DPredictedSpikes();
aHSpikes=gca;
aHSpikes.XLim=xLimScatter;
aHSpikes.YLim=yLimScatter;
xlabel('PC 1');
ylabel('PC 2');
x=sprintf('PCA Space: Represents Neural data');
title(x);

subplot(4,5,7);%Waveforms Predicted as Artifacts
pltArtifactRejection.waveformsPredictedArtifacts();
hold on;
pltArtifactRejection.meanWaveformsPredictedArtifacts();
xlabel('Time(Samples)');
ylabel('Micro-volts');
x=sprintf('Waveforms: predicted as Artifacts');
title(x);

subplot(4,5,8);%Scatter plot Artifacts
pltArtifactRejection.scatter2DPredictedArtifacts();
aHArtifacts=gca;
aHArtifacts.XLim=xLimScatter;
aHArtifacts.YLim=yLimScatter;
xlabel('PC 1');
ylabel('PC 2');
x=sprintf('PCA Space: Represents artifact data');
title(x);


subplot(4,5,9);
pltArtifactRejection.meanWaveformsPredictedSpikes();
hold on;
pltArtifactRejection.meanWaveformsPredictedArtifacts();
xlabel('Time(Samples)');
ylabel('Micro-volts');
x=sprintf('Mean Waveforms: Neural and Artifact');
title(x);


%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
pltClusMethod=PlotResultsClusMethods(featVectClusMethodSpikes,waveformSpikes,assignedLabelsKmeansidx);
subplot(4,5,11)
pltClusMethod.spikesWaveforms();
hold on;
pltClusMethod.plotEachClusterMeanWaveform();
xlabel('Time(Samples)');
ylabel('Micro-volts');
x=sprintf('Outputs: Clustering Method(K-NN)');
title(x);

subplot(4,5,12)
pltClusMethod.assignedClusSpikes2D();
aHSpikeClus=gca;
aHSpikeClus.XLim=xLimScatter;
aHSpikeClus.YLim=yLimScatter;
xlabel('PC 1');
ylabel('PC 2');
x=sprintf('Outputs: Clustering Method(K-NN)');
title(x);

subplot(4,5,13);
pltArtifactRejection.waveformsPredictedArtifacts();
hold on;
pltClusMethod.spikesWaveforms();
hold on;
pltClusMethod.plotEachClusterMeanWaveform();
hold on;
pltArtifactRejection.meanWaveformsPredictedArtifacts();
xlabel('Time(Samples)');
ylabel('Micro-volts');
x=sprintf('Waveforms with predicted labels');
title(x);



subplot(4,5,14);
pltClusMethod.assignedClusSpikes2D();
aHSpikeClus=gca;
aHSpikeClus.XLim=xLimScatter;
aHSpikeClus.YLim=yLimScatter;
hold on;
pltArtifactRejection.scatter2DPredictedArtifacts();
legendsRenamed=legend;
legendsRenamed.String{end}='Artifacts';
xlabel('PC 1');
ylabel('PC 2');
x=sprintf('Predicted labeled PCA Space');
title(x);


subplot(4,5,15);
pltClusMethod.plotEachClusterMeanWaveform();
hold on;
pltArtifactRejection.meanWaveformsPredictedArtifacts();
xlabel('Time(Samples)');
ylabel('Micro-volts');
x=sprintf('Mean wavelform of each predicted class');
title(x);

%--------------------------------------------------------------------------
%-------Automatize the process---------------------------------------------
%--------------------------------------------------------------------------



[assignedLabelsKmeansidx_new,waveforms_new,featVect_new] = automatizeKNNClusEuclideanDistAlgo2 (featVectClusMethodSpikes,waveformSpikes,assignedLabelsKmeansidx,timeStampsSpikes, thresholdDist);


pltClusMethod_new=PlotResultsClusMethods(featVect_new,waveforms_new,assignedLabelsKmeansidx_new);
%-----Ploting the results--------------------------------------------------

subplot(4,5,16);
pltClusMethod_new.spikesWaveforms();

hold on;
pltClusMethod_new.plotEachClusterMeanWaveform();

xlabel('Time(Samples)');
ylabel('Micro-volts');
x=sprintf('Output: Cluster Merging Method');
title(x)


subplot(4,5,17)
pltClusMethod_new.assignedClusSpikes2D();
aHSpikeClus=gca;
aHSpikeClus.XLim=xLimScatter;
aHSpikeClus.YLim=yLimScatter;
xlabel('PC 1');
ylabel('PC 2');
x=sprintf('Output: Cluster Merging Method');
title(x);

subplot(4,5,18);
pltArtifactRejection.waveformsPredictedArtifacts();
hold on;
pltClusMethod_new.spikesWaveforms();
hold on;
pltClusMethod_new.plotEachClusterMeanWaveform();
hold on;
pltArtifactRejection.meanWaveformsPredictedArtifacts();

xlabel('Time(Samples)');
ylabel('Micro-volts');
x=sprintf('Output: Spike Sorter');
title(x)


subplot(4,5,19);
pltClusMethod_new.assignedClusSpikes2D();
aHSpikeClus=gca;
aHSpikeClus.XLim=xLimScatter;
aHSpikeClus.YLim=yLimScatter;
hold on;
pltArtifactRejection.scatter2DPredictedArtifacts();
legendsRenamed=legend;
legendsRenamed.String{end}='Artifacts';
xlabel('PC 1');
ylabel('PC 2');
x=sprintf('Output: Spike Sorter');
title(x);


subplot(4,5,20);
pltClusMethod_new.plotEachClusterMeanWaveform();
hold on;
pltArtifactRejection.meanWaveformsPredictedArtifacts();
xlabel('Time(Samples)');
ylabel('Micro-volts');
x=sprintf('Mean Waveform of each predicted Class');
title(x)


pause()
end





