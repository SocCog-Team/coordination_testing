function [ coordination_metrics_struct, coordination_metrics_row, coordination_metrics_row_header ] = fn_compute_coordination_metrics_session( isOwnChoiceArray, sideChoiceArray, PerTrialStruct, cfg )
%FN_COMPUTE_COORDINATION_METRICS_SESSION Summary of this function goes here
%   This is supposed to do the same as compute_coortdination_mtrics, but
%   only for a single session and expects to get the data passed in instead
%   of being passed a (list of) file name(s) for the data set(s)


coordination_metrics_row = [];
coordination_metrics_row_header = {};
linearize_coordination_metrics_struct = 0;

if nargout > 1
    linearize_coordination_metrics_struct = 1;
    structs_to_linearize_list = {'sessionMetrics', 'coordination_struct', 'sessionMetrics_by_visibilty_blocks'};
end
if nargout > 2
    create_coordination_metrics_row_header = 1;
end

coordination_metrics_struct = struct();

isTrialVisible = PerTrialStruct.isTrialInvisible_AB';
targetAcquisitionTime = [PerTrialStruct.A_TargetAcquisitionRT'; PerTrialStruct.B_TargetAcquisitionRT'];



%-------------------- initialization --------------------

% sessionMetrics = struct('teTarget', {}, ...
%     'teSide', {},  ...
%     'miTarget', {},...
%     'miTargetSignif', {}, ...
%     'miTargetThresh', {}, ...
%     'miSide', {}, ...
%     'miSideSignif', {}, ...
%     'miSideThresh', {}, ...
%     'playerReward', {}, ...
%     'averReward', {}, ...
%     'isPairProficient', {}, ...
%     'dltReward', {}, ...
%     'dltSignif', {}, ...
%     'dltConfInterval', {}, ...
%     'shareOwnChoices', {}, ...
%     'shareLeftChoices', {}, ...
%     'shareJointChoices', {});

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
coordStructBlock = cell(1, 3);   % outcomes of coordination tests

blockBorder = {};

%---------------- dataset processing --------------------



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


% analyse all sessions for the given players pair

% here we consider only equilibrium (stabilized) values
nTrial = length(isOwnChoiceArray);
fistTestIndex = max(cfg.minStationarySegmentStart, nTrial-cfg.stationarySegmentLength);
testIndices = fistTestIndex:nTrial;
nTestIndices = length(testIndices);

if isempty(testIndices)
    disp(['fn_compute_coordination_metrics_session: found less than', num2str(cfg.minStationarySegmentStart), ' trials, coordination metrics will not be calculated.']);
    return
end
    
% estimate strategy over equilibrium trials
% this analysis results in the strategy description vectors used in the
% transparent games simulations.
[playerStrategy, playerNStateVisit] = ...
    estimate_strategy(isOwnChoiceArray(:, testIndices), sideChoiceArray(:,testIndices), targetAcquisitionTime(:,testIndices), cfg.minDRT);

strategy_struct.playerStrategy = playerStrategy;
strategy_struct.playerNStateVisit = playerNStateVisit;


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
    sessionMetrics.miTargetSignif, ...
    sessionMetrics.miTargetThresh] = calc_whole_mutual_information(x, y, cfg.pValueForMI);
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
coordStruct = ...
    check_coordination(isOwnChoiceArray(:,testIndices), sideChoiceArray(:,testIndices));


%%% THE FOLLOWING SHOULD MOVE OUT INTO the caller, as this is showing per
%%% trial data instead of per session aggregates
% compute MI and TE, as well as local MI and TE in windows
x = isOwnChoiceArray(1, :);
y = isOwnChoiceArray(2, :);
targetTE1 = calc_transfer_entropy(y, x, cfg.memoryLength, cfg.minSampleNum);
targetTE2 = calc_transfer_entropy(x, y, cfg.memoryLength, cfg.minSampleNum);
localTargetTE1 = calc_local_transfer_entropy(y, x, cfg.memoryLength, cfg.minSampleNum);
localTargetTE2 = calc_local_transfer_entropy(x, y, cfg.memoryLength, cfg.minSampleNum);
locMutualInf = calc_local_mutual_information(x, y, cfg.minSampleNum);
mutualInf = calc_mutual_information(x, y, cfg.minSampleNum);
% minValue = min([minValue, min(localTargetTE1), min(localTargetTE2)]);
% maxValue = max([maxValue, max(localTargetTE1), max(localTargetTE2)]);
% minMIvalue = min([minMIvalue, min(locMutualInf)]);
% maxMIvalue = max([maxMIvalue, max(locMutualInf)]);

per_trial.targetTE1 = targetTE1;
per_trial.targetTE2 = targetTE2;
per_trial.localTargetTE1 = localTargetTE1;
per_trial.localTargetTE2 = localTargetTE2;
per_trial.mutualInf = mutualInf;
per_trial.locMutualInf = locMutualInf;
%%% THE PRECEEDING SHOULD MOVE OUT



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
            check_coordination(isOwnChoiceArray(:,index), sideChoiceArray(:,index), cfg.check_coordination_alpha);
    end
end


% export these
sessionMetrics_by_visibilty_blocks.miValueBlock = miValueBlock;
sessionMetrics_by_visibilty_blocks.miSignifBlock = miSignifBlock;
sessionMetrics_by_visibilty_blocks.miSideValueBlock = miSideValueBlock;
sessionMetrics_by_visibilty_blocks.miSideSignifBlock = miSideSignifBlock;
sessionMetrics_by_visibilty_blocks.teBlock1 = teBlock1;
sessionMetrics_by_visibilty_blocks.teBlock2 = teBlock2;
sessionMetrics_by_visibilty_blocks.sideTEblock1 = sideTEblock1;
sessionMetrics_by_visibilty_blocks.sideTEblock2 = sideTEblock2;
sessionMetrics_by_visibilty_blocks.averageRewardBlock = averageRewardBlock;
sessionMetrics_by_visibilty_blocks.deltaRewardBlock = deltaRewardBlock;
sessionMetrics_by_visibilty_blocks.deltaSignifBlock = deltaSignifBlock;
%sessionMetrics_by_visibilty_blocks.coordination_struct_block = coordStructBlock;


%proficiencyThreshold = 2.75;
sessionMetrics.isPairProficient = check_pairs_proficiency(sessionMetrics.playerReward, cfg.proficiencyThreshold);

coordination_metrics_struct.strategy_struct = strategy_struct;
coordination_metrics_struct.sessionMetrics = sessionMetrics;
coordination_metrics_struct.coordination_struct = coordStruct;
coordination_metrics_struct.sessionMetrics_by_visibilty_blocks = sessionMetrics_by_visibilty_blocks;
coordination_metrics_struct.coordination_struct_by_visibilty_blocks = coordStructBlock;
coordination_metrics_struct.per_trial = per_trial;




%TODO:
%   linearize the data and create a matching header
coordStructBlock_suffix_list = {'visible_pre', 'invisible', 'visible_post'};
if (linearize_coordination_metrics_struct)
    
    % TrialsInCurrentSetIdx can be naively linearized so remove it
    fieldnames_to_remove_list = {'TrialsInCurrentSetIdx'}; % add all fields that should not be linearized to this list
    tmp_cfg = rmfield(cfg, fieldnames_to_remove_list);
    
    coordination_metrics_row = fn_linearize_struct(tmp_cfg, 'add_suffix_to_all_columns', {'_cfg'});     

    coordination_metrics_row = [coordination_metrics_row, fn_linearize_struct(sessionMetrics, 'add_suffix', {'A', 'B'})];   
    coordination_metrics_row = [coordination_metrics_row, fn_linearize_struct(coordStruct.key_value_struct, 'add_suffix', {'A', 'B'})];
    
    coordination_metrics_row = [coordination_metrics_row, fn_linearize_struct(sessionMetrics_by_visibilty_blocks, 'add_suffix', coordStructBlock_suffix_list)];     
     
     
     for i_block = 1 : length(coordStructBlock)
         if ~isempty(coordStructBlock{i_block})
             tmp_coordination_metrics_row = fn_linearize_struct(coordStructBlock{i_block}.key_value_struct, 'add_suffix_to_all_columns', coordStructBlock_suffix_list(i_block));
             coordination_metrics_row = [coordination_metrics_row, tmp_coordination_metrics_row];
             if (i_block == 1)
                 %n_columns = length(tmp_coordination_metrics_row);
                 coordStruct_key_value_struct_size = size(tmp_coordination_metrics_row);
             end
         else
             % these are blocks that are missing:
             tmp_coordination_metrics_row = NaN(coordStruct_key_value_struct_size);
             coordination_metrics_row = [coordination_metrics_row, tmp_coordination_metrics_row];
         end
     end
     
end
if (create_coordination_metrics_row_header)
    % the cfg variables
    [~, coordination_metrics_row_header] = fn_linearize_struct(tmp_cfg, 'add_suffix_to_all_columns', {'cfg'});     
    %coordination_metrics_row_header = [coordination_metrics_row_header, tmp_coordination_metrics_row_header];
    
    [~, tmp_coordination_metrics_row_header] = fn_linearize_struct(sessionMetrics, 'add_suffix', {'A', 'B'});
    % fix up some column names...
    tmp_coordination_metrics_row_header{(strcmp('dltConfInterval_A', tmp_coordination_metrics_row_header))} = 'dltConfInterval_Upper';
    tmp_coordination_metrics_row_header{(strcmp('dltConfInterval_B', tmp_coordination_metrics_row_header))} = 'dltConfInterval_Lower';
    coordination_metrics_row_header = [coordination_metrics_row_header, tmp_coordination_metrics_row_header];
    
    % the coordStruct
    [ ~, tmp_coordination_metrics_row_header] = fn_linearize_struct(coordStruct.key_value_struct, 'add_suffix', {'A', 'B'});
    coordination_metrics_row_header = [coordination_metrics_row_header, tmp_coordination_metrics_row_header];
    
    [ ~, tmp_coordination_metrics_row_header] = fn_linearize_struct(sessionMetrics_by_visibilty_blocks, 'add_suffix', coordStructBlock_suffix_list);
    tmp_coordination_metrics_row_header{(strcmp('teBlock1_visible_pre', tmp_coordination_metrics_row_header))} = 'teBlock_visible_pre_A';
    tmp_coordination_metrics_row_header{(strcmp('teBlock2_visible_pre', tmp_coordination_metrics_row_header))} = 'teBlock_visible_pre_B';
    tmp_coordination_metrics_row_header{(strcmp('teBlock1_invisible', tmp_coordination_metrics_row_header))} = 'teBlock_invisible_A';
    tmp_coordination_metrics_row_header{(strcmp('teBlock2_invisible', tmp_coordination_metrics_row_header))} = 'teBlock_invisible_B';
    tmp_coordination_metrics_row_header{(strcmp('teBlock1_visible_post', tmp_coordination_metrics_row_header))} = 'teBlock_visible_post_A';
    tmp_coordination_metrics_row_header{(strcmp('teBlock2_visible_post', tmp_coordination_metrics_row_header))} = 'teBlock_visible_post_B';

    tmp_coordination_metrics_row_header{(strcmp('sideTEblock1_visible_pre', tmp_coordination_metrics_row_header))} = 'sideTEblock_visible_pre_A';
    tmp_coordination_metrics_row_header{(strcmp('sideTEblock2_visible_pre', tmp_coordination_metrics_row_header))} = 'sideTEblock_visible_pre_B';
    tmp_coordination_metrics_row_header{(strcmp('sideTEblock1_invisible', tmp_coordination_metrics_row_header))} = 'sideTEblock_invisible_A';
    tmp_coordination_metrics_row_header{(strcmp('sideTEblock2_invisible', tmp_coordination_metrics_row_header))} = 'sideTEblock_invisible_B';
    tmp_coordination_metrics_row_header{(strcmp('sideTEblock1_visible_post', tmp_coordination_metrics_row_header))} = 'sideTEblock_visible_post_A';
    tmp_coordination_metrics_row_header{(strcmp('sideTEblock2_visible_post', tmp_coordination_metrics_row_header))} = 'sideTEblock_visible_post_B';
    
    coordination_metrics_row_header = [coordination_metrics_row_header, tmp_coordination_metrics_row_header];

     for i_block = 1 : length(coordStructBlock)
         if ~isempty(coordStructBlock{i_block})
             [~, tmp_coordination_metrics_row_header] = fn_linearize_struct(coordStructBlock{i_block}.key_value_struct, 'add_suffix_to_all_columns', coordStructBlock_suffix_list(i_block));
             coordination_metrics_row_header = [coordination_metrics_row_header, tmp_coordination_metrics_row_header];
             if (i_block == 1)
                 %n_columns = length(tmp_coordination_metrics_row);
                 coordStruct_key_value_struct_header = tmp_coordination_metrics_row_header;
             end
         else
             % these are blocks that are missing:
             tmp_coordination_metrics_row_header = strrep(coordStruct_key_value_struct_header, coordStructBlock_suffix_list{1}, coordStructBlock_suffix_list{i_block});             
             coordination_metrics_row_header = [coordination_metrics_row_header, tmp_coordination_metrics_row_header];
         end
     end
end

return
end

function [data_row, header_list] = fn_linearize_struct(input_struct, list_handling_command, list_suffix_list)
data_row = [];
header_list = {};

convert_fieldnames_2_column_names = 0;
if (nargout > 1)
    convert_fieldnames_2_column_names = 1;
end

field_list = fieldnames(input_struct);

for i_field = 1 : length(field_list)
    current_data = input_struct.(field_list{i_field});
    if isstruct(current_data)
        % oh, this is a struct so recurse
        error('Not implemented yet.');
        [sub_data_row, sub_header_list] = fn_linearize_struct(current_data, list_handling_command, list_suffix_list);
        data_row = [data_row, sub_data_row];
        if (convert_fieldnames_2_column_names)
            header_list = [header_list, sub_header_list];
        end
        continue
    else
        if length(current_data) == 1
            % is scalar value, just grab value and name
            data_row(end + 1) = current_data;
            if (convert_fieldnames_2_column_names)
               
                if strcmp(list_handling_command, 'add_suffix_to_all_columns')
                     header_list{end + 1} = [field_list{i_field}, '_', list_suffix_list{1}];
                else
                     header_list{end + 1} = field_list{i_field};
                end
            end
        else
            switch list_handling_command
                case 'add_suffix'
                    % only add a suffix to non-scalar structure fields
                    if length(current_data) == length(list_suffix_list)
                        for i_item = 1 : length(current_data)
                            data_row(end + 1) = current_data(i_item);
                            if (convert_fieldnames_2_column_names)
                                header_list{end + 1} = [field_list{i_field}, '_', list_suffix_list{i_item}];
                            end
                        end
                    else
                        error(['Encountered data item with more elements than suffixes supplied in list_suffix_list, fix this.']);
                    end
                case 'add_suffix_to_all_columns'
                    % append the suffix to all fields
                    if length(current_data) == length(list_suffix_list)
                        for i_item = 1 : length(current_data)
                            data_row(end + 1) = current_data(i_item);
                            if (convert_fieldnames_2_column_names)
                                header_list{end + 1} = [field_list{i_field}, '_', list_suffix_list{i_item}];
                            end
                        end
                    else
                        error(['Encountered data item with more elements than suffixes supplied in list_suffix_list, fix this.']);
                    end                    
                    
                    
                otherwise
                    error(['Encountered unhandled list_handling_command: ', list_handling_command]);
            end
        end
    end
end

return
end