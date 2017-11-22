FontSize = 11;
lineWidth = 1.0;

order = 1;
minSampleNum = 3*4.^(order+1);

filename = {'humanData_pair01.mat', 'humanData_pair02.mat',  ...
            'humanData_pair03.mat', 'humanData_pair04.mat', ...
            'humanData_pair05.mat', 'edData_best0.mat', ...
            'rlData_noncuriousVSnoncurious2.mat', 'rlData_noncuriousVScurios.mat', ...
            'rlData_curiosVScurios.mat'};

description = {'human pair 1', 'human pair 2',  'human pair 3', ...
               'human pair 4', 'human pair 5',  'evolutionary agents', ...
               'non-curious RL agents', 'non-curious vs curious RL agent',  'curious RL agents'};    
             
plotName = {'TEtarget', 'MutualInf', 'surprise_pos'};             

nFile = length(filename);          
targetTE1 = cell(1, nFile);
targetTE2 = cell(1, nFile);
mutualInf = cell(1, nFile);

maxValue = 0;
minValue = 0;
minMIvalue = 0;
maxMIvalue = 0;
for iFile = 1:nFile 
  load(filename{iFile}, 'isOwnChoice', 'isBottomChoice'); 
  x = isOwnChoice(1, :);
  y = isOwnChoice(2, :);
  targetTE1{iFile} = calc_local_transfer_entropy(x, y, order, minSampleNum);
  targetTE2{iFile} = calc_local_transfer_entropy(y, x, order, minSampleNum);
  mutualInf{iFile} = calc_local_mutual_information(x, y, minSampleNum);
  minValue = min([minValue, min(targetTE2{iFile}), min(targetTE2{iFile})]);
  maxValue = max([maxValue, max(targetTE1{iFile}), max(targetTE2{iFile})]);
  minMIvalue = min([minMIvalue, min(mutualInf{iFile})]);
  maxMIvalue = max([maxMIvalue, max(mutualInf{iFile})]);
end    

for iPlot = 1:2
  figure
  set( axes,'fontsize', FontSize,  'FontName', 'Arial');%'FontName', 'Times'); 

  for iFile = 1:nFile 
    subplot(3, 3, iFile)    
    hold on
    if (iPlot == 1)
      plot(targetTE1{iFile}, 'r-', 'linewidth', lineWidth)    
      plot(targetTE2{iFile}, 'b--', 'linewidth', lineWidth)    
    else
      plot([1, length(mutualInf{iFile})], [0 0], 'k--', 'linewidth', 1.2)
      plot(mutualInf{iFile}, 'Color', [0.4, 0.1, 0.4], 'linewidth', lineWidth)
    end        
    hold off
    set( gca, 'fontsize', FontSize,  'FontName', 'Arial');%'FontName', 'Times');      
    
    if (iPlot == 1)
      axis([0.8, length(targetTE1{iFile}) + 0.2, 1.01*minValue, 1.01*maxValue]);
    elseif (iPlot == 2)
      axis([0.8, length(mutualInf{iFile}) + 0.2, 1.01*minMIvalue, 1.01*maxMIvalue]);
    end        
    
    
    if (iFile == 1)
      if (iPlot == 1)
        legendHandle = legend('$\mathrm{te_{P2\rightarrow P1}}$', '$\mathrm{te_{P1\rightarrow P2}}$', 'location', 'NorthEast');  
      elseif (iPlot == 2)
        legendHandle = legend('$\mathrm{i(P1,P2)}$', 'location', 'NorthEast');  
      end        
      set(legendHandle, 'fontsize', FontSize-1, 'FontName', 'Times', 'Interpreter', 'latex');
    end  
    
    title(description{iFile}, 'fontsize', FontSize,  'FontName', 'Arial');%'FontName', 'Times', 'Interpreter', 'latex');
  end  
  set( gcf, 'PaperUnits','centimeters' );
  set(gcf,'PaperSize',fliplr(get(gcf,'PaperSize'))) 
  xSize = 21; ySize = 21;
  xLeft = 0; yTop = 0;
  set( gcf,'PaperPosition', [ xLeft yTop xSize ySize ] );
  print ( '-depsc', '-r600', plotName{iPlot});
  print('-dpdf', plotName{iPlot}, '-r600');
end

%% draw pictures for single recordings
fileOfInterest = [1,2,3,4,5];
nFileOfInterest = length(fileOfInterest);
for iFile = 1:nFileOfInterest 
  trueFileIndex = fileOfInterest(iFile);
  load(filename{trueFileIndex}, 'isOwnChoice', 'isBottomChoice'); 
  
  figure
  set( axes,'fontsize', FontSize,  'FontName', 'Arial');%'FontName', 'Times');  
  totalReward = 1 + 2.5*(isOwnChoice(1,:)+isOwnChoice(2,:));
  totalReward(totalReward == 6) = 2;
  subplot(4, 1, 1);
  plot(totalReward, 'k-', 'linewidth', lineWidth);
  set( gca, 'fontsize', FontSize,  'FontName', 'Arial');%'FontName', 'Times');  
  axis([0.8, length(isOwnChoice(1,:)) + 0.2, 0.5, 4.5]);
  legendHandle = legend('Joint reward', 'location', 'NorthWest');  
  set(legendHandle, 'fontsize', FontSize-1,  'FontName', 'Arial');%'FontName', 'Times', 'Interpreter', 'latex');
  title(description{trueFileIndex}, 'fontsize', FontSize,  'FontName', 'Arial');%'FontName', 'Times', 'Interpreter', 'latex');
  
  subplot(4, 1, 2);
  hold on
  plot(isOwnChoice(1,:), 'r-', 'linewidth', lineWidth+1);
  plot(isOwnChoice(2,:), 'b--', 'linewidth', lineWidth);
  hold off
  set( gca, 'fontsize', FontSize,  'FontName', 'Arial', 'yTick', [0,1], 'yTickLabel', {'Partner`s', 'Own'});%'FontName', 'Times');  
  axis([0.8, length(isOwnChoice(1,:)) + 0.2, -0.2, 1.5]);
  legendHandle = legend('choices P1', 'choices P2', 'location', 'NorthWest');  
  set(legendHandle, 'fontsize', FontSize-1,  'FontName', 'Arial');%'FontName', 'Times', 'Interpreter', 'latex'); 
  
  subplot(4, 1, 3);
  hold on
  plot(targetTE1{trueFileIndex}, 'r-', 'linewidth', lineWidth+1);    
  plot(targetTE2{trueFileIndex}, 'b--', 'linewidth', lineWidth);    
  hold off
  set( gca, 'fontsize', FontSize,  'FontName', 'Arial');%'FontName', 'Times');  
  axis([0.8, length(targetTE1{trueFileIndex}) + 0.2, 1.01*minValue, 1.01*maxValue]);  
  legendHandle = legend('$\mathrm{te_{P2\rightarrow P1}}$', '$\mathrm{te_{P1\rightarrow P2}}$', 'location', 'NorthWest');  
  set(legendHandle, 'fontsize', FontSize-1, 'FontName', 'Times', 'Interpreter', 'latex');

  
  subplot(4, 1, 4);
  plot(mutualInf{trueFileIndex}, 'm-', 'linewidth', lineWidth)    
  set( gca, 'fontsize', FontSize,  'FontName', 'Arial');%'FontName', 'Times');  
  axis([0.8, length(mutualInf{trueFileIndex}) + 0.2, 1.01*minMIvalue, 1.01*maxMIvalue]);  
  legendHandle = legend('$\mathrm{i(P1,P2)}$', 'location', 'NorthWest');  
  set(legendHandle, 'fontsize', FontSize-1, 'FontName', 'Times', 'Interpreter', 'latex');

  
  set( gcf, 'PaperUnits','centimeters' );
  xSize = 21; ySize = 29;
  xLeft = 0; yTop = 0;
  set( gcf,'PaperPosition', [ xLeft yTop xSize ySize ] );
  print ( '-depsc', '-r600', description{trueFileIndex});
  print('-dpdf', description{trueFileIndex}, '-r600');
end  
