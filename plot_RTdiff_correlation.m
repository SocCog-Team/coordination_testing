function plot_RTdiff_correlation()
% function plots the composite figure demonstrating correlation of RT diff
% and Probability to select anti-preffered target
windowSize = 8;
ispc = 1;
         
if ispc
    folder = 'Z:\taskcontroller\SCP_DATA\ANALYSES\PC1000\2018\CoordinationCheck';
else
    folder = fullfile('/', 'Volumes', 'social_neuroscience_data', 'taskcontroller', 'SCP_DATA', 'ANALYSES', 'PC1000', '2018', 'CoordinationCheck');
end

% compute for humans
humanFilenames = {...
    'DATA_20171113T162815.A_20011.B_10012.SCP_01.triallog.A.20011.B.10012_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20171115T165545.A_20013.B_10014.SCP_01.triallog.A.20013.B.10014_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20171116T164137.A_20015.B_10016.SCP_01.triallog.A.20015.B.10016_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20171121T165717.A_10018.B_20017.SCP_01.triallog.A.10018.B.20017_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20171121T175909.A_10018.B_20017.SCP_01.triallog.A.10018.B.20017_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20171123T165158.A_20019.B_10020.SCP_01.triallog.A.20019.B.10020_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20171127T164730.A_20021.B_20022.SCP_01.triallog.A.20021.B.20022_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20171128T165159.A_20024.B_10023.SCP_01.triallog.A.20024.B.10023_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20171130T145412.A_20025.B_20026.SCP_01.triallog.A.20025.B.20026_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20171130T164300.A_20027.B_10028.SCP_01.triallog.A.20027.B.10028_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20171205T163542.A_20029.B_10030.SCP_01.triallog.A.20029.B.10030_IC_JointTrials.isOwnChoice_sideChoice', ...
    };
index = [1:4,4:10];
[pSee, probOtherChoice, ~, ~, ...
    corrCoefAveraged, corrPValueAveraged] = compute_prob_to_see_for_dataset(folder, humanFilenames, windowSize, index);
indexToShow = 3;
pSeeHuman = pSee{indexToShow};
pOtherChoiceHuman = probOtherChoice{indexToShow};
humanCorr = corrCoefAveraged;
humanCorrToShow = corrCoefAveraged(:,indexToShow);
humanPValueToShow = corrPValueAveraged(:,indexToShow);

% compute for Flaffus-Curius
flaffusCuriusNaiveFilenames = {...
    'DATA_20171019T132932.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20171020T124628.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20171026T150942.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20171027T145027.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20171031T124333.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20171101T123413.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20171102T102500.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20171103T143324.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20171107T131228.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    };
flaffusCuriusConfFilenames = {...
    'DATA_20180418T143951.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180419T141311.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180424T121937.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180425T133936.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180426T171117.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180427T142541.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice'
    };
[~, ~, ~,~, ...
    corrCoefAveragedNaive, corrPValueAveragedNaive] = compute_prob_to_see_for_dataset(folder, flaffusCuriusNaiveFilenames, windowSize);
[pSeeConf, pOtherChoiceConf, ~,~,...
    corrCoefAveragedConf, corrPValueAveragedConf] = compute_prob_to_see_for_dataset(folder, flaffusCuriusConfFilenames, windowSize);
indexToShow = 2;
pSeeFlaffusCuriusConf = pSeeConf{indexToShow};
pOtherChoiceFlaffusCuriusConf = pOtherChoiceConf{indexToShow};
corrCoefFlaffusCuriusConf = corrCoefAveragedConf(:,indexToShow);
corrPValueFlaffusCuriusConf = corrPValueAveragedConf(:,indexToShow);
%flaffusCuriusCorr = [corrCoefAveragedNaive, corrCoefAveragedConf];
nFlaffusCuriusNaive = length(corrCoefAveragedNaive);

allOwnChoice = [];
allInitialFixationTime = [];
nSession = 5;
sessionBorderFlaffusCuriusNaive = zeros(1, nSession);
iSession = 2; %index of the first session for which the border is computed (for the 1st it is 0)
for i = nFlaffusCuriusNaive-nSession+1:nFlaffusCuriusNaive
    fullname = [folder '\' flaffusCuriusNaiveFilenames{i} '.mat'];
    load(fullname);
    
    % copy the rest to the processing function
    %targetAcquisitionTime = [PerTrialStruct.A_TargetAcquisitionRT'; PerTrialStruct.B_TargetAcquisitionRT'];
    initialFixationTime = [PerTrialStruct.A_InitialTargetReleaseRT'; PerTrialStruct.B_InitialTargetReleaseRT'];
    allInitialFixationTime = [allInitialFixationTime, initialFixationTime];
    allOwnChoice = [allOwnChoice, isOwnChoice];
    if (iSession <= nSession)
        sessionBorderFlaffusCuriusNaive(iSession) = length(allInitialFixationTime);
        iSession = iSession + 1;
    end    
end
allOtherChoice = 1 - allOwnChoice;
pSeeRaw = calc_probabilities_to_see(allInitialFixationTime);
[~, ~, corrCoefFlaffusCuriusNaiveJoint, corrPValueFlaffusCuriusNaiveJoint] ...
        = calc_prob_to_see_correlation(pSeeRaw, allOwnChoice, windowSize);
pSeeFlaffusCuriusNaiveJoint = movmean(pSeeRaw, windowSize, 2);
pOtherChoiceFlaffusCuriusNaiveJoint = movmean(allOtherChoice, windowSize, 2);




SMFlaffusFilenames = {...
    'DATA_20180131T155005.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180201T162341.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180202T144348.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180205T122214.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180209T145624.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180213T133932.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180214T141456.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180215T131327.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180216T140913.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180220T133215.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180221T133419.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180222T121106.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180223T143339.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180227T151756.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180228T132647.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice'%, ...
    %'DATA_20180406T111431.A_Flaffus.B_SM.SCP_01.triallog.A.Flaffus.B.SM_IC_JointTrials.isOwnChoice_sideChoice', ...
    %'DATA_20180409T145457.A_Flaffus.B_SM.SCP_01.triallog.A.Flaffus.B.SM_IC_JointTrials.isOwnChoice_sideChoice', ...
    %'DATA_20180410T125708.A_Flaffus.B_SM.SCP_01.triallog.A.Flaffus.B.SM_IC_JointTrials.isOwnChoice_sideChoice', ...
    %'DATA_20180411T104941.A_Flaffus.B_SM.SCP_01.triallog.A.Flaffus.B.SM_IC_JointTrials.isOwnChoice_sideChoice', ...
    %'DATA_20180413T113720.A_Flaffus.B_SM.SCP_01.triallog.A.Flaffus.B.SM_IC_JointTrials.isOwnChoice_sideChoice', ...
    %'DATA_20180416T122545.A_Flaffus.B_SM.SCP_01.triallog.A.Flaffus.B.SM_IC_JointTrials.isOwnChoice_sideChoice', ...
    %'DATA_20180416T124439.A_Flaffus.B_SM.SCP_01.triallog.A.Flaffus.B.SM_IC_JointTrials.isOwnChoice_sideChoice', ...
    %'DATA_20180417T161836.A_Flaffus.B_SM.SCP_01.triallog.A.Flaffus.B.SM_IC_JointTrials.isOwnChoice_sideChoice', ...
    %'DATA_20180423T141825.A_Flaffus.B_SM.SCP_01.triallog.A.Flaffus.B.SM_IC_JointTrials.isOwnChoice_sideChoice', ...
    };

SMCuriusFilenames = {...
    'DATA_20171206T141710.A_SM.B_Curius.SCP_01.triallog.A.SM.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20171208T140548.A_SM.B_Curius.SCP_01.triallog.A.SM.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20171211T110911.A_SM.B_Curius.SCP_01.triallog.A.SM.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20171212T104819.A_SM.B_Curius.SCP_01.triallog.A.SM.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180111T130920.A_SM.B_Curius.SCP_01.triallog.A.SM.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180112T103626.A_SM.B_Curius.SCP_01.triallog.A.SM.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180118T120304.A_SM.B_Curius.SCP_01.triallog.A.SM.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180423T162330.A_SM.B_Curius.SCP_01.triallog.A.SM.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    };

pSeeMonkeyTraining = cell(2,1);
pOtherChoiceMonkeyTraining = cell(2,1);
monkeyTrainingCorr = cell(2,1);
monkeyTrainingCorrToShow = zeros(2,1);
monkeyTrainingPValueToShow = zeros(2,1);


%index = [1:21,21:23];
indexToShow = 15;
[pSee, probOtherChoice, ~, ~, ...
    corrCoefAveraged, corrPValueAveraged] = compute_prob_to_see_for_dataset(folder, SMFlaffusFilenames, windowSize);
pSeeMonkeyTraining{1} = pSee{indexToShow}(2,:);
pOtherChoiceMonkeyTraining{1} = probOtherChoice{indexToShow}(2,:);
monkeyTrainingCorr{1} = corrCoefAveraged(2,:);
monkeyTrainingCorrToShow(1) = corrCoefAveraged(2,indexToShow);
monkeyTrainingPValueToShow(1) = corrPValueAveraged(2,indexToShow);


indexToShow = 8;
[pSee, probOtherChoice, ~, ~, ...
    corrCoefAveraged, corrPValueAveraged] = compute_prob_to_see_for_dataset(folder, SMCuriusFilenames, windowSize);
pSeeMonkeyTraining{2} = pSee{indexToShow}(2,:);
pOtherChoiceMonkeyTraining{2} = probOtherChoice{indexToShow}(2,:);
monkeyTrainingCorr{2} = corrCoefAveraged(2,:);
monkeyTrainingCorrToShow(2) = corrCoefAveraged(2,indexToShow);
monkeyTrainingPValueToShow(2) = corrPValueAveraged(2,indexToShow);




FontSize = 12;
fontType = 'Arial';
LineWidth = 1.4;
plotColor = [0.9290, 0.6940, 0.1250; ...
             0.4940, 0.1840, 0.5560];
imageName = 'correlationCompositePlot';         

figure
set( axes,'fontsize', FontSize, 'FontName', fontType);

% plot humans
playerName = {'A', 'B'};
subplot(4,3,1)
b = bar(humanCorr'); 
b(1).FaceColor = [0, 0.4470, 0.7410];
b(2).FaceColor = [0.85, 0.325, 0.098];
set( gca, 'fontsize', FontSize, 'FontName', fontType);
xlabel( ' pair ', 'fontsize', FontSize, 'FontName', fontType);
ylabel( ' correlation ', 'fontsize', FontSize, 'FontName', fontType);
titleText = 'Human pairs';
title(titleText, 'fontsize', FontSize, 'FontName',fontType)
axis( [0.5, length(humanCorr)+0.5, -1, 1]);

for iPlot = 1:2
    nTrial = length(pSeeHuman(1,:));
    subplot(4,3,1 + iPlot)
    hold on
    plot (pSeeHuman(iPlot,:), 'color', plotColor(1,:), 'linewidth', LineWidth);
    plot (pOtherChoiceHuman(iPlot,:), 'color', plotColor(2,:), 'linewidth', LineWidth);
    hold off;
    if (iPlot == 2)
        lHandle = legend('p_{see}', 'p_{other}', 'Location', 'NorthWest');
        set(lHandle, 'fontsize', FontSize-4, 'FontName',fontType);
    end    
    set( gca, 'fontsize', FontSize, 'FontName', fontType);
    xlabel( ' trials ', 'fontsize', FontSize, 'FontName', fontType);
    ylabel( ' probability ', 'fontsize', FontSize, 'FontName', fontType);
    titleText = ['Pair 3, ', playerName{iPlot}, sprintf(', %.2f (%.0d)', humanCorrToShow(iPlot), humanPValueToShow(iPlot))];
    
    title(titleText, 'fontsize', FontSize, 'FontName',fontType)
    axis( [0, nTrial, 0, 1.1]);
end

% plot Naive macaques
playerName = {'F', 'C'};
subplot(4,3,4)
hold on
plot(corrCoefAveragedNaive', '-o', 'linewidth', LineWidth); 
plot([.8, length(corrCoefAveragedNaive)+0.2], [0,0], 'k--', 'linewidth', 1);
hold off
set( gca, 'fontsize', FontSize, 'FontName', fontType);
lHandle = legend(playerName, 'Location', 'SouthEast');
set(lHandle, 'fontsize', FontSize-4, 'FontName',fontType);
xlabel( ' session ', 'fontsize', FontSize, 'FontName', fontType);
ylabel( ' correlation ', 'fontsize', FontSize, 'FontName', fontType);
titleText = 'F-C naive';
title(titleText, 'fontsize', FontSize, 'FontName',fontType)
axis( [0.8, length(corrCoefAveragedNaive)+0.2, -1, 1]);

for iPlot = 1:2
    nTrial = length(pSeeFlaffusCuriusNaiveJoint(1,:));
    subplot(4,3,4 + iPlot)
    hold on
    plot (pSeeFlaffusCuriusNaiveJoint(iPlot,:), 'color', plotColor(1,:), 'linewidth', 1);
    plot (pOtherChoiceFlaffusCuriusNaiveJoint(iPlot,:), 'color', plotColor(2,:), 'linewidth', 1);    
    for iSession = 2:length(sessionBorderFlaffusCuriusNaive)
        x = sessionBorderFlaffusCuriusNaive(iSession);
        plot([x,x], [0,1.1], '--k', 'linewidth', 1);    
    end    
    hold off;
    set( gca, 'fontsize', FontSize, 'FontName', fontType);
    xlabel( ' trials ', 'fontsize', FontSize, 'FontName', fontType);
    ylabel( ' probability ', 'fontsize', FontSize, 'FontName', fontType);
%    titleText = ['Player ', num2str(iPlot) ': ' sprintf('%.2f', corrCoefValue(iPlot)) ' (' sprintf('%.0d', corrPValue(iPlot)) ') / ' ...
%        sprintf('%.2f', corrCoefAveraged(iPlot)) ' (' sprintf('%.0d', corrPValueAveraged(iPlot)) ')'];
    titleText = [playerName{iPlot}, sprintf(' late sessions, %.2f (%.0d)', corrCoefFlaffusCuriusNaiveJoint(iPlot), corrPValueFlaffusCuriusNaiveJoint(iPlot))];
    title(titleText, 'fontsize', FontSize, 'FontName',fontType)
    axis( [0, nTrial, 0, 1.1]);
end

% plot macaques during training
playerName = {'F', 'C'};
subplot(4,3,7)
nSession = max(length(monkeyTrainingCorr{1}), length(monkeyTrainingCorr{2}));
hold on
plot(monkeyTrainingCorr{1}, '-o', 'linewidth', LineWidth); 
plot(monkeyTrainingCorr{2}, '-o', 'linewidth', LineWidth); 
plot([.8, nSession+0.2], [0,0], 'k--', 'linewidth', 1);
hold off
set( gca, 'fontsize', FontSize, 'FontName', fontType);
lHandle = legend(playerName, 'Location', 'SouthEast');
set(lHandle, 'fontsize', FontSize-4, 'FontName',fontType);
xlabel( ' session ', 'fontsize', FontSize, 'FontName', fontType);
ylabel( ' correlation ', 'fontsize', FontSize, 'FontName', fontType);
titleText = 'Confedarate training';
title(titleText, 'fontsize', FontSize, 'FontName',fontType)
axis( [0.8, nSession+0.2, -1, 1]);

for iPlot = 1:2
    nTrial = length(pSeeMonkeyTraining{iPlot});
    subplot(4,3,7 + iPlot)
    hold on
    plot(pSeeMonkeyTraining{iPlot}, 'color', plotColor(1,:), 'linewidth', LineWidth);
    plot(pOtherChoiceMonkeyTraining{iPlot}, 'color', plotColor(2,:), 'linewidth', LineWidth);    
    hold off;
    set( gca, 'fontsize', FontSize, 'FontName', fontType);
    xlabel( ' trials ', 'fontsize', FontSize, 'FontName', fontType);
    ylabel( ' probability ', 'fontsize', FontSize, 'FontName', fontType);
    titleText = [playerName{iPlot}, sprintf(', %.2f (%.0d)', monkeyTrainingCorrToShow(iPlot), monkeyTrainingPValueToShow(iPlot))];
    title(titleText, 'fontsize', FontSize, 'FontName',fontType)
    axis( [0, nTrial, 0, 1.1]);
end

monkeyTrainingCorr{2} = corrCoefAveraged(2,:);
monkeyTrainingCorrToShow(2) = corrCoefAveraged(2,indexToShow);
monkeyTrainingPValueToShow(2) = corrPValueAveraged(2,indexToShow);



% plot trained macaques
playerName = {'F', 'C'};
subplot(4,3,10)
hold on
plot(corrCoefAveragedConf', '-o', 'linewidth', LineWidth); 
plot([.8, length(corrCoefAveragedConf)+0.2], [0,0], 'k--', 'linewidth', 1);
hold off
set( gca, 'fontsize', FontSize, 'FontName', fontType);
lHandle = legend(playerName, 'Location', 'SouthEast');
set(lHandle, 'fontsize', FontSize-4, 'FontName',fontType);
xlabel( ' session ', 'fontsize', FontSize, 'FontName', fontType);
ylabel( ' correlation ', 'fontsize', FontSize, 'FontName', fontType);
titleText = 'F-C trained';
title(titleText, 'fontsize', FontSize, 'FontName',fontType)
axis( [0.8, length(corrCoefAveragedConf)+0.2, -1, 1]);

for iPlot = 1:2
    nTrial = length(pSeeFlaffusCuriusConf(1,:));
    subplot(4,3,10 + iPlot)
    hold on
    plot(pSeeFlaffusCuriusConf(iPlot,:), 'color', plotColor(1,:), 'linewidth', LineWidth);
    plot(pOtherChoiceFlaffusCuriusConf(iPlot,:), 'color', plotColor(2,:), 'linewidth', LineWidth);    
    hold off;
    set( gca, 'fontsize', FontSize, 'FontName', fontType);
    xlabel( ' trials ', 'fontsize', FontSize, 'FontName', fontType);
    ylabel( ' probability ', 'fontsize', FontSize, 'FontName', fontType);
%    titleText = ['Player ', num2str(iPlot) ': ' sprintf('%.2f', corrCoefValue(iPlot)) ' (' sprintf('%.0d', corrPValue(iPlot)) ') / ' ...
%        sprintf('%.2f', corrCoefAveraged(iPlot)) ' (' sprintf('%.0d', corrPValueAveraged(iPlot)) ')'];
    titleText = [playerName{iPlot}, sprintf(', %.2f (%.0d)', corrCoefFlaffusCuriusConf(iPlot), corrPValueFlaffusCuriusConf(iPlot))];
    title(titleText, 'fontsize', FontSize, 'FontName',fontType)
    axis( [0, nTrial, 0, 1.1]);
end

%axis( [min(dltX), max(dltX), 0, 1.15*max(dRT)] );



set( gcf, 'PaperUnits','centimeters' );
xSize = 27; ySize = 27; %10;
xLeft = 0; yTop = 0;
set( gcf,'PaperPosition', [ xLeft yTop xSize ySize ] );
print ( '-depsc', '-r600', [imageName '.eps']);
print ( '-dtiff', '-r600', [imageName '.tiff']);
print ( '-dpng', '-r600', [imageName '.png']);
end



function [pSee, probOtherChoice, corrCoefValue, corrPValue, ...
    corrCoefAveraged, corrPValueAveraged] = compute_prob_to_see_for_dataset(folder, fileArray, windowSize, sessionIndex)

if (~exist('sessionIndex', 'var'))
    sessionIndex = 1:length(fileArray);
end    
nFile = length(unique(sessionIndex));
pSee = cell(1, nFile);
probOtherChoice = cell(1, nFile);
corrCoefValue = zeros(2,nFile);
corrPValue = zeros(2,nFile);
corrCoefAveraged = zeros(2,nFile);
corrPValueAveraged = zeros(2,nFile);

indexLast = 0;
for i = 1:length(fileArray)
    fullname = fullfile(folder, [fileArray{i} '.mat']);
    load(fullname, 'isOwnChoice', 'PerTrialStruct');
    if sessionIndex(i) ~= indexLast
        initialFixationTime = [];
        isOtherChoice = [];
    end    
    isOtherChoice = [isOtherChoice, 1 - isOwnChoice];
    initialFixationTime = [initialFixationTime, [PerTrialStruct.A_InitialTargetReleaseRT'; PerTrialStruct.B_InitialTargetReleaseRT']];
    %targetAcquisitionTime = [targetAcquisitionTime, [PerTrialStruct.A_TargetAcquisitionRT'; PerTrialStruct.B_TargetAcquisitionRT']];
        
    if sessionIndex(i) ~= indexLast
        iSession = sessionIndex(i);
        isOwnChoice = 1 - isOtherChoice; % recompute back to  ensure merging of several files
        % copy the rest to the processing function
        pSeeRaw = calc_probabilities_to_see(initialFixationTime);
        [corrCoefValue(:,iSession), corrPValue(:,iSession), ...
         corrCoefAveraged(:,iSession), corrPValueAveraged(:,iSession)] ...
            = calc_prob_to_see_correlation(pSeeRaw, isOwnChoice, windowSize);
    
        pSee{iSession} = movmean(pSeeRaw, windowSize, 2);
        probOtherChoice{iSession} = movmean(isOtherChoice, windowSize, 2);
    end    
    indexLast = sessionIndex(i);
end
end