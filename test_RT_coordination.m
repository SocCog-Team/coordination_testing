FontSize = 11;
lineWidth = 1.0;

folder = 'Z:\taskcontroller\SCP_DATA\ANALYSES\PC1000\2018\CoordinationCheck\';
                               
                 
 filename = {'DATA_20170425T160951.A_21001.B_22002.SCP_00.triallog.A.21001.B.22002_IC_JointTrials.isOwnChoice_sideChoice',...
              'DATA_20170426T102304.A_21003.B_22004.SCP_00.triallog.A.21003.B.22004_IC_JointTrials.isOwnChoice_sideChoice',...
              'DATA_20170426T133343.A_21005.B_12006.SCP_00.triallog.A.21005.B.12006_IC_JointTrials.isOwnChoice_sideChoice',...
              'DATA_20170427T092352.A_21007.B_12008.SCP_00.triallog.A.21007.B.12008_IC_JointTrials.isOwnChoice_sideChoice',...
              'DATA_20170427T132036.A_21009.B_12010.SCP_00.triallog.A.21009.B.12010_IC_JointTrials.isOwnChoice_sideChoice',...
              };


nFile = 5;
coordStruct = cell(nFile, 1);


for iFile = 1:nFile(iSet)
  clear isOwnChoiceArray sideChoiceObjectiveArray
  load([folder, filename{i}, '.mat'], 'isOwnChoiceArray', 'sideChoiceObjectiveArray', 'PerTrialStruct'); 
  if (exist('isOwnChoiceArray', 'var'))
    isOwnChoice = isOwnChoiceArray;
  else
    load([filename{i}, '.mat'], 'isOwnChoice');
  end 
  if (exist('sideChoiceObjectiveArray', 'var'))
    sideChoice = sideChoiceObjectiveArray;
  else
    load([filename{i}, '.mat'], 'isBottomChoice');
  end       
  
  % here we consider only stationary (stabilized) values
  testIndices = max(20, length(isOwnChoice) - 200):length(isOwnChoice);
  coordStruct(i) = check_coordination(isOwnChoice(:,testIndices), sideChoice(:,testIndices));
       
end  