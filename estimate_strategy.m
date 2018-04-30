function [strategy, nStateVisit] = estimate_strategy(target, side, RT)
  BASIC_STRATEGY_LENGTH = 16; %(previous own choice x previous partner choce X previous location x current location)
  if (~exist('RT', 'var'))
    extendedStrategy = false;
    strategyLength = BASIC_STRATEGY_LENGTH;
  else  
    extendedStrategy = true;
    minDRT = 200;
    dRT = RT - RT(2:-1:1, :);
    strategyLength = 3*BASIC_STRATEGY_LENGTH;
  end 
  nTrial = length(target);
  
  % orient = 1 => own target for player 1 on the left/top
  % orient = 0 => own target for player 1 on the right/bottom
  orient = xor(target(1,:), side(1,:));
  trialOutcome = 2*target + target(2:-1:1, :);
  nStateVisit = zeros(2, strategyLength);
  strategy = zeros(2, strategyLength);
  
  for iTrial = 2:nTrial
    for iPlayer = 1:2
      currState = 1 + trialOutcome(iPlayer, iTrial - 1) + ...
                  + 4*orient(iTrial - 1) + ...
                  + 8*orient(iTrial);  
      if (extendedStrategy) && (dRT(iPlayer, iTrial) > minDRT) 
      % if RT is available and iPlayer reacted later, having enough time to see partners choice
        currState = currState + BASIC_STRATEGY_LENGTH*(1+target(2 - iPlayer, iTrial - 1));        
      end
      nStateVisit(iPlayer, currState) = nStateVisit(iPlayer, currState) + 1;
      strategy(iPlayer, currState) = strategy(iPlayer, currState) + target(iPlayer, iTrial);
    end  
  end
  strategy = strategy./nStateVisit;
end