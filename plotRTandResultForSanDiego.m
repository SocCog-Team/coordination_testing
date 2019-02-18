LineWidth = 2;
FontSize = 12;
fontType = 'Arial';

plotColor = [0.9290, 0.6940, 0.1250; ...
             0.4940, 0.1840, 0.5560];
%%
if ispc
    folder = 'Z:\taskcontroller\SCP_DATA\ANALYSES\PC1000\2018\CoordinationCheck';
else
    folder = fullfile('/', 'Volumes', 'social_neuroscience_data', 'taskcontroller', 'SCP_DATA', 'ANALYSES', 'PC1000', '2018', 'CoordinationCheck');
end

filename = 'DATA_20180419T141311.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat';
load([folder '\' filename]);

%x = zeros(50,3);
%for i = 1:50
minDRT = 50;
k = 0.08;
nTrial = length(isOwnChoice);
targetAcquisitionTime = [PerTrialStruct.A_TargetAcquisitionRT'; PerTrialStruct.B_TargetAcquisitionRT'];
initialFixationTime = [PerTrialStruct.A_InitialTargetReleaseRT'; PerTrialStruct.B_InitialTargetReleaseRT'];
%dRT = targetAcquisitionTime(1,:) - targetAcquisitionTime(2,:);
dRT = initialFixationTime(1,:) - initialFixationTime(2,:);
player1SeesIndex = (dRT > 0);
player2SeesIndex = (dRT < 0);
pSee = zeros(1, nTrial);
pSee(player1SeesIndex) =  1./(1 + exp(-k*(dRT(player1SeesIndex) - minDRT)));
pSee(player2SeesIndex) = -1./(1 + exp(-k*(minDRT - dRT(player2SeesIndex))));

a = corrcoef(pSee', isOwnChoice(1,:)');
b = corrcoef(pSee', isOwnChoice(2,:)');
c = corrcoef(pSee', (isOwnChoice(2,:) - isOwnChoice(1,:))');
%x(i,:) = [-a(2,1), b(2,1), c(2,1)];
%disp('******************')
%disp(['minDRT=' num2str(minDRT)])
%disp([a(2,1), b(2,1), c(2,1)])
%end
%figure
%plot(x(:,3))

%%
pSeeSingle = [pSee;-pSee];
pSeeSingle(pSeeSingle < 0) = 0;
a = corrcoef(pSeeSingle(1,:)', isOwnChoice(1,:)');
b = corrcoef(pSeeSingle(2,:)', isOwnChoice(2,:)');
disp([a(2,1), b(2,1)])

windowSize = 8;
a = corrcoef(movmean(pSeeSingle(1,:), windowSize), movmean(isOwnChoice(1,:), windowSize));
b = corrcoef(movmean(pSeeSingle(2,:), windowSize), movmean(isOwnChoice(2,:), windowSize));
disp([a(2,1), b(2,1)])

x = 1:150;
y = 1./(1 + exp(-k*(x - minDRT)));

figure
set( axes,'fontsize', FontSize, 'FontName', fontType);  

subplot(2,1,1)
hold on
lineHandle1 = plot ( movmean(pSeeSingle(1,:), windowSize), 'color', plotColor(1,:), 'linewidth', LineWidth);
lineHandle2 = plot ( movmean(1 - isOwnChoice(1,:), windowSize), 'color', [1,0,0], 'linewidth', LineWidth);
hold off;
%lHandle = legend('probability to see partner''s choice', 'share of other choices', 'location', 'southoutside');  
%set(lHandle, 'fontsize', FontSize-1, 'FontName',fontType);  
set( gca, 'fontsize', FontSize, 'FontName', fontType);
xlabel( ' Number of trial ', 'fontsize', FontSize, 'FontName', fontType);
ylabel( ' probability ', 'fontsize', FontSize, 'FontName', fontType);
title('Player 1 (corr 0.92)', 'fontsize', FontSize, 'FontName',fontType)
%axis( [184, 495, 0, 1.1]);
axis( [1, length(isOwnChoice), 0, 1.1]);
%axis( [min(dltX), max(dltX), 0, 1.15*max(dRT)] );

subplot(2,1,2)
hold on
lineHandle1 = plot ( movmean(pSeeSingle(2,:), windowSize), 'color', plotColor(1,:), 'linewidth', LineWidth);
lineHandle2 = plot ( movmean(1 - isOwnChoice(2,:), windowSize), 'color', [0,0,1], 'linewidth', LineWidth);
hold off;
%lHandle = legend('probability to see partner''s choice', 'share of other choices', 'location', 'northoutside');  
%set(lHandle, 'fontsize', FontSize-1, 'FontName',fontType);  
set( gca, 'fontsize', FontSize, 'FontName', fontType);
xlabel( ' Number of trial ', 'fontsize', FontSize, 'FontName', fontType);
ylabel( ' probability ', 'fontsize', FontSize, 'FontName', fontType);
title('Player 2 (corr 0.89)', 'fontsize', FontSize, 'FontName',fontType)
axis( [1, length(isOwnChoice), 0, 1.1]);
%axis( [184, 495, 0, 1.1]);

set( gcf, 'PaperUnits','centimeters' );
xSize = 21; ySize = 15; %10;
xLeft = 0; yTop = 0;
set( gcf,'PaperPosition', [ xLeft yTop xSize ySize ] );
print ( '-depsc', '-r600', 'FlaffusCurius_PseeAndChoice.eps');
print ( '-dtiff', '-r600', 'FlaffusCurius_PseeAndChoice.tiff');
print ( '-dpng', '-r600', 'FlaffusCurius_PseeAndChoice.png');

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
