function [ coordination_test_results ] = fn_compute_coordination_metrics_session( isOwnChoiceArray, sideChoiceArray, PerTrialStruct, cfg )
%FN_COMPUTE_COORDINATION_METRICS_SESSION Summary of this function goes here
%   This is supposed to do the same as compute_coortdination_mtrics, but
%   only for a single session and expects to get the data passed in instead
%   of being passed a (list of) file name(s) for the data set(s)

coordination_test_results = struct();

isTrialVisible = PerTrialStruct.isTrialInvisible_AB';
targetAcquisitionTime = [PerTrialStruct.A_TargetAcquisitionRT'; PerTrialStruct.B_TargetAcquisitionRT'];



%-------------------- initialization --------------------

sessionMetrics = struct('teTarget', {}, ...
    'teSide', {},  ...
    'miTarget', {},...
    'miTargetSignif', {}, ...
    'miTargetThresh', {}, ...
    'miSide', {}, ...
    'miSideSignif', {}, ...
    'miSideThresh', {}, ...
    'playerReward', {}, ...
    'averReward', {}, ...
    'isPairProficient', {}, ...
    'dltReward', {}, ...
    'dltSignif', {}, ...
    'dltConfInterval', {}, ...
    'shareOwnChoices', {}, ...
    'shareLeftChoices', {}, ...
    'shareJointChoices', {});

% strategy - probability to select own target given the state, incorporating
% previous outcome, current stimuli location and current partner's choice (if visible)
playerStrategy = {};    % estimated strategy
playerNStateVisit = {}; % number of state visits

% coordination metrics computed for a block within session.
% In a block equilibrium trials start from minStationarySegmentStart.
% this means that if there are now blocks (whole session is asingle block),
% the value of coordination metrics may still differe from the one
% computed for the whole session: the former is computed for all trials
% starting from minStationarySegmentStart, while the latter - for the last 200 trials (if available)
miValueBlock = {};       % target MI
miSignifBlock = {};      % target MI significance
miSideValueBlock = {};   % side MI
miSideSignifBlock = {};  % side MI significance
teBlock1 = {};           % target TE
teBlock2 = {};
sideTEblock1 = {};       % side TE
sideTEblock2 = {};
averageRewardBlock = {}; % average reward of two players
deltaRewardBlock = {};   % non-random reward component of each player
deltaSignifBlock = {};   % significance of non-random reward components
coordStructBlock = {};   % outcomes of coordination tests

blockBorder = {};

%---------------- dataset processing --------------------
totalFileIndex = 1;

% debug aid
%if (strmatch(dataset{iSet}.setName, 'MagnusFlaffusNaive'))
%    disp('Doh...');
%end
maxValue = 0;
minValue = 0;
minMIvalue = 0;
maxMIvalue = 0;

sessionMetrics.teTarget = zeros(2, 1);
sessionMetrics.teSide = zeros(2, 1);
sessionMetrics.miTarget = zeros(1, 1);
sessionMetrics.miTargetSignif = zeros(1, 1);
sessionMetrics.miTargetThresh = zeros(1, 1);
sessionMetrics.miSide = zeros(1, 1);
sessionMetrics.miSideSignif = zeros(1, 1);
sessionMetrics.miSideThresh = zeros(1, 1);
sessionMetrics.playerReward = zeros(2, 1);
sessionMetrics.averReward = zeros(1, 1);
sessionMetrics.isPairProficient = zeros(1, 1);
sessionMetrics.dltReward = zeros(1, 1);
sessionMetrics.dltSignif = zeros(1, 1);
sessionMetrics.dltConfInterval = zeros(2, 1);
sessionMetrics.shareOwnChoices = zeros(2, 1);
sessionMetrics.shareLeftChoices = zeros(2, 1);
sessionMetrics.shareJointChoices = zeros(1, 1);

% preallocate blockwise quanities
miValueBlock = NaN(1, 3);
miSignifBlock = NaN(1, 3);
miSideValueBlock = NaN(1, 3);
miSideSignifBlock = NaN(1, 3);
teBlock1 = NaN(1, 3);
teBlock2 = NaN(1, 3);
sideTEblock1 = NaN(1, 3);
sideTEblock2 = NaN(1, 3);
averageRewardBlock = NaN(1, 3);
deltaRewardBlock = NaN(1, 3);
deltaSignifBlock = NaN(1, 3);

blockBorder = zeros(1, 2);
playerStrategy = zeros(1, 8);
playerNStateVisit = zeros(1, 8);

% analyse all sessions for the given players pair

% here we consider only equilibrium (stabilized) values
nTrial = length(isOwnChoiceArray);
fistTestIndex = max(cfg.minStationarySegmentStart, nTrial-cfg.stationarySegmentLength);
testIndices = fistTestIndex:nTrial;
nTestIndices = length(testIndices);

% estimate strategy over equilibrium trials
[playerStrategy, playerNStateVisit] = ...
    estimate_strategy(isOwnChoiceArray(:, testIndices), sideChoiceArray(:,testIndices), targetAcquisitionTime(:,testIndices), cfg.minDRT);

[sessionMetrics.averReward, ...
    sessionMetrics.dltReward, ...
    sessionMetrics.dltSignif, ...
    sessionMetrics.dltConfInterval(:)] = ...
    calc_total_average_reward(isOwnChoiceArray(:,testIndices), sideChoiceArray(:,testIndices));

%target choices quantities
sessionMetrics.shareOwnChoices(:) = mean(isOwnChoiceArray(:, testIndices), 2);
sessionMetrics.shareJointChoices = mean(xor(isOwnChoiceArray(1, testIndices), isOwnChoiceArray(2, testIndices)));
sessionMetrics.playerReward(:) = 1 + sessionMetrics.shareOwnChoices(:) + 2*sessionMetrics.shareJointChoices;
x = isOwnChoiceArray(1, testIndices);
y = isOwnChoiceArray(2, testIndices);
[sessionMetrics.miTarget, ...
    sessionMetrics.miTargetsignif, ...
    sessionMetrics.miTargetthresh] = calc_whole_mutual_information(x, y, cfg.pValueForMI);
teValue1 = calc_transfer_entropy(y, x, cfg.memoryLength, nTestIndices);
teValue2 = calc_transfer_entropy(x, y, cfg.memoryLength, nTestIndices);
sessionMetrics.teTarget(:) = [teValue1(1); teValue2(1)];

%side choices quantities
sessionMetrics.shareLeftChoices(:) = mean(sideChoiceArray(:, testIndices), 2);
x = sideChoiceArray(1, testIndices);
y = sideChoiceArray(2, testIndices);
[sessionMetrics.miSide, ...
    sessionMetrics.miSideSignif, ...
    sessionMetrics.miSideThresh] = calc_whole_mutual_information(x, y, cfg.pValueForMI);
teValue1 = calc_transfer_entropy(y, x, cfg.memoryLength, nTestIndices);
teValue2 = calc_transfer_entropy(x, y, cfg.memoryLength, nTestIndices);
sessionMetrics.teSide(:) = [teValue1(1); teValue2(1)];

% perform coordination tests.
% To simplify visual inspection, results of all tests are qathered in single table
coordStruct(totalFileIndex) = ...
    check_coordination(isOwnChoiceArray(:,testIndices), sideChoiceArray(:,testIndices));

% compute MI and TE, as well as local MI and TE in windows
x = isOwnChoiceArray(1, :);
y = isOwnChoiceArray(2, :);
targetTE1 = calc_transfer_entropy(y, x, cfg.memoryLength, cfg.minSampleNum);
targetTE2 = calc_transfer_entropy(x, y, cfg.memoryLength, cfg.minSampleNum);
localTargetTE1 = calc_local_transfer_entropy(y, x, cfg.memoryLength, cfg.minSampleNum);
localTargetTE2 = calc_local_transfer_entropy(x, y, cfg.memoryLength, cfg.minSampleNum);
locMutualInf = calc_local_mutual_information(x, y, cfg.minSampleNum);
mutualInf = calc_mutual_information(x, y, cfg.minSampleNum);
minValue = min([minValue, min(localTargetTE1), min(localTargetTE2)]);
maxValue = max([maxValue, max(localTargetTE1), max(localTargetTE2)]);
minMIvalue = min([minMIvalue, min(locMutualInf)]);
maxMIvalue = max([maxMIvalue, max(locMutualInf)]);

% if there are blocked segments, compute statistics for each blcok
dataLength = length(x);
minBlockLength = 40;
blockIndices = cell(1,3);
invisibleStart = find(isTrialVisible == 1, 1, 'first');
invisibleEnd = find(isTrialVisible == 1, 1, 'last');
if (~isempty(invisibleStart))
    blockBorder(1, :) = invisibleStart;
end
if (~isempty(invisibleEnd))
    blockBorder(1,2) = invisibleEnd;
end
if (blockBorder(1,1) > 0)
    blockIndices{1} = cfg.minStationarySegmentStart:invisibleStart-1;
    blockIndices{2} = (invisibleStart+cfg.minStationarySegmentStart):invisibleEnd;
    if (invisibleEnd+1+cfg.minStationarySegmentStart+minBlockLength <= dataLength)
        blockIndices{3} = (invisibleEnd+1+cfg.minStationarySegmentStart):dataLength;
        nBlock = 3;
    else
        nBlock = 2;
    end
else
    blockIndices{1} = 20:dataLength;
    nBlock = 1;
end
for iBlock = 1:nBlock
    index = blockIndices{iBlock};
    blockLength = length(index);
    if (blockLength > 0)
        [averageRewardBlock(1, iBlock), ...
            deltaRewardBlock(1, iBlock), ...
            deltaSignifBlock(1, iBlock)] = calc_total_average_reward(isOwnChoiceArray(:,index), sideChoiceArray(:,index));
        %target choices quantities
        [miValueBlock(1, iBlock), miSignifBlock(1, iBlock)] = ...
            calc_whole_mutual_information(x(index), y(index), cfg.pValueForMI);
        teValue = calc_transfer_entropy(y(index), x(index), cfg.memoryLength, blockLength);
        teBlock1(1, iBlock) = teValue(1);
        teValue = calc_transfer_entropy(x(index), y(index), cfg.memoryLength, blockLength);
        teBlock2(1, iBlock) = teValue(1);
        
        %side choices quantities
        [miSideValueBlock(1, iBlock), miSideSignifBlock(1, iBlock)] = ...
            calc_whole_mutual_information(sideChoiceArray(1,index), sideChoiceArray(2,index), cfg.pValueForMI);
        teValue = calc_transfer_entropy(sideChoiceArray(2,index), sideChoiceArray(1,index), cfg.memoryLength, blockLength);
        sideTEblock1(1, iBlock) = teValue(1);
        teValue = calc_transfer_entropy(sideChoiceArray(1,index), sideChoiceArray(2,index), cfg.memoryLength, blockLength);
        sideTEblock2(1, iBlock) = teValue(1);
        
        coordStructBlock{1, iBlock} = ...
            check_coordination(isOwnChoiceArray(:,index), sideChoiceArray(:,index), 5*10^-5);
    end
end


proficiencyThreshold = 2.75;
sessionMetrics.isPairProficient = check_pairs_proficiency(sessionMetrics.playerReward, proficiencyThreshold);


return
end

