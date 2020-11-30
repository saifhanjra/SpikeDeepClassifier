function [assignedLabelsKmeansidx_new, waveforms_new,featVect_new,timeStampsNew,ind_new] = automatizeKNNClusEuclideanDistAlgo2 (featVectClusMethodSpikes,waveformsSpike,assignedLabelsKmeansidx,timeStampsSpikes,thresholdDist)
waveformsSpikeNorm=normalize(waveformsSpike,'zscore');
%waveformsSpikeNorm=meanNormalizationData(waveformsSpike);
waveformsMean=meanWaveformsClusteringMethod(waveformsSpikeNorm, assignedLabelsKmeansidx);
totalCluster=numel(unique(assignedLabelsKmeansidx));

    switch totalCluster
        case 3
            eDist1_2 = calcEuclideanDistMeanWaveforms(waveformsMean(1,:), waveformsMean(2,:));
            eDitsClusids=[1,2];
            eDist1_3 = calcEuclideanDistMeanWaveforms(waveformsMean(1,:), waveformsMean(3,:));
            eDitsClusids=[eDitsClusids;1,3];
            eDist2_3 = calcEuclideanDistMeanWaveforms(waveformsMean(2,:), waveformsMean(3,:));
            eDitsClusids=[eDitsClusids;2,3];
            assignedLabelsKmeansidx_new=assignedLabelsKmeansidx;
            waveforms_new=waveformsSpike;
            featVect_new=featVectClusMethodSpikes;
            timeStampsNew=timeStampsSpikes;
            ind_new=[];
            if any([eDist1_2,eDist1_3,eDist2_3]<=thresholdDist)
                meanDist=[eDist1_2,eDist1_3,eDist2_3];
                [meanDistDesc, meanDistDescId]=sort(meanDist);
                minimalDistClusterInd=meanDistDescId(1);
                minimalDistClusters=eDitsClusids(minimalDistClusterInd,:);

                idMergeClus1=minimalDistClusters(1,1);
                idMergeClus2=minimalDistClusters(1,2);
                idClusKeep=ismissing([1,2,3],minimalDistClusters);
                idClusKeep=find(idClusKeep==0);
                %----------------------------
                indicesClus1=find(assignedLabelsKmeansidx==idMergeClus1);
                indicesClus2=find(assignedLabelsKmeansidx==idMergeClus2);
                indicesMergeClus1Clus2=[indicesClus1;indicesClus2];
                indicesMergeClus1Clus2=sort(indicesMergeClus1Clus2);
                
                waveformsMergeClus1Clus2Norm=waveformsSpikeNorm(indicesMergeClus1Clus2,:);
                waveformsMergeClus1Clus2=waveformsSpike(indicesMergeClus1Clus2,:);
                
                featVectClusMergeClus1Clus2=featVectClusMethodSpikes(indicesMergeClus1Clus2,:);
                waveformsMeanMergeClus1Clus2=mean(waveformsMergeClus1Clus2Norm);
                timeStampsMergeClus1Clus2=timeStampsSpikes(indicesMergeClus1Clus2);
                
                indicesClus3=find(assignedLabelsKmeansidx==idClusKeep);
                waveformsClus3Norm=waveformsSpikeNorm(indicesClus3,:);
                waveformsClus3=waveformsSpike(indicesClus3,:);
                featVectClus3=featVectClusMethodSpikes(indicesClus3,:);
                waveformsMeanClus3=mean(waveformsClus3Norm);
                timeStampsClus3=timeStampsSpikes(indicesClus3);
                %----claculate eDist
                eDistMerge1Clus1_2_3=calcEuclideanDistMeanWaveforms(waveformsMeanMergeClus1Clus2,waveformsMeanClus3);
                if eDistMerge1Clus1_2_3 <= thresholdDist
                    assignedLabelsKmeansidx_new=ones(numel(assignedLabelsKmeansidx),1);
                    waveforms_new=waveformsSpike;
                    featVect_new=featVectClusMethodSpikes;
                    timeStampsNew=timeStampsSpikes;
                    ind_new=[];

                elseif eDistMerge1Clus1_2_3 > thresholdDist
                    sizeMergeClus1_2=size(waveformsMergeClus1Clus2Norm);
                    numberExamplesMergeClus1_2=sizeMergeClus1_2(1);
                    idMegedClus=sort(minimalDistClusters);
                    selectedIdMergeClus=idMegedClus(1);
                    relabeledWaveformsMergeClus1_2=selectedIdMergeClus.*ones(numberExamplesMergeClus1_2,1);

                    sizeClus3=size(waveformsClus3);
                    numberExamplesClus3=sizeClus3(1);
                    relabeledWaveformsClus3=idClusKeep.*ones(numberExamplesClus3,1);                   
                    
                    waveforms_new=[waveformsMergeClus1Clus2;waveformsClus3];
                    featVect_new=[featVectClusMergeClus1Clus2;featVectClus3];
                    assignedLabelsKmeansidx_new=[relabeledWaveformsMergeClus1_2;relabeledWaveformsClus3];
                    ind_new=[indicesMergeClus1Clus2; indicesClus3];
                    timeStampsNew=[timeStampsMergeClus1Clus2,timeStampsClus3];
                end
            end
        case 4
            eDist1_2 = calcEuclideanDistMeanWaveforms(waveformsMean(1,:), waveformsMean(2,:));
            eDitsClusids=[1,2];
            eDist1_3 = calcEuclideanDistMeanWaveforms(waveformsMean(1,:), waveformsMean(3,:));
            eDitsClusids=[eDitsClusids;1,3];
            eDist1_4 = calcEuclideanDistMeanWaveforms(waveformsMean(1,:), waveformsMean(4,:));
            eDitsClusids=[eDitsClusids;1,4];
            eDist2_3 = calcEuclideanDistMeanWaveforms(waveformsMean(2,:), waveformsMean(3,:));
            eDitsClusids=[eDitsClusids;2,3];
            eDist2_4 = calcEuclideanDistMeanWaveforms(waveformsMean(2,:), waveformsMean(4,:));
            eDitsClusids=[eDitsClusids;2,4];
            eDist3_4 = calcEuclideanDistMeanWaveforms(waveformsMean(3,:), waveformsMean(4,:));
            eDitsClusids=[eDitsClusids;3,4];

            assignedLabelsKmeansidx_new=assignedLabelsKmeansidx;
            waveforms_new=waveformsSpike;
            featVect_new=featVectClusMethodSpikes;

            if any([eDist1_2,eDist1_3,eDist1_4,eDist2_3,eDist2_4,eDist3_4]<=thresholdDist)
                meanDist=[eDist1_2,eDist1_3,eDist1_4, eDist2_3,eDist2_4,eDist3_4];
                [meanDistDesc, meanDistDescId]=sort(meanDist);
                minimalDistClusterInd=meanDistDescId(1);
                minimalDistClusters=eDitsClusids(minimalDistClusterInd,:);

                idMergeClus1=minimalDistClusters(1,1);
                idMergeClus2=minimalDistClusters(1,2);

                idClusKeep=ismissing([1,2,3,4],minimalDistClusters);
                idClusKeep=find(idClusKeep==0);

                indicesClus1=find(assignedLabelsKmeansidx_new==idMergeClus1);
                indicesClus2=find(assignedLabelsKmeansidx_new==idMergeClus2);

                indicesMergeClus1Clus2=[indicesClus1;indicesClus2];
                indicesMergeClus1Clus2=sort(indicesMergeClus1Clus2);

                waveformsMergeClus1Clus2=waveforms_new(indicesMergeClus1Clus2,:);
                featVectClusMergeClus1Clus2=featVectClusMethodSpikes(indicesMergeClus1Clus2,:);
                waveformsMeanMergeClus1Clus2=mean(waveformsMergeClus1Clus2);

                indicesClus3=find(assignedLabelsKmeansidx_new==idClusKeep(1));
                waveformsClus3=waveformsSpike(indicesClus3,:);
                waveformsMeanClus3=mean(waveformsClus3);
                featVectClus3=featVectClusMethodSpikes(indicesClus3,:);


                indicesClus4=find(assignedLabelsKmeansidx_new==idClusKeep(2));
                waveformsClus4=waveformsSpike(indicesClus4,:);
                waveformsMeanClus4=mean(waveformsClus4);
                featVectClus4=featVectClusMethodSpikes(indicesClus4,:);

                sizeMergeClus1_2=size(waveformsMergeClus1Clus2);
                numberExamplesMergeClus1_2=sizeMergeClus1_2(1);
                idsMegedClus=sort(minimalDistClusters);
                selectedIdMergedClus=idsMegedClus(1);
                relabeledWaveformsMergeClus1_2=selectedIdMergedClus.*ones(numberExamplesMergeClus1_2,1);%%%%%%--------


                sizeClus3_new=size(waveformsClus3);
                numberExamplesClus3_new=sizeClus3_new(1);
                relabeledClus3=idClusKeep(1).*(ones(numberExamplesClus3_new,1));%%%%%----

                sizeClus4_new=size(waveformsClus4);
                numberExamplesClus4_new=sizeClus4_new(1);
                relabeledClus4=idClusKeep(2).*(ones(numberExamplesClus4_new,1));%%%%%-----


                assignedLabelsKmeansidx_new=[relabeledWaveformsMergeClus1_2;relabeledClus3;relabeledClus4];
                waveforms_new=[waveformsMergeClus1Clus2; waveformsClus3;waveformsClus4];
                featVect_new=[featVectClusMergeClus1Clus2;featVectClus3;featVectClus4];

                eDistMerge1_2Clus_3=calcEuclideanDistMeanWaveforms(waveformsMeanMergeClus1Clus2,waveformsMeanClus3);
                eDitsClusidsNew=[selectedIdMergedClus,idClusKeep(1)];
                eDistMerge1_2Clus4=calcEuclideanDistMeanWaveforms(waveformsMeanMergeClus1Clus2,waveformsMeanClus4);
                eDitsClusidsNew=[eDitsClusidsNew; selectedIdMergedClus,idClusKeep(2)];
                eDist3_4New=calcEuclideanDistMeanWaveforms(waveformsMeanClus3,waveformsMeanClus4);
                eDitsClusidsNew=[eDitsClusidsNew; idClusKeep(1),idClusKeep(2)];


                if any([eDistMerge1_2Clus_3,eDistMerge1_2Clus4,eDist3_4New] <=thresholdDist)

                    meanDist=[eDistMerge1_2Clus_3,eDistMerge1_2Clus4,eDist3_4New];
                    [meanDistDesc, meanDistDescId]=sort(meanDist);
                    minimalDistClusterInd=meanDistDescId(1);
                    minimalDistClusters=eDitsClusidsNew(minimalDistClusterInd,:);

                    idMergeClus1=minimalDistClusters(1,1);
                    idMergeClus2=minimalDistClusters(1,2);

                    idClusKeep=ismissing([selectedIdMergedClus,idClusKeep(1),idClusKeep(2)],minimalDistClusters);
                    idClusKeep=find(idClusKeep==0);

                    indicesClus1=find(assignedLabelsKmeansidx_new==idMergeClus1);
                    indicesClus2=find(assignedLabelsKmeansidx_new==idMergeClus2);


                    indicesMergeClus1Clus2=[indicesClus1;indicesClus2];

                    indicesMergeClus1Clus2=sort(indicesMergeClus1Clus2);

                    waveformsMergeClus1Clus2=waveforms_new(indicesMergeClus1Clus2,:);
                    featVectClusMergeClus1Clus2=featVect_new(indicesMergeClus1Clus2,:);
                    waveformsMeanMergeClus1Clus2=mean(waveformsMergeClus1Clus2);

                    indicesClus3= find(assignedLabelsKmeansidx_new==idClusKeep);
                    featVectClus3=featVect_new(indicesClus3,:);
                    waveformsClus3=waveforms_new(indicesClus3,:);
                    waveformsMeanClus3=mean(waveformsClus3);

                    %----claculate eDist
                    eDistMerge1Clus1_2_3=calcEuclideanDistMeanWaveforms(waveformsMeanMergeClus1Clus2,waveformsMeanClus3);

                    if eDistMerge1Clus1_2_3 <= thresholdDist
                        assignedLabelsKmeansidx_new=ones(numel(assignedLabelsKmeansidx),1);
                        waveforms_new=waveformsSpike;
                        featVect_new=featVectClusMethodSpikes;
                    elseif eDistMerge1Clus1_2_3 > thresholdDist
                        sizeMergeClus1_2=size(waveformsMergeClus1Clus2);
                        numberExamplesMergeClus1_2=sizeMergeClus1_2(1);
                        idMinimalDistClusters=sort(minimalDistClusters);
                        idSelectedMergedClus=idMinimalDistClusters(1);
                        relabeledWaveformsMergeClus1_2=idSelectedMergedClus.*ones(numberExamplesMergeClus1_2,1);

                        sizeClus3=size(waveformsClus3);
                        numberExamplesClus3=sizeClus3(1);
                        relabeledWaveformsClus3=idClusKeep.*ones(numberExamplesClus3,1);

                        waveforms_new=[waveformsMergeClus1Clus2;waveformsClus3];
                        featVect_new=[featVectClusMergeClus1Clus2;featVectClus3];
                        assignedLabelsKmeansidx_new=[relabeledWaveformsMergeClus1_2;relabeledWaveformsClus3];

                    end










                end



            end




    end
end