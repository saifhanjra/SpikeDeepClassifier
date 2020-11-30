classdef PlotArtifactRejectionResults
    properties
        waveformsChannelPCAComp;
        featVectChannelClusMethod;
        yPredIdChannels;
        featVectChannelClusMethodSpikes;
        waveformChannelSpikes;
        
        featVectChannelClusMethodArtifacts;
        waveformChannelArtifacts
        
    end
    methods
        function self= PlotArtifactRejectionResults(waveformsChannelPCAComp,featVectChannelClusMethod,timeStampsChannel,yPredIdChannels)
            self.waveformsChannelPCAComp=waveformsChannelPCAComp;
            self.featVectChannelClusMethod=featVectChannelClusMethod;
            self.yPredIdChannels=yPredIdChannels;
            spikeClassLabel=1;
            self.featVectChannelClusMethodSpikes = getWaveformsOrfeatVectselectedClass(featVectChannelClusMethod, yPredIdChannels,timeStampsChannel, spikeClassLabel);
            self.waveformChannelSpikes=getWaveformsOrfeatVectselectedClass(waveformsChannelPCAComp, yPredIdChannels,timeStampsChannel, spikeClassLabel);
            
            artifactClassLabel=2;
            self.featVectChannelClusMethodArtifacts = getWaveformsOrfeatVectselectedClass(featVectChannelClusMethod, yPredIdChannels,timeStampsChannel, artifactClassLabel);
            self.waveformChannelArtifacts=getWaveformsOrfeatVectselectedClass(waveformsChannelPCAComp, yPredIdChannels, timeStampsChannel, artifactClassLabel);  
        end
        function rawWaveforms(self)
            plot((self.waveformsChannelPCAComp)','k');
            grid on;
        end
        function meanRawWaveforms(self)
            plot((mean(self.waveformsChannelPCAComp))','k','Linewidth',1.5);
            grid on;
        end
        function rawScatter2D(self)
            dataScatterPlot2D=self.featVectChannelClusMethod(:,1:2);
            scatter(dataScatterPlot2D(:,1),dataScatterPlot2D(:,2),'k');
            grid on;
        end
        function waveformsPredictedSpikes(self)
            plot((self.waveformChannelSpikes)','Color',[0,0.7,0.9]);
            grid on;
        end
        function meanWaveformsPredictedSpikes(self)
             plot((mean(self.waveformChannelSpikes))','Color',[0,0.7,0.9],'Linewidth',1.5);
             grid on;
        end
        
        function scatter2DPredictedSpikes(self)
            spikesDataScatterPlot2D=self.featVectChannelClusMethodSpikes(:,1:2);
            scatter(spikesDataScatterPlot2D(:,1),spikesDataScatterPlot2D(:,2),[],[0,0.7,0.9]);
            grid on;
        end
        function waveformsPredictedArtifacts(self)
            plot((self.waveformChannelArtifacts)','Color',[0.75,0.75,0.75]);
            grid on;
        end
        function meanWaveformsPredictedArtifacts(self)
            plot((mean(self.waveformChannelArtifacts))','Color',[0.75,0.75,0.75],'Linewidth',1.5);
            grid on;
        end
        function scatter2DPredictedArtifacts(self)
            artifactsDataScatterPlot2D=self.featVectChannelClusMethodArtifacts(:,1:2);
            scatter(artifactsDataScatterPlot2D(:,1),artifactsDataScatterPlot2D(:,2),[],[0.75,0.75,0.75]);
            grid on;
        end
        
    end
end
