function plotProbabilitiesToSee(pSee, isOwnChoice, imageName, needToPlotSigmoid)

isOtherChoice = 1 - isOwnChoice;
nTrial = length(pSee);

[rValue1,pValue1] = corrcoef(pSee(1,:)', isOtherChoice(1,:)');
[rValue2,pValue2] = corrcoef(pSee(2,:)', isOtherChoice(2,:)');
corrCoefValue = [rValue1(2,1), rValue2(2,1)];
corrPValue = [pValue1(2,1), pValue2(2,1)];

windowSize = 10;
pSeeAveraged = movmean(pSee, windowSize, 2);
pAccomodate = movmean(isOtherChoice, windowSize, 2);
 
[rValue1,pValue1] = corrcoef(pSeeAveraged(1,:)', pAccomodate(1,:)');
[rValue2,pValue2] = corrcoef(pSeeAveraged(2,:)', pAccomodate(2,:)');
corrCoefAveraged = [rValue1(2,1), rValue2(2,1)];
corrPValueAveraged = [pValue1(2,1), pValue2(2,1)];


LineWidth = 2;
FontSize = 12;
fontType = 'Arial';

plotColor = [0.9290, 0.6940, 0.1250; ...
             0.4940, 0.1840, 0.5560];

figure
set( axes,'fontsize', FontSize, 'FontName', fontType);  
if needToPlotSigmoid
    subplot(2,3,1:3:4)
    x = 1:150;
    y = 1./(1 + exp(-k*(x - minDRT)));
    plot (x, y, 'linewidth', LineWidth);
    set( gca, 'fontsize', FontSize, 'FontName', fontType);
    xlabel( '$\Delta\mathrm{RT}$ [ms]', 'fontsize', FontSize, 'FontName', fontType, 'Interpreter', 'latex');
    ylabel( ' probability to see partner''s choice ', 'fontsize', FontSize, 'FontName', fontType);
    axis( [0, max(x), 0, 1.01] );
end

for iPlot = 1:2
    if needToPlotSigmoid
        subplot(2,3,(3*iPlot-3)+(2:3))
    else
        subplot(2,1,iPlot)
    end
    hold on
    lineHandle1 = plot (pSeeAveraged(iPlot,:), 'color', plotColor(1,:), 'linewidth', LineWidth);
    lineHandle2 = plot (pAccomodate(iPlot,:), 'color', plotColor(2,:), 'linewidth', LineWidth);
    hold off;
    lHandle = legend('probability to see partner''s choice', 'share of Accommodate choices', 'location', 'northoutside');
    set(lHandle, 'fontsize', FontSize-1, 'FontName',fontType);        
    set( gca, 'fontsize', FontSize, 'FontName', fontType);
    xlabel( ' trials ', 'fontsize', FontSize, 'FontName', fontType);
    ylabel( ' probability ', 'fontsize', FontSize, 'FontName', fontType);
    titleText = ['Player ', num2str(iPlot) ': ' sprintf('%.2f', corrCoefValue(iPlot)) ' (' sprintf('%.0d', corrPValue(iPlot)) ') / ' ...
                    sprintf('%.2f', corrCoefAveraged(iPlot)) ' (' sprintf('%.0d', corrPValueAveraged(iPlot)) ')']; 
    title(titleText, 'fontsize', FontSize, 'FontName',fontType)
    axis( [0, nTrial, 0, 1.1]);
end
%axis( [min(dltX), max(dltX), 0, 1.15*max(dRT)] );

set( gcf, 'PaperUnits','centimeters' );
xSize = 21; ySize = 15; %10;
xLeft = 0; yTop = 0;
set( gcf,'PaperPosition', [ xLeft yTop xSize ySize ] );
print ( '-depsc', '-r600', [imageName '.eps']);
print ( '-dtiff', '-r600', [imageName '.tiff']);
print ( '-dpng', '-r600', [imageName '.png']);
