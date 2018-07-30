function [strategy, nStateVisit] = estimate_strategy(target, side, RT, minDRT)
nRow = 4;      % previous location x current location
nColBasic = 4; % previous own choice x previous partner choce
if (~exist('RT', 'var'))
    nCol = nColBasic;
    RT = zeros(size(target));
else
    nCol = 3*nColBasic; % 3 possible partner choices: invisible, own, other
end
if (~exist('minDRT', 'var'))
    minDRT = 0;
end
nTrial = length(target);
nStateVisit = cell(2, 1);
strategy = cell(2, 1);
for iPlayer = 1:2
    nStateVisit{iPlayer} = zeros(nRow, nCol);
    strategy{iPlayer} = zeros(nRow, nCol);
end

% for each trial starting from 2nd compute row and column indices
% describing the corresponding entry in strategy matrix
[rowIndex, colIndex] = compute_strategy_entries(target, side, RT, minDRT);

% compute number of visits in each entry of a strategy and probability to
% select own in each entry (the strategy)
for iTrial = 2:nTrial
    iRow = rowIndex(iTrial-1);
    for iPlayer = 1:2
        iCol = colIndex(iPlayer, iTrial-1);
        nStateVisit{iPlayer}(iRow, iCol) = nStateVisit{iPlayer}(iRow, iCol) + 1;
        strategy{iPlayer}(iRow, iCol) = strategy{iPlayer}(iRow, iCol) + target(iPlayer, iTrial);
    end
end
strategy = cellfun(@rdivide, strategy, nStateVisit, 'UniformOutput', false);
end