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

xLength = 200; 
filenames = {humanfiles, naiveFiles, confederateFiles};
caption = {'Humans', 'FC naive', 'FC confederate-trained'};
entropyDescriptor = {'Partner''s current choice', 'Partner''s history', 'Own history', 'Side'};
nSet = length(filenames);   
nCoordinated = cell(1, nSet);
balance = cell(1, nSet);
comparisonPtotal = cell(1, nSet);
strategy = cell(nSet, max(cellfun(@length, filenames)));
nStateVisit = cell(nSet, max(cellfun(@length, filenames)));
comparisonPvalue = cell(nSet, max(cellfun(@length, filenames)));
for iSet = 1:nSet
    nFile = length(filenames{iSet});          
    nCoordinated{iSet} = zeros(nFile, 1);
    balance{iSet}  = zeros(nFile, 1);
    comparisonPtotal{iSet}  = zeros(2, nFile);

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
        r1 = 1 + sum(isOwnChoice(1,index)) + nCoordinated{iSet}(iFile); 
        r2 = 1 + sum(isOwnChoice(2,index)) + nCoordinated{iSet}(iFile); 
        balance{iSet}(iFile) = min(r1,r2)/(r1+r2);
        comparisonPvalue{iSet, iFile} = zeros(2,3);

        [~, strategy{iSet, iFile}, ~, nStateVisit{iSet, iFile}] = estimate_strategy(isOwnChoice(:,index), isBottomChoice(:,index), [PerTrialStruct.A_InitialTargetReleaseRT(index)'; PerTrialStruct.B_InitialTargetReleaseRT(index)'], 50);
        nOwnChoice = strategy{iSet, iFile}.*nStateVisit{iSet, iFile};
        nOwnChoice(isnan(nOwnChoice)) = 0;
        for iPlayer = 1:2
            for iPos = 1:3
                [h,p, chi2stat,df] = prop_test(nOwnChoice(iPlayer, iPos:4:iPos+4), nStateVisit{iSet, iFile}(iPlayer, iPos:4:iPos+4), true);
                comparisonPvalue{iSet, iFile}(iPlayer,iPos) = p; 
            end
            [h,p, chi2stat,df] = prop_test([sum(nOwnChoice(iPlayer, 1:4)), sum(nOwnChoice(iPlayer, 5:8))], [sum(nStateVisit{iSet, iFile}(iPlayer, 1:4)), sum(nStateVisit{iSet, iFile}(iPlayer, 5:8))], true);
            comparisonPtotal{iSet}(iPlayer, iFile) = p; 

        end    
        
    end
end

iSet = 3;
figure('Name', caption{iSet});
set( axes,'fontsize', FontSize, 'FontName', fontType); 

for iFile = 1:nFile
    subplot(2, 3, iFile);
    bar(strategy{iSet, iFile}');
    set( gca, 'fontsize', FontSize, 'FontName', fontType, 'xTick', 1:nFile, 'xTickLabel', {'II','IA','AI','AA','II','IA','AI','AA','II','IA','AI','AA'});
    %if (iEntropy == 1)
    %    lHandle = legend('Player 1', 'Player 2', 'location', 'North', 'orientation', 'horizontal');
    %    set(lHandle, 'fontsize', FontSize, 'FontName',fontType);
    %end
    %title(entropyDescriptor{iEntropy}, 'fontsize', FontSize, 'FontName', fontType);
    axis([0.5, nFile+0.5, 0, 1])
end

