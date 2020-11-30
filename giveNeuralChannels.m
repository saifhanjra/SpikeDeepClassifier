function [neuralChannels,artifactsChannels, brokenChannels] =  giveNeuralChannels(channelLabelSession, percentageThreshold,scanChannels)
neuralChannels=[];
artifactsChannels=[];
brokenChannels=[];
for i=scanChannels(1):scanChannels(2)
    predictedChannelLabel=channelLabelSession{1, i};
    if strcmp(predictedChannelLabel,'Neural')
        confidencePercentage=str2num(channelLabelSession{2, i});
        if confidencePercentage > percentageThreshold
            neuralChannels=[neuralChannels,i];
        end
    elseif strcmp(predictedChannelLabel,'Artifacts')
        artifactsChannels=[artifactsChannels,i];
    else
        brokenChannels=[brokenChannels,i];
    end
    
end
end