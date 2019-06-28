LineWidth = 2;
fontSize = 12;
fontType = 'Arial';

plotColor = [0.9290, 0.6940, 0.1250; ...
             0.4940, 0.1840, 0.5560];
if ispc
    %folder = 'Y:\SCP_DATA\ANALYSES\PC1000\2019\CoordinationCheck';
    folder = 'Y:\SCP_DATA\ANALYSES\hms-beagle2\2019\CoordinationCheck';
else
    folder = fullfile('/', 'Volumes', 'social_neuroscience_data', 'taskcontroller', 'SCP_DATA', 'ANALYSES', 'PC1000', '2018', 'CoordinationCheck');
end


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

humanCaptions = cell(1, length(humanfiles));
for i = 1:length(humanfiles)
    humanCaptions{i} = ['Human pair ' num2str(i)];
end
    
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

       macaquesLateCaptions = { ...
           'CL', ...
           'TE', ...
           'TF', ...
           'TC', ...
           'CE', ...
           'MC', ...
           'FC', ...
           'MF', ...
           'LE', ...
           };
       

naiveFCFiles = {...
    'DATA_20171019T132932.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20171020T124628.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20171026T150942.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20171027T145027.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20171031T124333.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20171101T123413.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20171102T102500.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20171103T143324.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20171107T131228.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat'};

SMCuriusFiles = {...
    'DATA_20171206T141710.A_SM.B_Curius.SCP_01.triallog.A.SM.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20171208T140548.A_SM.B_Curius.SCP_01.triallog.A.SM.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20171211T110911.A_SM.B_Curius.SCP_01.triallog.A.SM.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20171212T104819.A_SM.B_Curius.SCP_01.triallog.A.SM.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20180111T130920.A_SM.B_Curius.SCP_01.triallog.A.SM.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20180112T103626.A_SM.B_Curius.SCP_01.triallog.A.SM.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20180118T120304.A_SM.B_Curius.SCP_01.triallog.A.SM.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20180423T162330.A_SM.B_Curius.SCP_01.triallog.A.SM.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat'};

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




confederateFiles = {...
    'DATA_20180418T143951.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20180419T141311.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20180424T121937.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20180425T133936.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20180426T171117.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20180427T142541.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat'...
    };
confederateCaptions = cell(1, length(confederateFiles));
for i = 1:length(confederateFiles)
    confederateCaptions{i} = ['FC conf. trained ' num2str(i)];
end


filenames = {humanfiles, naiveFiles, confederateFiles};
indexFilled = {[1:3,6:9,12,13,17], [], [2,5]};
indexUnfilled = {[4:5,10:11,14:16,18:19], 1:length(naiveFiles),[1,3,4,6]};
caption = {'Humans', 'Monkeys late', 'FC confederate-trained', 'FC naive', 'SM-Curius','SM-Flaffus'};
sessionTitle = {humanCaptions,macaquesLateCaptions,confederateCaptions};
nSet = length(filenames);   
xLength = 200; 

minDRT = 50;

setLength = cellfun(@length, filenames);
nFileTotal = sum(setLength);
maxFileNum = max(setLength);

nUncoordinted = cell(1, nSet);
nSeamlessSwitch = cell(1, nSet);
nChallengeResolving = cell(1, nSet);
nChallengeStart = cell(1, nSet);

twoTrialStateLabel = {'GG', 'RG', 'BG', 'MG', 'GR', 'RR', 'BR', 'MR', 'GB', 'RB', 'BB', 'MB', 'GM', 'RM', 'BM', 'MM'};

rtChange = cell(nSet, maxFileNum);
trialOutcomeWithHist = cell(nSet, maxFileNum);
        

for iSet = 1:nSet
    nFile = length(filenames{iSet}); 
    nUncoordinted{iSet} = zeros(nFile, 3);
    nSeamlessSwitch{iSet} = zeros(nFile, 5);
    nChallengeResolving{iSet} = zeros(nFile, 3);
    nChallengeStart{iSet}  = zeros(nFile, 3);
    
    disp(['Processing dataset' num2str(iSet)]);   
    for iFile = 1:nFile
        load([folder '\' filenames{iSet}{iFile}]);
        if (iSet ~= 3)
            index = max(2,length(isOwnChoice)-xLength+1):length(isOwnChoice);
        else
            index = 21:length(isOwnChoice);
            disp(length(isOwnChoice))
        end    
        nTestIndices = length(index);
        isPrevOwnChoice = isOwnChoice(:, index-1);
        isOwnChoice = isOwnChoice(:, index);
        sideChoice = isBottomChoice(:, index);
        trueIndices = TrialsInCurrentSetIdx(index);
        isPreceededByCorrectTrial = true(1, length(index));
        %isPreceededByCorrectTrial = ~(TrialsInCurrentSetIdx(index) - TrialsInCurrentSetIdx(index-1) - 1)';
        acquistionTime = [PerTrialStruct.A_TargetAcquisitionRT'; PerTrialStruct.B_TargetAcquisitionRT']; 
        initFixTime = [PerTrialStruct.A_InitialTargetReleaseRT'; PerTrialStruct.B_InitialTargetReleaseRT'];         
        midMotionTime = 0.5*(acquistionTime+initFixTime);
        
        acquistionTimeDiff = PerTrialStruct.A_TargetAcquisitionRT(index)' - PerTrialStruct.B_TargetAcquisitionRT(index)'; 
        initFixTimeDiff = PerTrialStruct.A_InitialTargetReleaseRT(index)' - PerTrialStruct.B_InitialTargetReleaseRT(index)';         
        midMotionTimeDiff = 0.5*(initFixTimeDiff + acquistionTimeDiff);
        midMotionTimeChange = diff(0.5*(acquistionTime+initFixTime),1,2);
        midMotionTimeChange = midMotionTimeChange(:, index-1);
        
        uncoordTrials = isOwnChoice(1,:) == isOwnChoice(2,:);
        nUncoordinted{iSet}(iFile, 1) = sum(uncoordTrials);
        nUncoordinted{iSet}(iFile, 2) = sum(isOwnChoice(1,uncoordTrials) == 1);
        nUncoordinted{iSet}(iFile, 3) = sum(isOwnChoice(1,uncoordTrials) == 0);
        nUncoordinted{iSet}(iFile,:) = 100*nUncoordinted{iSet}(iFile,:)/nTestIndices;
        
        seamlessSwitchTrials = (isOwnChoice(1,:) + isOwnChoice(2,:) == 1) & ...
                               (isPrevOwnChoice(1,:) + isPrevOwnChoice(2,:) == 1) & ...
                               (isOwnChoice(1,:) ~= isPrevOwnChoice(1,:)) & ...
                               (isPreceededByCorrectTrial);  

        nSeamlessSwitch{iSet}(iFile, 1) = sum(seamlessSwitchTrials);        

        selfishSwithTrials = (((isOwnChoice(1,seamlessSwitchTrials) == 1) & (midMotionTimeDiff(seamlessSwitchTrials) < -minDRT)) |...
                              ((isOwnChoice(2,seamlessSwitchTrials) == 1) & (midMotionTimeDiff(seamlessSwitchTrials) > minDRT)))  & ...
                               (isPreceededByCorrectTrial(seamlessSwitchTrials));
        benevolentSwithTrials = (((isOwnChoice(1,seamlessSwitchTrials) == 0) & (midMotionTimeDiff(seamlessSwitchTrials) < -minDRT)) |...
                                 ((isOwnChoice(2,seamlessSwitchTrials) == 0) & (midMotionTimeDiff(seamlessSwitchTrials) > minDRT))) & ...
                               (isPreceededByCorrectTrial(seamlessSwitchTrials));                          
        nSeamlessSwitch{iSet}(iFile, 2) = sum(selfishSwithTrials);
        nSeamlessSwitch{iSet}(iFile, 3) = sum(benevolentSwithTrials);

        unilateralUnforcedSelfishSwitch = (((isOwnChoice(1,:) == 1) & (isPrevOwnChoice(1,:) == 0) & (isPrevOwnChoice(2,:) == 1)& ...
                                            (midMotionTimeDiff < -minDRT)) |...
                                           ((isOwnChoice(2,:) == 1) & (isPrevOwnChoice(2,:) == 0) & (isPrevOwnChoice(1,:) == 1)& ...
                                            (midMotionTimeDiff > minDRT)))  & ...
                                           (isPreceededByCorrectTrial);  
        unilateralUnforcedBenevolentSwitch = (((isOwnChoice(1,:) == 0) & (isPrevOwnChoice(1,:) == 1) & (isPrevOwnChoice(2,:) == 0)& ...
                                               (midMotionTimeDiff < -minDRT)) |...
                                              ((isOwnChoice(2,:) == 0) & (isPrevOwnChoice(2,:) == 1) & (isPrevOwnChoice(1,:) == 0)& ...
                                               (midMotionTimeDiff > minDRT))) & ...
                                             (isPreceededByCorrectTrial);         
        nSeamlessSwitch{iSet}(iFile, 4) = sum(unilateralUnforcedSelfishSwitch);
        nSeamlessSwitch{iSet}(iFile, 5) = sum(unilateralUnforcedBenevolentSwitch);
        nSeamlessSwitch{iSet}(iFile,:) = 100*nSeamlessSwitch{iSet}(iFile,:)/nTestIndices;
        
        
        challengeResolvedTrials = (isPrevOwnChoice(1,:) == isPrevOwnChoice(2,:)) & (isOwnChoice(1,:) ~= isOwnChoice(2,:));
        nChallengeResolving{iSet}(iFile, 1) = sum(challengeResolvedTrials);
        challengeResolvedSelfish = (((isOwnChoice(1,challengeResolvedTrials) == 1) &  ...
                                     (midMotionTimeDiff(challengeResolvedTrials) < -minDRT)) |...
                                    ((isOwnChoice(2,challengeResolvedTrials) == 1) &  ...
                                     (midMotionTimeDiff(challengeResolvedTrials) > minDRT)));  
        challengeResolvedBenevolent = (((isOwnChoice(1,challengeResolvedTrials) == 0) &  ...
                                        (midMotionTimeDiff(challengeResolvedTrials) < -minDRT)) |...
                                       ((isOwnChoice(2,challengeResolvedTrials) == 0) &  ...
                                        (midMotionTimeDiff(challengeResolvedTrials) > minDRT)));            
        nChallengeResolving{iSet}(iFile, 2) = sum(challengeResolvedSelfish);
        nChallengeResolving{iSet}(iFile, 3) = sum(challengeResolvedBenevolent);
        nChallengeResolving{iSet}(iFile,:) = 100*nChallengeResolving{iSet}(iFile,:)/nTestIndices;            

        
        challengeStartTrials = (isPrevOwnChoice(1,:) ~= isPrevOwnChoice(2,:)) & (isOwnChoice(1,:) == isOwnChoice(2,:));
        nChallengeStart{iSet}(iFile, 1) = sum(challengeStartTrials);
        challengeStartSelfish = (((isOwnChoice(1,challengeStartTrials) == 1) &  ...
                                  (midMotionTimeDiff(challengeStartTrials) < -minDRT)) |...
                                 ((isOwnChoice(2,challengeStartTrials) == 1) &  ...
                                  (midMotionTimeDiff(challengeStartTrials) > minDRT)));  
        challengeStartBenevolent = (((isOwnChoice(1,challengeStartTrials) == 0) &  ...
                                     (midMotionTimeDiff(challengeStartTrials) < -minDRT)) |...
                                    ((isOwnChoice(2,challengeStartTrials) == 0) &  ...
                                     (midMotionTimeDiff(challengeStartTrials) > minDRT)));            
        nChallengeStart{iSet}(iFile, 2) = sum(challengeStartSelfish);
        nChallengeStart{iSet}(iFile, 3) = sum(challengeStartBenevolent);
        nChallengeStart{iSet}(iFile,:) = 100*nChallengeStart{iSet}(iFile,:)/nTestIndices;            
        
%{
       
        g = 1 + isPrevOwnChoice(1,:) + 2*isPrevOwnChoice(2,:) + 4*isOwnChoice(1,:) + 8*isOwnChoice(2,:);
        labelIndex = unique(g(isPreceededByCorrectTrial));
        figure('name', sessionTitle{iSet}{iFile}); 
        subplot(2,2, 1);
        boxplot(midMotionTimeDiff(isPreceededByCorrectTrial), g(isPreceededByCorrectTrial));
        title('RT_A - RT_B')
        set(gca, 'fontsize', fontSize, 'FontName', fontType, 'XTickLabel', twoTrialStateLabel(labelIndex))
        axis([0.5,length(labelIndex)+0.5,-250,250])

        subplot(2,2, 3);
        boxplot(midMotionTimeChange(1,isPreceededByCorrectTrial), g(isPreceededByCorrectTrial));
        title('RT change for Player A')
        set(gca, 'fontsize', fontSize, 'FontName', fontType, 'XTickLabel', twoTrialStateLabel(labelIndex))
        axis([0.5,length(labelIndex)+0.5,-250,250])
        
        subplot(2,2, 4);
        boxplot(midMotionTimeChange(2,isPreceededByCorrectTrial), g(isPreceededByCorrectTrial));
        title('RT change for Player B')
        set(gca, 'fontsize', fontSize, 'FontName', fontType, 'XTickLabel', twoTrialStateLabel(labelIndex))
        axis([0.5,length(labelIndex)+0.5,-250,250])
        
        rtChange{iSet, iFile} = midMotionTimeChange(:,isPreceededByCorrectTrial);
        trialOutcomeWithHist{iSet, iFile} = g(isPreceededByCorrectTrial);
 %}       
        figure('name', sessionTitle{iSet}{iFile}); 
        g = 1 + isOwnChoice(1,:) + 2*isOwnChoice(2,:);
        color = [0,1,0;1,0,0;0,0,1;1,0,1];
        hold on
        for iReward = 1:4
            index = g == iReward;
            scatter(midMotionTime(1,index), midMotionTime(2,index), 36, color(iReward,:), 'filled');
            scatter(mean(midMotionTime(1,index)), mean(midMotionTime(2,index)), 150, color(iReward,:), 'd');            
        end
        hold off
%{
        set( gcf, 'PaperUnits','centimeters' );
        xSize = 16; ySize = 24;
        xLeft = 0; yTop = 0;
        set( gcf,'PaperPosition', [ xLeft yTop xSize ySize ] );
        print ( '-depsc', '-r600','MutualInformationScatterPlot');
        print('-dpdf', 'FC_RT_for_conditions', '-r600');
%}
    end
end

%%
for iSet = 1:nSet;
nFile = length(filenames{iSet}); 

allFCrtChanges = [];
allFCtrialOutcome = [];

nTrialOutcome = length(twoTrialStateLabel);
medianByFile = {zeros(nTrialOutcome, nFile), zeros(nTrialOutcome, nFile)};
for iFile = 1:nFile    
    allFCrtChanges = [allFCrtChanges, rtChange{iSet, iFile}];
    allFCtrialOutcome = [allFCtrialOutcome, trialOutcomeWithHist{iSet, iFile}];
    for ix = 1:nTrialOutcome
        index = trialOutcomeWithHist{iSet, iFile} == ix;
        for iPlayer = 1:2
            medianByFile{iPlayer}(ix, iFile) = median(rtChange{iSet, iFile}(iPlayer,index), 2);        
        end    
    end    
end


medianTotal = zeros(nTrialOutcome, 2);
for ix = 1:nTrialOutcome
    indAll = allFCtrialOutcome == ix;
    medianTotal(ix, :) = median(allFCrtChanges(:,indAll), 2);        
end

yMax = max(max(max(medianByFile{1}, medianByFile{2}))); 
yMin = min(min(min(medianByFile{1}, medianByFile{2}))); 

figure
for iPlayer = 1:2
    for iPlot = 1:2
        subplot(2,2,iPlayer+(iPlot-1)*2)
        if (iPlot == 1)
            indexOfInterest = [8, 12, 14, 15, 7, 10];  
            markerSize = 12;
        else    
            indexOfInterest = 1:nTrialOutcome;
            markerSize = 8;
        end    
        nIndexOfInterest = length(indexOfInterest);
        hold on
        plot([0.5, nIndexOfInterest+0.5], [0, 0], 'k--', 'Linewidth', 1);
        for ix = 1:nIndexOfInterest
        	plot(repmat(ix, 1, nFile), medianByFile{iPlayer}(indexOfInterest(ix), :), 'ro', 'markersize', markerSize);
            plot([ix-0.4, ix+0.4], [medianTotal(indexOfInterest(ix), iPlayer), medianTotal(indexOfInterest(ix), iPlayer)], 'b-', 'Linewidth', 2);
        end
        hold off
        title(['Player ' num2str(iPlayer)])
        set(gca, 'fontsize', fontSize, 'FontName', fontType, 'XTick', 1:nIndexOfInterest, 'XTickLabel', twoTrialStateLabel(indexOfInterest))
        axis([0.5,nIndexOfInterest+0.5,yMin,yMax])  
    end    
end    
end
%%
coeff = 5;
maxN = 100;
confThreshold = 1:maxN;
%confThreshold = zeros(1,maxN);
dlt = 1;
alpha = 0.05;
for n = 1:maxN
    while dlt <= n
        [h,p,stats] = fishertest(coeff*[n+dlt, n-dlt;n,n], 'Tail','right');
        if (p < alpha)
            confThreshold(n) = dlt;
            break;
        end
        dlt = dlt + 1;
    end    
end  
xConfCurve = (1:maxN) - confThreshold;
yConfCurve = (1:maxN) + confThreshold;

figure
hold on
plot(1:100, 1:100, 'r');
plot(xConfCurve, yConfCurve, 'b--');
plot(yConfCurve, xConfCurve, 'b--');
axis([1,100,1,100])


%%
fontSize = 8;
fontType = 'Arial';
sz = 32;
selectedColorList = [ 70, 102, 126; 
                     108,  91,  97; 
                     136,  88, 150]/255;
setMarker = {'s', 'o', 'd'};

logTicks = [0.5, 1, 3, 10, 30, 100];
logLabels = {'0', '1', '3', '10', '30', '100'};

figure; 
set( axes,'fontsize', fontSize,  'FontName', fontType);
for iPlot = 1:4
    subplot(2,2,iPlot);
%for i = 1:6
%    subplot(2,3,i);
%    iPlot = i;
%    if (iPlot > 3)
%        iPlot = iPlot - 3;
%    end    
    yLabel = 'benevolent switches (per 100 trials)';
    xLabel = 'selfish switches (per 100 trials)';
    hold on
    for iSet = 1:nSet 
        if (iPlot == 1)
            data = nUncoordinted{iSet}(:, 2:3);
            name = 'Uncoordinated trials';
            yLabel = 'other-other (per 100 trials)';
            xLabel = 'own-own (per 100 trials)';
        elseif (iPlot == 3)
            data = nChallengeResolving{iSet}(:, 2:3);
            name = 'Challenge resolvings';
            yLabel = 'faster selects other (per 100 trials)';
            xLabel = 'faster selects own (per 100 trials)';   
        elseif (iPlot == 2)
            data = nSeamlessSwitch{iSet}(:, 2:3);
            %name = 'Unforced unilateral switches';
            name = 'Seamless switches';
            yLabel = 'faster selects other (per 100 trials)';
            xLabel = 'faster selects own (per 100 trials)'; 
        elseif (iPlot == 4)
            data = nChallengeStart{iSet}(:, 2:3);
            %name = 'Unforced unilateral switches';
            name = 'Challenge initiation';
            yLabel = 'faster selects other (per 100 trials)';
            xLabel = 'faster selects own (per 100 trials)';             
        end

        data = data + 0.5;% - 0.2*rand(length(data), 2);
        %contrast = (data(:, 1)-data(:, 2))./(data(:, 1)+data(:, 2));
        %dataToPlot = horzcat(data(:, 1) + data(:, 2), contrast);
        dataToPlot = data;    
            
        scatter(dataToPlot(indexUnfilled{iSet},1), dataToPlot(indexUnfilled{iSet}, 2), sz, selectedColorList(iSet, :), setMarker{iSet});        
        scatter(dataToPlot(indexFilled{iSet},1), dataToPlot(indexFilled{iSet}, 2), sz, selectedColorList(iSet, :), setMarker{iSet}, 'filled');
%{
        errBar = cell(1,2);
        if (iSet == 1)
            meanValue = mean(dataToPlot(indexUnfilled{iSet},:)); 
            stdValue = std(dataToPlot(indexUnfilled{iSet},:));
            stdValueL = min(2*stdValue, meanValue-0.5);
            stdValueU = 2*stdValue;
            plot([meanValue(1)-stdValueL(1), meanValue(1)+stdValueU(1)], [meanValue(2),meanValue(2)], 'Color', selectedColorList(iSet, :));
            errBar = errorbar(meanValue(1), meanValue(2),stdValueL(2), stdValueU(2));
            errBar.Marker = setMarker{iSet};
            errBar.Color = selectedColorList(iSet, :);
            errBar.MarkerSize = sz/3;
            errBar.MarkerEdgeColor = selectedColorList(iSet, :);
            errBar.MarkerFaceColor = [1,1,1];

            meanValue = mean(dataToPlot(indexFilled{iSet},:)); 
            stdValue = std(dataToPlot(indexFilled{iSet},:));
            stdValueL = min(2*stdValue, meanValue-0.5);
            stdValueU = 2*stdValue;
            %scatter(meanValue(1), meanValue(2), 1.5*sz, [0,0,1], setMarker{iSet}, 'filled');        
            %errBar{1} = herrorbar(meanValue(1), meanValue(2),stdValue(1));
            plot([meanValue(1)-stdValueL(1), meanValue(1)+stdValueU(1)], [meanValue(2),meanValue(2)], 'Color', selectedColorList(iSet, :));
            errBar = errorbar(meanValue(1), meanValue(2),stdValueL(2), stdValueU(2));
            errBar.Marker = setMarker{iSet};
            errBar.Color = selectedColorList(iSet, :);
            errBar.MarkerSize = sz/3;
            errBar.MarkerEdgeColor = [1,0,0];
            errBar.MarkerFaceColor = selectedColorList(iSet, :);
        else
            meanValue = mean(dataToPlot); 
            stdValue = std(dataToPlot); 
            stdValueL = min(2*stdValue, meanValue-0.5);
            stdValueU = 2*stdValue;
            plot([meanValue(1)-stdValueL(1), meanValue(1)+stdValueU(1)], [meanValue(2),meanValue(2)], 'Color', selectedColorList(iSet, :));
            errBar = errorbar(meanValue(1), meanValue(2),stdValueL(2), stdValueU(2));
            errBar.Marker = setMarker{iSet};
            errBar.Color = selectedColorList(iSet, :);
            errBar.MarkerSize = sz/3;
            errBar.MarkerEdgeColor = [1,0,0];
            errBar.MarkerFaceColor = selectedColorList(iSet, :);
        end    
%}        
    end 
    plot([0.1,100], [0.1,100], 'k--')   
    xConfCurve(xConfCurve < 0.1) = 0.1;
    plot(xConfCurve, yConfCurve, 'b--');
    plot(yConfCurve, xConfCurve, 'b--');
    hold off
    title(name);
    %axis([-0.1, 1.6, -0.1, 1.0]);
    xlabel(xLabel, 'fontsize', fontSize, 'FontName', fontType);
    ylabel(yLabel, 'fontsize', fontSize, 'FontName', fontType);
    set( gca, 'fontsize', fontSize, 'FontName', fontType);%'FontName', 'Times');
    %if (iPlot == 3)
    %    legendHandle = legend('humans coord', 'humans non-cooord', 'monkeys late', 'FC coord', 'FC non-cooord', 'location', 'eastoutside');
    %    set(legendHandle, 'fontsize', fontSize, 'FontName', fontType, 'Interpreter', 'latex');
    %end
    set(gca,'xscale','log','yscale','log','xTick', logTicks, 'xTickLabel', logLabels,'yTick', logTicks, 'yTickLabel', logLabels)
    %set(gca,'xscale','log')
    %axis([0.5, 101, 0.5, 51]);
    if (iPlot == 1) || (iPlot == 2)
        axis([0.5, 101, 0.5, 101]);
    else
        axis([0.5, 18, 0.5, 18]);
    end    
        
    %axis([0.5, 101, -1, 1]);
        
end

set( gcf, 'PaperUnits','centimeters' );
xSize = 16; ySize = 16;
xLeft = 0; yTop = 0;
set( gcf,'PaperPosition', [ xLeft yTop xSize ySize ] );
print ( '-depsc', '-r600','MutualInformationScatterPlot');
print('-dpdf', 'MutualInformationScatterPlot', '-r600');




%%
figure; 
set( axes,'fontsize', fontSize,  'FontName', fontType);
    yLabel = 'benevolent switches (per 100 trials)';
    xLabel = 'selfish switches (per 100 trials)';
    hold on
    for iSet = 1:nSet 
        data = [nChallengeResolving{iSet}(:, 2:3),nSeamlessSwitch{iSet}(:, 4:5)];
        %if (i <= 3)
        %    dataToPlot = data;
        %else
        data = data + 0.7 - 0.2*rand(length(data), 4);
        contrastX = (data(:, 2)-data(:, 1))./(data(:, 1)+data(:, 2));
        contrastY = (data(:, 4)-data(:, 3))./(data(:, 3)+data(:, 4));
    
            
        scatter(contrastX(indexUnfilled{iSet}), contrastY(indexUnfilled{iSet}), sz, selectedColorList(iSet, :), setMarker{iSet});        
        scatter(contrastX(indexFilled{iSet}), contrastY(indexFilled{iSet}), sz, selectedColorList(iSet, :), setMarker{iSet}, 'filled');
        
      
    end 
    
       
    
    
    %plot([0.1,100], [0.1,100], 'k--')
    hold off
    %axis([-0.1, 1.6, -0.1, 1.0]);
    xlabel(xLabel, 'fontsize', fontSize, 'FontName', fontType);
    ylabel(yLabel, 'fontsize', fontSize, 'FontName', fontType);
    set( gca, 'fontsize', fontSize, 'FontName', fontType);%'FontName', 'Times');
    %if (iPlot == 3)
    %    legendHandle = legend('humans coord', 'humans non-cooord', 'monkeys late', 'FC coord', 'FC non-cooord', 'location', 'eastoutside');
    %    set(legendHandle, 'fontsize', fontSize, 'FontName', fontType, 'Interpreter', 'latex');
    %end
    %set(gca,'xscale','log','yscale','log','xTick', logTicks, 'xTickLabel', logLabels,'yTick', logTicks, 'yTickLabel', logLabels)
    %set(gca,'xscale','log')
    %axis([0.5, 101, 0.5, 51]);
    axis([-1, 1, -1, 1]);


set( gcf, 'PaperUnits','centimeters' );
xSize = 20; ySize = 7;
xLeft = 0; yTop = 0;
set( gcf,'PaperPosition', [ xLeft yTop xSize ySize ] );
print ( '-depsc', '-r600','MutualInformationScatterPlot');
print('-dpdf', 'MutualInformationScatterPlot', '-r600');


%i = 0:200;
%p = 1/20; % robability to get to the 
%res = sum((i+1).*((1-p).^i))*p

%%
%}