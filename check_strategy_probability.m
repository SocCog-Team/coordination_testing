function [logMeanSrategyProbability, strategyProbability] = ...
    check_strategy_correlation(target, side, RT, strategy)

% for each trial starting from 2nd compute row and column indices
% describing the corresponding entry in strategy matrix
[rowIndex, colIndex] = compute_strategy_entries(target, side, RT);

% compute expectation of own choices for each time point basedon the strategy
ownChoiceExpectation = target; % preallocate and initialize dirst trials
                               % for those we assume strategy to be precise
for iTrial = 2:nTrial
    iRow = rowIndex(iTrial-1);
    for iPlayer = 1:2
        iCol = colIndex(iPlayer, iTrial-1);
        ownChoiceExpectation(iPlayer, iTrial) = strategy{iPlayer}(iRow, iCol);        
    end
end

% For own choices probability is estimated by expectation of own choice
strategyProbability = ownChoiceExpectation;
% For other choices probability is just (1 - expectation of own choice)
otherChoiceIndex = (target == 0);
strategyProbability(otherChoiceIndex) = 1 - ownChoiceExpectation(otherChoiceIndex);

logMeanSrategyProbability = exp(mean(log(strategyProbability), 2));
end