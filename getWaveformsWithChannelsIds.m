function[waveforms, channelsId,timeStampsElectrodes]= getWaveformsWithChannelsIds(nevStruct)
data=nevStruct.Data.Spikes.Waveform;
timeStamps=nevStruct.Data.Spikes.TimeStamp;
electrode=nevStruct.Data.Spikes.Electrode;
uniqueElectrode=unique(electrode);
uniqueElectrode=sort(uniqueElectrode);
waveforms=[];
channelsId=[];
timeStampsElectrodes=[];
for i=1:numel(uniqueElectrode)
    indElectrode_i=find(uniqueElectrode(i)==electrode);
    waveforms_i=data(:,indElectrode_i);
    waveforms=[waveforms,waveforms_i];
    timeStamps_i=timeStamps(indElectrode_i);
    timeStampsElectrodes=[timeStampsElectrodes,timeStamps_i];
    channelsId_i=electrode(indElectrode_i);
    channelsId=[channelsId,channelsId_i];
    
end
waveforms=double(waveforms);
end