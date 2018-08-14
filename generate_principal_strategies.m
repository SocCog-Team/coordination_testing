function [strategyArray, strategyNames] = generate_principal_strategies() 
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

% ------- basic strategies --------
% Insister
strategyArray{1}(1, 1:12) = 1;
% Conformist (the same as Follower, but without clear temporal following)
strategyArray{2}(1, 5:12) = 0.5;

% Left side following
strategyArray{3}(1, [1,2, 5,6, 9,10]) = 0.1;  % other with a slight bias for own
%strategyArray{3}(1, [3,4]) = 0.1;             % other with a slight bias for own
strategyArray{3}(2, [3,4, 7,8, 11,12]) = 1;
strategyArray{3}(2, [1,2, 5,6, 9,10]) = 0.6;  % random with a slight bias for own
%strategyArray{3}(3, [9,10]) = 1;
strategyArray{3}(3, [3,4, 7,8, 11,12]) = 0.1; % random with a slight bias for own
%strategyArray{3}(3, [1,2]) = 0.1;             % other with a slight bias for own
strategyArray{3}(4, [1,2, 5,6, 9,10]) = 1;
strategyArray{3}(4, [3,4, 7,8, 11,12]) = 0.6; % random with a slight bias for own

% Right side following
%strategyArray{4}(4, [11,12]) = 1;
strategyArray{4}(4, [1,2, 5,6, 9,10]) = 0.1;  % random with a slight bias for own
%strategyArray{4}(4, [3,4]) = 0.1;             % other with a slight bias for own
strategyArray{4}(3, [3,4, 7,8, 11,12]) = 1;
strategyArray{4}(3, [1,2, 5,6, 9,10]) = 0.6;  % random with a slight bias for own
%strategyArray{4}(2, [9,10]) = 1;
strategyArray{4}(2, [3,4, 7,8, 11,12]) = 0.1; % random with a slight bias for own
%strategyArray{4}(2, [1,2]) = 0.1;             % other with a slight bias for own
strategyArray{4}(1, [1,2, 5,6, 9,10]) = 1;
strategyArray{4}(1, [3,4, 7,8, 11,12]) = 0.6; % random with a slight bias for own

% ------- more complex strategies --------
% Side turn-taking
strategyArray{5}(1, [1,4, 5,7,8, 9,10,12]) = 0.5;
strategyArray{5}(1, [3, 11]) = 1;
strategyArray{5}(2, [1,4, 5,7,8, 9,11,12]) = 0.5;
strategyArray{5}(2, [2, 10]) = 1;
strategyArray{5}(3:4, :) = strategyArray{5}(2:-1:1, :);

% Turn-taking
strategyArray{6}(1, [3,7,9:12]) = 1;
strategyArray{6}(1, [1,4]) = 0.5;  

% Long-term turn-taking
% Similar to Challenger but behaviour after uncoordinated choice 
% in not important (should be rare)
% Human confederate can be classified either as challenger or as LT turn-taker
strategyArray{7}(1, [2, 6, 9:12]) = 1;
strategyArray{7}(1, [1,4]) = 0.5;
strategyArray{7}(1, [5,8]) = 0.1; % other with a slight bias for own;

% Challenger
% not entirely stubborn, but still unyilding
strategyArray{8}(1, [2, 6, 9:12]) = 1;
strategyArray{8}(1, [1,4]) = 0.9; 
strategyArray{8}(1, [5,8]) = 0.6;  % random with a slight bias for own


% ------- temporal strategies --------
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
