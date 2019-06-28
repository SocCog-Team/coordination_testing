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
filename = 'DATA_20180419T141311.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat';
fullname = [folder '\' filename];
load(fullname);

minDRT = 50;
k = 0.04;

initialFixationTime = [PerTrialStruct.A_InitialTargetReleaseRT'; PerTrialStruct.B_InitialTargetReleaseRT'];
pSee = calc_probabilities_to_see(initialFixationTime, minDRT);
windowSize = 10;
[corrCoefFlaffusCurius, corrPValueFlaffusCurius, corrCoefFlaffusCuriusAver, corrPValueFlaffusCuriusAver] ...
        = calc_prob_to_see_correlation(pSee, isOwnChoice, windowSize);

disp(corrCoefFlaffusCurius); 
disp(corrCoefFlaffusCuriusAver); 


x = 1:150;
y = 1./(1 + exp(-k*(x - minDRT)));

figure
set( axes,'fontsize', FontSize, 'FontName', fontType);  
subplot(2,3,1:3:4)
plot (x, y, 'linewidth', LineWidth);
set( gca, 'fontsize', FontSize, 'FontName', fontType);
xlabel( '$\Delta\mathrm{RT}$ [ms]', 'fontsize', FontSize, 'FontName', fontType, 'Interpreter', 'latex');
ylabel( ' probability to see partner''s choice ', 'fontsize', FontSize, 'FontName', fontType);
axis( [0, max(x), 0, 1.01] );

subplot(2,3,2:3)
hold on
lineHandle1 = plot ( movmean(pSee(1,:), windowSize), 'color', [1,0,0], 'linewidth', LineWidth);
lineHandle2 = plot ( movmean(1 - isOwnChoice(1,:), windowSize), 'color', plotColor(2,:), 'linewidth', LineWidth);
hold off;
lHandle = legend([lineHandle1,lineHandle2], 'probability to see partner''s choice', 'share of Accommodate choices', 'location', 'southoutside');  
set(lHandle, 'fontsize', FontSize-1, 'FontName',fontType);  
set( gca, 'fontsize', FontSize, 'FontName', fontType);
xlabel( ' trials ', 'fontsize', FontSize, 'FontName', fontType);
ylabel( ' probability ', 'fontsize', FontSize, 'FontName', fontType);
title('Player 1 (corr 0.94)', 'fontsize', FontSize, 'FontName',fontType)
axis( [1, length(isOwnChoice), 0, 1.1]);
%axis( [min(dltX), max(dltX), 0, 1.15*max(dRT)] );

subplot(2,3,5:6)
hold on
lineHandle1 = plot ( movmean(pSee(2,:), windowSize), 'color', [0,0,1], 'linewidth', LineWidth);
lineHandle2 = plot ( movmean(1 - isOwnChoice(2,:), windowSize), 'color', plotColor(2,:), 'linewidth', LineWidth);
hold off;
lHandle = legend([lineHandle1,lineHandle2], 'probability to see partner''s choice', 'share of Accommodate choices', 'location', 'northoutside');  
set(lHandle, 'fontsize', FontSize-1, 'FontName',fontType);  
set( gca, 'fontsize', FontSize, 'FontName', fontType);
xlabel( ' trials ', 'fontsize', FontSize, 'FontName', fontType);
ylabel( ' probability ', 'fontsize', FontSize, 'FontName', fontType);
title('Player 2 (corr 0.85)', 'fontsize', FontSize, 'FontName',fontType)
axis( [1, length(isOwnChoice), 0, 1.1]);

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


%% show shares of own choise for humans
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
    ylabel( ' share of Insist choices ', 'fontsize', FontSize, 'FontName', fontType);
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


%% show shares of own choise for monkeys
filename = 'DATA_20180309T110024.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice.mat';                
titleText = {'Macaque confederate training', 'Macaque confederate training (reaction times)'};
load([folder '\' filename]);


isTrialVisible = PerTrialStruct.isTrialInvisible_AB';
blockBorder = zeros(1,2);
invisibleStart = find(isTrialVisible == 1, 1, 'first');
invisibleEnd = find(isTrialVisible == 1, 1, 'last');
if (~isempty(invisibleStart))
    blockBorder(1) = invisibleStart;
end
if (~isempty(invisibleEnd))
	blockBorder(2) = invisibleEnd;
end
acquistionTime = movmean([PerTrialStruct.A_TargetAcquisitionRT'; PerTrialStruct.B_TargetAcquisitionRT'], 4, 2); 
figure
for iPlot = 1:2
    if (iPlot == 1)
        minY = 0;
        maxY = 1.1;
    else    
    	minY = 0.95*min(min(acquistionTime));
        maxY = 1.05*max(max(acquistionTime));
    end    
    subplot(2,1,iPlot)
    hold on
    fill([blockBorder(1:2), blockBorder(2:-1:1)], [minY, minY, maxY, maxY], [0.8,0.8,0.8]);
    if (iPlot == 1)
        h1 = plot ( movmean(isOwnChoice(1,:), 4), 'color', [1,0,0], 'linewidth', LineWidth);
        h2 = plot ( movmean(isOwnChoice(2,:), 4)+0.005, 'color', [0,0,1], 'linewidth', LineWidth);
    else        
        plot ( acquistionTime(1,:), 'color', [1,0,0], 'linewidth', LineWidth);
        plot ( acquistionTime(2,:), 'color', [0,0,1], 'linewidth', LineWidth);
    end    
    hold off;
    set( gca, 'fontsize', FontSize, 'FontName', fontType);
    xlabel( ' trials ', 'fontsize', FontSize, 'FontName', fontType);
    title(titleText{iPlot}, 'fontsize', FontSize, 'FontName',fontType)
    if (iPlot == 1)
        %lHandle = legend([h1, h2], 'Player 1', 'Player 2', 'location', 'Northwest');
        %set(lHandle, 'fontsize', FontSize, 'FontName',fontType);
        ylabel( ' share of Insist choices ', 'fontsize', FontSize, 'FontName', fontType);
        axis( [1, length(isOwnChoice(2,:)), minY, maxY]);
    else
        ylabel( ' acquisition time [ms] ', 'fontsize', FontSize, 'FontName', fontType);
        axis( [1, length(isOwnChoice(2,:)), minY, maxY]);
    end    
end
set( gcf, 'PaperUnits','centimeters' );
xSize = 15; ySize = 8; %10;
xLeft = 0; yTop = 0;
set( gcf,'PaperPosition', [ xLeft yTop xSize ySize ] );
print ( '-dpng', '-r600', 'MonkeyChoices.png');
print ( '-depsc', '-r600', 'MonkeyChoices.eps');

%% show shares of own choise for 4 strategies
filenames = {'DATA_20170426T133343.A_21005.B_12006.SCP_00.triallog.A.21005.B.12006_IC_JointTrials.isOwnChoice_sideChoice.mat',... 
             'DATA_20171128T165159.A_20024.B_10023.SCP_01.triallog.A.20024.B.10023_IC_JointTrials.isOwnChoice_sideChoice.mat',...
             'DATA_20180125T155742.A_Magnus.B_Flaffus.SCP_01.triallog.A.Magnus.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
             'DATA_20180419T141311.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat'...
             };

titleText = {'Human opaque, Challenger', ...
             'Human transparent, Turn-taker', ...
             'Macaques, side-strategy', ...
             'Macaques, Leader-Follower',...
             'Macaques, side-strategy (share of left choices)', ...
             'Macaques, Leader-Follower (reaction times)'};
         
figure
for iPlot = 1:4
    load([folder '\' filenames{iPlot}]);
    subplot(3,2,iPlot)
    hold on
    plot ( movmean(isOwnChoice(1,:), 4), 'color', [1,0,0], 'linewidth', LineWidth);
    plot ( movmean(isOwnChoice(2,:), 4)+0.005, 'color', [0,0,1], 'linewidth', LineWidth);
    hold off;
    if (iPlot == 2)
        lHandle = legend('Player 1', 'Player 2', 'location', 'Northwest');
        set(lHandle, 'fontsize', FontSize, 'FontName',fontType);
    end    
    set( gca, 'fontsize', FontSize, 'FontName', fontType);
    xlabel( ' trials ', 'fontsize', FontSize, 'FontName', fontType);
    ylabel( ' share of Insist choices ', 'fontsize', FontSize, 'FontName', fontType);
    title(titleText{iPlot}, 'fontsize', FontSize, 'FontName',fontType)
    axis( [1, length(isOwnChoice(2,:)), 0, 1.1]);
end

for iPlot = 1:2
    load([folder '\' filenames{2+iPlot}]);
    subplot(3,2,4+iPlot)
    hold on
    if (iPlot == 1)
        plot ( movmean(isBottomChoice(1,:), 4), 'color', [1,0,0], 'linewidth', LineWidth);
        plot ( movmean(isBottomChoice(2,:), 4)+0.005, 'color', [0,0,1], 'linewidth', LineWidth);
    else 
        initFixTime = movmean([PerTrialStruct.A_InitialTargetReleaseRT'; PerTrialStruct.B_InitialTargetReleaseRT'], 4, 2);
        plot ( initFixTime(1,:), 'color', [1,0,0], 'linewidth', LineWidth);
        plot ( initFixTime(2,:), 'color', [0,0,1], 'linewidth', LineWidth);
    end
    hold off;
    set( gca, 'fontsize', FontSize, 'FontName', fontType);
    xlabel( ' trials ', 'fontsize', FontSize, 'FontName', fontType);
    title(titleExtText{iPlot}, 'fontsize', FontSize, 'FontName',fontType)

    if (iPlot == 1)
        ylabel( ' share of left choices ', 'fontsize', FontSize, 'FontName', fontType);
        axis( [1, length(isOwnChoice(2,:)), 0, 1.1]);
    else    
        ylabel( ' reaction time [ms] ', 'fontsize', FontSize, 'FontName', fontType);
        axis( [1, length(isOwnChoice(2,:)), 0.95*min(min(initFixTime)), 1.05*max(max(initFixTime))]);
    end
end

set( gcf, 'PaperUnits','centimeters' );
xSize = 28; ySize = 21; %10;
xLeft = 0; yTop = 0;
set( gcf,'PaperPosition', [ xLeft yTop xSize ySize ] );
print ( '-dpng', '-r600', 'Examples4strategies.png');
print ( '-depsc', '-r600', 'Examples4strategies.eps');

% plot inset for turn-takers
load([folder '\' filenames{2}]);
figure
hold on
plot ( isOwnChoice(1,:)+0.01, 'color', [1,0,0], 'linewidth', LineWidth);
plot ( isOwnChoice(2,:)+0.01, 'color', [0,0,1], 'linewidth', LineWidth);
hold off;
set( gca, 'fontsize', FontSize, 'FontName', fontType);
axis( [120, 130, 0, 1.1]);
set( gcf, 'PaperUnits','centimeters' );
xSize = 7; ySize = 4; %10;
xLeft = 0; yTop = 0;
set( gcf,'PaperPosition', [ xLeft yTop xSize ySize ] );
print ( '-dpng', '-r600', 'HumanChoicesAdd.png');
print ( '-depsc', '-r600', 'HumanChoicesAdd.eps');


%% cooperation line plot for the poster
FontSize = 8;
fontType = 'Arial';
figure
set( axes,'fontsize', FontSize, 'FontName', fontType);

plotColor = [0.9290, 0.6940, 0.1250; ...
             0.4940, 0.1840, 0.5560];

shareCooperateBoS = [0.38, 0.41, 0.38, 0.38, 0.25, 1.00];
shareCooperateIPDfull = [1.00, 0.88, 0.91, 0.93, 0.38, 0.18];            

hold on
plot(0:0.1:0.5, shareCooperateBoS, '-o', 'linewidth', 2, 'Color', plotColor(1, :), 'MarkerSize', 6);
plot(0:0.1:0.5, shareCooperateIPDfull, '-o', 'linewidth', 2, 'Color', plotColor(2, :), 'MarkerSize',6);
hold off
set(gca, 'fontsize', FontSize, 'FontName',fontType, ... %'Interpreter', 'latex', ...
         'XTick', 0:0.1:0.5);
xlabel( 'Probability to see partner''s choice', 'fontsize', FontSize, 'FontName', fontType);
ylabel( {'Fraction of cooperative runs'}, 'fontsize', FontSize, 'FontName', fontType);
axis([0, 0.501, 0.0, 1.01])
lHandle = legend('iBoS', 'iPD', 'location', 'SouthWest');  
set(lHandle, 'fontsize', FontSize, 'FontName', fontType);


set( gcf, 'PaperUnits','centimeters' );
xSize = 9; ySize = 5; xLeft = 0; yTop = 0;
set( gcf,'PaperPosition', [ xLeft yTop xSize ySize ] );
print('-dpng', 'GameResults', '-r600');


shares = [37.5, 62.5, 0; 41.2, 57.1, 1.2; 37.5, 34.1, 27.7; ...
          37.5, 3.8, 57.9; 24.9, 0.0, 74.6; 0, 0, 100]/100;
labels = {'Turn-Taker','Challenger','Leader-Follower'};
                 
nBar = length(labels);
colormapBar = jet(nBar+1);
figure
set( axes,'fontsize', FontSize, 'FontName','Times');
h = bar(shares,'stacked');
for iBar = 1:nBar
    iColor = iBar;
    %if iBar >= 3
    %    iColor = iBar + 1;
    %end    
    h(iBar).FaceColor = colormapBar(iColor, :);
end  
set(gca, 'fontsize', FontSize, 'FontName','Times', 'XTick', 1:6, 'XTickLabel', {'0.0', '0.1', '0.2', '0.3', '0.4', '0.5'});    
lHandle = legend(h, labels,'Location','northoutside','Orientation','horizontal');
set(lHandle, 'fontsize', FontSize, 'FontName', fontType);
xlabel('Probability to see partner''s choice', 'fontsize', FontSize, 'FontName',fontType)
ylabel('Frequency of strategies', 'fontsize', FontSize, 'FontName',fontType)

axis([0.5, 6.5, 0, 1.051]);
  
ySize = 6; xSize = 9; xLeft = 0; yTop = 0;
set( gcf, 'PaperUnits','centimeters', 'PaperPosition', [ xLeft yTop xSize ySize ] );
print('-dpng', 'StrategiesInBoS', '-r600');


%% Results of BoS experiments for poster
FontSize = 8;
fontType = 'Arial';

shares = [0, 5/10, 0, 3/10; 4/10, 0, 3/10, 0; 0, 0, 1/7, 4/7];
labels = {'Turn-Taker','Challenger','Leader-Follower', 'Selecting Same Side'};
ticks = {'Humans\newline opaque', '   Humans\newline transparent', 'Macaques'};                 
nBar = length(labels);
colormapBar = jet(2*nBar);
figure
set( axes,'fontsize', FontSize, 'FontName',fontType);
h = bar(shares,'stacked');
for iBar = 1:nBar
    iColor = 2*iBar-1;
    if iBar >= 4
        iColor = 2*iBar-2;
    end    
    h(iBar).FaceColor = colormapBar(iColor, :);
end  
set(gca, 'fontsize', FontSize, 'FontName', fontType, 'XTick', 1:3, 'XTickLabel', ticks);    
lHandle = legend(h, labels,'Location','northoutside','Orientation','vertical');
set(lHandle, 'fontsize', FontSize, 'FontName', fontType);
%xlabel('Subjects', 'fontsize', FontSize, 'FontName',fontType)
ylabel('Frequency of strategies', 'fontsize', FontSize, 'FontName',fontType)

axis([0.5, 3.5, 0, 1.051]);
  
ySize = 10; xSize = 7; xLeft = 0; yTop = 0;
set( gcf, 'PaperUnits','centimeters', 'PaperPosition', [ xLeft yTop xSize ySize ] );
print('-dpng', 'ObservedBehaviourInBoS', '-r600');

%% Results of BoS simulations and experienments together for the poster
shares1 = [0.375, 0.625, 0, 0, 0; ...
          0.412, 0.571, 0.012, 0, 0; ...
          0.375, 0.341, 0.277, 0, 0; ...
          0.375, 0.038, 0.579, 0, 0;...
          0.249, 0.0, 0.746, 0, 0;...
          0, 0, 1, 0, 0];
labels = {'Turn-Taker','Challenger','Leader-Follower', 'Selecting Same Side', 'Not classified'};
%maxYValue = 1.198;
maxYValue = 1.01;

nBar = length(labels);
%colormapBar = jet(2*nBar);
colormapBar = [1,0,0;...
               0,0,1;...
               0,1,0;...
               0.7,0.3,0.9;...
               1,1,1];

figure
set( axes,'fontsize', FontSize, 'FontName','Times');
plotHandle1 = subplot(1,2,1);
h = bar(shares1,'stacked');
for iBar = 1:nBar
    iColor = 2*iBar-1;
    %if iBar >= 3
    %    iColor = iBar + 1;
    %end    
    h(iBar).FaceColor = colormapBar(iBar, :);
end  
set(gca, 'fontsize', FontSize, 'FontName',fontType, 'XTick', 1:6, 'XTickLabel', {'0.0', '0.1', '0.2', '0.3', '0.4', '0.5'}, 'YTick', 0:0.1:1);    
xlabel('Probability to see partner''s choice', 'fontsize', FontSize, 'FontName',fontType)
ylabel('Relative frequency of strategies', 'fontsize', FontSize, 'FontName',fontType)
axis([0.5, 6.5, 0, maxYValue]);
title('Simulation results', 'fontsize', FontSize, 'FontName',fontType)
  

shares2 = [0, 2/5, 0, 1/5, 2/5; 4/14, 4/14, 3/14, 0, 3/14; 0, 4/9, 1/9, 4/9, 0];
ticks = {'Humans\newline opaque', '   Humans\newline transparent', 'Macaques'};                 
%nBar = length(labels);
%colormapBar = jet(2*nBar);

plotHandle2 = subplot(1,2,2);
h = bar(shares2,'stacked');
for iBar = 1:nBar
    iColor = 2*iBar-1;
    if iBar >= 4
        iColor = 2*iBar-2;
    end    
    h(iBar).FaceColor = colormapBar(iBar, :);
end  
set(gca, 'fontsize', FontSize, 'FontName', fontType, 'XTick', 1:3, 'YTick', [], 'XTickLabel', ticks);    
lHandle = legend(h, labels,'Location','north','Orientation','vertical');
set(lHandle, 'fontsize', FontSize, 'FontName', fontType);
legendPos = get(lHandle,'Position');
set(lHandle,'Position',[legendPos(1) + 0.05*legendPos(3), legendPos(2) + 0.21*legendPos(4), legendPos(3:4)]) 

%ylabel('Frequency of strategies', 'fontsize', FontSize, 'FontName',fontType)
title('Experiments', 'fontsize', FontSize, 'FontName',fontType)
axis([0.5, 3.5, 0, maxYValue]);

plot1Pos = get(plotHandle1,'Position');
plot2Pos = get(plotHandle2,'Position');
set(plotHandle2,'Position',[plot2Pos(1) + 0.15*plot2Pos(3), plot2Pos(2), 0.95*plot2Pos(3), plot2Pos(4)]) 
set(plotHandle1,'Position',[plot1Pos(1), plot1Pos(2), 1.4*plot1Pos(3), plot1Pos(4)]) 

%bottomSubplotPos = get(bottomPlot,'Position');
  %set(bottomPlot,'Position',[bottomSubplotPos(1), topSubplotPos(2)-topSubplotPos(4)-0.1, bottomSubplotPos(3:end)]) 


  
ySize = 12; xSize = 22; xLeft = 0; yTop = 0;
set( gcf, 'PaperUnits','centimeters', 'PaperPosition', [ xLeft yTop xSize ySize ] );
print('-dpng', 'StrategyComparisonInBoS', '-r600');
print('-depsc', 'StrategyComparisonInBoS', '-r600');



%% RT distributions

x = 0:0.001:3.5;
dltX = -2.7:0.001:2.7;
minToSee1 = 0.5;
indexBefore1 = dltX < -minToSee1;
indexAfter1 = dltX > minToSee1;
minToSee2 = 0.2;
indexBefore2 = dltX < -minToSee2;
indexAfter2 = dltX > minToSee2;

m1 = 1.0;
m2 = 1.0;
std1 = 0.1;
std2 = 0.2;
tau1 = 0.5;
tau2 = 0.5;
rt1 = exgauss_pdf(x, m1, std1, tau1);
rt2 = exgauss_pdf(x, m2, std2, tau2);
dRT = exgauss_diff_pdf(dltX, m1,std1,tau1,m2,std2,tau2);


figure
set( axes,'fontsize', FontSize, 'FontName', fontType);  
distrPlot0 = subplot(2,3,1:3:4)
hold on
plot (x, rt1, 'b-', 'linewidth', LineWidth);
plot (x, rt2, 'r-', 'linewidth', LineWidth);
hold off;
set( gca, 'fontsize', FontSize+1, 'FontName', fontType);
lHandle = legend('RT_1', 'RT_2', 'location', 'NorthEast');  
set(lHandle, 'fontsize', FontSize, 'FontName',fontType);  
xlabel( ' time [s] ', 'fontsize', FontSize+1, 'FontName', fontType);
ylabel( ' probability density ', 'fontsize', FontSize+1, 'FontName', fontType);
axis( [0.4, max(x), 0, max(rt1) + 0.1] );


distrPlot1 = subplot(2,3,2:3)
hold on
plot (dltX, dRT, 'k-', 'linewidth', LineWidth);
area(dltX(indexBefore1), dRT(indexBefore1),'LineStyle',':', 'FaceColor', [0.2, 0.3, 1.0]);
area(dltX(indexAfter1), dRT(indexAfter1),'LineStyle',':', 'FaceColor', [1.0, 0.3, 0.2]);  
hold off;
%lHandle = legend('$\Delta\mathrm{RT}$', '$p^1_\mathrm{see}(\Delta T = 0.5)$', '$p^2_\mathrm{see}(\Delta T = 0.5)$', 'location', 'NorthEast');  
%set(lHandle, 'fontsize', FontSize, 'FontName',fontType, 'Interpreter', 'latex');  
set( gca, 'fontsize', FontSize+1, 'FontName', fontType);
ylabel( ' probability density ', 'fontsize', FontSize+1, 'FontName', fontType);
%title('$\mathrm{RT}_1 - \mathrm{RT}_2$, time interval for seeing action: 0.5 s', 'fontsize', FontSize+1, 'FontName',fontType, 'Interpreter', 'latex')
title('{RT}_1 - {RT}_2, time interval for seeing action: 0.5 s', 'fontsize', FontSize, 'FontName',fontType)
text(-2.5, 0.8*max(dRT), {'Probability that', 'Player 1 sees', 'partner''s choice'}, 'fontsize', FontSize, 'FontName', fontType)
text(0.9, 0.8*max(dRT), {'Probability that', 'Player 2 sees', 'partner''s choice'}, 'fontsize', FontSize, 'FontName', fontType)
axis( [min(dltX), max(dltX)+1, 0, 1.15*max(dRT)] );
%axis( [min(dltX), max(dltX), 0, 1.15*max(dRT)] );


distrPlot2 = subplot(2,3,5:6)
hold on
plot (dltX, dRT, 'k-', 'linewidth', LineWidth);
area(dltX(indexBefore2), dRT(indexBefore2),'LineStyle',':', 'FaceColor', [0.2, 0.3, 1.0]);
area(dltX(indexAfter2), dRT(indexAfter2),'LineStyle',':', 'FaceColor', [1.0, 0.3, 0.2]);  
hold off;
%lHandle = legend('$\Delta\mathrm{RT}$', '$p^1_\mathrm{see}(\Delta T = 0.2)$', '$p^2_\mathrm{see}(\Delta T = 0.2)$', 'location', 'NorthEast');  
%set(lHandle, 'fontsize', FontSize, 'FontName',fontType, 'Interpreter', 'latex');  
set( gca, 'fontsize', FontSize+1, 'FontName', fontType);
xlabel( ' time interval between players` actions [s] ', 'fontsize', FontSize, 'FontName', fontType);
ylabel( ' probability density ', 'fontsize', FontSize+1, 'FontName', fontType);
%title('$\mathrm{RT}_1 - \mathrm{RT}_2$, time interval for seeing action: 0.2 s', 'fontsize', FontSize+1, 'FontName',fontType, 'Interpreter', 'latex')
title('{RT}_1 - {RT}_2, time interval for seeing action: 0.2 s', 'fontsize', FontSize, 'FontName',fontType)
text(-2.5, 0.8*max(dRT), {'Probability that', 'Player 1 sees', 'partner''s choice'}, 'fontsize', FontSize, 'FontName', fontType)
text(0.9, 0.8*max(dRT), {'Probability that', 'Player 2 sees', 'partner''s choice'}, 'fontsize', FontSize, 'FontName', fontType)
axis( [min(dltX), max(dltX)+1, 0, 1.15*max(dRT)] );

set( gcf, 'PaperUnits','centimeters' );
xSize = 24; ySize = 10.6;
xLeft = 0; yTop = 0;
set( gcf,'PaperPosition', [ xLeft yTop xSize ySize ] );
print ( '-depsc', '-r600', 'rtDistribAndPsee.eps');
print ( '-dpng', '-r600', 'rtDistribAndPsee.png');


%% show shares of own choise for new humans
filenames = {'DATA_20181030T155123.A_181030ID0061S1.B_181030ID0062S1.SCP_01.triallog.A.181030ID0061S1.B.181030ID0062S1_IC_JointTrials.isOwnChoice_sideChoice.mat',...
    'DATA_20181031T135826.A_181031ID63S1.B_181031ID64S1.SCP_01.triallog.A.181031ID63S1.B.181031ID64S1_IC_JointTrials.isOwnChoice_sideChoice.mat',...
    'DATA_20181031T170224.A_181031ID65S1.B_181031ID66S1.SCP_01.triallog.A.181031ID65S1.B.181031ID66S1_IC_JointTrials.isOwnChoice_sideChoice.mat',...
    'DATA_20181101T133927.A_181101ID67S1.B_181101ID68S1.SCP_01.triallog.A.181101ID67S1.B.181101ID68S1_IC_JointTrials.isOwnChoice_sideChoice.mat',...
    'DATA_20181102T131833.A_181102ID69S1.B_181102ID70S1.SCP_01.triallog.A.181102ID69S1.B.181102ID70S1_IC_JointTrials.isOwnChoice_sideChoice.mat'};                
              
%titleText = {'Share own', 'Macaque confederate training (reaction times)'};

averWindow = 4;
for iFigure = 1:5
load([folder '\' filenames{iFigure}]);

a = sum(xor(isOwnChoice,isBottomChoice),2)
acquistionTime = movmean([PerTrialStruct.A_TargetAcquisitionRT'; PerTrialStruct.B_TargetAcquisitionRT'], averWindow, 2); 
initFixTime = movmean([PerTrialStruct.A_InitialTargetReleaseRT'; PerTrialStruct.B_InitialTargetReleaseRT'], averWindow, 2); 
figure('Name', ['Pair ' num2str(iFigure)])
for iPlot = 1:4
    if ((iPlot == 1) || (iPlot == 2))
        minY = 0;
        maxY = 1.1;
    elseif (iPlot == 3)    
    	minY = 0.95*min(min(acquistionTime));
        maxY = 1.05*max(max(acquistionTime));
    else 
    	minY = 0.95*min(min(initFixTime));
        maxY = 1.05*max(max(initFixTime));        
    end    
    subplot(2,2,iPlot)
    hold on
    fill([100,300,300,100], [minY, minY, maxY, maxY], [0.8,0.8,0.8]);
    if (iPlot == 1)
        h1 = plot ( movmean(isOwnChoice(1,:), averWindow), 'color', [1,0,0], 'linewidth', LineWidth);
        h2 = plot ( movmean(isOwnChoice(2,:), averWindow)+0.005, 'color', [0,0,1], 'linewidth', LineWidth);
    elseif (iPlot == 2)
        h1 = plot ( movmean(isBottomChoice(1,:), averWindow), 'color', [1,0,0], 'linewidth', LineWidth);
        h2 = plot ( movmean(isBottomChoice(2,:), averWindow)+0.005, 'color', [0,0,1], 'linewidth', LineWidth);
    elseif (iPlot == 3)      
        plot ( acquistionTime(1,:), 'color', [1,0,0], 'linewidth', LineWidth);
        plot ( acquistionTime(2,:), 'color', [0,0,1], 'linewidth', LineWidth); 
    else        
        plot ( initFixTime(1,:), 'color', [1,0,0], 'linewidth', LineWidth);
        plot ( initFixTime(2,:), 'color', [0,0,1], 'linewidth', LineWidth);
    end    
    hold off;
    set( gca, 'fontsize', FontSize, 'FontName', fontType);
    xlabel( ' trials ', 'fontsize', FontSize, 'FontName', fontType);
    %title(titleText{iPlot}, 'fontsize', FontSize, 'FontName',fontType)
    if (iPlot == 1)
        %lHandle = legend([h1, h2], 'Player 1', 'Player 2', 'location', 'Northwest');
        %set(lHandle, 'fontsize', FontSize, 'FontName',fontType);
        ylabel( ' share of Insist choices ', 'fontsize', FontSize, 'FontName', fontType);
        axis( [1, length(isOwnChoice(2,:)), minY, maxY]);
    elseif (iPlot == 2)
        %lHandle = legend([h1, h2], 'Player 1', 'Player 2', 'location', 'Northwest');
        %set(lHandle, 'fontsize', FontSize, 'FontName',fontType);
        ylabel( ' share of Left choices ', 'fontsize', FontSize, 'FontName', fontType);
        axis( [1, length(isOwnChoice(2,:)), minY, maxY]);        
    elseif (iPlot == 3)
        ylabel( ' acquisition time [ms] ', 'fontsize', FontSize, 'FontName', fontType);
        axis( [1, length(isOwnChoice(2,:)), minY, maxY]);
    else
        ylabel( ' init. fix. time [ms] ', 'fontsize', FontSize, 'FontName', fontType);
        axis( [1, length(isOwnChoice(2,:)), minY, maxY]);
    end    
end
set( gcf, 'PaperUnits','centimeters' );
xSize = 15; ySize = 8; %10;
xLeft = 0; yTop = 0;
set( gcf,'PaperPosition', [ xLeft yTop xSize ySize ] );
print ( '-dpng', '-r600', ['newHuman', num2str(iFigure), '.png']);
print ( '-depsc', '-r600', ['newHuman', num2str(iFigure), '.eps']);
end




%% check average rewards for late monkey sessions

lfFilenames = {...
    'DATA_20180418T143951.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20180419T141311.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20180424T121937.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20180425T133936.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20180426T171117.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
    'DATA_20180427T142541.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat'};
    
targetConfFilenames = {...
        'DATA_20180528T132259.A_Tesla.B_Curius.SCP_01.triallog.A.Tesla.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
        'DATA_20180530T153325.A_Tesla.B_Curius.SCP_01.triallog.A.Tesla.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
        'DATA_20180530T153325.A_Tesla.B_Curius.SCP_01.triallog.A.Tesla.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
        'DATA_20180507T151756.A_Tesla.B_Flaffus.SCP_01.triallog.A.Tesla.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
        'DATA_20180508T132214.A_Tesla.B_Flaffus.SCP_01.triallog.A.Tesla.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
        'DATA_20180509T122330.A_Tesla.B_Flaffus.SCP_01.triallog.A.Tesla.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
        'DATA_20181204T133846.A_Curius.B_Linus.SCP_01.triallog.A.Curius.B.Linus_IC_JointTrials.isOwnChoice_sideChoice.mat', ...    
        'DATA_20181210T150823.A_Curius.B_Linus.SCP_01.triallog.A.Curius.B.Linus_IC_JointTrials.isOwnChoice_sideChoice.mat',...
        'DATA_20181211T134136.A_Curius.B_Linus.SCP_01.triallog.A.Curius.B.Linus_IC_JointTrials.isOwnChoice_sideChoice.mat'};

targetNaiveFilenames = {...
        'DATA_20171101T123413.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat', ...    
        'DATA_20171102T102500.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
        'DATA_20171103T143324.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
        'DATA_20181115T084458.A_Linus.B_Elmo.SCP_01.triallog.A.Linus.B.Elmo_IC_JointTrials.isOwnChoice_sideChoice.mat', ...        
        'DATA_20181116T083235.A_Linus.B_Elmo.SCP_01.triallog.A.Linus.B.Elmo_IC_JointTrials.isOwnChoice_sideChoice.mat', ...    
        'DATA_20181120T083354.A_Linus.B_Elmo.SCP_01.triallog.A.Linus.B.Elmo_IC_JointTrials.isOwnChoice_sideChoice.mat'};
    
sideConfFilenames = {... 
        'DATA_20180613T095441.A_Curius.B_Elmo.SCP_01.triallog.A.Curius.B.Elmo_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
        'DATA_20180614T092826.A_Curius.B_Elmo.SCP_01.triallog.A.Curius.B.Elmo_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
        'DATA_20180615T111344.A_Curius.B_Elmo.SCP_01.triallog.A.Curius.B.Elmo_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
        'DATA_20180212T164357.A_Magnus.B_Curius.SCP_01.triallog.A.Magnus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
        'DATA_20180213T152733.A_Magnus.B_Curius.SCP_01.triallog.A.Magnus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
        'DATA_20180214T171119.A_Magnus.B_Curius.SCP_01.triallog.A.Magnus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat'};

        
sideNaiveFilenames = {... 
        'DATA_20180522T101558.A_Tesla.B_Elmo.SCP_01.triallog.A.Tesla.B.Elmo_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
        'DATA_20180523T092531.A_Tesla.B_Elmo.SCP_01.triallog.A.Tesla.B.Elmo_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
        'DATA_20180524T103704.A_Tesla.B_Elmo.SCP_01.triallog.A.Tesla.B.Elmo_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
        'DATA_20171121T103828.A_Magnus.B_Curius.SCP_01.triallog.A.Magnus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat',...    
        'DATA_20171122T102507.A_Magnus.B_Curius.SCP_01.triallog.A.Magnus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat',...
        'DATA_20171123T101549.A_Magnus.B_Curius.SCP_01.triallog.A.Magnus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice.mat',...
        'DATA_20180123T151927.A_Magnus.B_Flaffus.SCP_01.triallog.A.Magnus.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice.mat', ...
        'DATA_20180124T161657.A_Magnus.B_Flaffus.SCP_01.triallog.A.Magnus.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice.mat',...
        'DATA_20180125T155742.A_Magnus.B_Flaffus.SCP_01.triallog.A.Magnus.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice.mat'};
        
groupNames = {lfFilenames,targetConfFilenames,targetNaiveFilenames,sideConfFilenames, sideNaiveFilenames};

nGroup = length(groupNames);
averageReward = cell(nGroup, 1);
allAverageReward = [];
indexAverageReward = [];
for iGroup = 1:nGroup
    group = groupNames{iGroup};
    nFile = length(group);
    averageReward{iGroup} = zeros(1, nFile);
    for iFile = 1:nFile
        load([folder '\' group{iFile}]);
        index = 21:length(isOwnChoice);
        n = length(index);
        nCoordinated = sum(xor(isOwnChoice(1,index),isOwnChoice(2,index)));
        nOwnOwn = sum(and(isOwnChoice(1,index),isOwnChoice(2,index)));
        averageReward{iGroup}(iFile) = 1 + (nOwnOwn + 2.5*nCoordinated)/n;
        
        allAverageReward = [allAverageReward, averageReward{iGroup}(iFile)];
        indexAverageReward = [indexAverageReward, iGroup];
    end    
end    
figure
boxplot(allAverageReward, indexAverageReward,'Labels',{'LF confederate (F-C)','target confederate (T-C,T-F)','target both naive (F-C, T-E, E-L)','side confederate (M-C,C-E,C-L)', 'side both naive (M-C,M-F)'})