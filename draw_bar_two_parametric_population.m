function draw_bar_two_parametric_population(data, legendLabel, xTicksLabel, fontType, fontSize, pValue)

  [nBars, nDataSource] = size(data);  
  meanValue = cellfun(@mean, data);
  confIntValue = cellfun(@std, data);
  calc_cihw(cellfun(@std, data), cellfun(@std, data), pValue);
  
  maxValue = max(max(cellfun(@max, data))) + 0.1;
  minValue = min(min(min(cellfun(@max, data))) - 0.1, 0);
    
  xRange = 1:nBars;
  if (mod(nDataSource,2))
    marginValue = fix(nDataSource/2);
  else
    marginValue = (nDataSource-1)/2;
  end
  offset = -marginValue:marginValue;
  smooshFactor = 0.8;
  barWidth = 0.85*smooshFactor/nDataSource;

  colorVector = (0:nDataSource-1)/(nDataSource-1);
  barColor = [1 - 0.75*colorVector; 0.4 + 0.1*colorVector; 0.25 + 0.5*colorVector];
  %barColor = [min(0.7 + 0.4*colorVector, 1); 0.35 + 0.5*colorVector; max(0.8 - 0.9*colorVector, 0)];
  barHandle = [];
  
  hold on;
  for i = 1:nDataSource
    barOrigins = xRange + smooshFactor*(offset(i)/nDataSource);
    b = bar(barOrigins, meanValue(:, i), barWidth, 'FaceColor', barColor(:, i));
    barHandle = [barHandle b]; 
    errorbar(barOrigins, meanValue(:, i), confIntValue(:, i), 'LineStyle', 'none', 'color', 'black');
    for iBar = 1:nBars
        xValue = barOrigins(iBar)*ones(1, length(data{iBar, i}));
        scatter(xValue, data{iBar, i}, 15, [0,0,0]);
    end    
  end  
  %bar(barX, barData); 
  %errorbar(barX, barData, errData, 'o')
  hold off; 
  if (~isempty(legendLabel))
    legend_handleMain = legend(barHandle, legendLabel, 'location', 'NorthEast'); 
    set(legend_handleMain, 'fontsize', fontSize, 'FontName', fontType);%, 'FontName','Times', 'Interpreter', 'latex');
    pos = get(legend_handleMain, 'Position');
    set(legend_handleMain, 'Position', [pos(1) + 0.1, pos(2) + 0.07, pos(3:4)]);
    legend boxoff
  end  
  
  axis([0.5, nBars + 0.5, minValue, maxValue]);
  %axis([0.5, nBars + 1.5, 0, maxValue]);
  set( gca, 'XTick', 1:nBars, 'XTickLabel', xTicksLabel, 'fontsize', fontSize, 'FontName',fontType);   
end
