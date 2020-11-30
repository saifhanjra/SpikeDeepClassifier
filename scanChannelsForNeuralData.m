function ChannelLabelSession = scanChannelsForNeuralData(dataNEV, batchSize, trainedModelCNN, scanChannels)
trainedNet=trainedModelCNN.trainedNet;
for i=scanChannels(1):scanChannels(2) %Utah array contain 96 channels
electrodeId=i;    
yPredChannels =predictChannelFeatVectlLabelsDeepSpikeCNN(dataNEV, batchSize, electrodeId,trainedNet);% prediction on feature vectors
if yPredChannels ~= 0 % if the channel(is not broken and ) contain feature vectors
    [predictedOutput,ConfidencePercentage,channelLabel,frequencyChangesPrediction,totalFeatureVectors]=predictChannelLabelCummulativeAverage(electrodeId,yPredChannels);%predicted channel.
    % confidencePercantageSession{i}=ConfidencePercentage;% Reliabilty tag
    ChannelLabelSession{1,i}=channelLabel;% predicted channel label
    ChannelLabelSession{2,i}=num2str(ConfidencePercentage);%Reliabilty tag, percantage
    ChannelLabelSession{3,i}=num2str(frequencyChangesPrediction);% how many time the prediction switched at one electrode
    ChannelLabelSession{4,i}=num2str(totalFeatureVectors);% total number of feature vector on one electrode
elseif yPredChannels==0
    ChannelLabelSession{1,i}=0;% predicted channel label
    ChannelLabelSession{2,i}=num2str(0);%Reliabilty tag, percantage
    ChannelLabelSession{3,i}=num2str(0);% how many time the prediction switched at one electrode
    ChannelLabelSession{4,i}=num2str(0);% total number of feature vector on one electrode
end

end

end