LineWidth = 2;
FontSize = 12;
fontType = 'Arial';

plotColor = [0.9290, 0.6940, 0.1250; ...
             0.4940, 0.1840, 0.5560];
if ispc
    folder = 'Y:\SCP_DATA\ANALYSES\PC1000\2018\CoordinationCheck';
else
    folder = fullfile('/', 'Volumes', 'social_neuroscience_data', 'taskcontroller', 'SCP_DATA', 'ANALYSES', 'PC1000', '2018', 'CoordinationCheck');
end

%%
level05 = zeros(1,2);

xLength = 200;
nRun = 10000;
memeryLength = 2;
transfer2 = zeros(1, nRun);
transferFull = zeros(1, nRun);
isAvail = ones(1, xLength);
for iRun = 1:nRun
    x = randi(2, 1, xLength);
    y = randi(2, 1, xLength);
    z = randi(2, 1, xLength);
    instantTransfer = calc_instant_transfer(x, y, isAvail, memeryLength, xLength);
    transferEntropy = calc_transfer_entropy(x, y, memeryLength, xLength);
    transfer2(iRun) = instantTransfer(1);
    te2(iRun) = transferEntropy(1);
    
    instantTransfer = calc_conditional_instant_transfer(x, y, z, memeryLength, xLength);
    transferFull(iRun) = instantTransfer(1);
end
figure
histogram(transferFull);
y = quantile(transferFull,[0.50 0.75 0.90, 0.95])
level05(1,:) = quantile(transfer2,[0.90, 0.95]);
level05(2,:) = quantile(transferFull, [0.90, 0.95]);
level05te = quantile(te2, [0.90, 0.95]);

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
    'DATA_20181102T131833.A_181102ID69S1.B_181102ID70S1.SCP_01.triallog.A.181102ID69S1.B.181102ID70S1_IC_JointTrials.isOwnChoice_sideChoice.mat'};                

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
nSet = length(filenames);   
transferValue = cell(1, nSet);
nCoordinated = cell(1, nSet);

nPlot = 2;
figure;
set( axes,'fontsize', FontSize, 'FontName', fontType); 

for iSet = 1:nSet
    nFile = length(filenames{iSet});          
    

    hCoordVSzero = zeros(2, nFile);
    pCoordVSzero = 2*ones(2, nFile);
    ciCoordVSzeroA = zeros(2, nFile);
    statCoordVSzeroA = cell(1, nFile);
    ciCoordVSzeroI = zeros(2, nFile);
    statCoordVSzeroI = cell(1, nFile);

    hCoordVSnonc = zeros(2, nFile);
    pCoordVSnonc = 2*ones(2, nFile);
    ciCoordVSnoncA = zeros(2, nFile);
    statCoordVSnoncA = cell(1, nFile);
    ciCoordVSnoncI = zeros(2, nFile);
    statCoordVSnoncI = cell(1, nFile);

    hRedVSblue = zeros(2, nFile);
    pRedVSblue = 2*ones(2, nFile);
    ciRedVSblueA = zeros(2, nFile);
    statRedVSblueA = cell(1, nFile);
    ciRedVSblueI = zeros(2, nFile);
    statRedVSblueI = cell(1, nFile);


    pCoordVSzeroNew = 2*ones(2, nFile);

    transferValue{iSet} = zeros(nFile, nPlot);
    nCoordinated{iSet} = zeros(nFile, 1);


    for iFile = 1:nFile
        load([folder '\' filenames{iSet}{iFile}]);
        index = max(1,length(isOwnChoice)-199):length(isOwnChoice);
        %index = 1:length(isOwnChoice);
        indexCoordinated = xor(isOwnChoice(1,index),isOwnChoice(2,index));
        indexRed = and(isOwnChoice(1,index),indexCoordinated);
        indexBlue = and(isOwnChoice(2,index),indexCoordinated);
        indexUncoordinated = ~indexCoordinated;
        nCoordinated{iSet}(iFile) = nnz(indexCoordinated);

        acquistionTimeDiff = PerTrialStruct.A_TargetAcquisitionRT(index)' - PerTrialStruct.B_TargetAcquisitionRT(index)'; 
        initFixTimeDiff = PerTrialStruct.A_InitialTargetReleaseRT(index)' - PerTrialStruct.B_InitialTargetReleaseRT(index)'; 


        memoryLength = 2;
        x = isOwnChoice(1,index);
        y = isOwnChoice(2,index);
        isAvailable = abs(initFixTimeDiff) > 50;
        instantTransferToX = calc_instant_transfer(x, y, isAvailable, memoryLength, length(x));
        x = isBottomChoice(1,index);
        y = isBottomChoice(2,index);
        instantTransferSideToX = calc_instant_transfer(x, y, isAvailable, memoryLength, length(x));   
        transferValue{iSet}(iFile,1:2) = [instantTransferToX(1), instantTransferSideToX(1)];


        orient = xor(isOwnChoice(1,index), isBottomChoice(1,index));
        x = isOwnChoice(1,index);
        y = isOwnChoice(2,index);    
        instantTransferFull2 = calc_conditional_instant_transfer(x, y, orient, memoryLength, length(x));   
        transferValue{iSet}(iFile,3) = instantTransferFull2(1);

        calcToX = calc_instant_transfer(x, y, isAvailable, memoryLength, length(x));   
        transferValue{iSet}(iFile,1:2) = [instantTransferToX(1), instantTransferSideToX(1)];

        
        
        for iPlot = 2:nPlot
            %subplot(nPlot, nSet, 3*(iPlot-1)+ iSet);
            subplot(1, nSet, iSet);
            hold on
            if (iPlot == 1)
                bar(transferValue{iSet}(:,1:2));            
            else
                bar(transferValue{iSet}(:,3)); 
            end
            plot([0.5, nFile+0.5], [level05(iPlot,2), level05(iPlot,2)], 'k--', 'linewidth', LineWidth);                                                
            hold off
            set( gca, 'fontsize', FontSize, 'FontName', fontType, 'xTick', 1:nFile);
            if (iPlot == 1)
                lHandle = legend('Inf.transfer via target', 'Inf.transfer via side', 'location', 'North');  
            else
            %    lHandle = legend('Full information transfer', 'location', 'North');  
            end 
            %set(lHandle, 'fontsize', FontSize, 'FontName',fontType);
            title(caption{iSet}, 'fontsize', FontSize, 'FontName', fontType);
            if (iSet == 1)
                xlabel( ' pair ', 'fontsize', FontSize, 'FontName', fontType);
            end    
            axis([0.5, nFile+0.5, 0, 1])    
        end

        % find meanCoordRT as mean RT diff or (if mean RT diff) 
        % set it to -50/50 ms
        meanCoordRTA = mean(acquistionTimeDiff);    
        meanCoordRTI = mean(initFixTimeDiff);
        if (meanCoordRTA < -50)
            meanCoordRTA = -50;
        elseif (meanCoordRTA > 50)
            meanCoordRTA = 50;
        end 
        if (meanCoordRTI < -50)
            meanCoordRTI = -50;
        elseif (meanCoordRTI > 50)
            meanCoordRTI = 50;
        end

        % go further only if we actually have coordinated trials
        if (sum(indexCoordinated) <= 0)
            continue;
        end    
        % test reaction times distribution for being significantly > 0 
        % by comparing RT distribution with the nearest to mean number from [-50,50]
        [hCoordVSzero(1, iFile),pCoordVSzero(1,iFile),ciCoordVSzeroA(:,iFile),statCoordVSzeroA{iFile}] = ttest(acquistionTimeDiff(indexCoordinated), meanCoordRTA);
        [hCoordVSzero(2, iFile),pCoordVSzero(2,iFile),ciCoordVSzeroI(:,iFile),statCoordVSzeroI{iFile}] = ttest(initFixTimeDiff(indexCoordinated), meanCoordRTI);

        % test reaction times distribution for being significantly > 0 
        % by performing to one sided t-tests: against -50 (left side), and
        % against 50 (right side) 
        [~,pCoordVSzeroA(1,1),~, ~] = ttest(acquistionTimeDiff(indexCoordinated), 0.5, 'Tail', 'right');
        [~,pCoordVSzeroI(1,1),~, ~] = ttest(initFixTimeDiff(indexCoordinated), 0.5, 'Tail', 'right');
        [~,pCoordVSzeroA(2,1),~, ~] = ttest(acquistionTimeDiff(indexCoordinated), -0.5, 'Tail', 'left');
        [~,pCoordVSzeroI(2,1),~, ~] = ttest(initFixTimeDiff(indexCoordinated), -0.5, 'Tail', 'left');    
        pCoordVSzeroNew(:, iFile) = [min(pCoordVSzeroA), min(pCoordVSzeroI)] ;

        %figure('Name', ['Pair ' num2str(iFile)])
        %subplot(2,2,1)
        %histogram(acquistionTimeDiff(indexCoordinated))
        %title({'Target acquisition diff (deviations from mean within,', [' [-50,50] ms), coordinated trials. p = ' num2str(pCoordVSzero(1,iFile))]})
        %subplot(2,2,2)
        %histogram(initFixTimeDiff(indexCoordinated))
        %title({'Initial fixation diff (deviations from mean within', [' [-50,50] ms), coordinated trials. p = ' num2str(pCoordVSzero(2,iFile))]})

        % go further only if we actually have uncoordinated trials
        if (sum(indexUncoordinated) <= 0)
            continue;
        end     
        [hCoordVSnonc(1,iFile),pCoordVSnonc(1,iFile),ciCoordVSnoncA(:,iFile),statCoordVSnoncA{iFile}] = ttest2(acquistionTimeDiff(indexCoordinated), acquistionTimeDiff(indexUncoordinated));
        [hCoordVSnonc(2,iFile),pCoordVSnonc(2,iFile),ciCoordVSnoncI(:,iFile),statCoordVSnoncI{iFile}] = ttest2(initFixTimeDiff(indexCoordinated), initFixTimeDiff(indexUncoordinated));

        %subplot(2,2,3)
        %histogram(acquistionTimeDiff(indexUncoordinated))
        %title({'Target acquisition diff, uncoordinated trials', ['p = ' num2str(pCoordVSnonc(1,iFile))]})
        %subplot(2,2,4)
        %histogram(initFixTimeDiff(indexUncoordinated))
        %title({'Initial fixation diff, uncoordinated trials', ['p = ' num2str(pCoordVSnonc(2,iFile))]})

        if (sum(indexRed) <= 0) || (sum(indexBlue) <= 0)
            continue;
        end 

        % test for RT difference between jointly selected target of P1 
        % vs jointly selected target of P2
        [hRedVSblue(1,iFile),  pRedVSblue(1,iFile),  ciRedVSblueA(:,iFile),  statRedVSblueA{iFile}] = ttest2(acquistionTimeDiff(indexRed), acquistionTimeDiff(indexBlue));    
        [hRedVSblue(2,iFile),  pRedVSblue(2,iFile),  ciRedVSblueI(:,iFile),  statRedVSblueI{iFile}] = ttest2(initFixTimeDiff(indexRed), initFixTimeDiff(indexBlue));    
    end
end
