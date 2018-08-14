%for iSet = 1:nSet
for iSet = 17:17
    disp(['****** ' num2str(iSet) ': ' dataset{iSet}.setName '********']);
    GLM = cell(2, nFile(iSet));
    for iFile = 1:nFile(iSet)
        nTrial = length(allRT{iSet, iFile});
        fistTestIndex = cfg.minStationarySegmentStart;
        testIndices = fistTestIndex:nTrial-30;
        nTestIndices = length(testIndices);
        
        x = allSideChoice{iSet, iFile};
        surprizeSide = zeros(2, nTrial);
        surprizeTarget = zeros(2, nTrial);
        surprizeSide(1,:) = calc_surprise(x(1,:), 5, cfg.minSampleNum);
        surprizeSide(2,:) = calc_surprise(x(2,:), 5, cfg.minSampleNum);
        x = allOwnChoice{iSet, iFile};
        surprizeTarget(1,:) = calc_surprise(x(1,:), 5, cfg.minSampleNum);
        surprizeTarget(2,:) = calc_surprise(x(2,:), 5, cfg.minSampleNum);
        
        
        %RT = allRT{iSet, iFile}(:,testIndices);
        %localTargetTE1{iSet, iFile}
        %localTargetTE2{iSet, iFile}
             
        figure;
        subplot(3,1,1)
        hold on;
            plot( localTargetTE1{iSet, iFile}, 'LineWidth', 2 );
            plot( localTargetTE2{iSet, iFile}, 'LineWidth', 1 );
        hold off
        subplot(3,1,2)
        hold on;
            plot( surprizeSide(1,:), 'LineWidth', 2 );
            plot( surprizeSide(2,:), 'LineWidth', 1 );
        hold off  
        subplot(3,1,3)
        hold on;
            plot( surprizeTarget(1,:), 'LineWidth', 2 );
            plot( surprizeTarget(2,:), 'LineWidth', 1 );
        hold off         
        
        te = [localTargetTE1{iSet, iFile}; localTargetTE2{iSet, iFile}];
        surprizeSide = log(1 + surprizeSide);
        surprizeTarget = log(1 + surprizeTarget);
        figure;
        for iPlayer = 1:2                        
            Y = allRT{iSet, iFile}(iPlayer,testIndices);
            Y = (Y - mean(Y))/std(Y);
            
            X = [allSideChoice{iSet, iFile}(iPlayer,testIndices); ...
                 allOwnChoice{iSet, iFile}(iPlayer,testIndices); ...
                 te(3-iPlayer,testIndices-1); ...
                 surprizeSide(:,testIndices-1);
                 surprizeTarget(:,testIndices-1);
                 surprizeSide(:,testIndices);
                 surprizeTarget(:,testIndices);
                 allRT{iSet, iFile}(3-iPlayer,testIndices)];
            X = bsxfun(@minus, X, mean(X, 2)); 
            X = bsxfun(@rdivide, X, std(X, 0, 2));

            % Poisson distribution
            %GLM1  = fitglm( X', Y', 'Distribution', 'poisson', 'Link', 'log' );  
            % normal distribution by default
            GLM{iPlayer,iFile}  = fitglm( X', Y');
            %disp(['Session' num2str(iFile) ', Player' num2str(iPlayer) ': ' num2str(GLM{iPlayer,iFile}.Dispersion) ', ' num2str(GLM{iPlayer,iFile}.Rsquared.Ordinary)]);
            
            estY = glmval( GLM{iPlayer,1}.Coefficients.Estimate, X', 'identity' );  
            subplot(2,1,iPlayer)
            hold on;
            plot( Y, 'LineWidth', 2 );
            plot( estY, 'LineWidth', 1 );        
            hold off;
            legend( 'Real RT', 'Gaussian GLM' );
            if (iPlayer == 1)
                r2value = 1 - sum((Y' - estY).^2)/sum((Y - mean(Y)).^2);
                disp(['Session' num2str(iFile) ', Player' num2str(iPlayer) ': ' num2str(r2value) '; Dispersion: ' num2str(GLM{iPlayer,iFile}.Dispersion)]);
            end
            
        end    
    end
end    

