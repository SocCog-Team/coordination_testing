function [meanStrategyProbability, logMeanStrategyProbability, strategyProbability] = ...
    check_strategy_probability(target, side, strategy, RT, minDRT)

if (~exist('RT', 'var'))
    RT = zeros(size(target));
end
if (~exist('minDRT', 'var'))
    minDRT = 0;
end

% for each trial starting from 2nd compute row and column indices
% describing the corresponding entry in strategy matrix
[rowIndex, colIndex] = compute_strategy_entries(target, side, RT, minDRT);

% compute expectation of own choices for each time point basedon the strategy
ownChoiceExpectation = target; % preallocate and initialize dirst trials
                               % for those we assume strategy to be precise
nTrial = length(target);
                               
[~,nStrategy] = size(strategy);
strategyProbability = cell(1, nStrategy);
meanStrategyProbability = zeros(2, nStrategy);
logMeanStrategyProbability = zeros(2, nStrategy);
for iStrategy = 1:nStrategy
    for iTrial = 2:nTrial
        iRow = rowIndex(iTrial-1);
        for iPlayer = 1:2
            iCol = colIndex(iPlayer, iTrial-1);
            ownChoiceExpectation(iPlayer, iTrial) = strategy{iPlayer,iStrategy}(iRow, iCol);        
        end
    end

    % For own choices probability is estimated by expectation of own choice
    strategyProbability{iStrategy} = ownChoiceExpectation;
    % For other choices probability is just (1 - expectation of own choice)
    otherChoiceIndex = (target == 0);
    strategyProbability{iStrategy}(otherChoiceIndex) = 1 - ownChoiceExpectation(otherChoiceIndex);

    meanStrategyProbability(:, iStrategy) = mean(strategyProbability{iStrategy}, 2);
    logMeanStrategyProbability(:, iStrategy) = exp(mean(log(strategyProbability{iStrategy}), 2));
end    
end