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
  [partnerInluenceOnSide(iFile, :), partnerInluenceOnTarget(iFile, :)] = ...
          check_coordination(isOwnChoice(:,200:end), isBottomChoice(:,200:end));
  [sideChoiceIndependence(iFile), targetChoiceIndependence(iFile)] = ...
          check_independence(isOwnChoice(:,200:end), isBottomChoice(:,200:end));      
end

%coordinating pairs: 
% human pairs 3 and 5 (humanData_pair03.mat, humanData_pair05.mat); 
% artificial agents in edData_best0.mat', 
%   'rlData_noncuriousVSnoncurious2.mat', 
%   'rlData_noncuriousVScurios.mat