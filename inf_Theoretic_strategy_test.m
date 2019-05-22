LineWidth = 2;
FontSize = 12;
fontType = 'Arial';

plotColor = [0.9290, 0.6940, 0.1250; ...
             0.4940, 0.1840, 0.5560];
if ispc
    %folder = 'Y:\SCP_DATA\ANALYSES\PC1000\2019\CoordinationCheck';
    folder = 'Y:\SCP_DATA\ANALYSES\hms-beagle2\2019\CoordinationCheck';
else
    folder = fullfile('/', 'Volumes', 'social_neuroscience_data', 'taskcontroller', 'SCP_DATA', 'ANALYSES', 'PC1000', '2018', 'CoordinationCheck');
end

%%
xLength = 200;
nEntropy = 4; 

nRun = 10000;
memoryLength = 2;
entropyRandomValue = zeros(nEntropy, nRun);
isAvail = ones(1, xLength);
for iRun = 1:nRun
    x = randi(2, 1, xLength);
    y = randi(2, 1, xLength);
    z = randi(2, 1, xLength);  
    instantTransfer = calc_conditional_instant_transfer(x, y, z, memoryLength, xLength);
    entropyRandomValue(1, iRun) = instantTransfer(1);
    
    transferEntropy = calc_conditional_transfer_entropy(x, y, z, memoryLength, xLength);
    entropyRandomValue(2, iRun) = transferEntropy(1);

    condMI = calc_conditional_mi_with_past(x, z, memoryLength, xLength);
    entropyRandomValue(3, iRun) = condMI(1);
    
    mi = calc_mutual_information(x, z, xLength);
    entropyRandomValue(4, iRun) = mi(1);   
end
figure
histogram(entropyRandomValue(3,:));
%y = quantile(transferFull,[0.50 0.75 0.90, 0.95])
level05 = zeros(1,nEntropy);
for iEntropy = 1:nEntropy
    level05(iEntropy) = quantile(entropyRandomValue(iEntropy,:), 0.95);
end

%% t-test for RT

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


naiveFiles = {...
    'DATA_20171019T132932.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20171020T124628.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat', ...    
    'DATA_20171027T145027.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20171031T124333.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20171101T123413.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20171102T102500.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20171103T143324.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat'};



confederateFiles = {...
    'DATA_20180418T143951.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20180419T141311.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20180424T121937.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20180425T133936.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20180426T171117.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20180427T142541.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat'...
    };

filenames = {humanfiles, naiveFiles, confederateFiles};
caption = {'Humans', 'FC naive', 'FC confederate-trained'};
entropyDescriptor = {'Partner''s current choice', 'Partner''s history', 'Own history', 'Side'};
nSet = length(filenames);   
entropyValue = cell(2, nSet);
nCoordinated = cell(1, nSet);

for iSet = 1:nSet
    nFile = length(filenames{iSet});          
    entropyValue{1, iSet} = zeros(nEntropy, nFile);
    entropyValue{2, iSet} = zeros(nEntropy, nFile);
    nCoordinated{iSet} = zeros(nFile, 1);

    for iFile = 1:nFile
        load([folder '\' filenames{iSet}{iFile}]);
        if (iSet == 1)
            index = max(1,length(isOwnChoice)-xLength+1):length(isOwnChoice);
        else
            index = 21:length(isOwnChoice);
        end    
        acquistionTimeDiff = PerTrialStruct.A_TargetAcquisitionRT(index)' - PerTrialStruct.B_TargetAcquisitionRT(index)'; 
        initFixTimeDiff = PerTrialStruct.A_InitialTargetReleaseRT(index)' - PerTrialStruct.B_InitialTargetReleaseRT(index)';         
        
        %index = 1:length(isOwnChoice);
        indexCoordinated = xor(isOwnChoice(1,index),isOwnChoice(2,index));        
        nCoordinated{iSet}(iFile) = nnz(indexCoordinated);
               
        x = isOwnChoice(1,index);
        y = isOwnChoice(2,index);
        orient = xor(isOwnChoice(1,index), isBottomChoice(1,index));
        isAvailable = abs(initFixTimeDiff) > 50;
        
        instantTransfer = calc_conditional_instant_transfer(x, y, orient, memoryLength, xLength);
        entropyValue{1, iSet}(1, iFile) = instantTransfer(1);
        instantTransfer = calc_conditional_instant_transfer(y, x, orient, memoryLength, xLength);
        entropyValue{2, iSet}(1, iFile) = instantTransfer(1);
    
        transferEntropy = calc_conditional_transfer_entropy(x, y, orient, memoryLength, xLength);
        entropyValue{1, iSet}(2, iFile) = transferEntropy(1);
        transferEntropy = calc_conditional_transfer_entropy(y, x, orient, memoryLength, xLength);
        entropyValue{2, iSet}(2, iFile) = transferEntropy(1);

        condMI = calc_conditional_mi_with_past(x, orient, memoryLength, xLength);
        entropyValue{1, iSet}(3, iFile) = condMI(1);
        condMI = calc_conditional_mi_with_past(y, orient, memoryLength, xLength);
        entropyValue{2, iSet}(3, iFile) = condMI(1);
    
        mi = calc_mutual_information(x, orient, xLength);
        entropyValue{1, iSet}(4, iFile) = mi(1);    
        mi = calc_mutual_information(y, orient, xLength);
        entropyValue{2, iSet}(4, iFile) = mi(1);         
    end
    
    figure('Name', caption{iSet});
    set( axes,'fontsize', FontSize, 'FontName', fontType); 
    for iEntropy = 1:nEntropy
        subplot(2, 2, iEntropy);
        hold on
        bar([entropyValue{1, iSet}(iEntropy, :); entropyValue{2, iSet}(iEntropy, :)]');        
        plot([0.5, nFile+0.5], [level05(iEntropy), level05(iEntropy)], 'k--', 'linewidth', LineWidth);
        hold off
        set( gca, 'fontsize', FontSize, 'FontName', fontType, 'xTick', 1:nFile);
        if (iEntropy == 1)
            lHandle = legend('Player 1', 'Player 2', 'location', 'North', 'orientation', 'horizontal');
            set(lHandle, 'fontsize', FontSize, 'FontName',fontType);
        end
        title(entropyDescriptor{iEntropy}, 'fontsize', FontSize, 'FontName', fontType);
        axis([0.5, nFile+0.5, 0, 1])
    end
end

figure;
set( axes,'fontsize', FontSize, 'FontName', fontType); 

for iSet = 1:nSet
    nFile = length(filenames{iSet}); 
    for iPlayer = 1:2
        subplot(2, nSet, nSet*(iPlayer-1) + iSet);
        bar(entropyValue{iPlayer, iSet}','stacked');
        set( gca, 'fontsize', FontSize, 'FontName', fontType, 'xTick', 1:nFile);
        if (iSet == 3) && (iPlayer == 1)
            lHandle = legend(entropyDescriptor, 'location', 'North');
            set(lHandle, 'fontsize', FontSize, 'FontName',fontType);
        end
        %
        title(caption{iSet}, 'fontsize', FontSize, 'FontName', fontType);
        if (iSet == 1)
            xlabel( ' pair ', 'fontsize', FontSize, 'FontName', fontType);
        else
            xlabel( ' session ', 'fontsize', FontSize, 'FontName', fontType);
        end
        axis([0.5, nFile+0.5, 0, 1])
    end
end  


%%

%% generate strategies
nRun = 500;
nTrial = 200;


% own-own, own-other, other-own, other-other
% we encode own as 0 and ther as 1 for simple mapping with our theoretical
% strategies
strategyNames = {'TT1', 'LongTT', 'Challeging', 'Challeging LF', 'LF', 'Insistor-Follower', 'human LF-WSLS', 'human LF-TT'}; 
nStrategy = length(strategyNames);
pError = 0.02;
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

nSeeIndex = 3;
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

meanEntropyValue = cell(1, nSeeIndex);
stdEntropyValue = cell(1, nSeeIndex);
for iSeeIndex = 1:nSeeIndex
    meanEntropyValue{iSeeIndex} = zeros(4, nStrategy);
    stdEntropyValue{iSeeIndex} = zeros(4, nStrategy);
end    
entropyValueArtif = zeros(4, 2*nRun);
for iSeeIndex = 1:nSeeIndex
    for iStrategy = 1:2%nStrategy
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
            
            x = isOwnChoice(1,:);
            y = isOwnChoice(2,:);
            orient = randi(2, 1, nTrial) - 1;
                    
            instantTransfer = calc_conditional_instant_transfer(x, y, orient, memoryLength, xLength);
            entropyValueArtif(1, iRun) = instantTransfer(1);
            instantTransfer = calc_conditional_instant_transfer(y, x, orient, memoryLength, xLength);
            entropyValueArtif(1, iRun + nRun) = instantTransfer(1);

            transferEntropy = calc_conditional_transfer_entropy(x, y, orient, memoryLength, xLength);
            entropyValueArtif(2, iRun) = transferEntropy(1);
            transferEntropy = calc_conditional_transfer_entropy(y, x, orient, memoryLength, xLength);
            entropyValueArtif(2, iRun + nRun) = transferEntropy(1);

            condMI = calc_conditional_mi_with_past(x, orient, memoryLength, xLength);
            entropyValueArtif(3, iRun) = condMI(1);
            condMI = calc_conditional_mi_with_past(y, orient, memoryLength, xLength);
            entropyValueArtif(3, iRun + nRun) = condMI(1);

            mi = calc_mutual_information(x, orient, xLength);
            entropyValueArtif(4, iRun) = mi(1);    
            mi = calc_mutual_information(y, orient, xLength);
            entropyValueArtif(4, iRun + nRun) = mi(1);         
        end
        meanEntropyValue{iSeeIndex}(:,iStrategy) = mean(entropyValueArtif, 2);
        stdEntropyValue{iSeeIndex}(:,iStrategy) = std(entropyValueArtif, 0, 2);
    end       
end