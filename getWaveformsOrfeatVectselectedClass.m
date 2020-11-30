function [featVectSelectedClass, timeStampsSelectedClass]= getWaveformsOrfeatVectselectedClass(featureVectors, labels,timeStampsSingleChannel, selectedClasslabel)
%featureVector is a matrix, number of rows represent the observations and
%columns represent features.
selectedClassInd=find(labels==selectedClasslabel);
featVectSelectedClass=featureVectors(selectedClassInd,:);
timeStampsSelectedClass=timeStampsSingleChannel(selectedClassInd);
end