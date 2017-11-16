filename = {'humanData_pair01.mat', 'humanData_pair02.mat',  ...
            'humanData_pair03.mat', 'humanData_pair04.mat', ...
            'humanData_pair05.mat', 'edData_best0.mat', ...
            'rlData_noncuriousVSnoncurious2.mat', 'rlData_noncuriousVScurios.mat', ...
            'rlData_curiosVScurios.mat'};
nFile = length(filename);          

partnerInluenceOnSide = zeros(nFile, 2);
partnerInluenceOnTarget = zeros(nFile, 2);
sideChoiceIndependence = zeros(nFile, 1); 
targetChoiceIndependence = zeros(nFile, 1);
for iFile = 1:nFile 
  load(filename{iFile}, 'isOwnChoice', 'isBottomChoice'); 
  % we skip first 200 trials during those learning occured
  coordStruct(iFile) = ...
          check_coordination(isOwnChoice(:,200:end), isBottomChoice(:,200:end));
  [sideChoiceIndependence(iFile), targetChoiceIndependence(iFile)] = ...
          check_independence(isOwnChoice(:,200:end), isBottomChoice(:,200:end));      
end

% PAIRS OVERVIEW
%   human pairs:
% humanData_pair01 - no coordination, P1 follows bottom target, P2 - own target
% humanData_pair02 - fair coordination by choosing bottom target
% humanData_pair03 - not-quite-fair coordination (beneficial for P1) by turn-taking
% humanData_pair04 - no coordination
% humanData_pair05 - slightly unfair coordination (beneficial for P2) by turn-taking
%   artificial agents with memory 1 using evolutionary evolved turn-taking:
% edData_best0 (agents using evolutionary evolved turn-taking) - perfect coordination
%   Reinforcement-learning-based agents with various exploration levels
% rlData_noncuriousVSnoncurious2 - fair coordination by choosing bottom target
% rlData_noncuriousVScurios - unfair coordination: P1 follows own target, 
%    but sometimes SHORTLY switches to turn-taking; P2 follows P1.
% rlData_curiosVScurios.mat - both Players prefer own target and explore
%    too much to establish stable coordination