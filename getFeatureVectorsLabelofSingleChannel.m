function [featuresVectorsSingleChannel,labelsSingleChannel,timeStampsSingleChannel]= getFeatureVectorsLabelofSingleChannel(featureVectors,labels,timeStamps,IdentfiedChannel, channelIds)
indInterest=find(channelIds==IdentfiedChannel);
labelsSingleChannel=labels(indInterest);
featuresVectorsSingleChannel=featureVectors(:,indInterest);
timeStampsSingleChannel=timeStamps(indInterest);

end