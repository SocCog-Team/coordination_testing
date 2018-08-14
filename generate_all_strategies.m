function [strategyArray, strategyNames] = generate_all_strategies() 
% prepare strategies for testing
strategyNames = {'Own target following', 'Other target following', ...
                 'Left side following', 'Right side following', ...
                 'Side turn-taking', 'Turn-taking', 'Challenger', ... 
                 'Long turn-taking', 'Leader-Follower', 'Follower', ...
                 };
nStrategy = length(strategyNames);
strategyArray = cell(1, nStrategy);

nRow = 4;     
nCol = 12;
for iStrategy = 1:nStrategy
    strategyArray{iStrategy} = zeros(nRow, nCol);
end

PARAM_MARK = 2;
maxParamValue = ones(1, nStrategy);
% ----------Side Strategies----------
%{
% Left side following
strategyArray{1}(1, [11,12]) = 1;
strategyArray{1}(1, [1,2, 5,6, 9,10]) = 0.5;
strategyArray{1}(2, [3,4, 7,8, 11,12]) = 1;
strategyArray{1}(2, [1,2, 5,6, 9,10]) = 0.5;
strategyArray{1}(3, [9,10]) = 1;
strategyArray{1}(3, [3,4, 7,8, 11,12]) = 0.5;
strategyArray{1}(4, [1,2, 5,6, 9,10]) = 1;
strategyArray{1}(4, [3,4, 7,8, 11,12]) = 0.5;

% Right side following
strategyArray{2}(4, [11,12]) = 1;
strategyArray{2}(4, [1,2, 5,6, 9,10]) = 0.5;
strategyArray{2}(3, [3,4, 7,8, 11,12]) = 1;
strategyArray{2}(3, [1,2, 5,6, 9,10]) = 0.5;
strategyArray{2}(2, [9,10]) = 1;
strategyArray{2}(2, [3,4, 7,8, 11,12]) = 0.5;
strategyArray{2}(1, [1,2, 5,6, 9,10]) = 1;
strategyArray{2}(1, [3,4, 7,8, 11,12]) = 0.5;
%}
% ------- basic strategies --------
% Insister
strategyArray{1}(1, 1:12) = 1;
% Conformist (the same as Follower, but without clear temporal following)
strategyArray{2}(1, 5:12) = 0.5;

% Cautious left side following
strategyArray{3}(1, 1:6) = PARAM_MARK;  %indicates parameter value that should be computed
strategyArray{3}(1, 9:12) = 1;
strategyArray{3}(2, :) = 1;
strategyArray{3}(3, [1,2, 5,6]) = PARAM_MARK;  %indicates parameter value that should be computed;
strategyArray{3}(3, [9,10]) = 1;
strategyArray{3}(3, [3,4, 7,8, 11,12]) = 0.5;
strategyArray{3}(4, [1,2, 5,6, 9,10]) = 1;
strategyArray{3}(4, [3,4, 7,8, 11,12]) = 0.5;
maxParamValue(3) = 0.6;

% Cautious right side following
strategyArray{4}(4, 1:6) = PARAM_MARK;  %indicates parameter value that should be computed
strategyArray{4}(4, 9:12) = 1;
strategyArray{4}(3, :) = 1;
strategyArray{4}(2, [1,2, 5,6]) = PARAM_MARK;  %indicates parameter value that should be computed
strategyArray{4}(2, [9,10]) = 1;
strategyArray{4}(2, [3,4, 7,8, 11,12]) = 0.5;
strategyArray{4}(1, [1,2, 5,6, 9,10]) = 1;
strategyArray{4}(1, [3,4, 7,8, 11,12]) = 0.5;
maxParamValue(4) = 0.6;

% ------- more complex strategies strategies --------
% Side turn-taking
strategyArray{5}(1, [1,4, 5,7,8, 9,10,12]) = 0.5;
strategyArray{5}(1, [3, 11]) = 1;
strategyArray{5}(2, [1,4, 5,7,8, 9,11,12]) = 0.5;
strategyArray{5}(2, [2, 10]) = 1;
strategyArray{5}(3:4, :) = strategyArray{5}(2:-1:1, :);

% Turn-taking
strategyArray{6}(1, [3,7,9:12]) = 1;
strategyArray{6}(1, [1,4]) = PARAM_MARK;  %indicates parameter value that should be computed

% Challenger
% not entirely stubborn, but still unyilding
strategyArray{7}(1, [2, 6, 9:12]) = 1;
strategyArray{7}(1, [1,4]) = 0.9; 
strategyArray{7}(1, [5,8]) = PARAM_MARK;

% Long-term turn-taking
% Similar to Challenger but behaviour after uncoordinated choice 
% in not important (should be rare)
% Human confederate can be classified either as challenger or as LT turn-taker
strategyArray{8}(1, [2, 6, 9:12]) = 1;
strategyArray{8}(1, [1,4]) = 0.5;
strategyArray{8}(1, [5,8]) = PARAM_MARK;

% Leader-Follower
strategyArray{9}(1, [1:3, 9:11]) = 1;
strategyArray{9}(1, [4,8,12]) = 0.5;

% Follower
strategyArray{10}(1, 9:11) = 1;
strategyArray{10}(1, [4,8,12]) = 0.5;

% in target strategies all rows are the same, so just copy them
targetStrategyIndex = [1,2, 6:nStrategy];
for iStrategy = targetStrategyIndex
    strategyArray{iStrategy}(2:4,:) = repmat(strategyArray{iStrategy}(1,:), 3, 1);
end

% allow for "trembling hand effect"
minErrorProb = 0.01;
for iStrategy = 1:nStrategy
    strategyArray{iStrategy}(strategyArray{iStrategy} == 1) = 1 - minErrorProb;
    strategyArray{iStrategy}(strategyArray{iStrategy} == 0) = minErrorProb;
end
% ---------end of strategy description---------
end
