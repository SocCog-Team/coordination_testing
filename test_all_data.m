% Common abbreviations: MI - mutual information, TE - transfer entropy
%% prepare dataset for processing
clear all
addpath(genpath('WhittleSurrogates'));
currFolder = cd('../');
parentFolder = cd(currFolder);
addpath(fullfile(parentFolder, 'AuxiliaryFunctions'));

if ispc
    cfg.folder = 'Z:\taskcontroller\SCP_DATA\ANALYSES\PC1000\2018\CoordinationCheck';
else
    cfg.folder = fullfile('/', 'Volumes', 'social_neuroscience_data', 'taskcontroller', 'SCP_DATA', 'ANALYSES', 'PC1000', '2018', 'CoordinationCheck');
end

% filenames - list of all files related to specific Set
% captions - captions of files, adjacent files may have the same caption
% but the they are merged
magnusCuriusNaive.setName = 'MagnusCuriusNaive';
magnusCuriusNaive.filenames = {...
    'DATA_20171108T140407.A_Magnus.B_Curius.SCP_01.triallog.A.Magnus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20171109T133052.A_Magnus.B_Curius.SCP_01.triallog.A.Magnus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20171110T145559.A_Magnus.B_Curius.SCP_01.triallog.A.Magnus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20171113T111603.A_Magnus.B_Curius.SCP_01.triallog.A.Magnus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice',...
    'DATA_20171114T143708.A_Magnus.B_Curius.SCP_01.triallog.A.Magnus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice',...
    'DATA_20171115T134027.A_Magnus.B_Curius.SCP_01.triallog.A.Magnus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20171116T141954.A_Magnus.B_Curius.SCP_01.triallog.A.Magnus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice',...
    'DATA_20171116T142914.A_Magnus.B_Curius.SCP_01.triallog.A.Magnus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice',...
    'DATA_20171117T131908.A_Magnus.B_Curius.SCP_01.triallog.A.Magnus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice',...
    'DATA_20171120T115056.A_Magnus.B_Curius.SCP_01.triallog.A.Magnus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice',...
    'DATA_20171121T103828.A_Magnus.B_Curius.SCP_01.triallog.A.Magnus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice',...
    'DATA_20171122T102507.A_Magnus.B_Curius.SCP_01.triallog.A.Magnus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20171123T101549.A_Magnus.B_Curius.SCP_01.triallog.A.Magnus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice',...
    };
magnusCuriusNaive.captions = {...
    '08.11.17', ...
    '09.11.17', ...
    '10.11.17', ...
    '13.11.17', ...
    '14.11.17', ...
    '15.11.17', ...
    '16.11.17', ...
    '16.11.17', ...
    '17.11.17', ...
    '20.11.17', ...
    '21.11.17', ...
    '22.11.17', ...
    '23.11.17', ...
    };


magnusNaiveCuriusConfederate.setName = 'MagnusNaiveCuriusConfederate';
magnusNaiveCuriusConfederate.filenames = {...
    'DATA_20180212T164357.A_Magnus.B_Curius.SCP_01.triallog.A.Magnus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180213T152733.A_Magnus.B_Curius.SCP_01.triallog.A.Magnus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180214T171119.A_Magnus.B_Curius.SCP_01.triallog.A.Magnus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    };
magnusNaiveCuriusConfederate.captions = {...
    '12.02.18',...
    '13.02.18',...
    '14.02.18', ...
    };


magnusFlaffusNaive.setName = 'MagnusFlaffusNaive';
magnusFlaffusNaive.filenames = {...
    'DATA_20171129T100056.A_Magnus.B_Flaffus.SCP_01.triallog.A.Magnus.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20171130T093044.A_Magnus.B_Flaffus.SCP_01.triallog.A.Magnus.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20171201T101044.A_Magnus.B_Flaffus.SCP_01.triallog.A.Magnus.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20171205T103518.A_Magnus.B_Flaffus.SCP_01.triallog.A.Magnus.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20171206T111532.A_Magnus.B_Flaffus.SCP_01.triallog.A.Magnus.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20171208T092614.A_Magnus.B_Flaffus.SCP_01.triallog.A.Magnus.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20171212T132217.A_Magnus.B_Flaffus.SCP_01.triallog.A.Magnus.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20171213T142240.A_Magnus.B_Flaffus.SCP_01.triallog.A.Magnus.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20171214T072407.A_Magnus.B_Flaffus.SCP_01.triallog.A.Magnus.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20171219T135223.A_Magnus.B_Flaffus.SCP_01.triallog.A.Magnus.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180105T142814.A_Magnus.B_Flaffus.SCP_01.triallog.A.Magnus.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180105T150525.A_Magnus.B_Flaffus.SCP_01.triallog.A.Magnus.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180108T155548.A_Magnus.B_Flaffus.SCP_01.triallog.A.Magnus.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180109T171512.A_Magnus.B_Flaffus.SCP_01.triallog.A.Magnus.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180109T172928.A_Magnus.B_Flaffus.SCP_01.triallog.A.Magnus.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180110T151942.A_Magnus.B_Flaffus.SCP_01.triallog.A.Magnus.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180110T165831.A_Magnus.B_Flaffus.SCP_01.triallog.A.Magnus.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180111T150745.A_Magnus.B_Flaffus.SCP_01.triallog.A.Magnus.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180115T141937.A_Magnus.B_Flaffus.SCP_01.triallog.A.Magnus.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180116T144201.A_Magnus.B_Flaffus.SCP_01.triallog.A.Magnus.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180117T151458.A_Magnus.B_Flaffus.SCP_01.triallog.A.Magnus.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180118T140639.A_Magnus.B_Flaffus.SCP_01.triallog.A.Magnus.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180118T154054.A_Magnus.B_Flaffus.SCP_01.triallog.A.Magnus.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180119T143953.A_Magnus.B_Flaffus.SCP_01.triallog.A.Magnus.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180122T164338.A_Magnus.B_Flaffus.SCP_01.triallog.A.Magnus.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180123T151927.A_Magnus.B_Flaffus.SCP_01.triallog.A.Magnus.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180124T161657.A_Magnus.B_Flaffus.SCP_01.triallog.A.Magnus.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180125T155742.A_Magnus.B_Flaffus.SCP_01.triallog.A.Magnus.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    };
magnusFlaffusNaive.captions = {...
    '20171129', ...
    '20171130', ...
    '20171201', ...
    '20171205', ...
    '20171206', ...
    '20171208', ...
    '20171212', ...
    '20171213', ...
    '20171214', ...
    '20171219', ...
    '20180105', ...
    '20180105', ...
    '20180108', ...
    '20180109', ...
    '20180109', ...
    '20180110T15', ...
    '20180110T17', ...
    '20180111', ...
    '20180115', ...
    '20180116', ...
    '20180117', ...
    '20180118T14', ...
    '20180118T16', ...
    '20180119', ...
    '20180122', ...
    '20180123', ...
    '20180124', ...
    '20180125', ...
    };


flaffusCuriusNaive.setName = 'FlaffusCuriusNaive';
flaffusCuriusNaive.filenames = {...
    'DATA_20171019T132932.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20171020T124628.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20171026T150942.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20171027T145027.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20171031T124333.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20171101T123413.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20171102T102500.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20171103T143324.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20171107T131228.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    };
flaffusCuriusNaive.captions = {...
    '2017.10.19', ...
    '2017.10.20', ...
    '2017.10.26', ...
    '2017.10.27',...
    '2017.10.31',...
    '2017.11.01', ...
    '2017.11.02',...
    '2017.11.03',...
    '2017.11.07', ...
    };


flaffusCuriusConfederate.setName = 'flaffusCuriusConfederate';
flaffusCuriusConfederate.filenames = {...
    'DATA_20180418T143951.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180419T141311.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180420T151954.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180424T121937.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180425T133936.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180426T171117.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180427T142541.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180427T153406.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180501T124452.A_Curius.B_Flaffus.SCP_01.triallog.A.Curius.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    };
flaffusCuriusConfederate.captions = {...
    '2018.04.18',...
    '2018.04.19', ...
    '2018.04.20', ...
    '2018.04.24', ...
    '2018.04.25', ...
    '2018.04.26', ...
    '2018.04.27', ...
    '2018.04.27', ...
    '2018.05.01', ...
    };


flaffusEC.setName = 'FlaffusEC';
flaffusEC.filenames = {...
    'DATA_20171116T115210.A_EC.B_Flaffus.SCP_01.triallog.A.EC.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20171117T093215.A_EC.B_Flaffus.SCP_01.triallog.A.EC.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20171121T133541.A_EC.B_Flaffus.SCP_01.triallog.A.EC.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20171122T133949.A_EC.B_Flaffus.SCP_01.triallog.A.EC.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20171124T131200.A_EC.B_Flaffus.SCP_01.triallog.A.EC.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    };
flaffusEC.captions = {...
    '2017.11.16, 11:52:10', ...
    '2017.11.17, 09:32:15', ...
    '2017.11.21, 13:35:41', ...
    '2017.11.22, 13:39:49', ...
    '2017.11.24, 13:12:00', ...
    };


teslaElmoNaive.setName = 'TeslaElmoNaive';
teslaElmoNaive.filenames = {...
    'DATA_20180516T090940.A_Tesla.B_Elmo.SCP_01.triallog.A.Tesla.B.Elmo_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180517T085104.A_Tesla.B_Elmo.SCP_01.triallog.A.Tesla.B.Elmo_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180518T104104.A_Tesla.B_Elmo.SCP_01.triallog.A.Tesla.B.Elmo_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180522T101558.A_Tesla.B_Elmo.SCP_01.triallog.A.Tesla.B.Elmo_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180523T092531.A_Tesla.B_Elmo.SCP_01.triallog.A.Tesla.B.Elmo_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180524T103704.A_Tesla.B_Elmo.SCP_01.triallog.A.Tesla.B.Elmo_IC_JointTrials.isOwnChoice_sideChoice', ...
    };
teslaElmoNaive.captions = {...
    '20180516', ...
    '20180517', ...
    '20180518', ...
    '20180522', ...
    '20180523', ...
    '20180524', ...
    };


teslaNaiveFlaffusConfederate.setName = 'teslaNaiveFlaffusConfederate';
teslaNaiveFlaffusConfederate.filenames = {...
    'DATA_20180504T114516.A_Tesla.B_Flaffus.SCP_01.triallog.A.Tesla.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180507T151756.A_Tesla.B_Flaffus.SCP_01.triallog.A.Tesla.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180508T132214.A_Tesla.B_Flaffus.SCP_01.triallog.A.Tesla.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180509T122330.A_Tesla.B_Flaffus.SCP_01.triallog.A.Tesla.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    };
teslaNaiveFlaffusConfederate.captions = {...
    '20180504', ...
    '20180507', ...
    '20180508', ...
    '20180509', ...
    };


teslaNaiveCuriusConfederate.setName = 'TeslaNaiveCuriusConfederate';
teslaNaiveCuriusConfederate.filenames = {...
    'DATA_20180525T091512.A_Tesla.B_Curius.SCP_01.triallog.A.Tesla.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180528T132259.A_Tesla.B_Curius.SCP_01.triallog.A.Tesla.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180529T130237.A_Tesla.B_Curius.SCP_01.triallog.A.Tesla.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180530T153325.A_Tesla.B_Curius.SCP_01.triallog.A.Tesla.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180531T104356.A_Tesla.B_Curius.SCP_01.triallog.A.Tesla.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    };
teslaNaiveCuriusConfederate.captions = {...
    '20180525', ...
    '20180528', ...
    '20180529', ...
    '20180530', ...
    '20180531', ...
    };


JKElmo.setName = 'JKElmo';
JKElmo.filenames = {...
    'DATA_20180620T095959.A_JK.B_Elmo.SCP_01.triallog.A.JK.B.Elmo_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180621T080841.A_JK.B_Elmo.SCP_01.triallog.A.JK.B.Elmo_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180622T071433.A_JK.B_Elmo.SCP_01.triallog.A.JK.B.Elmo_IC_JointTrials.isOwnChoice_sideChoice', ...
    };
JKElmo.captions = {...
    '20180620', ...
    '20180621', ...
    '20180622', ...
    };


SMTesla.setName = 'SMTesla';
SMTesla.filenames = {...
    'DATA_20180601T122747.A_Tesla.B_SM.SCP_01.triallog.A.Tesla.B.SM_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180604T150239.A_Tesla.B_SM.SCP_01.triallog.A.Tesla.B.SM_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180605T150607.A_Tesla.B_SM.SCP_01.triallog.A.Tesla.B.SM_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180606T142829.A_Tesla.B_SM.SCP_01.triallog.A.Tesla.B.SM_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180607T142823.A_Tesla.B_SM.SCP_01.triallog.A.Tesla.B.SM_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180607T145715.A_Tesla.B_SM.SCP_01.triallog.A.Tesla.B.SM_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180608T100903.A_Tesla.B_SM.SCP_01.triallog.A.Tesla.B.SM_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180611T150057.A_Tesla.B_SM.SCP_01.triallog.A.Tesla.B.SM_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180612T162540.A_Tesla.B_SM.SCP_01.triallog.A.Tesla.B.SM_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180613T141225.A_Tesla.B_SM.SCP_01.triallog.A.Tesla.B.SM_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180614T165947.A_Tesla.B_SM.SCP_01.triallog.A.Tesla.B.SM_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180615T150245.A_Tesla.B_SM.SCP_01.triallog.A.Tesla.B.SM_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180615T154238.A_Tesla.B_SM.SCP_01.triallog.A.Tesla.B.SM_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180618T140913.A_Tesla.B_SM.SCP_01.triallog.A.Tesla.B.SM_IC_JointTrials.isOwnChoice_sideChoice', ...
    };
SMTesla.captions = {...
    '20180601', ...
    '20180604', ...
    '20180605', ...
    '20180606', ...
    '20180607', ...
    '20180607', ...
    '20180608', ...
    '20180611', ...
    '20180612', ...
    '20180613', ...
    '20180614', ...
    '20180615', ...
    '20180615', ...
    '20180618', ...
    };


SMElmo.setName = 'SMElmo';
SMElmo.filenames = {...
    'DATA_20180619T150344.A_SM.B_Elmo.SCP_01.triallog.A.SM.B.Elmo_IC_JointTrials.isOwnChoice_sideChoice', ...
    };
SMElmo.captions = {...
    '20180619', ...
    };


SMCurius.setName = 'SMCurius';
SMCurius.filenames = {...
    'DATA_20171206T141710.A_SM.B_Curius.SCP_01.triallog.A.SM.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20171208T140548.A_SM.B_Curius.SCP_01.triallog.A.SM.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20171211T110911.A_SM.B_Curius.SCP_01.triallog.A.SM.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20171212T104819.A_SM.B_Curius.SCP_01.triallog.A.SM.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180111T130920.A_SM.B_Curius.SCP_01.triallog.A.SM.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180112T103626.A_SM.B_Curius.SCP_01.triallog.A.SM.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180118T120304.A_SM.B_Curius.SCP_01.triallog.A.SM.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180423T162330.A_SM.B_Curius.SCP_01.triallog.A.SM.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    };
SMCurius.captions = {...
    '06.12.17', ...
    '08.12.17', ...
    '11.12.17', ...
    '12.12.17', ...
    '11.01.18', ...
    '12.01.18', ...
    '18.01.18', ...
    '23.04.18', ...
    };


SMCuriusBlock.setName = 'SMCuriusBlock';
SMCuriusBlock.filenames = {...
    'DATA_20171213T112521.A_SM.B_Curius.SCP_01.triallog.A.SM.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20171215T122633.A_SM.B_Curius.SCP_01.triallog.A.SM.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20171221T135010.A_SM.B_Curius.SCP_01.triallog.A.SM.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20171222T104137.A_SM.B_Curius.SCP_01.triallog.A.SM.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180119T123000.A_SM.B_Curius.SCP_01.triallog.A.SM.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180123T132012.A_SM.B_Curius.SCP_01.triallog.A.SM.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180124T141322.A_SM.B_Curius.SCP_01.triallog.A.SM.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180125T140345.A_SM.B_Curius.SCP_01.triallog.A.SM.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180126T132629.A_SM.B_Curius.SCP_01.triallog.A.SM.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...'
    };
SMCuriusBlock.captions = {...
    '13.12.2017', ...
    '15.12.2017', ...
    '21.12.2017', ...
    '22.12.2017', ...
    '19.01.2018', ...
    '23.01.2018', ...
    '24.01.2018', ...
    '25.01.2018', ...
    '26.01.2018'...
    };
SMCuriusBlockBorder = [143,	344; 138, 239; 115, 259;  123, 263; ...
    162, 322; 167, 331; 158, 314; 160, 325; 161, 317];


SMFlaffus.setName = 'SMFlaffus';
SMFlaffus.filenames = {...
    'DATA_20180131T155005.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180201T162341.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180202T144348.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180205T122214.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180209T145624.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180213T133932.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180214T141456.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180215T131327.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180216T140913.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180220T133215.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180221T133419.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180222T121106.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180223T143339.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180227T151756.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180228T132647.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    };
SMFlaffus.captions = {...
    '31.01.18', ...
    '01.02.18', ...
    '02.02.18', ...
    '05.02.18', ...
    '09.02.18', ...
    '13.02.18', ...
    '14.02.18', ...
    '15.02.18', ...
    '16.02.18', ...
    '20.02.18', ...
    '21.02.18', ...
    '22.02.18', ...
    '23.02.18', ...
    '27.02.18', ...
    '28.02.18', ...
    };


FlaffusSM.setName = 'FlaffusSM';
FlaffusSM.filenames = {...
    'DATA_20180406T111431.A_Flaffus.B_SM.SCP_01.triallog.A.Flaffus.B.SM_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180409T145457.A_Flaffus.B_SM.SCP_01.triallog.A.Flaffus.B.SM_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180410T125708.A_Flaffus.B_SM.SCP_01.triallog.A.Flaffus.B.SM_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180411T104941.A_Flaffus.B_SM.SCP_01.triallog.A.Flaffus.B.SM_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180413T113720.A_Flaffus.B_SM.SCP_01.triallog.A.Flaffus.B.SM_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180416T122545.A_Flaffus.B_SM.SCP_01.triallog.A.Flaffus.B.SM_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180416T124439.A_Flaffus.B_SM.SCP_01.triallog.A.Flaffus.B.SM_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180417T161836.A_Flaffus.B_SM.SCP_01.triallog.A.Flaffus.B.SM_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180423T141825.A_Flaffus.B_SM.SCP_01.triallog.A.Flaffus.B.SM_IC_JointTrials.isOwnChoice_sideChoice', ...
    };
FlaffusSM.captions = {...
    '06.04.18', ...
    '09.04.18', ...
    '10.04.18', ...
    '11.04.18', ...
    '13.04.18', ...
    '16.04.18', ...
    '16.04.18', ...
    '17.04.18', ...
    '23.04.18', ...
    };


SMFlaffusBlock.setName = 'SMFlaffusBlock';
SMFlaffusBlock.filenames = {...
    'DATA_20180301T122505.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180302T151740.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180306T112342.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180307T100718.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180308T121753.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180309T110024.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    };
SMFlaffusBlock.captions = {...
    '01.03.18', ...
    '02.03.18', ...
    '06.03.18', ...
    '07.03.18', ...
    '08.03.18', ...
    '09.03.18' ...
    };


TNCurius.setName = 'TNCurius';
TNCurius.filenames = {...
    'DATA_20180406T135926.A_TN.B_Curius.SCP_01.triallog.A.TN.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180410T144850.A_TN.B_Curius.SCP_01.triallog.A.TN.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180411T145314.A_TN.B_Curius.SCP_01.triallog.A.TN.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180413T143841.A_TN.B_Curius.SCP_01.triallog.A.TN.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180417T130643.A_TN.B_Curius.SCP_01.triallog.A.TN.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
    };
TNCurius.captions = {...
    '06.04.18', ...
    '10.04.18', ...
    '11.04.18', ...
    '13.04.18', ...
    '17.04.18', ...
    };


humanPair.setName = 'HumanPairs';
humanPair.filenames = {...
    'DATA_20170425T160951.A_21001.B_22002.SCP_00.triallog.A.21001.B.22002_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20170426T102304.A_21003.B_22004.SCP_00.triallog.A.21003.B.22004_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20170426T133343.A_21005.B_12006.SCP_00.triallog.A.21005.B.12006_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20170427T092352.A_21007.B_12008.SCP_00.triallog.A.21007.B.12008_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20170427T132036.A_21009.B_12010.SCP_00.triallog.A.21009.B.12010_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20171113T162815.A_20011.B_10012.SCP_01.triallog.A.20011.B.10012_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20171115T165545.A_20013.B_10014.SCP_01.triallog.A.20013.B.10014_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20171116T164137.A_20015.B_10016.SCP_01.triallog.A.20015.B.10016_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20171121T165717.A_10018.B_20017.SCP_01.triallog.A.10018.B.20017_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20171121T175909.A_10018.B_20017.SCP_01.triallog.A.10018.B.20017_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20171123T165158.A_20019.B_10020.SCP_01.triallog.A.20019.B.10020_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20171127T164730.A_20021.B_20022.SCP_01.triallog.A.20021.B.20022_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20171128T165159.A_20024.B_10023.SCP_01.triallog.A.20024.B.10023_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20171130T145412.A_20025.B_20026.SCP_01.triallog.A.20025.B.20026_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20171130T164300.A_20027.B_10028.SCP_01.triallog.A.20027.B.10028_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20171205T163542.A_20029.B_10030.SCP_01.triallog.A.20029.B.10030_IC_JointTrials.isOwnChoice_sideChoice', ...
    };
humanPair.captions = {...
    '01vs02', ...
    '03vs04', ...
    '05vs06', ...
    '07vs08', ...
    '09vs10', ...
    '11vs12', ...
    '13vs14', ...
    '15vs16', ...
    '18vs17', ...
    '18vs17', ...
    '19vs20', ...
    '21vs22', ...
    '24vs23', ...
    '25vs26', ...
    '27vs28', ...
    '29vs30', ...
    };


humanPairBlocked.setName = 'HumanPairsBlocked';
humanPairBlocked.filenames = {...
    'DATA_20180319T155543.A_31001.B_31002.SCP_01.triallog.A.31001.B.31002_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180320T142201.A_32003.B_32004.SCP_01.triallog.A.32003.B.32004_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180321T134216.A_31005.B_32006.SCP_01.triallog.A.31005.B.32006_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180322T110101.A_31007.B_32008.SCP_01.triallog.A.31007.B.32008_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180322T164348.A_32009.B_32010.SCP_01.triallog.A.32009.B.32010_IC_JointTrials.isOwnChoice_sideChoice', ...
    };
humanPairBlocked.captions = {...
    '01vs02', ...
    '03vs04', ...
    '05vs06', ...
    '07vs08', ...
    '09vs10', ...
    };


SMhumanBlocked.setName = 'SMHumanBlocked';
SMhumanBlocked.filenames = {...
    'DATA_20180417T185908.A_SM.B_52001.SCP_01.triallog.A.SM.B.52001_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180418T111112.A_SM.B_52002.SCP_01.triallog.A.SM.B.52002_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180419T112118.A_SM.B_51003.SCP_01.triallog.A.SM.B.51003_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180420T171629.A_SM.B_52004.SCP_01.triallog.A.SM.B.52004_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180420T192826.A_SM.B_52005.SCP_01.triallog.A.SM.B.52005_IC_JointTrials.isOwnChoice_sideChoice', ...
    };
SMhumanBlocked.captions = {...
    'Human Confederate 1', ...
    'Human Confederate 2', ...
    'Human Confederate 3', ...
    'Human Confederate 4', ...
    'Human Confederate 5', ...
    };


% flag indicating whether to scan all datasets or only selected ones
SCAN_ALL_DATASET = 1;
%SCAN_ALL_DATASET = 0;
if (SCAN_ALL_DATASET)
    dataset = {teslaElmoNaive, teslaNaiveFlaffusConfederate, teslaNaiveCuriusConfederate, SMTesla, SMElmo, JKElmo, magnusCuriusNaive, magnusNaiveCuriusConfederate, flaffusCuriusNaive, flaffusCuriusConfederate, flaffusEC, SMCurius, SMCuriusBlock, TNCurius, SMFlaffus, SMFlaffusBlock, FlaffusSM, humanPair, humanPairBlocked, SMhumanBlocked, magnusFlaffusNaive};
    %dataset = {teslaNaiveFlaffusConfederate, teslaNaiveCuriusConfederate};
    %dataset = {magnusFlaffusNaive};
else
    dataset = {SMhumanBlocked};
end


%% plotting parameters
% COPY FROM HERE
fontSize = 8;
markerSize = 4;
lineWidth = 1.0;

plotName = {'TEtarget', 'MutualInf', 'surprise_pos'};

colorList = [...
    % blue group: navy, purple, blue, light blue, lavender
    0.0, 0.0, 0.5; ...
    0.6, 0.2, 0.7; ...
    0.2, 0.3, 0.8; ...    
    0.5, 0.6, 1.0; ...
    0.9, 0.7, 1.0; ...    
    
    % cyan group: teal, light teal, cyan
    0.0, 0.5, 0.5; ...
    0.0, 0.8, 0.7; ...
    0.3, 0.9, 0.9; ...   
     
    % green group: olive, lime, 
    0.5, 0.5, 0.0; ...    
    0.8, 0.9, 0.2; ... 
    
    % red group: red, magenta, pink, coral
    0.8, 0.1, 0.2; ...
    1.0, 0.2, 0.7; ...
    1.0, 0.5, 0.6; ...
    1.0, 0.8, 0.8; ...
        
    % yellow group: maroon, brown, yellow
    0.6, 0.0, 0.0; ... 
    0.7, 0.4, 0.2; ...    
    1.0, 0.9, 0.5; ...
    
    ];

%% set parameters of the methods
cfg.pValueForMI = 0.01;
cfg.memoryLength = 1; % number of previous trials that affect the choices on the current trils
cfg.minSampleNum = 6*(2.^(cfg.memoryLength+1))*(2.^cfg.memoryLength);
cfg.stationarySegmentLength = 200;  % number of last trials supposedly corresponding to equilibrium state
cfg.minStationarySegmentStart = 20; % earliest possible start of equilibrium state
cfg.minDRT = 200; %minimal difference of reaction times allowing the slower partner to se the choice of the faster 

%% run analysis 
resultFilename = 'coordinationData.mat';
compute_coordination_metrics(dataset, cfg, resultFilename);
%if (~res)
%    error('Processing failed, please debug');
%end    
load(resultFilename); 
%% test strategies

% prepare strategies for testing
strategyNames = {'Own target following', 'Other target following', ...
                 'Left side following', 'Right side following', ...
                 'Side turn-taking', 'Turn-taking', 'Challenger', ... 
                 'Long turn-taking', 'Leader-Follower', 'Follower', ...
                 };
nStrategy = length(strategyNames);
strategyArray = cell(1, nStrategy);
basicStrategyIndex = [1,2,3,4];

nRow = 4;     
nCol = 12;
for iStrategy = 1:nStrategy
    strategyArray{iStrategy} = zeros(nRow, nCol);
end

goodProbabilityThreshold = 0.95;
minProbabilityThreshold = 0.33;
minDRT = 200;

PARAM_MARK = 2;
maxParamValue = ones(1, nStrategy);
% ----------Side Strategies----------
%{
% Left side following
strategyArray{1}(1, [11,12]) = 1;
strategyArray{1}(1, [1,2, 5,6, 9,10]) = 0.5;
strategyArray{1}(2, [3,4, 7,8, 11,12]) = 1;
strategyArray{1}(2, [1,2, 5,6, 9,10]) = 0.5;
strategyArray{1}(3, [9,10]) = 1;
strategyArray{1}(3, [3,4, 7,8, 11,12]) = 0.5;
strategyArray{1}(4, [1,2, 5,6, 9,10]) = 1;
strategyArray{1}(4, [3,4, 7,8, 11,12]) = 0.5;

% Right side following
strategyArray{2}(4, [11,12]) = 1;
strategyArray{2}(4, [1,2, 5,6, 9,10]) = 0.5;
strategyArray{2}(3, [3,4, 7,8, 11,12]) = 1;
strategyArray{2}(3, [1,2, 5,6, 9,10]) = 0.5;
strategyArray{2}(2, [9,10]) = 1;
strategyArray{2}(2, [3,4, 7,8, 11,12]) = 0.5;
strategyArray{2}(1, [1,2, 5,6, 9,10]) = 1;
strategyArray{2}(1, [3,4, 7,8, 11,12]) = 0.5;
%}
% ------- basic strategies --------
% Insister
strategyArray{1}(1, 1:12) = 1;
% Conformist (the same as Follower, but without clear temporal following)
strategyArray{2}(1, 5:12) = 0.5;

% Cautious left side following
strategyArray{3}(1, 1:6) = PARAM_MARK;  %indicates parameter value that should be computed
strategyArray{3}(1, 9:12) = 1;
strategyArray{3}(2, :) = 1;
strategyArray{3}(3, [1,2, 5,6]) = PARAM_MARK;  %indicates parameter value that should be computed;
strategyArray{3}(3, [9,10]) = 1;
strategyArray{3}(3, [3,4, 7,8, 11,12]) = 0.5;
strategyArray{3}(4, [1,2, 5,6, 9,10]) = 1;
strategyArray{3}(4, [3,4, 7,8, 11,12]) = 0.5;
maxParamValue(3) = 0.6;

% Cautious right side following
strategyArray{4}(4, 1:6) = PARAM_MARK;  %indicates parameter value that should be computed
strategyArray{4}(4, 9:12) = 1;
strategyArray{4}(3, :) = 1;
strategyArray{4}(2, [1,2, 5,6]) = PARAM_MARK;  %indicates parameter value that should be computed
strategyArray{4}(2, [9,10]) = 1;
strategyArray{4}(2, [3,4, 7,8, 11,12]) = 0.5;
strategyArray{4}(1, [1,2, 5,6, 9,10]) = 1;
strategyArray{4}(1, [3,4, 7,8, 11,12]) = 0.5;
maxParamValue(4) = 0.6;

% ------- more complex strategies strategies --------
% Side turn-taking
strategyArray{5}(1, [1,4, 5,7,8, 9,10,12]) = 0.5;
strategyArray{5}(1, [3, 11]) = 1;
strategyArray{5}(2, [1,4, 5,7,8, 9,11,12]) = 0.5;
strategyArray{5}(2, [2, 10]) = 1;
strategyArray{5}(3:4, :) = strategyArray{5}(2:-1:1, :);

% Turn-taking
strategyArray{6}(1, [3,7,9:12]) = 1;
strategyArray{6}(1, [1,4]) = PARAM_MARK;  %indicates parameter value that should be computed

% Challenger
% not entirely stubborn, but still unyilding
strategyArray{7}(1, [2, 6, 9:12]) = 1;
strategyArray{7}(1, [1,4]) = 0.9; 
strategyArray{7}(1, [5,8]) = PARAM_MARK;

% Long-term turn-taking
% Similar to Challenger but behaviour after uncoordinated choice 
% in not important (should be rare)
% Human confederate can be classified either as challenger or as LT turn-taker
strategyArray{8}(1, [2, 6, 9:12]) = 1;
strategyArray{8}(1, [1,4]) = 0.5;
strategyArray{8}(1, [5,8]) = PARAM_MARK;

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

strategyParam = cell(nSet, max(nFile));
strategyProbabilityPerTrial = cell(nSet, max(nFile));
strategyMeanProbability = cell(nSet, max(nFile));
strategyLogMeanProbability = cell(nSet, max(nFile));

identifiedStrategyIndex = cell(nSet, 1);
identifiedStrategyProb = cell(nSet, 1);
identifiedStrategyParam = cell(nSet, 1);
for iSet = 1:nSet
    disp(['Test strategies for cfg.minDRT' num2str(iSet)]);
    
    identifiedStrategyIndex{iSet} = zeros(2, nFile(iSet));
    identifiedStrategyProb{iSet} = zeros(2, nFile(iSet));
    identifiedStrategyParam{iSet} = zeros(2, nFile(iSet));
    for iFile = 1:nFile(iSet)
        % here we consider only equilibrium (stabilized) values
        nTrial = length(allOwnChoice{iSet, iFile});
        fistTestIndex = max(minStationarySegmentStart, nTrial-stationarySegmentLength);
        testIndices = fistTestIndex:nTrial;
        nTestIndices = length(testIndices);
        
        isOwnChoice = allOwnChoice{iSet, iFile}(:,testIndices);
        sideChoice = allSideChoice{iSet, iFile}(:,testIndices);
        RT = allRT{iSet, iFile}(:,testIndices);
        
        strategyForTest = cell(2, nStrategy);
        strategyForTest(1,:) = strategyArray;
        strategyForTest(2,:) = strategyArray;
        % estimate strategy parameters
        strategyParam{iSet, iFile} = -ones(2, nStrategy); %initialize with invalid values
        [strategy, nStateVisit] = estimate_strategy(isOwnChoice, sideChoice, RT, minDRT);                
        strategy{1}(isnan(strategy{1})) = 0;
        strategy{2}(isnan(strategy{2})) = 0;

        for iStrategy = 1:nStrategy
            m = zeros(1,2);
            n = zeros(1,2);
            paramIndex = (strategyArray{iStrategy} == PARAM_MARK);
            if (nnz(paramIndex) > 0)
                for iPlayer = 1:2   
                    m(iPlayer) = sum(sum(strategy{iPlayer}(paramIndex).*nStateVisit{iPlayer}(paramIndex)));
                    n(iPlayer) = sum(sum(nStateVisit{iPlayer}(paramIndex)));
                end                        
                paramValue = m./n;            
                paramValue(n == 0) = 0.5; % replace incorrect values by uncertainty
               
                paramErrorProb = minErrorProb;
                paramValue(paramValue > 1 - paramErrorProb) = 1 - paramErrorProb;
                paramValue(paramValue < paramErrorProb) = paramErrorProb;
                paramValue(paramValue > maxParamValue(iStrategy)) = maxParamValue(iStrategy);
            
                strategyParam{iSet, iFile}(:, iStrategy) = paramValue;
            
                for iPlayer = 1:2  
                    strategyForTest{iPlayer,iStrategy}(paramIndex) = paramValue(iPlayer);
                end              
            end    
        end
%{        
        for iStrategy = 1:nStrategy
            m1 = zeros(1,2);
            n1 = zeros(1,2);
            m2 = zeros(1,2);
            n2 = zeros(1,2);
            paramPosIndex = strategyArray{iStrategy} == PARAM_MARK;
            if (nnz(paramPosIndex) > 0)
                for iPlayer = 1:2   
                    m1(iPlayer) = sum(sum(strategy{iPlayer}(paramPosIndex).*nStateVisit{iPlayer}(paramPosIndex)));
                    n1(iPlayer) = sum(sum(nStateVisit{iPlayer}(paramPosIndex)));
                end    
            end
            paramInvIndex = strategyArray{iStrategy} == INVERSE_PARAM_MARK;
            if (nnz(paramInvIndex) > 0)
                for iPlayer = 1:2   
                    m2(iPlayer) = sum(sum(strategy{iPlayer}(paramInvIndex).*nStateVisit{iPlayer}(paramInvIndex)));
                    n2(iPlayer) = sum(sum(nStateVisit{iPlayer}(paramInvIndex)));
                end   
            end
            paramValue = (m1+(n2-m2))./(n1+n2);            
            paramValue(n1 + n2 == 0) = 0.5; % replace incorrect values by uncertainty
               
            paramErrorProb = 0.05;
            paramValue(paramValue > 1 - paramErrorProb) = 1 - paramErrorProb;
            paramValue(paramValue < paramErrorProb) = paramErrorProb;
            paramValue(paramValue > maxParamValue(iStrategy)) = maxParamValue(iStrategy);
            
            strategyParam{iSet, iFile}(:, iStrategy) = paramValue;
            for iPlayer = 1:2  
                if (nnz(paramPosIndex) > 0)
                    strategyForTest{iPlayer,iStrategy}(paramPosIndex) = paramValue(iPlayer);
                end
                if (nnz(paramInvIndex) > 0)
                    strategyForTest{iPlayer,iStrategy}(paramInvIndex) = 1 - paramValue(iPlayer);
                end                
            end    
        end
%}            
               
        [strategyMeanProbability{iSet, iFile}, strategyLogMeanProbability{iSet, iFile}, ...
         strategyProbabilityPerTrial{iSet, iFile}] = check_strategy_probability(isOwnChoice, sideChoice, strategyForTest, RT, minDRT);        
     
       
        % first test basic strategies
        for iPlayer = 1:2 
            [bestBasicStrategyProb, bestBasicStrategyIndex] = max(strategyLogMeanProbability{iSet, iFile}(iPlayer, basicStrategyIndex));
            if (bestBasicStrategyProb >= goodProbabilityThreshold)
                identifiedStrategyProb{iSet}(iPlayer, iFile) = bestBasicStrategyProb;
                identifiedStrategyIndex{iSet}(iPlayer, iFile) = basicStrategyIndex(bestBasicStrategyIndex);         
            else
                [identifiedStrategyProb{iSet}(iPlayer, iFile), maxStrategyIndex] = max(strategyLogMeanProbability{iSet, iFile}(iPlayer, :));
                identifiedStrategyIndex{iSet}(iPlayer, iFile) = maxStrategyIndex;
                identifiedStrategyParam{iSet}(iPlayer, iFile) = strategyParam{iSet, iFile}(iPlayer, maxStrategyIndex);  
            end
        end    
    end
    badIdentificationIndex = identifiedStrategyProb{iSet} < minProbabilityThreshold;
    identifiedStrategyIndex{iSet}(badIdentificationIndex) = 0;
end

%% results plotting
plot_MI_TE_timecources = false;
plot_blockwise_result = true;

plot_coordination_metrics_per_set(dataset, sessionMetrics, fontSize, markerSize);

for iSet = 1:nSet   
    if (plot_MI_TE_timecources)
        % plot MI and TE dynamics over each session
        nFileCol = floor(sqrt(2*nFile(iSet)));
        nFileRow = ceil(nFile(iSet)/nFileCol);
        figureTitle = {' Transfer Entropy', ' Mutual Information'};
        for iPlot = 1:2
            figure('Name',[dataset{iSet}.setName, figureTitle{iPlot}]);
            set( axes,'fontsize', fontSize,  'FontName', 'Arial');%'FontName', 'Times');

            for iFile = 1:nFile(iSet)
                subplot(nFileRow, nFileCol, iFile)
                hold on
                if (iPlot == 1)
                    if (blockBorder{iSet}(iFile,1) > 0)
                        fill([blockBorder{iSet}(iFile,:), blockBorder{iSet}(iFile,2:-1:1)], ...
                            [1.01*minValue, 1.01*minValue, 1.01*maxValue, 1.01*maxValue], [0.8,0.8,0.8]);
                    end
                    h1 = plot(localTargetTE1{iSet, iFile}, 'Color', [0.9, 0.5, 0.5], 'linewidth', lineWidth);
                    h2 = plot(localTargetTE2{iSet, iFile}, 'Color', [0.5, 0.5, 0.9], 'linewidth', lineWidth);
                    h3 = plot(targetTE1{iSet, iFile}, 'r-', 'linewidth', lineWidth+1);
                    h4 = plot(targetTE2{iSet, iFile}, 'b-', 'linewidth', lineWidth+1);
                elseif (iPlot == 2)
                    if (blockBorder{iSet}(iFile,1) > 0)
                        fill([blockBorder{iSet}(iFile,:), blockBorder{iSet}(iFile,2:-1:1)], ...
                            [1.01*minMIvalue, 1.01*minMIvalue, 1.01*maxMIvalue, 1.01*maxMIvalue], [0.8,0.8,0.8]);
                    end
                    h1 = plot(locMutualInf{iSet, iFile}, 'Color', [0.7, 0.3, 0.7], 'linewidth', lineWidth);
                    h2 = plot(mutualInf{iSet, iFile}, 'Color', [0.4, 0.1, 0.4], 'linewidth', lineWidth+1);
                    plot([1, length(locMutualInf{iSet, iFile})], [0 0], 'k--', 'linewidth', 1.2)
                end
                hold off
                set( gca, 'fontsize', fontSize,  'FontName', 'Arial');%'FontName', 'Times');
                if (iPlot == 1)
                    axis([0.8, length(targetTE1{iSet, iFile}) + 0.2, 1.01*minValue, 1.01*maxValue]);
                else
                    axis([0.8, length(locMutualInf{iSet, iFile}) + 0.2, 1.01*minMIvalue, 1.01*maxMIvalue]);
                end
                if (iFile == 1)
                    if (iPlot == 1)
                        legendHandle = legend([h1, h2, h3, h4], '$\mathrm{te_{P1\rightarrow P2}}$', '$\mathrm{te_{P2\rightarrow P1}}$', '$\mathrm{TE_{P1\rightarrow P2}}$', '$\mathrm{TE_{P2\rightarrow P1}}$', 'location', 'NorthEast');
                    elseif (iPlot == 2)
                        legendHandle = legend([h1, h2], '$\mathrm{i(P1,P2)}$', '$\mathrm{MI(P1,P2)}$', 'location', 'NorthEast');
                    end
                    set(legendHandle, 'fontsize', fontSize-1, 'FontName', 'Times', 'Interpreter', 'latex');
                end

                title(dataset{iSet}.captions{iFile}, 'fontsize', fontSize,  'FontName', 'Arial');%'FontName', 'Times', 'Interpreter', 'latex');
            end
            set( gcf, 'PaperUnits','centimeters' );
            xSize = 29; ySize = 21;
            xLeft = 0; yTop = 0;
            set( gcf,'PaperPosition', [ xLeft yTop xSize ySize ] );
            set(gcf,'PaperSize',fliplr(get(gcf,'PaperSize')))
            print ( '-depsc', '-r600', [plotName{iPlot}, '_', dataset{iSet}.setName]);
            print('-dpdf', [plotName{iPlot}, '_', dataset{iSet}.setName], '-r600');
        end
    end
    % If there are 3 blocks (sessions with trial blocking): plot boxplots for
    % each trial block (before, during and after the blocking) representing
    % distribution of MI, TE and non-random reward component for given block
    if (plot_blockwise_result) && (blockBorder{iSet}(1,1) > 0)
        figure('Name', [dataset{iSet}.setName ' block-wise plot']);
        set( axes,'fontsize', fontSize,  'FontName', 'Arial');%'FontName', 'Times');
        subplot(1,4,1)
        boxplot(miValueBlock{iSet});
        title('Mutual information (target)', 'fontsize', fontSize,  'FontName', 'Arial');
        set( gca, 'fontsize', fontSize,  'FontName', 'Arial', 'XTickLabel', {'before', 'block', 'after'});%'FontName', 'Times');
        
        subplot(1,4,2)
        boxplot(sideMIvalueBlock{iSet});
        title('Mutual information (side)', 'fontsize', fontSize,  'FontName', 'Arial');
        set( gca, 'fontsize', fontSize,  'FontName', 'Arial', 'XTickLabel', {'before', 'block', 'after'});%'FontName', 'Times');
        
        subplot(1,4,3)
        boxplot(teBlock1{iSet});
        title('Transfer entropy', 'fontsize', fontSize,  'FontName', 'Arial');
        set( gca, 'fontsize', fontSize,  'FontName', 'Arial', 'XTickLabel', {'before', 'block', 'after'});%'FontName', 'Times');
        
        subplot(1,4,4)
        boxplot(deltaRewardBlock{iSet});
        title('Non-random reward', 'fontsize', fontSize,  'FontName', 'Arial');
        set( gca, 'fontsize', fontSize,  'FontName', 'Arial', 'XTickLabel', {'before', 'block', 'after'});%'FontName', 'Times');
        
        set( gcf, 'PaperUnits','centimeters' );
        set(gcf,'PaperSize',fliplr(get(gcf,'PaperSize')))
        xSize = 30; ySize = 7;
        xLeft = 0; yTop = 0;
        set( gcf,'PaperPosition', [ xLeft yTop xSize ySize ] );
        print ( '-depsc', '-r600', ['BlockBoxplot_' dataset{iSet}.setName]);
        print('-r600', ['BlockBoxplot_' dataset{iSet}.setName],'-dtiff');
    end
end


%% plot overall MI scatter plot
monkeyNaiveSet = [1,7,9,21];
monkeyTrainedSet = [2,3,8,10];
monkeyConfederateSet = [4,5,6,11,12,14,15,17];
humanSet = [18,19,20];
%blockedSet = [13,16,19,20];
%blockedSet = [19];
allSets = {monkeyNaiveSet, monkeyTrainedSet, monkeyConfederateSet,humanSet};
%allSets = {naiveSet, trainedSet, humanConfederateSet};
setMarker = {'o', 's', 'd', '+', 'x'};
selectedColorList = [colorList(1,:); colorList(4,:); colorList(5,:); colorList(6,:); colorList(8,:); colorList(9,:); colorList(10,:); colorList(12,:); colorList(14,:); colorList(15,:)];
legendIndex = [allSets{:}];

totalFileIndex = 1;
%{
nPoint = sum(nFile);
xScatterPlot = zeros(nPoint, 1);
yScatterPlot = zeros(nPoint, 1);
colorScatterPlot = zeros(nPoint, 3);
for iSet = 1:nSet
    for iFile = 1:nFile(iSet)
        xScatterPlot(totalFileIndex) = sideMIvalueWhole{iSet, iFile};
        yScatterPlot(totalFileIndex) = miValueWhole{iSet, iFile};
        colorScatterPlot(totalFileIndex,:) = colorList(iSet, :);
    end
end    
%}
sz = 16;
nSetGroup = length(allSets);
figure('Name', 'MI scatter plot');
set( axes,'fontsize', fontSize,  'FontName', 'Arial');%'FontName', 'Times');
hold on
for iSetGroup = 1:nSetGroup
  for iSet = 1:length(allSets{iSetGroup}) 
    i = allSets{iSetGroup}(iSet);
    if ((setMarker{iSetGroup} == 's') || (setMarker{iSetGroup} == 'o') || (setMarker{iSetGroup} == 'd'))
        scatter([sideMIvalueWhole{i, :}], [miValueWhole{i, :}], sz, selectedColorList(iSet, :), setMarker{iSetGroup}, 'filled');
    else    
        scatter([sideMIvalueWhole{i, :}], [miValueWhole{i, :}], sz, selectedColorList(iSet, :), setMarker{iSetGroup});
    end    
  end  
end
hold off
axis([-0.1, 1.6, -0.1, 1.0]);
xlabel('side Mutual Information', 'fontsize', fontSize, 'FontName', 'Arial');
ylabel('target Mutual Information', 'fontsize', fontSize, 'FontName', 'Arial');
set( gca, 'fontsize', fontSize, 'FontName', 'Arial');%'FontName', 'Times');

legendHandle = legend(dataset{legendIndex}.setName, 'location', 'NorthEast');
set(legendHandle, 'fontsize', fontSize, 'FontName', 'Arial', 'Interpreter', 'latex');

set( gcf, 'PaperUnits','centimeters' );
xSize = 20; ySize = 14;
xLeft = 0; yTop = 0;
set( gcf,'PaperPosition', [ xLeft yTop xSize ySize ] );
print ( '-depsc', '-r600','MutualInformationScatterPlot');
print('-dpdf', 'MutualInformationScatterPlot', '-r600');

%% plot reward distribution in human and monkey pairs
monkeySetForReward = [1,7,9,21, 2,3,8,10];
humanSetForReward = [18,19];
allSetsForReward = {monkeySetForReward, humanSetForReward};
labelGroupForReward = {'monkeys', 'humans'};

%{
monkeyNaive = [1,7,9,21];
monkeyTrained = [2,3,8,10];
humanSetForReward = [18,19];
allSetsForReward = {monkeyNaive, monkeyTrained, humanSetForReward};
labelGroupForReward = {'naive monkeys', 'trained monkeys', 'humans'};
%}

% compute reward distribution
nSetGroupForReward = length(allSetsForReward);
groupedReward = {[], []};
groupIndex = {[], []};
groupedFairness = {[], []};
fairnessGroupIndex = {[], []};
for iSetGroup = 1:nSetGroupForReward
    rewardDistr = {[], []};
    for iSet = 1:length(allSetsForReward{iSetGroup}) 
        i = allSetsForReward{iSetGroup}(iSet);
        rewardDistr{1} = [rewardDistr{1}, [playerMeanReward{i, :}]];
        rewardDistr{2} = [rewardDistr{2}, [playerMeanReward{i, sessionMetrics(i).isPairProficient}]];
    end  
    for i = 1:2 % for all and for proficient pairs
        rewardBonusForCooperation = 2;
        fairness = (rewardDistr{i}(1,:) - rewardBonusForCooperation)./(sum(rewardDistr{i}, 1) - 2*rewardBonusForCooperation);
        indexWinners = fairness > 0.5;
        fairness(indexWinners) = 1 - fairness(indexWinners);
      
        groupSize = numel(rewardDistr{i});
        groupedReward{i} = [groupedReward{i}, reshape(rewardDistr{i}, [1, groupSize])];  
        groupedFairness{i} = [groupedFairness{i}, fairness];
        groupIndex{i} = [groupIndex{i}, (iSetGroup - 1)*ones(1,groupSize)];
        fairnessGroupIndex{i} = [fairnessGroupIndex{i}, (iSetGroup - 1)*ones(1,groupSize/2)];
    end   
end

rewardPlotTitle = {'all participants', 'only effective pairs'};
figure('Name', 'reward distribution plot');
set( axes,'fontsize', fontSize,  'FontName', 'Arial');%'FontName', 'Times');
for iPlot = 1:2
  subplot(1,4,iPlot);
  boxplot(groupedReward{iPlot},groupIndex{iPlot}, 'Widths', 0.8);
  title(rewardPlotTitle{iPlot}, 'fontsize', fontSize,  'FontName', 'Arial');
  set( gca, 'fontsize', fontSize,  'FontName', 'Arial', 'XTickLabel', labelGroupForReward);%'FontName', 'Times');
  axis([0.5, nSetGroupForReward + 0.5, 1.0, 4.01]);
  xlabel('species', 'fontsize', fontSize, 'FontName', 'Arial');
  if iPlot == 1
    ylabel('mean per-session reward', 'fontsize', fontSize, 'FontName', 'Arial');
  end
  set( gca, 'fontsize', fontSize, 'FontName', 'Arial');%'FontName', 'Times');
end
for iPlot = 1:2
  subplot(1,4,2 + iPlot);
  boxplot(groupedFairness{iPlot},fairnessGroupIndex{iPlot}, 'Widths', 0.8);
  title(rewardPlotTitle{iPlot}, 'fontsize', fontSize,  'FontName', 'Arial');
  set( gca, 'fontsize', fontSize,  'FontName', 'Arial', 'XTickLabel', labelGroupForReward);%'FontName', 'Times');
  axis([0.5, nSetGroupForReward + 0.5, 0.32, 0.501]);
  xlabel('species', 'fontsize', fontSize, 'FontName', 'Arial');
  if iPlot == 1
    ylabel('reward share', 'fontsize', fontSize, 'FontName', 'Arial');
  end
  set( gca, 'fontsize', fontSize, 'FontName', 'Arial');%'FontName', 'Times');
end

set( gcf, 'PaperUnits','centimeters' );
xSize = 18; ySize = 14;
xLeft = 0; yTop = 0;
set( gcf,'PaperPosition', [ xLeft yTop xSize ySize ] );
print ( '-depsc', '-r600','RewardDistributionPerSpecies');
print('-dpdf', 'RewardDistributionPerSpecies', '-r600');
print('-dpng', 'RewardDistributionPerSpecies', '-r600');



figure('Name', 'reward distribution plot');
set( axes,'fontsize', fontSize,  'FontName', 'Arial');%'FontName', 'Times');
for iPlot = 1:2
  subplot(1,2,iPlot);
  boxplot(groupedReward{iPlot},groupIndex{iPlot}, 'Widths', 0.8);
  title(rewardPlotTitle{iPlot}, 'fontsize', fontSize,  'FontName', 'Arial');
  set( gca, 'fontsize', fontSize,  'FontName', 'Arial', 'XTickLabel', labelGroupForReward);%'FontName', 'Times');
  axis([0.5, nSetGroupForReward + 0.5, 1.0, 4.01]);
  %xlabel('species', 'fontsize', fontSize, 'FontName', 'Arial');
  if iPlot == 1
    ylabel('mean per-session reward', 'fontsize', fontSize, 'FontName', 'Arial');
  end
  set( gca, 'fontsize', fontSize, 'FontName', 'Arial');%'FontName', 'Times');
end

set( gcf, 'PaperUnits','centimeters' );
xSize = 21; ySize = 14;
xLeft = 0; yTop = 0;
set( gcf,'PaperPosition', [ xLeft yTop xSize ySize ] );
print ( '-depsc', '-r600','RewardSplittingPerSpecies');
print('-dpdf', 'RewardLevelPerSpecies', '-r600');
print('-dpng', 'RewardLevelPerSpecies', '-r600');




figure('Name', 'sharing the spoils');
set( axes,'fontsize', fontSize,  'FontName', 'Arial');%'FontName', 'Times');

for iPlot = 1:2
  subplot(1,2,iPlot);
  boxplot(groupedFairness{iPlot},fairnessGroupIndex{iPlot}, 'Widths', 0.8);
  title(rewardPlotTitle{iPlot}, 'fontsize', fontSize,  'FontName', 'Arial');
  set( gca, 'fontsize', fontSize,  'FontName', 'Arial', 'XTickLabel', labelGroupForReward);%'FontName', 'Times');
  axis([0.5, nSetGroupForReward + 0.5, 0.32, 0.501]);
  %xlabel('species', 'fontsize', fontSize, 'FontName', 'Arial');
  if iPlot == 1
    ylabel('reward share', 'fontsize', fontSize, 'FontName', 'Arial');
  end
  set( gca, 'fontsize', fontSize, 'FontName', 'Arial');%'FontName', 'Times');
end

set( gcf, 'PaperUnits','centimeters' );
xSize = 14; ySize = 14;
xLeft = 0; yTop = 0;
set( gcf,'PaperPosition', [ xLeft yTop xSize ySize ] );
print ( '-depsc', '-r600','RewardSplittingPerSpecies');
print('-dpdf', 'RewardSplittingPerSpecies', '-r600');
print('-dpng', 'RewardSplittingPerSpecies', '-r600');


%% plot RT difference distribution in human and monkey pairs

% compute RT difference distribution
groupedLargeRTshare = {[], []};
groupIndexRTshare = {[], []};
groupRTdiff = {[], []};
groupRewardClass = {[], []};

minDRT = [200, 200];
rewardPerCategory = zeros(2*nSetGroupForReward, 2);
rewardConfPerCategory = zeros(2*nSetGroupForReward, 2);

for iSetGroup = 1:nSetGroupForReward
    rewardDistrPerCategory = {[], []; [], []};

    largeRTshareDistr = {[], []};
    for iSet = 1:length(allSetsForReward{iSetGroup}) 
        i = allSetsForReward{iSetGroup}(iSet);
        shareLargeRT = zeros(1, nFile(i));        
        for iFile = 1:nFile(i)
            
            if (i == 18) && (iFile < 6)
                continue
            end    
            
            nTrial = length(allRT{i, iFile});
            fistTestIndex = max(minStationarySegmentStart, nTrial-stationarySegmentLength);
            testIndices = fistTestIndex:nTrial;
            nTestIndices = length(testIndices);
            RT = allRT{i, iFile}(:,testIndices);
            isOwnChoice = allOwnChoice{i, iFile}(:,testIndices);
            isJointChoice = xor(isOwnChoice(1,:),isOwnChoice(2,:));
            
            rtDiff = abs(RT(1,:) - RT(2,:));
            indexLargeDRT = rtDiff > minDRT(iSetGroup);
       
            shareLargeRT(iFile) = nnz(indexLargeDRT)/length(rtDiff);           
            rewardValue = 1 + 2*isJointChoice + mean(isOwnChoice, 1);    
            rewardDistrPerCategory{1, 1} = [rewardDistrPerCategory{1, 1}, rewardValue(indexLargeDRT)];
            rewardDistrPerCategory{2, 1} = [rewardDistrPerCategory{2, 1}, rewardValue(~indexLargeDRT)];
                        
            groupRTdiff{1} = [groupRTdiff{1}, rtDiff];
            perTrialRewardClass = 1 + isJointChoice + 3*(iSetGroup-1);
            groupRewardClass{1} = [groupRewardClass{1}, perTrialRewardClass];
            if (sessionMetrics(iSet).isPairProficient(iFile))
                groupRTdiff{2} = [groupRTdiff{2}, rtDiff];
                groupRewardClass{2} = [groupRewardClass{2}, perTrialRewardClass];        
                rewardDistrPerCategory{1, 2} = [rewardDistrPerCategory{1, 2}, rewardValue(indexLargeDRT)];
                rewardDistrPerCategory{2, 2} = [rewardDistrPerCategory{2, 2}, rewardValue(~indexLargeDRT)];
            end           
        end    
        largeRTshareDistr{1} = [largeRTshareDistr{1}, shareLargeRT];
        largeRTshareDistr{2} = [largeRTshareDistr{2}, shareLargeRT(sessionMetrics(iSet).isPairProficient)]; 
    end  
    for iPlot = 1:2 % for all and for proficient pairs                 
        groupSize = length(largeRTshareDistr{iPlot});
        groupedLargeRTshare{iPlot} = [groupedLargeRTshare{iPlot}, largeRTshareDistr{iPlot}];
        groupIndexRTshare{iPlot} = [groupIndexRTshare{iPlot}, (iSetGroup - 1)*ones(1,groupSize)];        
        
        for iCategory = 1:2
            rewardPerCategory(2*(iSetGroup-1) + iCategory, iPlot) = mean(rewardDistrPerCategory{iCategory, iPlot});
            
            n = length(rewardDistrPerCategory{iCategory, iPlot});
            alpha = 0.05;
            stdValue = std(rewardDistrPerCategory{iCategory, iPlot});
            rewardConfPerCategory(2*(iSetGroup-1) + iCategory, iPlot) = calc_cihw(stdValue, n, alpha);
        end    
    end    
end

rewardPlotTitle = {'all participants', 'only effective pairs'};
rewardRTgroupLabel = {'monkeys separate', 'monkeys joint', 'humans separate', 'humans joint'};

figure('Name', 'reward distribution plot');
set( axes,'fontsize', fontSize,  'FontName', 'Arial');%'FontName', 'Times');
for iPlot = 1:2
  subplot(1,2,iPlot);
  boxplot(groupRTdiff{iPlot},groupRewardClass{iPlot}, 'Widths', 0.7);
  title(rewardPlotTitle{iPlot}, 'fontsize', fontSize,  'FontName', 'Arial');
  set( gca, 'fontsize', fontSize,  'FontName', 'Arial', 'XTickLabel', rewardRTgroupLabel, 'XTickLabelRotation', 45);%'FontName', 'Times');
  %axis([0.5, nSetGroupForReward + 0.5, 1.0, 4.01]);
  %xlabel('grou', 'fontsize', fontSize, 'FontName', 'Arial');
  if iPlot == 1
    ylabel('reaction time differences', 'fontsize', fontSize, 'FontName', 'Arial');
  end
  set( gca, 'fontsize', fontSize, 'FontName', 'Arial');%'FontName', 'Times');
end
%{
for iPlot = 1:2
  subplot(1,4,2 + iPlot);
  boxplot(groupedLargeRTshare{iPlot},groupIndexRTshare{iPlot}, 'Widths', 0.8);
  title(rewardPlotTitle{iPlot}, 'fontsize', fontSize,  'FontName', 'Arial');
  set( gca, 'fontsize', fontSize,  'FontName', 'Arial', 'XTickLabel', labelGroupForReward);%'FontName', 'Times');
  %axis([0.5, 2.5, 1.0, 4.01]);
  xlabel('species', 'fontsize', fontSize, 'FontName', 'Arial');
  if iPlot == 1
    ylabel('share of trials with dRT > 150', 'fontsize', fontSize, 'FontName', 'Arial');
  end
  set( gca, 'fontsize', fontSize, 'FontName', 'Arial');%'FontName', 'Times');
end
%}
set( gcf, 'PaperUnits','centimeters' );
xSize = 16; ySize = 14;
xLeft = 0; yTop = 0;
set( gcf,'PaperPosition', [ xLeft yTop xSize ySize ] );
print ( '-depsc', '-r600','RTandCoordinationPerSpecies');
print('-dpdf', 'RTandCoordinationPerSpecies', '-r600');
print('-dpng', 'RTandCoordinationPerSpecies', '-r600');

rewardRTgroupLabel = {'monkeys, choice delay', 'monkeys, no delay', 'humans, choice delay', 'humans, no delay'};

figure('Name', 'reward distribution plot');
set( axes,'fontsize', fontSize,  'FontName', 'Arial');%'FontName', 'Times');

for iPlot = 1:2
  nPoint = length(rewardConfPerCategory(:,iPlot));
  subplot(1,2,iPlot);
  errorbar(rewardPerCategory(:,iPlot),rewardConfPerCategory(:,iPlot), 's','MarkerSize',5,...
    'MarkerEdgeColor','red','MarkerFaceColor','red');
  title(rewardPlotTitle{iPlot}, 'fontsize', fontSize,  'FontName', 'Arial');
  set( gca, 'fontsize', fontSize,  'FontName', 'Arial', 'XTick', 1:nPoint, 'XTickLabel', rewardRTgroupLabel, 'XTickLabelRotation', 45);%'FontName', 'Times');
  axis([0.5, nPoint + 0.5, 2.95, 3.45]);
  %xlabel('grou', 'fontsize', fontSize, 'FontName', 'Arial');
  if iPlot == 1
    ylabel('average reward', 'fontsize', fontSize, 'FontName', 'Arial');
  end
  set( gca, 'fontsize', fontSize, 'FontName', 'Arial');%'FontName', 'Times');
end
%{
for iPlot = 1:2
  subplot(1,4,2 + iPlot);
  boxplot(groupedLargeRTshare{iPlot},groupIndexRTshare{iPlot}, 'Widths', 0.8);
  title(rewardPlotTitle{iPlot}, 'fontsize', fontSize,  'FontName', 'Arial');
  set( gca, 'fontsize', fontSize,  'FontName', 'Arial', 'XTickLabel', labelGroupForReward);%'FontName', 'Times');
  %axis([0.5, 2.5, 1.0, 4.01]);
  xlabel('species', 'fontsize', fontSize, 'FontName', 'Arial');
  if iPlot == 1
    ylabel('share of trials with dRT > 150', 'fontsize', fontSize, 'FontName', 'Arial');
  end
  set( gca, 'fontsize', fontSize, 'FontName', 'Arial');%'FontName', 'Times');
end
%}
set( gcf, 'PaperUnits','centimeters' );
xSize = 16; ySize = 14;
xLeft = 0; yTop = 0;
set( gcf,'PaperPosition', [ xLeft yTop xSize ySize ] );
print ( '-depsc', '-r600','RTandRewardPerSpecies');
print('-dpdf', 'RTandRewardPerSpecies', '-r600');
print('-dpng', 'RTandRewardPerSpecies', '-r600');


%% plot employed strategies
nStrategy = length(strategyNames);
strategyLabels = strategyNames;
strategyLabels{nStrategy+1} = 'Not identified';

%strategyArray = cell(1, nStrategy);
%basicStrategyIndex = [1,2,3,4];

% compute reward distribution
nSetGroupForReward = length(allSetsForReward);
strategyDistribution = cell(2,1);
for i = 1:2
    strategyDistribution{i} = zeros(nSetGroupForReward, nStrategy + 1);
end
histEdge = [0, 1:nStrategy + 1] + 0.5;

for iSetGroup = 1:nSetGroupForReward
    observedStrategies = {[], []};
    for iSet = 1:length(allSetsForReward{iSetGroup}) 
        i = allSetsForReward{iSetGroup}(iSet);
        observedStrategies{1} = [observedStrategies{1}, identifiedStrategyIndex{i}];
        observedStrategies{2} = [observedStrategies{2}, identifiedStrategyIndex{i}(:,sessionMetrics(i).isPairProficient)];
    end  
    for i = 1:2 % for all and for proficient pairs      
        observedStrategies{i}(observedStrategies{i} == 0) = nStrategy + 1;
        strategyHist = histcounts(observedStrategies{i}, histEdge);
        strategyDistribution{i}(iSetGroup, :) = strategyHist/sum(strategyHist);
    end 
end

basicStrategyBorder = max(basicStrategyIndex) + 0.5;
rewardPlotTitle = {'all participants', 'only effective pairs'};
figure('Name', 'reward distribution plot');
set( axes,'fontsize', fontSize,  'FontName', 'Arial');%'FontName', 'Times');
for iPlot = 1:2
  maxStrategyProb = max(max(strategyDistribution{iPlot}));
  subplot(2,1,iPlot);
  hold on
  bar(strategyDistribution{iPlot}');
  plot([basicStrategyBorder,basicStrategyBorder], [0, maxStrategyProb + 0.05], 'k--')
  hold off
  title(rewardPlotTitle{iPlot}, 'fontsize', fontSize,  'FontName', 'Arial');
  set( gca, 'fontsize', fontSize,  'FontName', 'Arial', 'XTickLabel', strategyLabels, 'XTickLabelRotation',45);%'FontName', 'Times');
  axis([0.5, nStrategy + 1.5, 0, maxStrategyProb + 0.02]);
  if iPlot == 1
    legendHandle = legend(labelGroupForReward, 'location', 'NorthEast');
    set(legendHandle, 'fontsize', fontSize,  'FontName', 'Arial');%'FontName', 'Times', 'Interpreter', 'latex');
  end      
 % if iPlot == 2
 %     xlabel('strategy', 'fontsize', fontSize, 'FontName', 'Arial');
 % end
  ylabel('relative frequency', 'fontsize', fontSize, 'FontName', 'Arial');
  set( gca, 'fontsize', fontSize, 'FontName', 'Arial');%'FontName', 'Times');
end

set( gcf, 'PaperUnits','centimeters' );
xSize = 18; ySize = 14;
xLeft = 0; yTop = 0;
set( gcf,'PaperPosition', [ xLeft yTop xSize ySize ] );
print ( '-depsc', '-r600','EmployedStrategies');
print('-dpdf', 'EmployedStrategies', '-r600');
print('-dpng', 'EmployedStrategies', '-r600');


%{
%% blocked trials figure
monkeyBlockSetIndex = [find(strcmp(setName, 'SMCuriusBlock')), find(strcmp(setName, 'SMFlaffusBlock'))];
humanBlockSetIndex = find(strcmp(setName, 'SMhumanBlocked'));
iSet = monkeyBlockSetIndex(2);
iFile = 6;

isOwnChoice = allOwnChoice{iSet,iFile};
sideChoice = allSideChoice{iSet,iFile};
maxXvalue = length(isOwnChoice(1,:));

fontSize = 8;
figure('Name', [setName{iSet} ' block-wise plot']);
set( axes,'fontsize', fontSize,  'FontName', 'Arial');%'FontName', 'Times');

subplot(2,4,1:2);
hold on
fill([blockBorder{iSet}(iFile,:), blockBorder{iSet}(iFile,2:-1:1)], ...
    [-0.01, -0.01, 1.55, 1.55], [0.8,0.8,0.8]);
h1 = plot(movmean(isOwnChoice(1,:), 8), 'r-', 'linewidth', lineWidth+1);
h2 = plot(movmean(isOwnChoice(2,:), 8), 'b-', 'linewidth', lineWidth);
hold off
set( gca, 'fontsize', fontSize,  'FontName', 'Arial', 'yTick', [0,0.5,1], 'XTick', []);%'FontName', 'Times');
axis([0.8, maxXvalue + 0.01, -0.01, 1.9]);
ylabel( {'Share of own', ' choice in 8 rounds'}, 'fontsize', fontSize, 'FontName', 'Arial');
title('(a)', 'fontsize', fontSize,  'FontName', 'Arial');%'FontName', 'Times', 'Interpreter', 'latex');
legendHandle = legend([h1, h2], 'Human confederate', 'Monkey', 'location', 'NorthWest');
set(legendHandle, 'fontsize', fontSize,  'FontName', 'Arial');%'FontName', 'Times', 'Interpreter', 'latex');


totalReward = 1 + 2.5*(isOwnChoice(1,:)+isOwnChoice(2,:));
totalReward(totalReward == 6) = 2;
subplot(2,4,5:6);
hold on
fill([blockBorder{iSet}(iFile,:), blockBorder{iSet}(iFile,2:-1:1)], ...
    [0.9, 0.9, 3.6, 3.6], [0.8,0.8,0.8]);
h1 = plot(totalReward, 'm-', 'linewidth', lineWidth);
hold off
set( gca, 'fontsize', fontSize,  'FontName', 'Arial');%'FontName', 'Times');
axis([0.8, maxXvalue + 0.2, 0.9, 3.6]);
ylabel( ' Average reward ', 'fontsize', fontSize, 'FontName', 'Arial');
title('(b)', 'fontsize', fontSize,  'FontName', 'Arial');%'FontName', 'Times', 'Interpreter', 'latex');


subplot(2,4,3)
boxplot(vertcat(miValueBlock{monkeyBlockSetIndex}));
ylabel('Mutual information', 'fontsize', fontSize,  'FontName', 'Arial');
set( gca, 'fontsize', fontSize,  'FontName', 'Arial', 'XTick', []);%'FontName', 'Times');
axis([0.5,3.5, -0.03, 0.77]);
title('(c)', 'fontsize', fontSize,  'FontName', 'Arial');%'FontName', 'Times', 'Interpreter', 'latex');

subplot(2,4,4)
boxplot(vertcat(miValueBlock{humanBlockSetIndex}));
set( gca, 'fontsize', fontSize,  'FontName', 'Arial', 'XTick', []);%'FontName', 'Times');
axis([0.5,3.5, -0.03, 0.77]);
title('(d)', 'fontsize', fontSize,  'FontName', 'Arial');%'FontName', 'Times', 'Interpreter', 'latex');

subplot(2,4,7)
boxplot(vertcat(teBlock1{monkeyBlockSetIndex}));
ylabel('Transfer entropy', 'fontsize', fontSize,  'FontName', 'Arial');
set( gca, 'fontsize', fontSize,  'FontName', 'Arial', 'XTickLabel', {'before', 'block', 'after'});%'FontName', 'Times');
axis([0.5,3.5, -0.01, 0.34]);
title('(e)', 'fontsize', fontSize,  'FontName', 'Arial');%'FontName', 'Times', 'Interpreter', 'latex');

subplot(2,4,8)
boxplot(vertcat(teBlock1{humanBlockSetIndex}));
set( gca, 'fontsize', fontSize,  'FontName', 'Arial', 'XTickLabel', {'before', 'block', 'after'});%'FontName', 'Times');
axis([0.5,3.5, -0.01, 0.34]);
title('(f)', 'fontsize', fontSize,  'FontName', 'Arial');%'FontName', 'Times', 'Interpreter', 'latex');

set( gcf, 'PaperUnits','centimeters' );
%    set(gcf,'PaperSize',fliplr(get(gcf,'PaperSize')))
xSize = 18; ySize = 8; xLeft = 0; yTop = 0;
set( gcf,'PaperPosition', [ xLeft yTop xSize ySize ] );
print ( '-depsc', '-r600', 'Fig4_blocks');
print('-r600', 'Fig4_blocks','-dtiff');
%}
%{
%% draw pictures for single recordings
%fileOfInterest = [5,6,8,12];
%fileOfInterest = {[2,3,5,6,8,11], 6:8, 1:4};
if (SCAN_ALL_DATASET)
    %fileOfInterest = {1:12, 1:18, 1:4, [], 1:9, 1:16, 1:3, 1:15, 1:5, 1:5};
    fileOfInterest = {[], [], [], [], [], [], [], [], [], [], 1, []};
else
    fileOfInterest = {1:9, 1:5};
end
for iSet = 1:nSet
    nFileOfInterest = length(fileOfInterest{iSet});
    titleList = unique(dataset{iSet}.captions, 'stable');
    for iFile = 1:nFileOfInterest
        trueFileIndex = fileOfInterest{iSet}(iFile);
        isOwnChoice = allOwnChoice{iSet,trueFileIndex};
        sideChoice = allSideChoice{iSet,trueFileIndex};
        maxXvalue = length(isOwnChoice(1,:));
        figure
        set( axes,'fontsize', fontSize,  'FontName', 'Arial');%'FontName', 'Times');
        totalReward = 1 + 2.5*(isOwnChoice(1,:)+isOwnChoice(2,:));
        totalReward(totalReward == 6) = 2;
        subplot(5, 1, 1);
        plot(totalReward, 'k-', 'linewidth', lineWidth);
        set( gca, 'fontsize', fontSize,  'FontName', 'Arial');%'FontName', 'Times');
        axis([0.8, maxXvalue + 0.2, 0.5, 4.9]);
        legendHandle = legend('Joint reward', 'location', 'NorthWest');
        set(legendHandle, 'fontsize', fontSize-6,  'FontName', 'Arial');%'FontName', 'Times', 'Interpreter', 'latex');
        title(titleList{trueFileIndex}, 'fontsize', fontSize,  'FontName', 'Arial');%'FontName', 'Times', 'Interpreter', 'latex');
        
        subplot(5, 1, 2);
        hold on
        if (blockBorder{iSet}(iFile,:) > 0)
            fill([blockBorder{iSet}(iFile,:), blockBorder{iSet}(iFile,2:-1:1)], ...
                [-0.01, -0.01, 1.8, 1.8], [0.8,0.8,0.8]);
        end
        %h1 = plot(movmean(isOwnChoice(1,:), 8), 'r-', 'linewidth', lineWidth+1);
        %h2 = plot(movmean(isOwnChoice(2,:), 8), 'b-', 'linewidth', lineWidth);
        h1 = plot(isOwnChoice(1,:), 'r-', 'linewidth', lineWidth+1);
        h2 = plot(isOwnChoice(2,:), 'b-', 'linewidth', lineWidth);
        hold off
        set( gca, 'fontsize', fontSize,  'FontName', 'Arial', 'yTick', [0,0.5,1]);%'FontName', 'Times');
        axis([0.8, maxXvalue + 0.01, -0.01, 1.8]);
        legendHandle = legend([h1, h2], 'Share own choices P1', 'Share own choices P2', 'location', 'NorthWest');
        set(legendHandle, 'fontsize', fontSize-6,  'FontName', 'Arial');%'FontName', 'Times', 'Interpreter', 'latex');
        
        subplot(5, 1, 3);
        hold on
        if (~isempty(blockBorder{iSet}))
            fill([blockBorder{iSet}(iFile,:), blockBorder{iSet}(iFile,2:-1:1)], ...
                [1.01*minValue, 1.01*minValue, 1.1*maxValue, 1.1*maxValue], [0.8,0.8,0.8]);
        end
        h1 = plot(localTargetTE1{iSet, trueFileIndex}, 'Color', [0.9, 0.5, 0.5], 'linewidth', lineWidth);
        h2 = plot(localTargetTE2{iSet, trueFileIndex}, 'Color', [0.5, 0.5, 0.9], 'linewidth', lineWidth);
        h3 = plot(targetTE1{iSet, trueFileIndex}, 'r-', 'linewidth', lineWidth+1);
        h4 = plot(targetTE2{iSet, trueFileIndex}, 'b-', 'linewidth', lineWidth+1);
        hold off
        set( gca, 'fontsize', fontSize,  'FontName', 'Arial');%'FontName', 'Times');
        axis([0.8, maxXvalue + 0.2, 1.01*minValue, 1.1*maxValue]);
        legendHandle = legend([h1, h2, h3, h4], '$\mathrm{te_{P1\rightarrow P2}}$', '$\mathrm{te_{P2\rightarrow P1}}$', '$\mathrm{TE_{P1\rightarrow P2}}$', '$\mathrm{TE_{P2\rightarrow P1}}$', 'location', 'NorthWest');
        set(legendHandle, 'fontsize', fontSize-6, 'FontName', 'Times', 'Interpreter', 'latex');
        
        subplot(5, 1, 4);
        hold on
        if (~isempty(blockBorder{iSet}))
            fill([blockBorder{iSet}(iFile,:), blockBorder{iSet}(iFile,2:-1:1)], ...
                [-0.01, -0.01, 1.8, 1.8], [0.8,0.8,0.8]);
        end
        %h1 = plot(movmean(sideChoice(1,:), 8), 'r-', 'linewidth', lineWidth+1);
        %h2 = plot(movmean(sideChoice(2,:), 8), 'b-', 'linewidth', lineWidth);
        h1 = plot(sideChoice(1,:), 'r-', 'linewidth', lineWidth+1);
        h2 = plot(sideChoice(2,:), 'b--', 'linewidth', lineWidth);
        hold off
        set( gca, 'fontsize', fontSize,  'FontName', 'Arial', 'yTick', [0,0.5,1]);%'FontName', 'Times');
        axis([0.8, maxXvalue + 0.2, -0.01, 1.8]);
        legendHandle = legend([h1, h2], 'Share left choices P1', 'Share left choices P2', 'location', 'NorthWest');
        set(legendHandle, 'fontsize', fontSize-6,  'FontName', 'Arial');%'FontName', 'Times', 'Interpreter', 'latex');
        
        subplot(5, 1, 5);
        hold on
        if (~isempty(blockBorder{iSet}))
            fill([blockBorder{iSet}(iFile,:), blockBorder{iSet}(iFile,2:-1:1)], ...
                [0, 0, 1.01*maxMIvalue, 1.01*maxMIvalue], [0.8,0.8,0.8]);
        end
        h1 = plot(locMutualInf{iSet, trueFileIndex}, 'Color', [0.7, 0.3, 0.7], 'linewidth', lineWidth);
        h2 = plot(mutualInf{iSet, trueFileIndex}, 'Color', [0.4, 0.1, 0.4], 'linewidth', lineWidth+1);
        hold off
        set( gca, 'fontsize', fontSize,  'FontName', 'Arial');%'FontName', 'Times');
        %axis([0.8, maxXvalue + 0.2, 1.01*minMIvalue, 1.01*maxMIvalue]);
        axis([0.8, maxXvalue + 0.2, 0, 1.01*maxMIvalue]);
        legendHandle = legend([h1, h2], '$\mathrm{i(P1,P2)}$', '$\mathrm{MI(P1,P2)}$', 'location', 'NorthWest');
        set(legendHandle, 'fontsize', fontSize-6, 'FontName', 'Times', 'Interpreter', 'latex');
        
        
        set( gcf, 'PaperUnits','centimeters' );
        set(gcf,'PaperSize',fliplr(get(gcf,'PaperSize')))
        xSize = 21; ySize = 29;
        xLeft = 0; yTop = 0;
        set( gcf,'PaperPosition', [ xLeft yTop xSize ySize ] );
        print ( '-depsc', '-r600', ['set', num2str(iSet), '_session', num2str(trueFileIndex)]);
        print('-r600', ['set', num2str(iSet), '_session', num2str(trueFileIndex)],'-dpng');
        %print('-dpdf', ['set', num2str(iSet), '_session', num2str(trueFileIndex)], '-r600');
        
        %mean(sideChoice, 2)
        %memoryLength = 2;
        %plot_precursor_freq(isOwnChoice, isBottomChoice, memoryLength, {'other','own'});
        %plot_precursor_freq(isBottomChoice, isOwnChoice, memoryLength, {'left','right'});
    end
end
%}