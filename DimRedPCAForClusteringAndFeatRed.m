classdef  DimRedPCAForClusteringAndFeatRed
    properties
        featureVectorsPCAComp %featureVectorsPCAComp: is matrix with rows represents observations and columns 
                              %represents features
        %variabilityIntact   %VariabilityIntact: is the varibilty one want to intact.
    end
    
    methods
        function self = DimRedPCAForClusteringAndFeatRed(featureVectorsPCAComp)
            self.featureVectorsPCAComp=featureVectorsPCAComp;
        end
        function featureVectorsReduced=featureReductionForClusteringMethod(self,variabilityIntact)
            %VariabilityIntact: is the varibilty one want to intact.
            %De-mean (MATLAB will de-mean inside of PCA, but I want the de-meaned values later)
            featureVectorsPCACompDemeaned = self.featureVectorsPCAComp - mean(self.featureVectorsPCAComp);
%             featureVectorsPCACompDemeaned=normalize(self.featureVectorsPCAComp);

            % Do the PCA
            [coeff,score,latent,~,explained] = pca(featureVectorsPCACompDemeaned);
            % Calculate eigenvalues and eigenvectors of the covariance matrix
             covarianceMatrix = cov(featureVectorsPCACompDemeaned);
             [U,S,V] = svd(covarianceMatrix);
             
             sumOfAllPrinCs=sum(diag(S));
             
             diagSElements = diag(S);
             
             var=1;%the maximum amount of loss of variance
             k=1; %Intilizing the required amount of principal components
             variabilityIntact=1-variabilityIntact;
             
             while var >= variabilityIntact
                 sumOfSelectedPrinCs=sum(diagSElements(1:k));
                 var=1-sumOfSelectedPrinCs/sumOfAllPrinCs;
                 k=k+1;
             end
             featureVectorsReduced=score(:,1:k);
             
             %Ureduce =U(:,1:k); %selecting the 'k' eigen vectors,
             %which contain the amount of the variance you want to capture
             % %featureVectorsReduceCalculated=featureVectorsPCACompDemeaned*Ureduce;
            
        end
        function featureVectors2D=vis2D(self)
            %VariabilityIntact: is the varibilty one want to intact.
            %De-mean (MATLAB will de-mean inside of PCA, but I want the de-meaned values later)
            featureVectorsPCACompDemeaned = self.featureVectorsPCAComp - mean(self.featureVectorsPCAComp);
            % Do the PCA
            [coeff,score,latent,~,explained] = pca(featureVectorsPCACompDemeaned);
            featureVectors2D=score(:,1:2);
        end
        function featureVectors3D=vis3D(self)
            %VariabilityIntact: is the varibilty one want to intact.
            %De-mean (MATLAB will de-mean inside of PCA, but I want the de-meaned values later)
            featureVectorsPCACompDemeaned = self.featureVectorsPCAComp - mean(self.featureVectorsPCAComp);
            % Do the PCA
            [coeff,score,latent,~,explained] = pca(featureVectorsPCACompDemeaned);
            featureVectors3D=score(:,1:2);
        end
    end

end
% %featureVectorsPCAComp: is matrix with rows represents observations and columns
% %represents features
% %VariabilityIntact: is the varibilty one want to intact.
% 
% % % De-mean (MATLAB will de-mean inside of PCA, but I want the de-meaned values later)
% featureVectorsPCAComp = featureVectorsPCAComp - mean(featureVectorsPCAComp);
% 
% 
% % % Do the PCA
% [coeff,score,latent,~,explained] = pca(featureVectorsPCAComp);
% % 
% % % Calculate eigenvalues and eigenvectors of the covariance matrix
%  covarianceMatrix = cov(featureVectorsPCAComp);
%  [U,S,V] = svd(covarianceMatrix);
% 
% sumOfAllPrinCs=sum(diag(S));
% % 
% diagSElements = diag(S);
% var=1;%the maximum amount of loss of variance
% k=1; %Intilizing the required amount of principal components
% % 
% VariabilityIntact=1-VariabilityIntact;
%  while var >= VariabilityIntact
%     sumOfSelectedPrinCs=sum(diagSElements(1:k));
%     var=1-sumOfSelectedPrinCs/sumOfAllPrinCs;
%     k=k+1;
% end
% %Ureduce =U(:,1:k); %selecting the 'k' eigen vectors,
% %which contain the amount of the variance you want to capture
% featureVectorsReduced=score(:,1:k);
% 
% %featureVectorsReduceCalculated=featureVectorsPCAComp*Ureduce;
% end