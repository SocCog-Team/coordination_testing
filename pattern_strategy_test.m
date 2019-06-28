%function pattern_strategy_test()
LineWidth = 2;
FontSize = 12;
fontType = 'Arial';

plotColor = [0.9290, 0.6940, 0.1250; ...
             0.4940, 0.1840, 0.5560];
if ispc
    %folder = 'Y:\SCP_DATA\ANALYSES\PC1000\2019\CoordinationCheck';
    %folder = 'Y:\SCP_DATA\ANALYSES\hms-beagle2\2019\CoordinationCheck';
    folder = 'C:\Documents\CoordinationCheck';

else
    folder = fullfile('/', 'Volumes', 'social_neuroscience_data', 'taskcontroller', 'SCP_DATA', 'ANALYSES', 'PC1000', '2018', 'CoordinationCheck');
end

%% generate strategies
nRun = 500;
nTrial = 200;
nPattern = nTrial - 1;

nState = 4;
transposedIndices = [1:4:13,2:4:14,3:4:15,4:4:16];

% own-own, own-other, other-own, other-other
% we encode own as 0 and ther as 1 for simple mapping with our theoretical
% strategies
strategyNames = {'TT1', 'LongTT', 'Challeging', 'Challeging LF', 'LF', 'Insistor-Follower', 'human LF-WSLS', 'human LF-TT'}; 
nStrategy = length(strategyNames);
pError = 0.01;
strategyType = cell(nStrategy, 1);
strategyType{1} = [5/8,pError,1-pError,5/8; ...
                   5/8,pError,1-pError,5/8]; % both period-1 turn-taking
strategyType{2} = [5/8,1-pError,pError,5/8; ...
                   5/8,1-pError,pError,5/8]; %both  long turn-taking
strategyType{3} = [1-pError,1-pError,0.1,1-pError; ...
                   1-pError,1-pError,0.1,1-pError]; %both challenging
strategyType{4} = [1-pError,1-pError,0.5,1-pError;
                   1-pError,1-pError,0.5,1-pError]; %challenging L-F
strategyType{5} = [1-pError,1-pError,1-pError,1-pError; ...
                   1-pError,1-pError,1-pError,1-pError]; %both LF
strategyType{6} = [1-pError,1-pError,1-pError,1-pError;
                   1/4,1-pError,0.1,1-pError]; %1 insist (LF), 2 rarely challenges
strategyType{7} = [0.5,5/8,3/8,0.5;
                   0.5,5/8,3/8,0.5]; %random players with slight tendency to WSLS
strategyType{8} = [0.5,3/8,5/8,0.5;
                   0.5,3/8,5/8,0.5]; %random players with slight tendency to TT
INSIST_FOLLOW = 6;               

nSeeIndex = 6;
%nSeeIndex = 21;
pSeeValues = cell(2,1);
pSeeValues{1} = repmat(0.0:(0.5/(nSeeIndex-1)):0.5, nStrategy, 1);
pSeeValues{2} = repmat(0.0:(0.5/(nSeeIndex-1)):0.5, nStrategy, 1);
% strategy 6 is stubbrn insisting ignoring the partner
pSeeValues{1}(6,:) = 0; 
pSeeValues{2}(6,:) = 0;
% strategies 7-8 is unidirectional LF
pSeeValues{1}(7,:) = 0.0:(1/(nSeeIndex-1)):1; 
pSeeValues{1}(8,:) = 0.0:(1/(nSeeIndex-1)):1; 
pSeeValues{2}(7:8,:) = 0;

jointPatternDistribution = cell(1,nSeeIndex);
simplifiedFeatures = cell(1,nSeeIndex);
pcaCoeff = cell(1,nSeeIndex);
pcaScore = cell(1,nSeeIndex);
pcaLatent = cell(1,nSeeIndex);

for iSeeIndex = 1:nSeeIndex
    jointPatternDistribution{iSeeIndex} = zeros(2*nStrategy*nRun, nState^2);
    iTotalRun = 1;
    for iStrategy = 1:nStrategy
        strategy = strategyType{iStrategy};
        for iRun = 1:nRun
            if (iStrategy == INSIST_FOLLOW)
                % variable probabilities to insist
                strategy(2,3) = (1/4)*rand(1);
            end    
            isOwnChoice = zeros(2, nTrial);
            state = zeros(1,2);
            choiceRand = rand(nTrial, 2);
            seePartnerRand = rand(nTrial, 1);
            isP1See = (seePartnerRand < pSeeValues{1}(iStrategy, iSeeIndex));
            isP2See = (seePartnerRand > 1 - pSeeValues{2}(iStrategy, iSeeIndex));  
            for iTrial = 1:nTrial
                prSelectOther = 1 - [strategy(1, state(1)+1), strategy(2, state(2)+1)];                    
                isSelectedOther = choiceRand(iTrial, :) < prSelectOther;
                if (isP1See(iTrial))
                    if (choiceRand(iTrial, 1) > pError) %unless error - P1 follows P2
                        isSelectedOther(1) = 1 - isSelectedOther(2);
                    else
                        isSelectedOther(1) = isSelectedOther(2);
                    end    
                elseif (isP2See(iTrial))
                    if (choiceRand(iTrial, 2) > pError) %unless error - P2 follows P1
                        isSelectedOther(2) = 1 - isSelectedOther(1);
                    else
                        isSelectedOther(2) = isSelectedOther(1);
                    end
                end                
                isOwnChoice(:,iTrial) = 1 - isSelectedOther;    
                state = 2*isSelectedOther + isSelectedOther(2:-1:1);
            end

            pattern2 = isOwnChoice(:,1:nPattern) + 2*isOwnChoice(:,2:nPattern+1);
            jointPattern = pattern2(1,:) + nState*pattern2(2,:);        
            jointPatternDistribution{iSeeIndex}(iTotalRun, :) = histcounts(jointPattern,0:16, 'normalization','probability');        
            strategyClassification(iTotalRun) = iStrategy;
            iTotalRun = iTotalRun + 1;        
        end
    end   
    jointPatternDistribution{iSeeIndex}(nStrategy*nRun+1:end, :) = jointPatternDistribution{iSeeIndex}(1:nStrategy*nRun, transposedIndices);    
    
%    nSimpleFeatures = 6;
    nSimpleFeatures = 5;
    simplifiedFeatures{iSeeIndex} = zeros(2*nStrategy*nRun, nSimpleFeatures);
    simplifiedFeatures{iSeeIndex}(:, 1) = jointPatternDistribution{iSeeIndex}(:, 7) + jointPatternDistribution{iSeeIndex}(:, 10);
    simplifiedFeatures{iSeeIndex}(:, 2) = jointPatternDistribution{iSeeIndex}(:, 4) + jointPatternDistribution{iSeeIndex}(:, 13);   
    simplifiedFeatures{iSeeIndex}(:, 3) = abs(jointPatternDistribution{iSeeIndex}(:, 4) - jointPatternDistribution{iSeeIndex}(:, 13));
    simplifiedFeatures{iSeeIndex}(:, 4) = jointPatternDistribution{iSeeIndex}(:, 14) + jointPatternDistribution{iSeeIndex}(:, 15) + ...
                                          jointPatternDistribution{iSeeIndex}(:, 8)  + jointPatternDistribution{iSeeIndex}(:, 12);   
    simplifiedFeatures{iSeeIndex}(:, 5) = jointPatternDistribution{iSeeIndex}(:, 16);
%    simplifiedFeatures{iSeeIndex}(:, 6) = jointPatternDistribution{iSeeIndex}(:, 1) + jointPatternDistribution{iSeeIndex}(:, 2) + ...
%                                                jointPatternDistribution{iSeeIndex}(:, 3) + jointPatternDistribution{iSeeIndex}(:, 5) + ...
%                                                jointPatternDistribution{iSeeIndex}(:, 6) + jointPatternDistribution{iSeeIndex}(:, 9) + ...
%                                                jointPatternDistribution{iSeeIndex}(:, 11);

end


%% check behavioural strategies
humanfiles = {'DATA_20171115T165545.A_20013.B_10014.SCP_01.triallog.A.20013.B.10014_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20171116T164137.A_20015.B_10016.SCP_01.triallog.A.20015.B.10016_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20171121T165717.A_10018.B_20017.SCP_01.triallog.A.10018.B.20017_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20171123T165158.A_20019.B_10020.SCP_01.triallog.A.20019.B.10020_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20171127T164730.A_20021.B_20022.SCP_01.triallog.A.20021.B.20022_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20171128T165159.A_20024.B_10023.SCP_01.triallog.A.20024.B.10023_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20171130T145412.A_20025.B_20026.SCP_01.triallog.A.20025.B.20026_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20171130T164300.A_20027.B_10028.SCP_01.triallog.A.20027.B.10028_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20171205T163542.A_20029.B_10030.SCP_01.triallog.A.20029.B.10030_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20181030T155123.A_181030ID0061S1.B_181030ID0062S1.SCP_01.triallog.A.181030ID0061S1.B.181030ID0062S1_IC_JointTrials.isOwnChoice_sideChoice.mat',...
    'DATA_20181031T135826.A_181031ID63S1.B_181031ID64S1.SCP_01.triallog.A.181031ID63S1.B.181031ID64S1_IC_JointTrials.isOwnChoice_sideChoice.mat',...
    'DATA_20181031T170224.A_181031ID65S1.B_181031ID66S1.SCP_01.triallog.A.181031ID65S1.B.181031ID66S1_IC_JointTrials.isOwnChoice_sideChoice.mat',...
    'DATA_20181101T133927.A_181101ID67S1.B_181101ID68S1.SCP_01.triallog.A.181101ID67S1.B.181101ID68S1_IC_JointTrials.isOwnChoice_sideChoice.mat',...
    'DATA_20181102T131833.A_181102ID69S1.B_181102ID70S1.SCP_01.triallog.A.181102ID69S1.B.181102ID70S1_IC_JointTrials.isOwnChoice_sideChoice.mat',...
    'DATA_20190416T115438.A_190416ID103S1.B_190416ID104S1.SCP_01.triallog.A.190416ID103S1.B.190416ID104S1_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20190417T115027.A_190417ID105S1.B_190417ID106S1.SCP_01.triallog.A.190417ID105S1.B.190417ID106S1_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20190418T172245.A_190418ID107S1.B_190418ID108S1.SCP_01.triallog.A.190418ID107S1.B.190418ID108S1_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20190419T120024.A_190419ID109S1.B_190419ID110S1.SCP_01.triallog.A.190419ID109S1.B.190419ID110S1_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20190419T163215.A_190419ID111S1.B_190419ID112S1.SCP_01.triallog.A.190419ID111S1.B.190419ID112S1_IC_JointTrials.isOwnChoice_sideChoice.mat'};                

% 9: 20-28  
naiveFiles = {... 
           'DATA_20181211T134136.A_Curius.B_Linus.SCP_01.triallog.A.Curius.B.Linus_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
           'DATA_20180524T103704.A_Tesla.B_Elmo.SCP_01.triallog.A.Tesla.B.Elmo_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
           'DATA_20180509T122330.A_Tesla.B_Flaffus.SCP_01.triallog.A.Tesla.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
           'DATA_20180530T153325.A_Tesla.B_Curius.SCP_01.triallog.A.Tesla.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
           'DATA_20180615T111344.A_Curius.B_Elmo.SCP_01.triallog.A.Curius.B.Elmo_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
           'DATA_20180214T171119.A_Magnus.B_Curius.SCP_01.triallog.A.Magnus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
           'DATA_20171103T143324.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
           'DATA_20180125T155742.A_Magnus.B_Flaffus.SCP_01.triallog.A.Magnus.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
           'DATA_20181120T083354.A_Linus.B_Elmo.SCP_01.triallog.A.Linus.B.Elmo_IC_JointTrials.isOwnChoice_sideChoice.mat'};            

%    'DATA_20171019T132932.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
%    'DATA_20171020T124628.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat', ...    
%    'DATA_20171027T145027.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
%    'DATA_20171031T124333.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
%    'DATA_20171101T123413.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
%    'DATA_20171102T102500.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
%    'DATA_20171103T143324.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat'};

%8: 29:36 
SMCuriusFiles = {...
    'DATA_20171206T141710.A_SM.B_Curius.SCP_01.triallog.A.SM.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20171208T140548.A_SM.B_Curius.SCP_01.triallog.A.SM.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20171211T110911.A_SM.B_Curius.SCP_01.triallog.A.SM.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20171212T104819.A_SM.B_Curius.SCP_01.triallog.A.SM.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20180111T130920.A_SM.B_Curius.SCP_01.triallog.A.SM.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20180112T103626.A_SM.B_Curius.SCP_01.triallog.A.SM.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20180118T120304.A_SM.B_Curius.SCP_01.triallog.A.SM.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20180423T162330.A_SM.B_Curius.SCP_01.triallog.A.SM.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat'};

%15: 37-51
SMFlaffusFiles = {...
    'DATA_20180131T155005.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20180201T162341.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20180202T144348.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20180205T122214.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20180209T145624.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20180213T133932.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20180214T141456.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20180215T131327.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20180216T140913.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20180220T133215.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20180221T133419.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20180222T121106.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20180223T143339.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20180227T151756.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20180228T132647.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice.mat'};


%15: 52-57
confederateFiles = {...
    'DATA_20180418T143951.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20180419T141311.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20180424T121937.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20180425T133936.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20180426T171117.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20180427T142541.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat'...
    };



filenames = {humanfiles, naiveFiles, SMCuriusFiles, SMFlaffusFiles, confederateFiles};
%caption = {'Humans', 'FC naive', 'FC confederate-trained'};
caption = {'Humans', 'Macaques', 'C conf. training', 'F conf. training', 'FC confederate-trained'};
entropyDescriptor = {'Partner''s current choice', 'Partner''s history', 'Own history', 'Side'};
nSet = length(filenames);   
xLength = 200; 

nFileTotal = 0;
indexOfRealSet = cell(1, nSet);
for iSet = 1:nSet
    indexOfRealSet{iSet} = (nFileTotal+1):(nFileTotal + length(filenames{iSet})); 
    nFileTotal = nFileTotal + length(filenames{iSet});
end
jointPatternDistributionInData = zeros(nFileTotal, 16);
iFileTotal = 1;

for iSet = 1:nSet
    nFile = length(filenames{iSet});  
    nPlotHor = ceil(sqrt(nFile));
    nPlotVert = ceil(nFile/nPlotHor);
    %nPlotHor = ceil(nFile/2);
    %nPlotVert = 5;
    figure('Name', caption{iSet});
    set( axes,'fontsize', FontSize, 'FontName', fontType);    
    for iFile = 1:nFile
        load([folder '\' filenames{iSet}{iFile}]);
        if (iSet == 1)
            index = max(1,length(isOwnChoice)-xLength+1):length(isOwnChoice);
        else
            index = 21:length(isOwnChoice);
        end    
        acquistionTimeDiff = PerTrialStruct.A_TargetAcquisitionRT(index)' - PerTrialStruct.B_TargetAcquisitionRT(index)'; 
        initFixTimeDiff = PerTrialStruct.A_InitialTargetReleaseRT(index)' - PerTrialStruct.B_InitialTargetReleaseRT(index)'; 
        
        % for computing who is faster ignore the first trial, since it is
        % only relevant for the past
        firstFasterIndex = (initFixTimeDiff(2:end) < -100);
        secondFasterIndex = (initFixTimeDiff(2:end) >= 100);
        
        x = isOwnChoice(1,index);
        y = isOwnChoice(2,index);
        orient = xor(isOwnChoice(1,index), isBottomChoice(1,index));
        
        nPattern = length(index)-1;
        x2pattern = x(1:nPattern) + 2*x(2:nPattern+1);
        y2pattern = y(1:nPattern) + 2*y(2:nPattern+1);  
        
        jointPattern = x2pattern + 4*y2pattern;
        
        jointPatternDistributionInData(iFileTotal, :) = histcounts(jointPattern,0:16, 'normalization','probability');
        iFileTotal = iFileTotal + 1;
        

        if (iFile > nPlotHor)
            iPlot = 2*nPlotHor + iFile;
        else
            iPlot = iFile;
        end    
        
        subplot(nPlotVert, nPlotHor, iFile);
        h = histogram2(x2pattern,y2pattern,0:4, 0:4, 'DisplayStyle','tile','normalization','probability','ShowEmptyBins','on');
        set( gca, 'fontsize', FontSize, 'FontName', fontType, 'XTick', 0.5:3.5, 'XTickLabel', {'BB','BR','RB','RR'}, 'YTick', 0.5:3.5, 'YTickLabel', {'RR','RB','BR','BB'});
        title([caption{iSet} ' ' num2str(iFile)], 'fontsize', FontSize, 'FontName', fontType);
        
%{
        subplot(nPlotVert, nPlotHor, iPlot);
        h = histogram2(x2pattern(firstFasterIndex),y2pattern(firstFasterIndex),0:4, 0:4, 'DisplayStyle','tile','normalization','probability','ShowEmptyBins','on');
        set( gca, 'fontsize', FontSize, 'FontName', fontType, 'XTick', 0.5:3.5, 'XTickLabel', {'BB','BR','RB','RR'}, 'YTick', 0.5:3.5, 'YTickLabel', {'RR','RB','BR','BB'});
        title([caption{iSet} ' ' num2str(iFile) ', 1st faster (' num2str(sum(firstFasterIndex)) ')'], 'fontsize', FontSize-4, 'FontName', fontType);
        
        subplot(nPlotVert, nPlotHor, iPlot + nPlotHor);
        h = histogram2(x2pattern(secondFasterIndex),y2pattern(secondFasterIndex),0:4, 0:4, 'DisplayStyle','tile','normalization','probability','ShowEmptyBins','on');
        set( gca, 'fontsize', FontSize, 'FontName', fontType, 'XTick', 0.5:3.5, 'XTickLabel', {'BB','BR','RB','RR'}, 'YTick', 0.5:3.5, 'YTickLabel', {'RR','RB','BR','BB'});
        title([caption{iSet} ' ' num2str(iFile) ', 2nd faster (' num2str(sum(secondFasterIndex)) ')'], 'fontsize', FontSize-4, 'FontName', fontType);
%}
    end    
end

simplifiedFeaturesInData = zeros(nFileTotal, nSimpleFeatures);
simplifiedFeaturesInData(:, 1) = jointPatternDistributionInData(:, 7) + jointPatternDistributionInData(:, 10);
simplifiedFeaturesInData(:, 2) = jointPatternDistributionInData(:, 4) + jointPatternDistributionInData(:, 13);   
simplifiedFeaturesInData(:, 3) = abs(jointPatternDistributionInData(:, 4) - jointPatternDistributionInData(:, 13));
simplifiedFeaturesInData(:, 4) = jointPatternDistributionInData(:, 14) + jointPatternDistributionInData(:, 15) + ...
                                 jointPatternDistributionInData(:, 8)  + jointPatternDistributionInData(:, 12);   
simplifiedFeaturesInData(:, 5) = jointPatternDistributionInData(:, 16);
%simplifiedFeaturesInData(:, 6) = jointPatternDistributionInData(:, 1) + jointPatternDistributionInData(:, 2) + ...
%                                 jointPatternDistributionInData(:, 3) + jointPatternDistributionInData(:, 5) + ...
%                                 jointPatternDistributionInData(:, 6) + jointPatternDistributionInData(:, 9) + ...
%                                 jointPatternDistributionInData(:, 11);

iFileTotal = 1;
for iSet = 1:nSet
    figure('Name', caption{iSet});
    set( axes,'fontsize', FontSize, 'FontName', fontType);    
    for iFile = 1:nFile
        iFileTotal = iFileTotal + 1;
        

        if (iFile > nPlotHor)
            iPlot = 2*nPlotHor + iFile;
        else
            iPlot = iFile;
        end    
        
        subplot(nPlotVert, nPlotHor, iFile);
        h = histogram2(x2pattern,y2pattern,0:4, 0:4, 'DisplayStyle','tile','normalization','probability','ShowEmptyBins','on');
        set( gca, 'fontsize', FontSize, 'FontName', fontType, 'XTick', 0.5:3.5, 'XTickLabel', {'BB','BR','RB','RR'}, 'YTick', 0.5:3.5, 'YTickLabel', {'RR','RB','BR','BB'});
        title([caption{iSet} ' ' num2str(iFile)], 'fontsize', FontSize, 'FontName', fontType);        
    end    
    
    
end


%% pca and clustering
nCluster = 6;
agglRes = cell(1,nSeeIndex);
%agglResFull = cell(1,nSeeIndex);
%emRes = cell(1,nSeeIndex);
%emParam = cell(1,nSeeIndex);
clusterCenter = cell(1,nSeeIndex);
mergedPatterns = cell(1,nSeeIndex);
for iSeeIndex = 1:nSeeIndex 
    %mergedPatterns{iSeeIndex} = [jointPatternDistribution{iSeeIndex}; jointPatternDistributionInData];    
    mergedPatterns{iSeeIndex} = [simplifiedFeatures{iSeeIndex}; simplifiedFeaturesInData];    
    [pcaCoeff{iSeeIndex},pcaScore{iSeeIndex},pcaLatent{iSeeIndex}] = pca(mergedPatterns{iSeeIndex});
    %kmeanRes = kmeans(jointPatternDistribution{iSeeIndex},7);     
    %agglResFull{iSeeIndex} = clusterdata(mergedPatterns,'Maxclust',nCluster, 'linkage', 'average'); 
    %agglRes{iSeeIndex} = clusterdata(jointPatternDistribution{iSeeIndex},'Maxclust',nCluster, 'linkage', 'single'); 
    agglRes{iSeeIndex} = clusterdata(simplifiedFeatures{iSeeIndex},'Maxclust',nCluster, 'linkage', 'single'); 
    %clusterCenter{iSeeIndex} = zeros(nCluster, nState^2);
    clusterCenter{iSeeIndex} = zeros(nCluster, nSimpleFeatures);
    for iCluster = 1:nCluster 
        clusterIndex = (agglRes{iSeeIndex} == iCluster);
        %clusterCenter{iSeeIndex}(iCluster, :) = mean(jointPatternDistribution{iSeeIndex}(clusterIndex,:), 1);    
        clusterCenter{iSeeIndex}(iCluster, :) = mean(simplifiedFeatures{iSeeIndex}(clusterIndex,:), 1);    
    end
    
   % % run EM clustering
   % dataForEM = [mergedPatterns randi(nCluster, length(mergedPatterns), 1)];
   % paramForEM = make_initial_guess();   % make some initial guess
   % [emOutput, emParam{iSeeIndex}] = EM(dataForEM, paramForEM);   
   % emRes{iSeeIndex} = emOutput(:,end);
end

indexSimulated = 1:2*nStrategy*nRun;
%clusterResult = cell(1,nSet);
for iSet = 1:nSet
     indexOfRealSet{iSet} = indexOfRealSet{iSet} + 2*nStrategy*nRun;
%     clusterResult{iSet} = zeros(length(indexOfRealSet{iSet}), nSeeIndex);
%     for iSeeIndex = 1:nSeeIndex 
%        clusterResult{iSet}(:, iSeeIndex) = agglRes{iSeeIndex}(indexOfRealSet{iSet});
%     end   
end

strategyClassification = zeros(2*nStrategy*nRun, 1);
for iStrategy = 1:nStrategy
    strategyClassification((iStrategy-1)*nRun+1:iStrategy*nRun) = iStrategy;
end
strategyClassification(nStrategy*nRun+1:end) = strategyClassification(1:nStrategy*nRun);
strategyClassification(strategyClassification == nStrategy) = nStrategy - 1;

%%
distanceToCluster = zeros(nFileTotal, nSeeIndex);
closestCluster = zeros(nFileTotal, nSeeIndex);

distanceToClusterElement = cell(1,nSeeIndex);
membershipProb  = cell(1,nSeeIndex);
closestDistance = zeros(nFileTotal, nSeeIndex);
closestClusterElement = zeros(nFileTotal, nSeeIndex);
sigma = 0.3;
for iSeeIndex = 1:nSeeIndex    
    %distanceMatrix = pdist2(jointPatternDistributionInData, clusterCenter{iSeeIndex});
    distanceMatrix = pdist2(simplifiedFeaturesInData, clusterCenter{iSeeIndex});
    [distanceToCluster(:, iSeeIndex), closestCluster(:, iSeeIndex)] = min(distanceMatrix,[], 2);
   
    distanceToClusterElement{iSeeIndex} = zeros(nFileTotal, nCluster);
    for iCluster = 1:nCluster 
        clusterIndex = (agglRes{iSeeIndex} == iCluster);
        %distanceMatrix = pdist2(jointPatternDistributionInData, jointPatternDistribution{iSeeIndex}(clusterIndex,:));
        distanceMatrix = pdist2(simplifiedFeaturesInData, simplifiedFeatures{iSeeIndex}(clusterIndex,:));
        distanceToClusterElement{iSeeIndex}(:, iCluster) = min(distanceMatrix,[], 2);

    end
    [closestDistance(:, iSeeIndex), closestClusterElement(:, iSeeIndex)] = min(distanceToClusterElement{iSeeIndex}, [], 2);
    expDist = exp(-distanceToClusterElement{iSeeIndex}/sigma^2);
    for iSession = 1:nFileTotal
        membershipProb{iSeeIndex}(iSession, :) = expDist(iSession, :)./sum(expDist(iSession, :));
    end
end

distanceToStrategy = cell(1,nSeeIndex);
strategyProb  = cell(1,nSeeIndex);
distanceToClosestStrategy = zeros(nFileTotal, nSeeIndex);
closestStrategy = zeros(nFileTotal, nSeeIndex);
averageInStrategyDistance = zeros(nSeeIndex, nStrategy-1);
for iSeeIndex = 1:nSeeIndex    
    % distanceMatrix = pdist2(jointPatternDistributionInData, clusterCenter{iSeeIndex});
    distanceMatrix = pdist2(simplifiedFeaturesInData, clusterCenter{iSeeIndex});
    [distanceToCluster(:, iSeeIndex), closestCluster(:, iSeeIndex)] = min(distanceMatrix,[], 2);
   
    distanceToClusterElement{iSeeIndex} = zeros(nFileTotal, nCluster);
    for iStrategy = 1:nStrategy - 1
        if (iStrategy < nStrategy-1)
            strategyIndex = (strategyClassification == iStrategy);
        else
            strategyIndex = (strategyClassification >= iStrategy);
        end    
        %distanceMatrix = pdist2(jointPatternDistributionInData, jointPatternDistribution{iSeeIndex}(strategyIndex,:));
        distanceMatrix = pdist2(simplifiedFeaturesInData, simplifiedFeatures{iSeeIndex}(strategyIndex,:));
        %distanceToStrategy{iSeeIndex}(:, iStrategy) = min(distanceMatrix,[], 2);
        distanceToStrategy{iSeeIndex}(:, iStrategy) = mean(distanceMatrix, 2);
        
        distanceMatrix = pdist2(simplifiedFeatures{iSeeIndex}(strategyIndex,:), simplifiedFeatures{iSeeIndex}(strategyIndex,:));
        averageInStrategyDistance(iSeeIndex, iStrategy) = mean(mean(distanceMatrix));
    end
    [distanceToClosestStrategy(:, iSeeIndex), closestStrategy(:, iSeeIndex)] = min(distanceToStrategy{iSeeIndex}, [], 2);
    expDist = exp(-distanceToStrategy{iSeeIndex}/sigma^2);
    for iSession = 1:nFileTotal
        strategyProb{iSeeIndex}(iSession, :) = expDist(iSession, :)./sum(expDist(iSession, :));
    end
end

% find for each real recording the best distance to cluster    
[~, closestPSeeIndex] = min(distanceToClosestStrategy, [], 2);

%{
% consider confederate trained monkeys separately
distanceConfederateTrained = zeros(1,nSeeIndex);
indexConfederateTrained = nFileTotal-5:nFileTotal;
for iSeeIndex = 1:nSeeIndex
    distanceConfederateTrained(iSeeIndex) = sum(min(distanceToStrategy{iSeeIndex}(indexConfederateTrained, :), [], 2).^2);
end
[~, closestPSeeIndexConfederateTrained] = min(distanceConfederateTrained); 
closestPSeeIndex(indexConfederateTrained) = closestPSeeIndexConfederateTrained;
%}

distanceForClosestPsee = zeros(nFileTotal, nStrategy - 1);
membershipForClosestPsee = zeros(nFileTotal, nStrategy - 1);
membershipValid = false(nFileTotal, 3);
improvementComparedToNonTransparent = zeros(nFileTotal, 1);
for iFileTotal = 1:nFileTotal
    iSeeIndex = closestPSeeIndex(iFileTotal);
    %distanceForClosestPsee(iFileTotal, :) = distanceToClusterElement{iSeeIndex}(iFileTotal, :);
    %membershipForClosestPsee(iFileTotal, :) = membershipProb{iSeeIndex}(iFileTotal, :);
    distanceForClosestPsee(iFileTotal, :) = distanceToStrategy{iSeeIndex}(iFileTotal, :);
    membershipForClosestPsee(iFileTotal, :) = strategyProb{iSeeIndex}(iFileTotal, :);   
    
    [nearestStrategyDist, nearestStrategyIndex] = min(distanceForClosestPsee(iFileTotal, :));
    if (nearestStrategyDist < 2.5*averageInStrategyDistance(iSeeIndex, nearestStrategyIndex))
        membershipValid(iFileTotal,1) = true;
    end    
    if (nearestStrategyDist < 2*averageInStrategyDistance(iSeeIndex, nearestStrategyIndex))
        membershipValid(iFileTotal,2) = true;
    end    
    if (nearestStrategyDist < averageInStrategyDistance(iSeeIndex, nearestStrategyIndex))
        membershipValid(iFileTotal,3) = true;
    end    
    improvementComparedToNonTransparent(iFileTotal) = nearestStrategyDist/min(distanceToStrategy{1}(iFileTotal, :));
end    
indexRelevantNaiveMonkey = [20,22,23,26,28];
indexTrainedMonkey = 52:57;
indexRelevantHuman = [1:3,6:9,12,13,17];
indexExcludedHuman = [4:5,10:11,14:16,18:19];

indexArray = {indexRelevantHuman,indexExcludedHuman,indexRelevantNaiveMonkey,indexTrainedMonkey};
nIndexSet = length(indexArray);
meanImprovement = zeros(1, nIndexSet);
stdImprovement = zeros(1, nIndexSet);
for iIndexSet = 1:nIndexSet
    meanImprovement(iIndexSet) = mean(improvementComparedToNonTransparent(indexArray{iIndexSet}));
    stdImprovement(iIndexSet) = std(improvementComparedToNonTransparent(indexArray{iIndexSet}));
end    
dataForBoxPlot = 1 - improvementComparedToNonTransparent([indexArray{:}]);

pSeeDataForScatterPlot = closestPSeeIndex(indexRelevantHuman);


%{

%}
%% plot simulated results only
xAxisName = {'Mutual stubborness', 'Fast vs. Slow switching', 'Fast vs. Slow switching', 'Fast vs. Slow switching', 'Fast vs. Slow switching', 'Fast vs. Slow switching'};
yAxisName = {'Fast vs. Slow switching', 'Switching vs. Challeging', 'Balance', 'Balance', 'Balance', 'Balance'};
zAxisName = {'Balance', 'Balance', 'Switching vs. Challeging', 'Switching vs. Challeging', 'Switching vs. Challeging', 'Switching vs. Challeging'};

for iSeeIndex = 1:nSeeIndex    
    figure
    set( axes,'fontsize', FontSize, 'FontName', fontType);   
    subplot(4, 7, [1:3,8:10]);
    hold on
    for iCluster = 1:nCluster
        clusterIndex = (agglRes{iSeeIndex} == iCluster);
        scatter3(pcaScore{iSeeIndex}(clusterIndex,1),pcaScore{iSeeIndex}(clusterIndex,2),pcaScore{iSeeIndex}(clusterIndex,3),'filled');
    end    
    hold off    
    xlabel(xAxisName{iSeeIndex}, 'fontsize', FontSize, 'FontName',fontType)
    ylabel(yAxisName{iSeeIndex}, 'fontsize', FontSize, 'FontName',fontType)
    zlabel(zAxisName{iSeeIndex}, 'fontsize', FontSize, 'FontName',fontType)
    legend('Cluster 1', 'Cluster 2', 'Cluster 3', 'Cluster 4', 'Cluster 5', 'Cluster 6')

      
    subplot(4, 7, [5:7,12:14]);
    hold on
    for iStrategy = 1:nStrategy
        strategyIndex = [(iStrategy-1)*nRun+1:(iStrategy*nRun), (nStrategy + iStrategy-1)*nRun+1:(nStrategy + iStrategy)*nRun];
        scatter3(pcaScore{iSeeIndex}(strategyIndex,1),pcaScore{iSeeIndex}(strategyIndex,2),pcaScore{iSeeIndex}(strategyIndex,3),'filled');        
    end    
    hold off    
    xlabel(xAxisName{iSeeIndex}, 'fontsize', FontSize, 'FontName',fontType)
    ylabel(yAxisName{iSeeIndex}, 'fontsize', FontSize, 'FontName',fontType)
    zlabel(zAxisName{iSeeIndex}, 'fontsize', FontSize, 'FontName',fontType)
    legend(strategyNames)
    
    
    
    for iCluster = 1:nCluster
        subplot(4, 7, 21 + iCluster);
        %image(64*reshape(clusterCenter{iSeeIndex}(iCluster, :),[4,4]))
        bar(clusterCenter{iSeeIndex}(iCluster, :))
        caxis([0 64])
        set( gca, 'fontsize', FontSize-2, 'YDir', 'normal', 'FontName', fontType, 'XTick', 1:74, 'XTickLabel', {'TT','11','22','1S','S2','12','O'});
        title(['Cluster ' num2str(iCluster)], 'fontsize', FontSize-2, 'FontName', fontType);
    end    
    subplot(4, 7, 28);
    caxis([0 64])
    colorbar
end

%% plot results with real data projected
xAxisName = {'Mutual stubborness', 'Fast vs. Slow switching', 'Fast vs. Slow switching', 'Fast vs. Slow switching', 'Fast vs. Slow switching', 'Fast vs. Slow switching'};
yAxisName = {'Fast vs. Slow switching', 'Switching vs. Challeging', 'Balance', 'Balance', 'Balance', 'Balance'};
zAxisName = {'Balance', 'Balance', 'Switching vs. Challeging', 'Switching vs. Challeging', 'Switching vs. Challeging', 'Switching vs. Challeging'};

for iSeeIndex = 1:nSeeIndex    
    figure
    set( axes,'fontsize', FontSize, 'FontName', fontType);   
    hold on
    scatter3(pcaScore{iSeeIndex}(indexSimulated,1),pcaScore{iSeeIndex}(indexSimulated,2),pcaScore{iSeeIndex}(indexSimulated,3));
    for iSet = 1:nSet
        scatter3(pcaScore{iSeeIndex}(indexOfRealSet{iSet},1),pcaScore{iSeeIndex}(indexOfRealSet{iSet},2),pcaScore{iSeeIndex}(indexOfRealSet{iSet},3),'filled');
    end
    hold off    
    xlabel(xAxisName{iSeeIndex}, 'fontsize', FontSize, 'FontName',fontType)
    ylabel(yAxisName{iSeeIndex}, 'fontsize', FontSize, 'FontName',fontType)
    zlabel(zAxisName{iSeeIndex}, 'fontsize', FontSize, 'FontName',fontType)
    legend('artificial', 'Humans', 'FC naive', 'FC confederate')
end

%% plot results with human data projected
xAxisName = {'Mutual stubborness', 'Fast vs. Slow switching', 'Fast vs. Slow switching', 'Fast vs. Slow switching', 'Fast vs. Slow switching', 'Fast vs. Slow switching'};
yAxisName = {'Fast vs. Slow switching', 'Switching vs. Challeging', 'Balance', 'Balance', 'Balance', 'Balance'};
zAxisName = {'Balance', 'Balance', 'Switching vs. Challeging', 'Switching vs. Challeging', 'Switching vs. Challeging', 'Switching vs. Challeging'};

for iSeeIndex = 1:nSeeIndex    
    figure
    set( axes,'fontsize', FontSize, 'FontName', fontType);   
    hold on
    scatter3(pcaScore{iSeeIndex}(indexSimulated,1),pcaScore{iSeeIndex}(indexSimulated,2),pcaScore{iSeeIndex}(indexSimulated,3));
    iSet = 1;
    for File = 1:7
        i = indexOfRealSet{iSet}(File);
        scatter3(pcaScore{iSeeIndex}(i,1),pcaScore{iSeeIndex}(i,2),pcaScore{iSeeIndex}(i,3),22,'filled');
    end
    for File = 8:14
        i = indexOfRealSet{iSet}(File);
        scatter3(pcaScore{iSeeIndex}(i,1),pcaScore{iSeeIndex}(i,2),pcaScore{iSeeIndex}(i,3),40,'filled');
    end
    hold off    
    xlabel(xAxisName{iSeeIndex}, 'fontsize', FontSize, 'FontName',fontType)
    ylabel(yAxisName{iSeeIndex}, 'fontsize', FontSize, 'FontName',fontType)
    zlabel(zAxisName{iSeeIndex}, 'fontsize', FontSize, 'FontName',fontType)
    legend('artificial', 'Human 1', 'Human 2','Human 3','Human 4','Human 5','Human 6','Human 7','Human 8','Human 9','Human 10','Human 11','Human 12','Human 13','Human 14')
end


%% pca all together
nCluster = 6;
agglRes = cell(1,nSeeIndex);
mergedAll = [];
for iSeeIndex = 1:nSeeIndex    
    mergedAll = [mergedAll; jointPatternDistribution{iSeeIndex}];
end        
mergedAll = [mergedAll; jointPatternDistributionInData];    
[~,pcaScoreAll,~] = pca(mergedAll);

nSimulated = 2*nStrategy*nRun;


%kmeanRes = kmeans(jointPatternDistribution{iSeeIndex},7);     
%agglResFull{iSeeIndex} = clusterdata(mergedPatterns,'Maxclust',nCluster, 'linkage', 'average'); 
%    agglRes{iSeeIndex} = clusterdata(jointPatternDistribution{iSeeIndex},'Maxclust',nCluster, 'linkage', 'single'); 
%    clusterCenter{iSeeIndex} = zeros(nCluster, nState^2);
%    for iCluster = 1:nCluster 
%        clusterIndex = (agglRes{iSeeIndex} == iCluster);
%        clusterCenter{iSeeIndex}(iCluster, :) = mean(jointPatternDistribution{iSeeIndex}(clusterIndex,:), 1);    
%    end
  
%%  
figure
while(1)
set( axes,'fontsize', FontSize, 'FontName', fontType);     
for iSeeIndex = 1:nSeeIndex 
    clf
    pcaScoreToPlot = pcaScoreAll((iSeeIndex-1)*nSimulated+1:iSeeIndex*nSimulated,:);
    hold on     
    for iStrategy = 1:nStrategy
        strategyIndex = [(iStrategy-1)*nRun+1:(iStrategy*nRun), (nStrategy + iStrategy-1)*nRun+1:(nStrategy + iStrategy)*nRun];
        scatter3(pcaScoreToPlot(strategyIndex,1),pcaScoreToPlot(strategyIndex,2),pcaScoreToPlot(strategyIndex,3),'filled');        
    end    
    hold off    
%    xlabel(xAxisName{iSeeIndex}, 'fontsize', FontSize, 'FontName',fontType)
%    ylabel(yAxisName{iSeeIndex}, 'fontsize', FontSize, 'FontName',fontType)
%    zlabel(zAxisName{iSeeIndex}, 'fontsize', FontSize, 'FontName',fontType)
    legend(strategyNames)
    title(['p_{see} = ' num2str((iSeeIndex-1)/(nSeeIndex-1))]);
    axis([-0.3, 0.45, -0.25, 1])
    pause(0.25);        
end
end
%end