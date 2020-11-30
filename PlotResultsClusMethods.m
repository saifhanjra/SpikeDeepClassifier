classdef PlotResultsClusMethods
    properties
        featVectClusMethods % is a matrix with rows represent observations and colums represent features (two features)
        totalclusters
        assignedLabelsClusMethod
        waveFormSpikes
    end
    methods
        function self = PlotResultsClusMethods(featVectClusMethods,waveFormSpikes,assignedLabelsClusMethod)
            self.featVectClusMethods=featVectClusMethods;
            self.waveFormSpikes=waveFormSpikes;
            self.assignedLabelsClusMethod=assignedLabelsClusMethod;
            self.totalclusters=numel(unique(assignedLabelsClusMethod));
        end
        function ax2= assignedClusSpikes2D (self)
            featVect2D=self.featVectClusMethods(:,1:2);
            labels=unique(self.assignedLabelsClusMethod);
            colours=[1 0.5 0; 0.2 1 1; 0.6 0.2 1; 1 1 0];
            legends=[{'Unit 1'},{'Unit 2'},{'Unit 3'},{'Unit 4'}];
            
            switch self.totalclusters
                case 1
                    slectedColour=colours(labels,:);
                    gscatter(featVect2D(:,1),featVect2D(:,2),self.assignedLabelsClusMethod,slectedColour)
                    legend({'Unit 1'})
                    legend(legends(labels))
                case 2
                    slectedColour=colours(labels,:);
                    gscatter(featVect2D(:,1),featVect2D(:,2),self.assignedLabelsClusMethod,slectedColour)
                    legend([{'Unit 1'},{'Unit 2'}])
                    legend(legends(labels))
                case 3
                    slectedColour=colours(labels,:);
                    gscatter(featVect2D(:,1),featVect2D(:,2),self.assignedLabelsClusMethod,slectedColour)
                    legend([{'Unit 1'},{'Unit 2'},{'Unit 3'}])
                    legend(legends(labels))
                case 4
                    slectedColour=colours(labels,:);
                    gscatter(featVect2D(:,1),featVect2D(:,2),self.assignedLabelsClusMethod,slectedColour)
                    legend(legends(labels))
            end
            grid on;
            ax2=gca;
        end            
        
        
        function axWaveforms= spikesWaveforms(self)
            labels=unique(self.assignedLabelsClusMethod);
            colours=[1 0.5 0; 0.2 1 1; 0.6 0.2 1; 1 1 0];
%             legends=[{'Unit 1'},{'Unit 2'},{'Unit 3'},{'Unit 4'}];
            
            switch self.totalclusters
                case 1
                    selectedColour=colours(labels,:);
                    plot (self.waveFormSpikes','Color', selectedColour)
%                     legend(legends(labels));
                case 2
                    selectedColour=colours(labels,:);
                    
                    for idx = 1 : 2
                        ind_i= find(self.assignedLabelsClusMethod==labels(idx));
                        waveformsSpikes_i=self.waveFormSpikes(ind_i,:);
                        plot(waveformsSpikes_i','Color', selectedColour(idx,:));
                        hold on;
                    end
%                     legend(legends(labels))
                case 3
                     selectedColour=colours(labels,:);
                    for idx = 1 : 3
                        ind_i= find(self.assignedLabelsClusMethod==labels(idx));
                        waveformsSpikes_i=self.waveFormSpikes(ind_i,:);
                        plot(waveformsSpikes_i','Color', selectedColour(idx,:));
                        hold on;
                    end
%                     legend(legends(labels))
                case 4
                     selectedColour=colours(labels,:);
                    for idx = 1 : 4
                        ind_i= find(self.assignedLabelsClusMethod==labels(idx));
                        waveformsSpikes_i=self.waveFormSpikes(ind_i,:);
                        plot(waveformsSpikes_i','Color', selectedColour(idx,:));
                        hold on;
                    end
            end
            grid on;
            axWaveforms=gca;
            
            
        end
        function axMeanWaveforms = plotEachClusterMeanWaveform(self)
            labels=unique(self.assignedLabelsClusMethod);
            colours=[1 0.8 0.6; 0 0.8 0.8; 0.4 0 0.8; 0.8 0.8 0];
            switch self.totalclusters
                
                case 1
                    selectedColour=colours(labels,:);
                    meanWaveforms= mean(self.waveFormSpikes);
                    plot (meanWaveforms', 'Color',selectedColour, 'LineWidth',1.5)
%                     legend({'Unit 1'})
                    hold on;
                case 2
                    selectedColour=colours(labels,:);
                    for idx = 1 : 2
                        ind_i= find(self.assignedLabelsClusMethod==labels(idx));
                        waveformsSpikes_i=self.waveFormSpikes(ind_i,:);
                        meanWaveforms_i=mean(waveformsSpikes_i);
                        plot(meanWaveforms_i','Color',selectedColour(idx,:), 'LineWidth',1.5);
                        hold on;
                    end
                case 3
                    selectedColour=colours(labels,:);
                    for idx = 1 : 3
                        ind_i= find(self.assignedLabelsClusMethod==labels(idx));
                        waveformsSpikes_i=self.waveFormSpikes(ind_i,:);
                        meanWaveforms_i=mean(waveformsSpikes_i);
                        
                        plot(meanWaveforms_i','Color',selectedColour(idx,:), 'LineWidth',1.5);
                        hold on;
                    end
                case 4
                    selectedColour=colours(labels,:);
                    for idx = 1 : 4
                        ind_i= find(self.assignedLabelsClusMethod==labels(idx));
                        waveformsSpikes_i=self.waveFormSpikes(ind_i,:);
                        meanWaveforms_i=mean(waveformsSpikes_i);
                        plot(meanWaveforms_i','Color',selectedColour(idx,:), 'LineWidth',1.5);
                        hold on;
                    end
                    
                    
            end
            grid on;
            axMeanWaveforms=gca;
            
        end
    end
end