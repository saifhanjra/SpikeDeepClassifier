function waveformsMean= meanWaveformsClusteringMethod(waveforms, labels)
%waveforms: is a matrix with no. of rows represent the number of waveforms and
% columns represent number of samples of each waveforms.
%labels: is a row-vector , each row reprsents the label of corresponding waveform.  

    labelsUnique=unique(labels);
    totalClasses=numel(labelsUnique);
    switch totalClasses
        case 1
            waveformsMean=mean(waveforms);
        case 2
            waveformsMean=zeros(2,48);
            ind_1=find(labels==1);
            waveforms_1=waveforms(ind_1,:);
            meanWaveforms_1=mean(waveforms_1);
            waveformsMean(1,:)=meanWaveforms_1;
            ind_2=find(labels==2);
            waveforms_2=waveforms(ind_2,:);
            meanWaveforms_2=mean(waveforms_2);
            waveformsMean(2,:)=meanWaveforms_2;
        case 3
            waveformsMean=zeros(3,48);
            ind_1=find(labels==1);
            waveforms_1=waveforms(ind_1,:);
            meanWaveforms_1=mean(waveforms_1);
            waveformsMean(1,:)=meanWaveforms_1;
            ind_2=find(labels==2);
            waveforms_2=waveforms(ind_2,:);
            meanWaveforms_2=mean(waveforms_2);
            waveformsMean(2,:)=meanWaveforms_2;
            ind_3=find(labels==3);
            waveforms_3=waveforms(ind_3,:);
            meanWaveforms_3=mean(waveforms_3);
            waveformsMean(3,:)=meanWaveforms_3;
        case 4
            waveformsMean=zeros(4,48);
            ind_1=find(labels==1);
            waveforms_1=waveforms(ind_1,:);
            meanWaveforms_1=mean(waveforms_1);
            waveformsMean(1,:)=meanWaveforms_1;
            ind_2=find(labels==2);
            waveforms_2=waveforms(ind_2,:);
            meanWaveforms_2=mean(waveforms_2);
            waveformsMean(2,:)=meanWaveforms_2;
            ind_3=find(labels==3);
            waveforms_3=waveforms(ind_3,:);
            meanWaveforms_3=mean(waveforms_3);
            waveformsMean(3,:)=meanWaveforms_3;
            ind_4=find(labels==4);
            waveforms_4=waveforms(ind_4,:);
            meanWaveforms_4=mean(waveforms_4);
            waveformsMean(4,:)=meanWaveforms_4;
            
            
            


    end


end