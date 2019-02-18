ispc = 1;
if ispc
    folder = 'Z:\taskcontroller\SCP_DATA\ANALYSES\PC1000\2018\CoordinationCheck';
else
    folder = fullfile('/', 'Volumes', 'social_neuroscience_data', 'taskcontroller', 'SCP_DATA', 'ANALYSES', 'PC1000', '2018', 'CoordinationCheck');
end

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

flaffusCuriusConfederateFilenames = {...
    'DATA_20180418T143951.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180419T141311.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180424T121937.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180425T133936.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180426T171117.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180427T142541.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice'
    };

humanTransparentPairFilenames = {...
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
    'DATA_20180228T132647.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180406T111431.A_Flaffus.B_SM.SCP_01.triallog.A.Flaffus.B.SM_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180409T145457.A_Flaffus.B_SM.SCP_01.triallog.A.Flaffus.B.SM_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180410T125708.A_Flaffus.B_SM.SCP_01.triallog.A.Flaffus.B.SM_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180411T104941.A_Flaffus.B_SM.SCP_01.triallog.A.Flaffus.B.SM_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180413T113720.A_Flaffus.B_SM.SCP_01.triallog.A.Flaffus.B.SM_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180416T122545.A_Flaffus.B_SM.SCP_01.triallog.A.Flaffus.B.SM_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180416T124439.A_Flaffus.B_SM.SCP_01.triallog.A.Flaffus.B.SM_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180417T161836.A_Flaffus.B_SM.SCP_01.triallog.A.Flaffus.B.SM_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180423T141825.A_Flaffus.B_SM.SCP_01.triallog.A.Flaffus.B.SM_IC_JointTrials.isOwnChoice_sideChoice', ...
    };

SMTeslaFilenames = {...
    'DATA_20180601T122747.A_Tesla.B_SM.SCP_01.triallog.A.Tesla.B.SM_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180604T150239.A_Tesla.B_SM.SCP_01.triallog.A.Tesla.B.SM_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180605T150607.A_Tesla.B_SM.SCP_01.triallog.A.Tesla.B.SM_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180606T142829.A_Tesla.B_SM.SCP_01.triallog.A.Tesla.B.SM_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180607T142823.A_Tesla.B_SM.SCP_01.triallog.A.Tesla.B.SM_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180607T145715.A_Tesla.B_SM.SCP_01.triallog.A.Tesla.B.SM_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180608T100903.A_Tesla.B_SM.SCP_01.triallog.A.Tesla.B.SM_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180611T150057.A_Tesla.B_SM.SCP_01.triallog.A.Tesla.B.SM_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180612T162540.A_Tesla.B_SM.SCP_01.triallog.A.Tesla.B.SM_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180613T141225.A_Tesla.B_SM.SCP_01.triallog.A.Tesla.B.SM_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180614T165947.A_Tesla.B_SM.SCP_01.triallog.A.Tesla.B.SM_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180615T150245.A_Tesla.B_SM.SCP_01.triallog.A.Tesla.B.SM_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180615T154238.A_Tesla.B_SM.SCP_01.triallog.A.Tesla.B.SM_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180618T140913.A_Tesla.B_SM.SCP_01.triallog.A.Tesla.B.SM_IC_JointTrials.isOwnChoice_sideChoice', ...
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

needToPlotSigmoid = 0;
%fileArray = flaffusCuriusConfederateFilenames;
%fileArray = flaffusCuriusNaiveFilenames;
%imageNameBase = 'FlaffusCurius_PseeAndChoice';

%fileArray = humanTransparentPairFilenames;
%imageNameBase = 'human_PseeAndChoice';

%fileArray = SMFlaffusFilenames;
%imageNameBase = 'SM_Flaffus';

%fileArray = SMTeslaFilenames;
%imageNameBase = 'Tesla_SM';

fileArray = SMCuriusFilenames;
imageNameBase = 'SM_Curius';

meanRT = zeros(2, length(fileArray));
medianRT = zeros(2, length(fileArray));

for i = 1:length(fileArray)
    fullname = [folder '\' fileArray{i} '.mat'];
    load(fullname);
    
    % copy the rest to the processing function    
    %targetAcquisitionTime = [PerTrialStruct.A_TargetAcquisitionRT'; PerTrialStruct.B_TargetAcquisitionRT'];
    initialFixationTime = [PerTrialStruct.A_InitialTargetReleaseRT'; PerTrialStruct.B_InitialTargetReleaseRT'];
    
    meanRT(:, i) = mean(initialFixationTime, 2);
    medianRT(:, i) = median(initialFixationTime, 2);
    
    minDRT = 50;
    %pSee = computeProbabilitiesToSee(initialFixationTime, minDRT);
    
    imageName = [imageNameBase int2str(i)];
    %plotProbabilitiesToSee(pSee, isOwnChoice, imageName, needToPlotSigmoid);
end
figure
subplot(2,1,1)
title('mean')
plot(meanRT')
lHandle = legend('SM', 'Curius');    
subplot(2,1,2)
title('median')
plot(medianRT')

%{
meanRT = [meanRT(:, 1:15),meanRT(2:-1:1, 16:24)];
medianRT = [medianRT(:, 1:15),medianRT(2:-1:1, 16:24)];
figure
subplot(2,1,1)
title('mean')
hold on 
plot(meanRT')
plot([0, 25], [420, 420], '--k')
plot([15.5, 15.5], [200, 800], '--k')
hold off
lHandle = legend('SM', 'Flaffus');    
subplot(2,1,2)
title('median')
hold on 
plot(medianRT')
plot([0, 25], [400, 400], '--k')
plot([15.5, 15.5], [200, 800], '--k')
hold off
%}

%%
x = [SMCuriusMedian, SMFlaffusMedian, FlaffusSMMedian, TeslaSMMedian];
g = [ones(1,length(SMCuriusMedian)), 2*ones(1,length(SMFlaffusMedian)), 3*ones(1,length(FlaffusSMMedian)), 4*ones(1,length(TeslaSMMedian))];
xTicks = {['SM-Curius (' num2str(length(SMCuriusMedian)) ')'],...
          ['SM-Flaffus (' num2str(length(SMFlaffusMedian)) ')'],...
          ['Flaffus-SM (' num2str(length(FlaffusSMMedian)) ')'],...
          ['Tesla-SM (' num2str(length(TeslaSMMedian)) ')']};

FontSize = 12;
fontType = 'Arial';

figure
set( axes,'fontsize', FontSize, 'FontName', fontType); 
boxplot(x,g)
title('SM median RT per session', 'fontsize', FontSize, 'FontName',fontType)
set( gca, 'fontsize', FontSize, 'FontName', fontType, 'XTickLabel', xTicks);
ylabel( ' Initial Target Release RT [ms]', 'fontsize', FontSize, 'FontName', fontType);
set( gcf, 'PaperUnits','centimeters' );
xSize = 15; ySize = 10; %10;
xLeft = 0; yTop = 0;
set( gcf,'PaperPosition', [ xLeft yTop xSize ySize ] );
print ( '-dpng', '-r600', 'TouchPanelTimeDifference.png');    

%% joint picture
allOwnChoice = [];
allInitialFixationTime = [];
for i = length(fileArray)-5:length(fileArray)
    fullname = [folder '\' fileArray{i} '.mat'];
    load(fullname);
    
    % copy the rest to the processing function    
    %targetAcquisitionTime = [PerTrialStruct.A_TargetAcquisitionRT'; PerTrialStruct.B_TargetAcquisitionRT'];
    initialFixationTime = [PerTrialStruct.A_InitialTargetReleaseRT'; PerTrialStruct.B_InitialTargetReleaseRT'];
    allInitialFixationTime = [allInitialFixationTime, initialFixationTime];
    allOwnChoice = [allOwnChoice, isOwnChoice];
end

minDRT = 50;
pSee = computeProbabilitiesToSee(allInitialFixationTime, minDRT);
    
imageName = 'FlaffusCuriusNaive6last';
plotProbabilitiesToSee(pSee, allOwnChoice, imageName, needToPlotSigmoid);


%%

load([folder '\' filename]);

figure
set( axes,'fontsize', fontSize,  'FontName', fontType);%'FontName', 'Times');
subplot(2,1,1)
hold on
plot ( 1 - movmean(isOwnChoice(1,:), 4), 'color', [0,0,1], 'linewidth', LineWidth);
plot ( 1 - movmean(isOwnChoice(2,:), 4)+0.01, 'color', [1,0,0], 'linewidth', LineWidth);
hold off;
 
set( gca, 'fontsize', FontSize, 'FontName', fontType, 'xTick', []);
%xlabel( ' trials ', 'fontsize', FontSize, 'FontName', fontType);
ylabel( ' share of Accommodate choices ', 'fontsize', FontSize, 'FontName', fontType);
%title(titleText{iPlot}, 'fontsize', FontSize, 'FontName',fontType)
axis( [1, 547, 0, 1.1]);
lHandle = legend('Player 1', 'Player 2', 'orientation', 'horizontal', 'location', 'SouthOutside');
set(lHandle, 'fontsize', FontSize, 'FontName',fontType);

t1 = movmean(initialFixationTime(1,:), 4);
t2 = movmean(initialFixationTime(2,:), 4);
subplot(2,1,2)
hold on
plot ( t1, 'color', [0,0,1], 'linewidth', LineWidth);
plot ( t2, 'color', [1,0,0], 'linewidth', LineWidth);
hold off;
  
set( gca, 'fontsize', FontSize, 'FontName', fontType);
xlabel( ' trials ', 'fontsize', FontSize, 'FontName', fontType);
ylabel( ' reaction time [ms] ', 'fontsize', FontSize, 'FontName', fontType);
%title(titleText{iPlot}, 'fontsize', FontSize, 'FontName',fontType)
axis( [1, 547, min(min(t1), min(t2)), max(max(t1), max(t2))])

set( gcf, 'PaperUnits','centimeters' );
xSize = 21; ySize = 9; %10;
xLeft = 0; yTop = 0;
set( gcf,'PaperPosition', [ xLeft yTop xSize ySize ] );
print ( '-dpng', '-r600', 'FlaffusCurius_RT.png');


%%
filenames = {'DATA_20170426T133343.A_21005.B_12006.SCP_00.triallog.A.21005.B.12006_IC_JointTrials.isOwnChoice_sideChoice.mat',... 
             'DATA_20171128T165159.A_20024.B_10023.SCP_01.triallog.A.20024.B.10023_IC_JointTrials.isOwnChoice_sideChoice.mat'};

titleText = {'Human opaque, Challenger', 'Human transparent, Turn-taker'};
figure
for iPlot = 1:2
    load([folder '\' filenames{iPlot}]);
    subplot(2,1,iPlot)
    hold on
    plot ( movmean(isOwnChoice(1,:), 4), 'color', [0,0,1], 'linewidth', LineWidth);
    plot ( movmean(isOwnChoice(2,:), 4)+0.01, 'color', [1,0,0], 'linewidth', LineWidth);
    hold off;
    if (iPlot == 2)
        lHandle = legend('Player 1', 'Player 2', 'location', 'Northwest');
        set(lHandle, 'fontsize', FontSize, 'FontName',fontType);
    end    
    set( gca, 'fontsize', FontSize, 'FontName', fontType);
    xlabel( ' trials ', 'fontsize', FontSize, 'FontName', fontType);
    ylabel( ' share of own choices ', 'fontsize', FontSize, 'FontName', fontType);
    title(titleText{iPlot}, 'fontsize', FontSize, 'FontName',fontType)
    axis( [1, 400, 0, 1.1]);
end
set( gcf, 'PaperUnits','centimeters' );
xSize = 10; ySize = 12; %10;
xLeft = 0; yTop = 0;
set( gcf,'PaperPosition', [ xLeft yTop xSize ySize ] );
print ( '-dpng', '-r600', 'HumanChoices.png');



figure
hold on
plot ( isOwnChoice(1,:)+0.01, 'color', [0,0,1], 'linewidth', LineWidth);
plot ( isOwnChoice(2,:)+0.01, 'color', [1,0,0], 'linewidth', LineWidth);
hold off;
set( gca, 'fontsize', FontSize, 'FontName', fontType);
axis( [120, 130, 0, 1.1]);
set( gcf, 'PaperUnits','centimeters' );
xSize = 7; ySize = 4; %10;
xLeft = 0; yTop = 0;
set( gcf,'PaperPosition', [ xLeft yTop xSize ySize ] );
print ( '-dpng', '-r600', 'HumanChoicesAdd.png');
