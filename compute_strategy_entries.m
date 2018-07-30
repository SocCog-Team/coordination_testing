function [rowIndex, colIndex] = compute_strategy_entries(target, side, RT, minDRT)
% stategy is described by a table of 4x12, with the following structure:
%
% orintation          | partner invisible | partner selects I | partner selects A
% (t-1)-th | t-th     | II | IA | AI | AA | II | IA | AI | AA | II | IA | AI | AA
% P1 left  | P1 left  |1, 1|1, 2|1, 3|1, 4|1, 5|1, 6|1, 7|1, 8|1, 9|1,10|1,11|1,12|
% P1 left  | P1 right |2, 1| ...
% P1 right | P1 left  |3, 1| ...
% P1 right | P1 right |4, 1| ...

if ((~exist('RT', 'var')) || (~exist('minDRT', 'var')) || (minDRT <= 0))
    actionOfPartnerVisible = zeros(2, length(target) - 1);
else
    dRT = RT - RT(2:-1:1, :);
    actionOfPartnerVisible = (dRT(:, 2:end) > minDRT);
end

% orient = 1 => own target for player 1 on the left/top
% orient = 0 => own target for player 1 on the right/bottom
orient = xor(target(1,:), side(1,:));
rowIndex = 2*orient(1:end-1) + orient(2:end) + 1;

trialOutcome = 2*target(:, 1:end-1) + target(2:-1:1, 1:end-1);
shiftDueToVisibility = 4.*(2 - target(2:-1:1, 2:end)).*(actionOfPartnerVisible);
% compute strategy column:
% first we shift depending on action visibility and than compute the
% index of previous outcome: II, IA, AI, AA
colIndex = shiftDueToVisibility + (4 - trialOutcome);
end