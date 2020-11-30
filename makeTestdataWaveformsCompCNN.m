function waveformsCompCNNs = makeTestdataWaveformsCompCNN(waveforms)
totalExamples=size(waveforms);
totalExamples=totalExamples(2);
waveformsTranspose=waveforms';
for i=1:totalExamples
    waveforms_i=waveformsTranspose(i,:);
    featuresVectorsWaveforms=reshape(waveforms_i,[48,1]);
    featuresVectorsWaveforms=featuresVectorsWaveforms';
    waveformsCompCNNs(:,:,1,i)=featuresVectorsWaveforms;
end
if totalExamples==0
    waveformsCompCNNs=[];
end


end