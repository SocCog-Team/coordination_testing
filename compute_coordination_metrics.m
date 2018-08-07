function compute_coordination_metrics(dataset, cfg, resultFilename)

if ~exist('resultFilename', 'var') || isempty(resultFilename)
    resultFilename = [];
end

if (exist(resultFilename,'file'))
    prev = load(resultFilename, 'dataset', 'cfg');
end
if (isfield(prev,'dataset') && isfield(prev, 'cfg') && isequal(prev.cfg, cfg) && isequal(prev.dataset, dataset))
    disp('dataset already processed'); %display the value of myVar
    return
end

%-------------------- initialization --------------------
nSet = length(dataset);
nFile = cell2mat(cellfun(@(x) length(unique(x.captions)), dataset, 'UniformOutput',false));

% by-trial quantities
allOwnChoice = cell(nSet, max(nFile));  % target choice (0 - other, 1 - own)
allSideChoice = cell(nSet, max(nFile)); % side choice (0 - objective right, 1 - objective left)
allRT = cell(nSet, max(nFile)); % target acquisition times

% by-trial coordination metrics computed over window of cfg.minSampleNum trials
mutualInf = cell(nSet, max(nFile));       % target local MI
locMutualInf = cell(nSet, max(nFile));    % target MI
targetTE1 = cell(nSet, max(nFile));       % target (averaged) TE
targetTE2 = cell(nSet, max(nFile));
localTargetTE1 = cell(nSet, max(nFile));  % target local TE
localTargetTE2 = cell(nSet, max(nFile));

% coordination metrics computed for each session
% (over supposedly equilibrium trials)
% shareOwnChices - percentages of trials with own choice
% shareLeftChices - percentages of trials with objective left choice,
% shareJointChices - percentages of trials where both players chosen the same target
% playerReward - mean reward of each player
% MI - target/side MI
% MIsignif - target/side MI significance
% MIthresh - target/side MI minimal significant value
% averReward - average reward of two players
% dltReward - non-random reward component of each player
% dltSignif - significance of non-random reward components
% dltConfInterval - confidence interval for non-random reward components
sessionMetrics = struct('teTarget', cell(1, nSet), ...
    'teSide', cell(1, nSet),  ...
    'miTarget', cell(1, nSet),...
    'miTargetSignif', cell(1, nSet), ...
    'miTargetThresh', cell(1, nSet), ...
    'miSide', cell(1, nSet), ...
    'miSideSignif', cell(1, nSet), ...
    'miSideThresh', cell(1, nSet), ...
    'playerReward', cell(1, nSet), ...
    'averReward', cell(1, nSet), ...
    'isPairProficient', cell(1, nSet), ...
    'dltReward', cell(1, nSet), ...
    'dltSignif', cell(1, nSet), ...
    'dltConfInterval', cell(1, nSet), ...
    'shareOwnChoices', cell(1, nSet), ...
    'shareLeftChoices', cell(1, nSet), ...
    'shareJointChoices', cell(1, nSet));

% strategy - probability to select own target given the state, incorporating
% previous outcome, current stimuli location and current partner's choice (if visible)
playerStrategy = cell(nSet, max(nFile));    % estimated strategy
playerNStateVisit = cell(nSet, max(nFile)); % number of state visits

% coordination metrics computed for a block within session.
% In a block equilibrium trials start from minStationarySegmentStart.
% this means that if there are now blocks (whole session is asingle block),
% the value of coordination metrics may still differe from the one
% computed for the whole session: the former is computed for all trials
% starting from minStationarySegmentStart, while the latter - for the last 200 trials (if available)
miValueBlock = cell(nSet, 1);       % target MI
miSignifBlock = cell(nSet, 1);      % target MI significance
miSideValueBlock = cell(nSet, 1);   % side MI
miSideSignifBlock = cell(nSet, 1);  % side MI significance
teBlock1 = cell(nSet, 1);           % target TE
teBlock2 = cell(nSet, 1);
sideTEblock1 = cell(nSet, 1);       % side TE
sideTEblock2 = cell(nSet, 1);
averageRewardBlock = cell(nSet, 1); % average reward of two players
deltaRewardBlock = cell(nSet, 1);   % non-random reward component of each player
deltaSignifBlock = cell(nSet, 1);   % significance of non-random reward components
coordStructBlock = cell(nSet, 3);   % outcomes of coordination tests

blockBorder = cell(nSet, 1);

%---------------- dataset processing --------------------
totalFileIndex = 1;
for iSet = 1:nSet
    disp(['Processing dataset' num2str(iSet)]);
    % debug aid
    %if (strmatch(dataset{iSet}.setName, 'MagnusFlaffusNaive'))
    %    disp('Doh...');
    %end
    maxValue = 0;
    minValue = 0;
    minMIvalue = 0;
    maxMIvalue = 0;
    
    sessionMetrics(iSet).teTarget = zeros(2, nFile(iSet));
    sessionMetrics(iSet).teSide = zeros(2, nFile(iSet));
    sessionMetrics(iSet).miTarget = zeros(1, nFile(iSet));
    sessionMetrics(iSet).miTargetSignif = zeros(1, nFile(iSet));
    sessionMetrics(iSet).miTargetThresh = zeros(1, nFile(iSet));
    sessionMetrics(iSet).miSide = zeros(1, nFile(iSet));
    sessionMetrics(iSet).miSideSignif = zeros(1, nFile(iSet));
    sessionMetrics(iSet).miSideThresh = zeros(1, nFile(iSet));
    sessionMetrics(iSet).playerReward = zeros(2, nFile(iSet));
    sessionMetrics(iSet).averReward = zeros(1, nFile(iSet));
    sessionMetrics(iSet).isPairProficient = zeros(1, nFile(iSet));
    sessionMetrics(iSet).dltReward = zeros(1, nFile(iSet));
    sessionMetrics(iSet).dltSignif = zeros(1, nFile(iSet));
    sessionMetrics(iSet).dltConfInterval = zeros(2, nFile(iSet));
    sessionMetrics(iSet).shareOwnChoices = zeros(2, nFile(iSet));
    sessionMetrics(iSet).shareLeftChoices = zeros(2, nFile(iSet));
    sessionMetrics(iSet).shareJointChoices = zeros(1, nFile(iSet));
    
    % preallocate blockwise quanities
    miValueBlock{iSet} = NaN(nFile(iSet), 3);
    miSignifBlock{iSet} = NaN(nFile(iSet), 3);
    miSideValueBlock{iSet} = NaN(nFile(iSet), 3);
    miSideSignifBlock{iSet} = NaN(nFile(iSet), 3);
    teBlock1{iSet} = NaN(nFile(iSet), 3);
    teBlock2{iSet} = NaN(nFile(iSet), 3);
    sideTEblock1{iSet} = NaN(nFile(iSet), 3);
    sideTEblock2{iSet} = NaN(nFile(iSet), 3);
    averageRewardBlock{iSet} = NaN(nFile(iSet), 3);
    deltaRewardBlock{iSet} = NaN(nFile(iSet), 3);
    deltaSignifBlock{iSet} = NaN(nFile(iSet), 3);
    
    blockBorder{iSet} = zeros(nFile(iSet), 2);
    playerStrategy{iSet} = zeros(nFile(iSet), 8);
    playerNStateVisit{iSet} = zeros(nFile(iSet), 8);
    
    % analyse all sessions for the given players pair
    filenameIndex = 1;
    for iFile = 1:nFile(iSet)
        % merge data for all files having the same caption
        isOwnChoice = [];
        sideChoice = [];
        isTrialVisible = [];
        targetAcquisitionTime = [];
        
        i = filenameIndex;
        while(length(dataset{iSet}.filenames) >= i)
            if (~strcmp(dataset{iSet}.captions{i}, dataset{iSet}.captions{filenameIndex}))
                break;
            end
            clear isOwnChoiceArray sideChoiceObjectiveArray
            load(fullfile(cfg.folder, [dataset{iSet}.filenames{i}, '.mat']), 'isOwnChoiceArray', 'sideChoiceObjectiveArray', 'PerTrialStruct');
            disp(['Loading ', fullfile(cfg.folder, [dataset{iSet}.filenames{i}, '.mat']) ]);
            if (exist('isOwnChoiceArray', 'var'))
                isOwnChoice = [isOwnChoice, isOwnChoiceArray];
            else
                temp = isOwnChoice;
                load([dataset{iSet}.filenames{i}, '.mat'], 'isOwnChoice');
                isOwnChoice = [temp, isOwnChoice];
            end
            if (exist('sideChoiceObjectiveArray', 'var'))
                sideChoice = [sideChoice, sideChoiceObjectiveArray];
            else
                load([dataset{iSet}.filenames{i}, '.mat'], 'isBottomChoice');
                sideChoice = [sideChoice, isBottomChoice];
            end
            isTrialVisible = [isTrialVisible, PerTrialStruct.isTrialInvisible_AB'];
            targetAcquisitionTime = [targetAcquisitionTime, [PerTrialStruct.A_TargetAcquisitionRT'; PerTrialStruct.B_TargetAcquisitionRT']];
            i = i + 1;
        end
        filenameIndex = i;
        allOwnChoice{iSet, iFile} = isOwnChoice;
        allSideChoice{iSet, iFile} = sideChoice;
        allRT{iSet, iFile} = targetAcquisitionTime;
        
        % here we consider only equilibrium (stabilized) values
        nTrial = length(isOwnChoice);
        fistTestIndex = max(cfg.minStationarySegmentStart, nTrial-cfg.stationarySegmentLength);
        testIndices = fistTestIndex:nTrial;
        nTestIndices = length(testIndices);
        
        % estimate strategy over equilibrium trials
        [playerStrategy{iSet, iFile}, playerNStateVisit{iSet, iFile}] = ...
            estimate_strategy(isOwnChoice(:, testIndices), sideChoice(:,testIndices), targetAcquisitionTime(:,testIndices), cfg.minDRT);
        
        [sessionMetrics(iSet).averReward(iFile), ...
            sessionMetrics(iSet).dltReward(iFile), ...
            sessionMetrics(iSet).dltSignif(iFile), ...
            sessionMetrics(iSet).dltConfInterval(:, iFile)] = ...
            calc_total_average_reward(isOwnChoice(:,testIndices), sideChoice(:,testIndices));
        
        %target choices quantities
        sessionMetrics(iSet).shareOwnChoices(:, iFile) = mean(isOwnChoice(:, testIndices), 2);
        sessionMetrics(iSet).shareJointChoices(iFile) = mean(xor(isOwnChoice(1, testIndices), isOwnChoice(2, testIndices)));
        sessionMetrics(iSet).playerReward(:, iFile) = 1 + sessionMetrics(iSet).shareOwnChoices(:, iFile) + 2*sessionMetrics(iSet).shareJointChoices(iFile);
        x = isOwnChoice(1, testIndices);
        y = isOwnChoice(2, testIndices);
        [sessionMetrics(iSet).miTarget(iFile), ...
            sessionMetrics(iSet).miTargetsignif(iFile), ...
            sessionMetrics(iSet).miTargetthresh(iFile)] = calc_whole_mutual_information(x, y, cfg.pValueForMI);
        teValue1 = calc_transfer_entropy(y, x, cfg.memoryLength, nTestIndices);
        teValue2 = calc_transfer_entropy(x, y, cfg.memoryLength, nTestIndices);
        sessionMetrics(iSet).teTarget(:, iFile) = [teValue1(1);teValue2(1)];
        
        %side choices quantities
        sessionMetrics(iSet).shareLeftChoices(:, iFile) = mean(sideChoice(:, testIndices), 2);
        x = sideChoice(1, testIndices);
        y = sideChoice(2, testIndices);
        [sessionMetrics(iSet).miSide(iFile), ...
            sessionMetrics(iSet).miSideSignif(iFile), ...
            sessionMetrics(iSet).miSideThresh(iFile)] = calc_whole_mutual_information(x, y, cfg.pValueForMI);
        teValue1 = calc_transfer_entropy(y, x, cfg.memoryLength, nTestIndices);
        teValue2 = calc_transfer_entropy(x, y, cfg.memoryLength, nTestIndices);
        sessionMetrics(iSet).teSide(:, iFile) = [teValue1(1);teValue2(1)];
        
        % perform coordination tests.
        % To simplify visual inspection, results of all tests are qathered in single table
        coordStruct(totalFileIndex) = ...
            check_coordination(isOwnChoice(:,testIndices), sideChoice(:,testIndices));
        totalFileIndex = totalFileIndex + 1;
        
        % compute MI and TE, as well as local MI and TE in windows
        x = isOwnChoice(1, :);
        y = isOwnChoice(2, :);
        targetTE1{iSet, iFile} = calc_transfer_entropy(y, x, cfg.memoryLength, cfg.minSampleNum);
        targetTE2{iSet, iFile} = calc_transfer_entropy(x, y, cfg.memoryLength, cfg.minSampleNum);
        localTargetTE1{iSet, iFile} = calc_local_transfer_entropy(y, x, cfg.memoryLength, cfg.minSampleNum);
        localTargetTE2{iSet, iFile} = calc_local_transfer_entropy(x, y, cfg.memoryLength, cfg.minSampleNum);
        locMutualInf{iSet, iFile} = calc_local_mutual_information(x, y, cfg.minSampleNum);
        mutualInf{iSet, iFile} = calc_mutual_information(x, y, cfg.minSampleNum);
        minValue = min([minValue, min(localTargetTE1{iSet, iFile}), min(localTargetTE2{iSet, iFile})]);
        maxValue = max([maxValue, max(localTargetTE1{iSet, iFile}), max(localTargetTE2{iSet, iFile})]);
        minMIvalue = min([minMIvalue, min(locMutualInf{iSet, iFile})]);
        maxMIvalue = max([maxMIvalue, max(locMutualInf{iSet, iFile})]);
        
        % if there are blocked segments, compute statistics for each blcok
        dataLength = length(x);
        minBlockLength = 40;
        blockIndices = cell(1,3);
        invisibleStart = find(isTrialVisible == 1, 1, 'first');
        invisibleEnd = find(isTrialVisible == 1, 1, 'last');
        if (~isempty(invisibleStart))
            blockBorder{iSet}(iFile,:) = invisibleStart;
        end
        if (~isempty(invisibleEnd))
            blockBorder{iSet}(iFile,2) = invisibleEnd;
        end
        if (blockBorder{iSet}(iFile,1) > 0)
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
                [averageRewardBlock{iSet}(iFile, iBlock), ...
                    deltaRewardBlock{iSet}(iFile, iBlock), ...
                    deltaSignifBlock{iSet}(iFile, iBlock)] = calc_total_average_reward(isOwnChoice(:,index), sideChoice(:,index));
                %target choices quantities
                [miValueBlock{iSet}(iFile, iBlock), miSignifBlock{iSet}(iFile, iBlock)] = ...
                    calc_whole_mutual_information(x(index), y(index), cfg.pValueForMI);
                teValue = calc_transfer_entropy(y(index), x(index), cfg.memoryLength, blockLength);
                teBlock1{iSet}(iFile, iBlock) = teValue(1);
                teValue = calc_transfer_entropy(x(index), y(index), cfg.memoryLength, blockLength);
                teBlock2{iSet}(iFile, iBlock) = teValue(1);
                
                %side choices quantities
                [miSideValueBlock{iSet}(iFile, iBlock), miSideSignifBlock{iSet}(iFile, iBlock)] = ...
                    calc_whole_mutual_information(sideChoice(1,index), sideChoice(2,index), cfg.pValueForMI);
                teValue = calc_transfer_entropy(sideChoice(2,index), sideChoice(1,index), cfg.memoryLength, blockLength);
                sideTEblock1{iSet}(iFile, iBlock) = teValue(1);
                teValue = calc_transfer_entropy(sideChoice(1,index), sideChoice(2,index), cfg.memoryLength, blockLength);
                sideTEblock2{iSet}(iFile, iBlock) = teValue(1);
                
                coordStructBlock{iSet, iBlock}(iFile) = ...
                    check_coordination(isOwnChoice(:,index), sideChoice(:,index), 5*10^-5);
            end
        end
        %isBottomChoice = sideChoiceObjectiveArray;
    end
    proficiencyThreshold = 2.75;
    sessionMetrics(iSet).isPairProficient = check_pairs_proficiency(sessionMetrics(iSet).playerReward, proficiencyThreshold);
end

if ~isempty(resultFilename)
    save(resultFilename);
    disp(['Saved coortdination metrics as ', resultFilename]);
else
    disp('No result file saved, since no result file name was specified.');
end
end