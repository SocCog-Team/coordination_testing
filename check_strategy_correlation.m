function corrCoef = check_strategy_correlation(target, RT, strategy)
  if (~exist('RT', 'var'))
    extendedStrategy = false;
  else  
    extendedStrategy = true;
    minDRT = 200;
    dRT = RT - RT(2:-1:1, :);
  end 
  nTrial = length(target);
  
  predictedTarget = target;
  
  trialOutcome = 1 + 2*target + target(2:-1:1, :);
  
  for iTrial = 2:nTrial
    for iPlayer = 1:2
      currState = trialOutcome(iPlayer, iTrial - 1);  
      if (extendedStrategy) && (dRT(iPlayer, iTrial) > minDRT) 
      % if RT is available and iPlayer reacted later, having enough time to see partners choice
        currState = currState + 4 + 4*target(2 - iPlayer, iTrial-1);        
      end
      predictedTarget(iPlayer, iTrial) = strategy(currState);
    end  
  end
  corrCoef = corr(target(:, 2:end), predictedTarget(:, 2:end));
end