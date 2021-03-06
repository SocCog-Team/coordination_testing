function draw_bar_two_parametric_population(data, legendLabel, xTicksLabel, scatterSize, barColor, connectLines, pValue)

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

  %barColor = [min(0.7 + 0.4*colorVector, 1); 0.35 + 0.5*colorVector; max(0.8 - 0.9*colorVector, 0)];
  barHandle = [];
  
  hold on;
  barOrigins = zeros(nBars, nDataSource);
  for i = 1:nDataSource
      barOrigins(:, i) = xRange + smooshFactor*(offset(i)/nDataSource);
  end    
  
  for i = 1:nDataSource
      b = bar(barOrigins(:,i), meanValue(:, i), barWidth, 'FaceColor', barColor(:, i));
      barHandle = [barHandle b];
      if (~connectLines)
        errorbar(barOrigins(:,i), meanValue(:, i), confIntValue(:, i), 'LineStyle', 'none', 'color', 'black');
      end  
      for iBar = 1:nBars
          xValue = barOrigins(iBar, i)*ones(1, length(data{iBar, i}));
          scatter(xValue, data{iBar, i}, scatterSize, [0,0,0]);
      end
  end
  
  if (connectLines)
      for i = 1:nDataSource - 1
          for iBar = 1:nBars             
              nPoint = length(data{iBar, i});
              if (nPoint == length(data{iBar, i+1}))
                  for iPoint = 1:nPoint
                      line([barOrigins(iBar, i), barOrigins(iBar, i+1)], [data{iBar, i}(iPoint), data{iBar, i+1}(iPoint)], 'color', 'black');
                  end
              end
          end
      end
  end
 
 
  hold off; 
  if (~isempty(legendLabel))
    legend_handleMain = legend(barHandle, legendLabel, 'location', 'North', 'orientation', 'horizontal'); 
    set(legend_handleMain);
    %pos = get(legend_handleMain, 'Position');
    %set(legend_handleMain, 'Position', [pos(1) + 0.1, pos(2) + 0.07, pos(3:4)]);
    legend boxoff
  end  
  
  axis([0.5, nBars + 0.5, minValue, maxValue]);
  %axis([0.5, nBars + 1.5, 0, maxValue]);
  set( gca, 'XTick', 1:nBars, 'XTickLabel', xTicksLabel);   
end
