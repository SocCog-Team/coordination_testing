function [ coordination_metrics_struct, coordination_metrics_row, coordination_metrics_row_header ] = fn_compute_coordination_metrics_session_by_indexedtrials( isOwnChoiceArray, sideChoiceArray, PerTrialStruct, cfg, trial_index, use_all_trials, prefix_string, suffix_string )
%FN_COMPUTE_COORDINATION_METRICS_SESSION_BY_INDEXEDTRIALS Summary of this function goes here
%   This is supposed to do the same as compute_coortdination_mtrics, but
%   only for a single session and expects to get the data passed in instead
%   of being passed a (list of) file name(s) for the data set(s)
%   This version should not special case the blocked trials anymore, but
%   simply operate on the indexed trials and append the supplied prefix and
%   suffix

% TODO:
%   if trial_index, prefix_string, suffix_string are cell arrays, loop over
%   the elements and create and concatenate all sets.
%   Allow manual override of the stationarySegmentLength, minStationarySegmentStart
%   logic to use the full supplied index...
%   Calculate and return the coordination measures for the confederate
%   case, so based on the confederates choices

% DONE:
%   change to take in a list of trial indices and just calculate and return
%   header and data for that set, also allow to pass in a common suffix
%   string to make sure the header fields can be made unique, that also
%   allows to get rid of the special casing of the invisibility trials and
%   will return the exact same measures for each subset.
%   


% use the following two to decorate all variable names for the coordination_metrics_row_header
if ~exist('prefix_string', 'var') || isempty(prefix_string)
    prefix_string = '';
end
if ~exist('suffix_string', 'var') || isempty(suffix_string)
    suffix_string = '';
end


coordination_metrics_row = [];
coordination_metrics_row_header = {};
linearize_coordination_metrics_struct = 0;

if nargout > 1
    linearize_coordination_metrics_struct = 1;
    structs_to_linearize_list = {'sessionMetrics', 'coordination_struct'};
end
if nargout > 2
    create_coordination_metrics_row_header = 1;
end

coordination_metrics_struct = struct();

isTrialVisible = PerTrialStruct.isTrialInvisible_AB(trial_index)';

% reduce the data to the indexed subset
targetAcquisitionTime = [PerTrialStruct.A_TargetAcquisitionRT(trial_index)'; PerTrialStruct.B_TargetAcquisitionRT(trial_index)'];
isOwnChoiceArray = isOwnChoiceArray(:, trial_index);
sideChoiceArray = sideChoiceArray(:, trial_index);


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
%---------------- dataset processing --------------------



sessionMetrics.teTarget = NaN(2, 1);
sessionMetrics.teSide = NaN(2, 1);
sessionMetrics.miTarget = NaN(1, 1);
sessionMetrics.miTargetSignif = NaN(1, 1);
sessionMetrics.miTargetThresh = NaN(1, 1);
sessionMetrics.miSide = NaN(1, 1);
sessionMetrics.miSideSignif = NaN(1, 1);
sessionMetrics.miSideThresh = NaN(1, 1);
sessionMetrics.playerReward = NaN(2, 1);
sessionMetrics.averReward = NaN(1, 1);
sessionMetrics.isPairProficient = NaN(1, 1);
sessionMetrics.dltReward = NaN(1, 1);
sessionMetrics.dltSignif = NaN(1, 1);
sessionMetrics.dltConfInterval = NaN(2, 1);
sessionMetrics.shareOwnChoices = NaN(2, 1);
sessionMetrics.shareLeftChoices = NaN(2, 1);
sessionMetrics.shareJointChoices = NaN(1, 1);



% analyse all sessions for the given players pair

% here we consider only equilibrium (stabilized) values
nTrial = length(isOwnChoiceArray);
if ~(use_all_trials)    
    firstTestIndex = max(cfg.minStationarySegmentStart, nTrial-cfg.stationarySegmentLength);       
else
    firstTestIndex = 1;
end
testIndices = firstTestIndex:nTrial; 
nTestIndices = length(testIndices);

% add information about the number of analyzed trials to the output
cfg.use_all_trials = use_all_trials;
cfg.nTrials = nTrial;
cfg.firstTestIndex = firstTestIndex;
cfg.nTestIndices = nTestIndices;


if isempty(testIndices)
    disp([mfilename, ': found less than ', num2str(cfg.minStationarySegmentStart), ' trials, coordination metrics will not be calculated.']);
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


%proficiencyThreshold = 2.75;
sessionMetrics.isPairProficient = check_pairs_proficiency(sessionMetrics.playerReward, cfg.proficiencyThreshold);

coordination_metrics_struct.strategy_struct = strategy_struct;
coordination_metrics_struct.sessionMetrics = sessionMetrics;
coordination_metrics_struct.coordination_struct = coordStruct;
coordination_metrics_struct.per_trial = per_trial;




%TODO:
%   linearize the data and create a matching header
if (linearize_coordination_metrics_struct)
    % TrialsInCurrentSetIdx can not be naively linearized (unequal length) so remove it
    fieldnames_to_remove_list = {'TrialsInCurrentSetIdx'}; % add all fields that should not be linearized to this list
    tmp_cfg = rmfield(cfg, fieldnames_to_remove_list);
    
    coordination_metrics_row = fn_linearize_struct(tmp_cfg, 'add_suffix_to_all_columns', {'_cfg'});     

    coordination_metrics_row = [coordination_metrics_row, fn_linearize_struct(sessionMetrics, 'add_suffix', {'A', 'B'})];   
    coordination_metrics_row = [coordination_metrics_row, fn_linearize_struct(coordStruct.key_value_struct, 'add_suffix', {'A', 'B'})];     
end

if (create_coordination_metrics_row_header)
    % the cfg variables
    [~, coordination_metrics_row_header] = fn_linearize_struct(tmp_cfg, 'add_suffix_to_all_columns', {'cfg'});     
    %coordination_metrics_row_header = [coordination_metrics_row_header, tmp_coordination_metrics_row_header];
    
    [~, tmp_coordination_metrics_row_header] = fn_linearize_struct(sessionMetrics, 'add_suffix', {'A', 'B'});
    % fix up some column names...
    tmp_coordination_metrics_row_header{(strcmp('dltConfInterval_A', tmp_coordination_metrics_row_header))} = 'dltConfInterval_Lower';
    tmp_coordination_metrics_row_header{(strcmp('dltConfInterval_B', tmp_coordination_metrics_row_header))} = 'dltConfInterval_Upper';
    coordination_metrics_row_header = [coordination_metrics_row_header, tmp_coordination_metrics_row_header];
    
    % the coordStruct
    [ ~, tmp_coordination_metrics_row_header] = fn_linearize_struct(coordStruct.key_value_struct, 'add_suffix', {'A', 'B'});
    coordination_metrics_row_header = [coordination_metrics_row_header, tmp_coordination_metrics_row_header];

    % now unconditionally sandwich all header items between prefix_string and
    % suffix_string
    n_columns = length(coordination_metrics_row_header);
    for i_header_column = 1 : length(coordination_metrics_row_header)
        coordination_metrics_row_header{i_header_column} = [prefix_string, coordination_metrics_row_header{i_header_column}, suffix_string];
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