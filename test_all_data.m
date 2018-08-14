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
    '20171129T100056', ...
    '20171130T093044', ...
    '20171201T101044', ...
    '20171205T103518', ...
    '20171206T111532', ...
    '20171208T092614', ...
    '20171212T132217', ...
    '20171213T142240', ...
    '20171214T072407', ...
    '20171219T135223', ...
    '20180105T142814', ...
    '20180105T150525', ...
    '20180108T155548', ...
    '20180109T171512', ...
    '20180109T172928', ...
    '20180110T151942', ...
    '20180110T165831', ...
    '20180111T150745', ...
    '20180115T141937', ...
    '20180116T144201', ...
    '20180117T151458', ...
    '20180118T140639', ...
    '20180118T154054', ...
    '20180119T143953', ...
    '20180122T164338', ...
    '20180123T151927', ...
    '20180124T161657', ...
    '20180125T155742', ...
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
    '20180516T090940', ...
    '20180517T085104', ...
    '20180518T104104', ...
    '20180522T101558', ...
    '20180523T092531', ...
    '20180524T103704', ...
    };


teslaNaiveFlaffusConfederate.setName = 'teslaNaiveFlaffusConfederate';
teslaNaiveFlaffusConfederate.filenames = {...
    'DATA_20180504T114516.A_Tesla.B_Flaffus.SCP_01.triallog.A.Tesla.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180507T151756.A_Tesla.B_Flaffus.SCP_01.triallog.A.Tesla.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180508T132214.A_Tesla.B_Flaffus.SCP_01.triallog.A.Tesla.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180509T122330.A_Tesla.B_Flaffus.SCP_01.triallog.A.Tesla.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
    };
teslaNaiveFlaffusConfederate.captions = {...
    '20180504T114516', ...
    '20180507T151756', ...
    '20180508T132214', ...
    '20180509T122330', ...
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
    '20180525T091512', ...
    '20180528T132259', ...
    '20180529T130237', ...
    '20180530T153325', ...
    '20180531T104356', ...
    };


elmoNaiveCuriusConfederate.setName = 'ElmoNaiveCuriusConfederate';
elmoNaiveCuriusConfederate.filenames = {...
    'DATA_20180605T091549.A_Curius.B_Elmo.SCP_01.triallog.A.Curius.B.Elmo_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180606T111853.A_Curius.B_Elmo.SCP_01.triallog.A.Curius.B.Elmo_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180607T102506.A_Curius.B_Elmo.SCP_01.triallog.A.Curius.B.Elmo_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180611T112158.A_Curius.B_Elmo.SCP_01.triallog.A.Curius.B.Elmo_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180612T131016.A_Curius.B_Elmo.SCP_01.triallog.A.Curius.B.Elmo_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180613T095441.A_Curius.B_Elmo.SCP_01.triallog.A.Curius.B.Elmo_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180614T092826.A_Curius.B_Elmo.SCP_01.triallog.A.Curius.B.Elmo_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180615T111344.A_Curius.B_Elmo.SCP_01.triallog.A.Curius.B.Elmo_IC_JointTrials.isOwnChoice_sideChoice', ...
    };
elmoNaiveCuriusConfederate.captions = {...
    '20180605T091549', ...
    '20180606T111853', ...
    '20180607T102506', ...
    '20180611T112158', ...
    '20180612T131016', ...
    '20180613T095441', ...
    '20180614T092826', ...
    '20180615T111344', ...
    };


JKElmo.setName = 'JKElmo';
JKElmo.filenames = {...
    'DATA_20180620T095959.A_JK.B_Elmo.SCP_01.triallog.A.JK.B.Elmo_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180621T080841.A_JK.B_Elmo.SCP_01.triallog.A.JK.B.Elmo_IC_JointTrials.isOwnChoice_sideChoice', ...
    'DATA_20180622T071433.A_JK.B_Elmo.SCP_01.triallog.A.JK.B.Elmo_IC_JointTrials.isOwnChoice_sideChoice', ...
    };
JKElmo.captions = {...
    '20180620T095959', ...
    '20180621T080841', ...
    '20180622T071433', ...
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
    '20180601T122747', ...
    '20180604T150239', ...
    '20180605T150607', ...
    '20180606T142829', ...
    '20180607T142823', ...
    '20180607T145715', ...
    '20180608T100903', ...
    '20180611T150057', ...
    '20180612T162540', ...
    '20180613T141225', ...
    '20180614T165947', ...
    '20180615T150245', ...
    '20180615T154238', ...
    '20180618T140913', ...
    };


SMElmo.setName = 'SMElmo';
SMElmo.filenames = {...
    'DATA_20180619T150344.A_SM.B_Elmo.SCP_01.triallog.A.SM.B.Elmo_IC_JointTrials.isOwnChoice_sideChoice', ...
    };
SMElmo.captions = {...
    '20180619T150344', ...
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
%    'DATA_20170425T160951.A_21001.B_22002.SCP_00.triallog.A.21001.B.22002_IC_JointTrials.isOwnChoice_sideChoice', ...
%    'DATA_20170426T102304.A_21003.B_22004.SCP_00.triallog.A.21003.B.22004_IC_JointTrials.isOwnChoice_sideChoice', ...
%    'DATA_20170426T133343.A_21005.B_12006.SCP_00.triallog.A.21005.B.12006_IC_JointTrials.isOwnChoice_sideChoice', ...
%    'DATA_20170427T092352.A_21007.B_12008.SCP_00.triallog.A.21007.B.12008_IC_JointTrials.isOwnChoice_sideChoice', ...
%    'DATA_20170427T132036.A_21009.B_12010.SCP_00.triallog.A.21009.B.12010_IC_JointTrials.isOwnChoice_sideChoice', ...
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
 %   '01vs02', ...
 %   '03vs04', ...
 %   '05vs06', ...
 %   '07vs08', ...
 %   '09vs10', ...
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
    dataset = {teslaElmoNaive, teslaNaiveFlaffusConfederate, teslaNaiveCuriusConfederate, elmoNaiveCuriusConfederate, SMTesla, SMElmo, JKElmo, magnusCuriusNaive, magnusNaiveCuriusConfederate, flaffusCuriusNaive, flaffusCuriusConfederate, flaffusEC, SMCurius, SMCuriusBlock, TNCurius, SMFlaffus, SMFlaffusBlock, FlaffusSM, humanPair, humanPairBlocked, SMhumanBlocked, magnusFlaffusNaive};
    %dataset = {teslaNaiveFlaffusConfederate, teslaNaiveCuriusConfederate};
    %dataset = {magnusFlaffusNaive};
else
    dataset = {SMhumanBlocked};
end


%% plotting parameters
% COPY FROM HERE
fontSize = 8;
fontType = 'Arial';
markerSize = 4;
lineWidth = 1.0;


OutPutType = 'pdf';
figure_visibility_string = 'on';
output_rect_fraction = 3; % default 0.5
DefaultAxesType = 'PrimateNeurobiology2018DPZ'; % DPZ2017Evaluation, PrimateNeurobiology2018DPZ
DefaultPaperSizeType = 'PrimateNeurobiology2018DPZ0.5'; % DPZ2017Evaluation, PrimateNeurobiology2018DPZ
fnFormatDefaultAxes(DefaultAxesType);


plotName = {'TEtarget', 'MutualInf', 'surprise_pos'};

commonColorList = [...
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

basicStrategyIndex = 1:4;
complexStrategyIndex = 5:8;
temporalStrategyIndex = [9,10];
sideStrategyIndex = 3:4;
targetStrategyIndex = 1:2;
turnTakingStrategyIndex = 5:7;
competitiveStrategyIndex = 8;

goodProbabilityThreshold = 0.95;
minProbabilityThreshold = 0.33;
minDRT = 150;

[strategyArray, strategyNames] = generate_principal_strategies();
nStrategy = length(strategyNames);

strategyParam = cell(nSet, max(nFile));
strategyProbabilityPerTrial = cell(nSet, max(nFile));
strategyMeanProbability = cell(nSet, max(nFile));
strategyLogMeanProbability = cell(nSet, max(nFile));

identifiedStrategyIndex = cell(nSet, 1);
identifiedStrategyProb = cell(nSet, 1);
identifiedStrategyParam = cell(nSet, 1);

basicStrategyLikelihood = cell(nSet, 1);
complexStrategyLikelihood = cell(nSet, 1);
temporalStrategyLikelihood = cell(nSet, 1);
sideStrategyLikelihood = cell(nSet, 1);
targetStrategyLikelihood = cell(nSet, 1);
turnTakingStrategyLikelihood = cell(nSet, 1);
competitiveStrategyLikelihood = cell(nSet, 1);

for iSet = 1:nSet
    disp(['Test strategies for minDRT: ' num2str(iSet)]);
    
    identifiedStrategyIndex{iSet} = zeros(2, nFile(iSet));
    identifiedStrategyProb{iSet} = zeros(2, nFile(iSet));
    identifiedStrategyParam{iSet} = zeros(2, nFile(iSet));
    
    basicStrategyLikelihood{iSet} = zeros(2, nFile(iSet));
    complexStrategyLikelihood{iSet} = zeros(2, nFile(iSet));
    temporalStrategyLikelihood{iSet} = zeros(2, nFile(iSet));
    sideStrategyLikelihood{iSet} = zeros(2, nFile(iSet));
    targetStrategyLikelihood{iSet} = zeros(2, nFile(iSet));
    turnTakingStrategyLikelihood{iSet} = zeros(2, nFile(iSet));
    competitiveStrategyLikelihood{iSet} = zeros(2, nFile(iSet));
    
    for iFile = 1:nFile(iSet)
        % here we consider only equilibrium (stabilized) values
        nTrial = length(allOwnChoice{iSet, iFile});
        fistTestIndex = max(cfg.minStationarySegmentStart, nTrial-cfg.stationarySegmentLength);
        testIndices = fistTestIndex:nTrial;
        nTestIndices = length(testIndices);
        
        isOwnChoice = allOwnChoice{iSet, iFile}(:,testIndices);
        sideChoice = allSideChoice{iSet, iFile}(:,testIndices);
        RT = allRT{iSet, iFile}(:,testIndices);
        
        strategyForTest = cell(2, nStrategy);
        strategyForTest(1,:) = strategyArray;
        strategyForTest(2,:) = strategyArray;
        %{
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
        %}  
               
        [strategyMeanProbability{iSet, iFile}, strategyLogMeanProbability{iSet, iFile}, ...
         strategyProbabilityPerTrial{iSet, iFile}] = check_strategy_probability(isOwnChoice, sideChoice, strategyForTest, RT, minDRT);        
     
        % likelihood of simple/complex/temporal strategy
        for iPlayer = 1:2                         
            basicStrategyLikelihood{iSet}(iPlayer, iFile) = max(strategyLogMeanProbability{iSet, iFile}(iPlayer, basicStrategyIndex));
            complexStrategyLikelihood{iSet}(iPlayer, iFile) = max(strategyLogMeanProbability{iSet, iFile}(iPlayer, complexStrategyIndex));
            temporalStrategyLikelihood{iSet}(iPlayer, iFile) = max(strategyLogMeanProbability{iSet, iFile}(iPlayer, temporalStrategyIndex));
            sideStrategyLikelihood{iSet}(iPlayer, iFile) = max(strategyLogMeanProbability{iSet, iFile}(iPlayer, sideStrategyIndex));
            targetStrategyLikelihood{iSet}(iPlayer, iFile) = max(strategyLogMeanProbability{iSet, iFile}(iPlayer, targetStrategyIndex));
            turnTakingStrategyLikelihood{iSet}(iPlayer, iFile) = max(strategyLogMeanProbability{iSet, iFile}(iPlayer, turnTakingStrategyIndex));
            competitiveStrategyLikelihood{iSet}(iPlayer, iFile) = max(strategyLogMeanProbability{iSet, iFile}(iPlayer, competitiveStrategyIndex));
        end    
     
     
        % identify winning strategy
        for iPlayer = 1:2             
            % first test basic strategies
            [bestBasicStrategyProb, bestBasicStrategyIndex] = max(strategyLogMeanProbability{iSet, iFile}(iPlayer, basicStrategyIndex));
            if (bestBasicStrategyProb >= goodProbabilityThreshold)
                identifiedStrategyProb{iSet}(iPlayer, iFile) = bestBasicStrategyProb;
                identifiedStrategyIndex{iSet}(iPlayer, iFile) = basicStrategyIndex(bestBasicStrategyIndex);         
            else
                [identifiedStrategyProb{iSet}(iPlayer, iFile), maxStrategyIndex] = max(strategyLogMeanProbability{iSet, iFile}(iPlayer, :));
                identifiedStrategyIndex{iSet}(iPlayer, iFile) = maxStrategyIndex;
                %identifiedStrategyParam{iSet}(iPlayer, iFile) = strategyParam{iSet, iFile}(iPlayer, maxStrategyIndex);  
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
            set( axes,'fontsize', fontSize,  'FontName', fontType);%'FontName', 'Times');

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
                set( gca, 'fontsize', fontSize,  'FontName', fontType);%'FontName', 'Times');
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

                title(dataset{iSet}.captions{iFile}, 'fontsize', fontSize,  'FontName', fontType);%'FontName', 'Times', 'Interpreter', 'latex');
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
        set( axes,'fontsize', fontSize,  'FontName', fontType);%'FontName', 'Times');
        subplot(1,4,1)
        boxplot(miValueBlock{iSet});
        title('Mutual information (target)', 'fontsize', fontSize,  'FontName', fontType);
        set( gca, 'fontsize', fontSize,  'FontName', fontType, 'XTickLabel', {'before', 'block', 'after'});%'FontName', 'Times');
        
        subplot(1,4,2)
        boxplot(miSideValueBlock{iSet});
        title('Mutual information (side)', 'fontsize', fontSize,  'FontName', fontType);
        set( gca, 'fontsize', fontSize,  'FontName', fontType, 'XTickLabel', {'before', 'block', 'after'});%'FontName', 'Times');
        
        subplot(1,4,3)
        boxplot(teBlock1{iSet});
        title('Transfer entropy', 'fontsize', fontSize,  'FontName', fontType);
        set( gca, 'fontsize', fontSize,  'FontName', fontType, 'XTickLabel', {'before', 'block', 'after'});%'FontName', 'Times');
        
        subplot(1,4,4)
        boxplot(deltaRewardBlock{iSet});
        title('Non-random reward', 'fontsize', fontSize,  'FontName', fontType);
        set( gca, 'fontsize', fontSize,  'FontName', fontType, 'XTickLabel', {'before', 'block', 'after'});%'FontName', 'Times');
        
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
selectedColorList = [commonColorList(1,:); commonColorList(4,:); commonColorList(5,:); commonColorList(6,:); commonColorList(8,:); commonColorList(9,:); commonColorList(10,:); commonColorList(12,:); commonColorList(14,:); commonColorList(15,:)];
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
set( axes,'fontsize', fontSize,  'FontName', fontType);%'FontName', 'Times');
hold on
for iSetGroup = 1:nSetGroup
  for iSet = 1:length(allSets{iSetGroup}) 
    i = allSets{iSetGroup}(iSet);
    if ((setMarker{iSetGroup} == 's') || (setMarker{iSetGroup} == 'o') || (setMarker{iSetGroup} == 'd'))
        scatter(sessionMetrics(i).miSide, sessionMetrics(i).miTarget, sz, selectedColorList(iSet, :), setMarker{iSetGroup}, 'filled');
    else    
        scatter(sessionMetrics(i).miSide, sessionMetrics(i).miTarget, sz, selectedColorList(iSet, :), setMarker{iSetGroup});
    end    
  end  
end
hold off
axis([-0.1, 1.6, -0.1, 1.0]);
xlabel('side Mutual Information', 'fontsize', fontSize, 'FontName', fontType);
ylabel('target Mutual Information', 'fontsize', fontSize, 'FontName', fontType);
set( gca, 'fontsize', fontSize, 'FontName', fontType);%'FontName', 'Times');

legendHandle = legend(cellfun(@(x) x.setName, dataset(legendIndex), 'UniformOutput', false), 'location', 'NorthEast');
set(legendHandle, 'fontsize', fontSize, 'FontName', fontType, 'Interpreter', 'latex');

set( gcf, 'PaperUnits','centimeters' );
xSize = 20; ySize = 14;
xLeft = 0; yTop = 0;
set( gcf,'PaperPosition', [ xLeft yTop xSize ySize ] );
print ( '-depsc', '-r600','MutualInformationScatterPlot');
print('-dpdf', 'MutualInformationScatterPlot', '-r600');


%% plot MI scatter plot with angular transformation
monkeyNaiveSet = [1,7,9,21];
monkeyTrainedSet = [2,3,8,10];
monkeyConfederateSet = [4,5,6,11,12,14,15,17];
humanSet = [18,19,20];
%blockedSet = [13,16,19,20];
%blockedSet = [19];
allSets = {monkeyNaiveSet, monkeyTrainedSet, monkeyConfederateSet,humanSet};
%allSets = {naiveSet, trainedSet, humanConfederateSet};
setMarker = {'o', 's', 'd', '+', 'x'};
selectedColorList = [commonColorList(1,:); commonColorList(9,:); commonColorList(12,:); commonColorList(15,:); commonColorList(4,:); commonColorList(5,:); commonColorList(6,:); commonColorList(8,:); commonColorList(10,:); commonColorList(14,:)];
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
sz = 18;
nSetGroup = length(allSets);
figure('Name', 'Reward scatter plot');
set( axes,'fontsize', fontSize,  'FontName', fontType);%'FontName', 'Times');
hold on
for iSetGroup = 1:nSetGroup
  for iSet = 1:length(allSets{iSetGroup}) 
    i = allSets{iSetGroup}(iSet);
    xData = sessionMetrics(i).miSide;
    yData = sessionMetrics(i).miTarget;
    
    rData = sqrt(xData.^2 + yData.^2);
    phiData = atan(xData./yData);
    phiData(yData == 0) = pi()/2;

    if ((setMarker{iSetGroup} == 's') || (setMarker{iSetGroup} == 'o') || (setMarker{iSetGroup} == 'd'))
        scatter(phiData, rData, sz, selectedColorList(iSet, :), setMarker{iSetGroup}, 'filled');
    else    
        scatter(phiData, rData, sz, selectedColorList(iSet, :), setMarker{iSetGroup});
    end    
  end  
end
hold off
axis([-0.05, pi()/2+1, -0.05, 1.2]);
ylabel('$\sqrt{\mathrm{MI}_\mathrm{side}^2 + \mathrm{MI}_\mathrm{target}^2}$', 'fontsize', fontSize, 'FontName', fontType, 'Interpreter', 'latex');
xlabel('$\mathrm{atan}\big(\mathrm{MI}_\mathrm{side}/\mathrm{MI}_\mathrm{target}\big), { }^\circ$', 'fontsize', fontSize, 'FontName', fontType, 'Interpreter', 'latex');
set( gca, 'xTick', [0, pi()/4, pi()/2], 'xTickLabel', {'0', '45', '90'}, 'fontsize', fontSize, 'FontName', fontType);

legendHandle = legend(cellfun(@(x) x.setName, dataset(legendIndex), 'UniformOutput', false), 'location', 'NorthEast');
set(legendHandle, 'fontsize', fontSize, 'FontName', fontType, 'Interpreter', 'latex');

set( gcf, 'PaperUnits','centimeters' );
xSize = 20; ySize = 14;
xLeft = 0; yTop = 0;
set( gcf,'PaperPosition', [ xLeft yTop xSize ySize ] );
print ( '-depsc', '-r600','MIangularScatterPlot');
print('-dpdf', 'MIangularScatterPlot', '-r600');


%% plot likelihoods of employed strategies

monkeyEarlySetIndex = [1,2,3,4,8,10,22];
monkeyEarlySessionIndex = ones(1,length(monkeyEarlySetIndex));
monkeyEarlyProficientSessionIndex = zeros(1,length(monkeyEarlySetIndex));
for i = 1:length(monkeyEarlySetIndex)
    iSet = monkeyEarlySetIndex(i);
    monkeyEarlyProficientSessionIndex(i) = find(sessionMetrics(iSet).isPairProficient, 1, 'first');
end    

monkeyLateSetIndex = [1,2,3,4,9,10,22];
monkeyLateSessionIndex = nFile(monkeyLateSetIndex);
monkeyLateProficientSessionIndex = zeros(1,length(monkeyEarlySetIndex));
for i = 1:length(monkeyEarlySetIndex)
    iSet = monkeyLateSetIndex(i);
    monkeyLateProficientSessionIndex(i) = find(sessionMetrics(iSet).isPairProficient, 1, 'last');
end    

iHumanSet = 19;
humanSetIndex = iHumanSet*ones(1,nFile(iHumanSet));
humanSessionIndex = 1:nFile(iHumanSet);
humanProficientSessionIndex = find(sessionMetrics(iHumanSet).isPairProficient);
humanProficientSetIndex = iHumanSet*ones(1,length(humanProficientSessionIndex));


monkeySMearlySetIndex = [5,6,13,16];
monkeySMearlySessionIndex = ones(1, length(monkeySMearlySetIndex));
monkeySMearlyProficientSetIndex = [13,16];
monkeySMearlyProficientSessionIndex = zeros(1,length(monkeySMearlyProficientSetIndex));
for i = 1:length(monkeySMearlyProficientSetIndex)
    iSet = monkeySMearlyProficientSetIndex(i);
    monkeySMearlyProficientSessionIndex(i) = find(sessionMetrics(iSet).isPairProficient, 1, 'first');
end    

monkeySMlateSetIndex = [13,16]; %[5,7,13,16];
monkeySMlateSessionIndex = nFile(monkeySMlateSetIndex);
monkeySMlateProficientSetIndex = [13,16];
monkeySMlateProficientSessionIndex = zeros(1,length(monkeySMlateProficientSetIndex));
for i = 1:length(monkeySMlateProficientSetIndex)
    iSet = monkeySMlateProficientSetIndex(i);
    monkeySMlateProficientSessionIndex(i) = find(sessionMetrics(iSet).isPairProficient, 1, 'last');
end   



iConfederateTrained = 11;
confederateTrainedSessionIndex = 1:nFile(iConfederateTrained) - 1;
confederateTrainedSetIndex = iConfederateTrained*ones(1,length(confederateTrainedSessionIndex));
 
groupSetIndex = {humanSetIndex, monkeyEarlySetIndex, monkeyLateSetIndex, monkeySMearlySetIndex, monkeySMlateSetIndex, confederateTrainedSetIndex};
groupSessionIndex = {humanSessionIndex, monkeyEarlySessionIndex, monkeyLateSessionIndex, monkeySMearlySessionIndex, monkeySMlateSessionIndex, confederateTrainedSessionIndex};
groupProficientSetIndex = {humanProficientSetIndex, monkeyEarlySetIndex, monkeyLateSetIndex, monkeySMearlyProficientSetIndex, monkeySMlateProficientSetIndex, confederateTrainedSetIndex};
groupProficientSessionIndex = {humanProficientSessionIndex, monkeyEarlyProficientSessionIndex, monkeyLateProficientSessionIndex, monkeySMearlyProficientSessionIndex, monkeySMlateProficientSessionIndex, confederateTrainedSessionIndex};

nGroup = 3;
basicLikelihood = cell(nGroup, 3);
detailedLikelihood = cell(nGroup, 4);
basicProfLikelihood = cell(nGroup, 3);
detailedProfLikelihood = cell(nGroup, 4);
for iGroup = 1:nGroup
    for i = 1:length(groupSetIndex{iGroup})
        iSet = groupSetIndex{iGroup}(i);
        iFile = groupSessionIndex{iGroup}(i);
        basicLikelihood{iGroup, 1}(2*i-1:2*i) = basicStrategyLikelihood{iSet}(:, iFile);
        basicLikelihood{iGroup, 2}(2*i-1:2*i) = complexStrategyLikelihood{iSet}(:, iFile);
        basicLikelihood{iGroup, 3}(2*i-1:2*i) = temporalStrategyLikelihood{iSet}(:, iFile);
        detailedLikelihood{iGroup, 1}(2*i-1:2*i) = sideStrategyLikelihood{iSet}(:, iFile);
        detailedLikelihood{iGroup, 2}(2*i-1:2*i) = targetStrategyLikelihood{iSet}(:, iFile);
        detailedLikelihood{iGroup, 3}(2*i-1:2*i) = turnTakingStrategyLikelihood{iSet}(:, iFile);
        detailedLikelihood{iGroup, 4}(2*i-1:2*i) = temporalStrategyLikelihood{iSet}(:, iFile);         
    end
    for i = 1:length(groupProficientSetIndex{iGroup})   
        iSet = groupProficientSetIndex{iGroup}(i);
        iFile = groupProficientSessionIndex{iGroup}(i);
        basicProfLikelihood{iGroup, 1}(2*i-1:2*i) = basicStrategyLikelihood{iSet}(:, iFile);
        basicProfLikelihood{iGroup, 2}(2*i-1:2*i) = complexStrategyLikelihood{iSet}(:, iFile);
        basicProfLikelihood{iGroup, 3}(2*i-1:2*i) = temporalStrategyLikelihood{iSet}(:, iFile);
        detailedProfLikelihood{iGroup, 1}(2*i-1:2*i) = sideStrategyLikelihood{iSet}(:, iFile);
        detailedProfLikelihood{iGroup, 2}(2*i-1:2*i) = targetStrategyLikelihood{iSet}(:, iFile);
        detailedProfLikelihood{iGroup, 3}(2*i-1:2*i) = turnTakingStrategyLikelihood{iSet}(:, iFile);
        detailedProfLikelihood{iGroup, 4}(2*i-1:2*i) = temporalStrategyLikelihood{iSet}(:, iFile);         
    end
end    

pValue = 0.05;
labelSubjectGroups = { 'humans  ', 'macaques early  ', 'macaques late  '};
labelProfSubjectGroups = {'proficient humans', 'macaques proficient early', 'macaques proficient late'};

colorVector = [1, 0, 0.5];
barColor = [1 - 0.75*colorVector; 0.4 + 0.1*colorVector; 0.25 + 0.5*colorVector];


figureName = {'Basic_MonkeyOnly', 'Basic_MonkeyOnly_Connect', 'Basic_HumanOnly', 'Basic_All', 'Basic_All_Prof', 'Detailed_MonkeyOnly', 'Detailed_MonkeyOnly_Connect', 'Detailed_HumanOnly', 'Detailed_All', 'Detailed_All_Prof'};
figureName = cellfun(@(x) ['StrategyLikelihood_' x], figureName, 'UniformOutput', false);
nFigure = length(figureName);
nBasicFigure = nFigure/2;
for iFigure = 1:nFigure   
    indexFigureType = mod(iFigure, nBasicFigure);
    if (indexFigureType == 0)
        indexFigureType = nBasicFigure;
    end
    
    barPlotHandle = figure('Name', figureName{iFigure}, 'visible', figure_visibility_string);
    [output_rect] = fnFormatPaperSize(DefaultPaperSizeType, gcf, output_rect_fraction);
    set(gcf(), 'Units', 'centimeters', 'Position', output_rect, 'PaperPosition', output_rect);

    %set( axes,'fontsize', fontSize,  'FontName', fontType);
    
    if iFigure <= nBasicFigure
        if (indexFigureType ~= nBasicFigure)
            likelihoodValues = basicLikelihood;
        else
            likelihoodValues = basicProfLikelihood;
        end
        strategyGroupLabels = {'basic', 'complex', 'temporal'};
    else
        if (indexFigureType ~= nBasicFigure)
            likelihoodValues = detailedLikelihood;
        else
            likelihoodValues = detailedProfLikelihood;
        end
        strategyGroupLabels = {'side-based', 'target-based', 'turn-taking', 'temporal'};
    end  
    if (indexFigureType < 3)
        indexBarToDisplay = 2:3;
    elseif (indexFigureType == 3)    
        indexBarToDisplay = 1;
    else
        indexBarToDisplay = 1:3;
    end    
    
    [~, nStrategyGroup] = size(likelihoodValues);
    scatterSize = 32;
    if (indexFigureType == 2)
        connectLines = true;
    else
        connectLines = false;
    end 
    draw_bar_two_parametric_population(likelihoodValues(indexBarToDisplay,:)', labelSubjectGroups(indexBarToDisplay), strategyGroupLabels, scatterSize, barColor(:,indexBarToDisplay), connectLines, pValue);
    ylabel('average likelihood');
    
    %set( gcf, 'PaperUnits','centimeters' );
    %xSize = 18; ySize = 14;   xLeft = 0; yTop = 0;
    %set( gcf,'PaperPosition', [ xLeft yTop xSize ySize ] );
    %print ( '-depsc', fileName, '-r600');
    %print('-dpdf', fileName, '-r600');
    %print('-dpng', fileName, '-r600');
    
    write_out_figure(barPlotHandle, [figureName{iFigure} '.pdf']);
    write_out_figure(barPlotHandle, [figureName{iFigure} '.ps3']);
    savefig(figureName{iFigure});
end

%% plot MI scatter plot for selected strategies
colorList = zeros(5,3);
basicColorList = [0.250, 0.50, 0.75;...
                  1.000, 0.40, 0.25; ...
                  0.625, 0.45, 0.50; ...
                  1.000, 0.40, 0.25;...
                  0.625, 0.45, 0.50; ...
                  0.000, 0.20, 0.95];
setMarker = {'o', 'o', 'o', 's', 's', 'd'};
labelSubjectGroups = {'humans', 'macaques early', 'macaques late', 'macaques vs. human confederate early', 'macaques vs. human confederate late', 'confederate-trained macaques'};
              
sz = 96;
nSetGroup = length(allSets);

figureName = {'HumanOnly', 'MonkeyOnly', 'Naive', 'NaiveFaded', 'NaiveFaded_NHPwithSM', 'NaiveFaded_NHPwithSMFaded', 'All', 'All_labeled'};
figureName = cellfun(@(x) ['Scatter_' x], figureName, 'UniformOutput', false);
figureName = [figureName, cellfun(@(x) [x, '_Prof'], figureName, 'UniformOutput', false)];
nFigure = length(figureName);
nBasicFigure = nFigure/2;
for iFigure = 1:nFigure   
    if (iFigure <= nBasicFigure)
        setIndex = groupSetIndex;
        fileIndex = groupSessionIndex;
    else
        setIndex = groupProficientSetIndex;
        fileIndex = groupProficientSessionIndex;
    end
     
    indexFigureType = mod(iFigure, nBasicFigure);
    if (indexFigureType == 0)
        indexFigureType = nBasicFigure;
    end
    
    colorList = basicColorList;
    if (indexFigureType > 3)
        colorList(1:3, :) = basicColorList(1:3, :) + 0.3;
        if (indexFigureType > 5)
           colorList(4:5, :) = basicColorList(4:5, :) + 0.3;
        end   
    end    
    colorList(colorList > 1) = 1;
    
    nSetGroup = 1;
    if (indexFigureType > 1)
        if (indexFigureType > 4)
            if (indexFigureType > 6)
                nSetGroup = 6;
            else
                nSetGroup = 5;
            end
        else    
            nSetGroup = 3;
        end    
    end 
    
    if (indexFigureType == 2) % only monkey plot
        firstGroup = 2;
    else
        firstGroup = 1;
    end    
    xData = cell(1,nSetGroup);
    yData = cell(1,nSetGroup);    
    
    for iGroup = firstGroup:nSetGroup
        xData{iGroup} = zeros(1, length(setIndex{iGroup}));
        yData{iGroup} = zeros(1, length(setIndex{iGroup}));
        for i = 1:length(setIndex{iGroup})
            iSet = setIndex{iGroup}(i);
            iFile = fileIndex{iGroup}(i);
        
            xData{iGroup}(i) = sessionMetrics(iSet).miSide(iFile);
            yData{iGroup}(i) = sessionMetrics(iSet).miTarget(iFile);    
        end    
    end
    scatterPlotHandle = figure('Name', figureName{iFigure}, 'visible', figure_visibility_string);
    %set( axes,'fontsize', fontSize,  'FontName', fontType);%'FontName', 'Times');
    hold on
    for iGroup = firstGroup:nSetGroup
        rData = sqrt(xData{iGroup}.^2 + yData{iGroup}.^2);
        phiData = atan(xData{iGroup}./yData{iGroup});
        phiData(yData{iGroup} == 0) = pi()/2;
        n = length(rData);
        phiData = phiData + 0.002*((1:n) - n/2); % to make points discernable
        
        scatter(phiData, rData, sz, colorList(iGroup, :), setMarker{iGroup}, 'LineWidth',3);
        if (indexFigureType == nBasicFigure)
            indexStr = num2str((1:n)'); indexCell = cellstr(indexStr);
            dx = 0.02; dy = 0.02; % displacement so the text does not overlay the data points
            text(phiData+dx, rData+dy, indexCell,'Color', colorList(iGroup, :), 'Fontsize', 20);
        end    
    end    
    hold off
    axis([-0.05, pi()/2+0.1, -0.05, 1.4]);
    %ylabel('$\sqrt{\mathrm{MI}_\mathrm{side}^2 + \mathrm{MI}_\mathrm{target}^2}$', 'fontsize', fontSize, 'FontName', fontType, 'Interpreter', 'latex');
    %xlabel('$\mathrm{atan}\big(\mathrm{MI}_\mathrm{side}/\mathrm{MI}_\mathrm{target}\big), { }^\circ$', 'fontsize', fontSize, 'FontName', fontType, 'Interpreter', 'latex');
    %set( gca, 'xTick', [0, pi()/4, pi()/2], 'xTickLabel', {'0', '45', '90'}, 'fontsize', fontSize, 'FontName', fontType);
    ylabel('Coordination strength (MI magnitude) [a.u.]');
    xlabel('Coordination type (angle between MI`s) [degree]');
    set( gca, 'xTick', [0, pi()/4, pi()/2], 'xTickLabel', {'Side-based (0)', 'Trial-by-trial (45)', 'Target-based (90)'});
    
    if (indexFigureType ~= 2) % if not humans only
        legendHandle = legend(labelSubjectGroups(1:nSetGroup), 'location', 'NorthWest');
        set(legendHandle);
    end 
    %set( gcf, 'PaperUnits','centimeters' );
    %xSize = 20; ySize = 14;
    %xLeft = 0; yTop = 0;
    %set( gcf,'PaperPosition', [ xLeft yTop xSize ySize ] );
    %print ( '-depsc', '-r600',figureName{iFigure});
    
    [output_rect] = fnFormatPaperSize(DefaultPaperSizeType, gcf, output_rect_fraction);
    set(gcf(), 'Units', 'centimeters', 'Position', output_rect, 'PaperPosition', output_rect);
    write_out_figure(scatterPlotHandle, [figureName{iFigure} '.pdf']);
    write_out_figure(scatterPlotHandle, [figureName{iFigure} '.ps3']);
    %print('-dpdf', figureName{iFigure}, '-r600');
    savefig(figureName{iFigure});
end
%% plot dynamics of strategy likelihood
fileName = {'likelihoodDynamics_FlaffusCurius', 'likelihoodDynamics_Human'};
setIndex = [11,19];
lastFileIndex = [nFile(setIndex(1)) - 1, nFile(setIndex(2))];
nFigure = length(fileName);
playerName = {'Flaffus', 'Curius'; 'Human Player 1', 'Human Player 2'};

for iFigure = 1:nFigure
    iSet = setIndex(iFigure);
    
    playerIndex = ones(2,nFile(iSet));
    playerIndex(1,end) = 2;
    playerIndex(2,1:end-1) = 2;
    
    y = cell(1,2);
    for iPlayer = 1:2
        y{iPlayer} = zeros(4,lastFileIndex(iFigure));
        for iFile = 1:lastFileIndex(iFigure)
            y{iPlayer}(1,iFile) = sideStrategyLikelihood{iSet}(playerIndex(iPlayer,iFile), iFile);
            y{iPlayer}(2,iFile) = targetStrategyLikelihood{iSet}(playerIndex(iPlayer,iFile), iFile);
            y{iPlayer}(3,iFile) = turnTakingStrategyLikelihood{iSet}(playerIndex(iPlayer,iFile), iFile);
            y{iPlayer}(4,iFile) = temporalStrategyLikelihood{iSet}(playerIndex(iPlayer,iFile), iFile);
        end
    end
    
    strategyGroupLabels = {'side-based', 'target-based', 'turn-taking', 'temporal'};
    dynamicsHandle = figure('Name', 'strategies likelihood');
    [output_rect] = fnFormatPaperSize(DefaultPaperSizeType, gcf, output_rect_fraction);
    set(gcf(), 'Units', 'centimeters', 'Position', output_rect, 'PaperPosition', output_rect);
    
    %set( axes,'fontsize', fontSize,  'FontName', fontType);
    for iPlot = 1:2
        subplot(2,1,iPlot)
        plot(y{iPlot}', 'LineWidth', 2);
        
        if iPlot == 1
            legendHandle = legend(strategyGroupLabels, 'location', 'NorthWest', 'orientation', 'horizontal');
            set(legendHandle);
        end
        if (iFigure == 1)
            [~, labelIndices] = unique(dataset{iSet}.captions);
            correctLabel = dataset{iSet}.captions(sort(labelIndices));
            set( gca, 'XTick', 1:lastFileIndex(iFigure), 'XTickLabel', correctLabel, 'XTickLabelRotation',45);
        else
            set( gca, 'XTick', 1:lastFileIndex(iFigure));
        end
        set( gca, 'YTick', 0:0.25:1);
        title(playerName{iFigure, iPlot});
        axis([0.9, lastFileIndex(iFigure) + 0.1, 0, 1.24]);
        
        ylabel('average likelihood');
    end
    %set( gcf, 'PaperUnits','centimeters' );
    %xSize = 14; ySize = 12;  xLeft = 0; yTop = 0;
    %set( gcf,'PaperPosition', [ xLeft yTop xSize ySize ] );
    %print ( '-depsc', fileName, '-r600');
    %print('-dpdf', fileName, '-r600');
    %print('-dpng', fileName, '-r600');
    
    write_out_figure(dynamicsHandle, [fileName{iFigure} '.pdf']);
    write_out_figure(dynamicsHandle, [fileName{iFigure} '.ps3']);
    savefig(fileName{iFigure});
end


%% RT prediction

%% plot reward distribution in human and monkey pairs
monkeySetForReward = [1,7,9,21, 2,3,8,10];
humanSetForReward = [18,19];
allSetsForReward = {monkeySetForReward, humanSetForReward};
labelGroupForReward = {'macaques', 'humans'};

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
        rewardDistr{1} = [rewardDistr{1}, sessionMetrics(i).playerReward];
        rewardDistr{2} = [rewardDistr{2}, sessionMetrics(i).playerReward(:, sessionMetrics(i).isPairProficient)];
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
set( axes,'fontsize', fontSize,  'FontName', fontType);%'FontName', 'Times');
for iPlot = 1:2
  subplot(1,4,iPlot);
  boxplot(groupedReward{iPlot},groupIndex{iPlot}, 'Widths', 0.8);
  title(rewardPlotTitle{iPlot}, 'fontsize', fontSize,  'FontName', fontType);
  set( gca, 'fontsize', fontSize,  'FontName', fontType, 'XTickLabel', labelGroupForReward);%'FontName', 'Times');
  axis([0.5, nSetGroupForReward + 0.5, 1.0, 4.01]);
  xlabel('species', 'fontsize', fontSize, 'FontName', fontType);
  if iPlot == 1
    ylabel('mean per-session reward', 'fontsize', fontSize, 'FontName', fontType);
  end
  set( gca, 'fontsize', fontSize, 'FontName', fontType);%'FontName', 'Times');
end
for iPlot = 1:2
  subplot(1,4,2 + iPlot);
  boxplot(groupedFairness{iPlot},fairnessGroupIndex{iPlot}, 'Widths', 0.8);
  title(rewardPlotTitle{iPlot}, 'fontsize', fontSize,  'FontName', fontType);
  set( gca, 'fontsize', fontSize,  'FontName', fontType, 'XTickLabel', labelGroupForReward);%'FontName', 'Times');
  axis([0.5, nSetGroupForReward + 0.5, 0.32, 0.501]);
  xlabel('species', 'fontsize', fontSize, 'FontName', fontType);
  if iPlot == 1
    ylabel('reward share', 'fontsize', fontSize, 'FontName', fontType);
  end
  set( gca, 'fontsize', fontSize, 'FontName', fontType);%'FontName', 'Times');
end

set( gcf, 'PaperUnits','centimeters' );
xSize = 18; ySize = 14;
xLeft = 0; yTop = 0;
set( gcf,'PaperPosition', [ xLeft yTop xSize ySize ] );
print ( '-depsc', '-r600','RewardDistributionPerSpecies');
print('-dpdf', 'RewardDistributionPerSpecies', '-r600');
print('-dpng', 'RewardDistributionPerSpecies', '-r600');



figure('Name', 'reward distribution plot');
set( axes,'fontsize', fontSize,  'FontName', fontType);%'FontName', 'Times');
for iPlot = 1:2
  subplot(1,2,iPlot);
  boxplot(groupedReward{iPlot},groupIndex{iPlot}, 'Widths', 0.8);
  title(rewardPlotTitle{iPlot}, 'fontsize', fontSize,  'FontName', fontType);
  set( gca, 'fontsize', fontSize,  'FontName', fontType, 'XTickLabel', labelGroupForReward);%'FontName', 'Times');
  axis([0.5, nSetGroupForReward + 0.5, 1.0, 4.01]);
  %xlabel('species', 'fontsize', fontSize, 'FontName', fontType);
  if iPlot == 1
    ylabel('mean per-session reward', 'fontsize', fontSize, 'FontName', fontType);
  end
  set( gca, 'fontsize', fontSize, 'FontName', fontType);%'FontName', 'Times');
end

set( gcf, 'PaperUnits','centimeters' );
xSize = 21; ySize = 14;
xLeft = 0; yTop = 0;
set( gcf,'PaperPosition', [ xLeft yTop xSize ySize ] );
print ( '-depsc', '-r600','RewardSplittingPerSpecies');
print('-dpdf', 'RewardLevelPerSpecies', '-r600');
print('-dpng', 'RewardLevelPerSpecies', '-r600');




figure('Name', 'sharing the spoils');
set( axes,'fontsize', fontSize,  'FontName', fontType);%'FontName', 'Times');

for iPlot = 1:2
  subplot(1,2,iPlot);
  boxplot(groupedFairness{iPlot},fairnessGroupIndex{iPlot}, 'Widths', 0.8);
  title(rewardPlotTitle{iPlot}, 'fontsize', fontSize,  'FontName', fontType);
  set( gca, 'fontsize', fontSize,  'FontName', fontType, 'XTickLabel', labelGroupForReward);%'FontName', 'Times');
  axis([0.5, nSetGroupForReward + 0.5, 0.32, 0.501]);
  %xlabel('species', 'fontsize', fontSize, 'FontName', fontType);
  if iPlot == 1
    ylabel('reward share', 'fontsize', fontSize, 'FontName', fontType);
  end
  set( gca, 'fontsize', fontSize, 'FontName', fontType);%'FontName', 'Times');
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
    for i = 1:length(allSetsForReward{iSetGroup}) 
        iSet = allSetsForReward{iSetGroup}(i);
        shareLargeRT = zeros(1, nFile(iSet));        
        for iFile = 1:nFile(iSet)
            
            if (iSet == 18) && (iFile < 6)
                continue
            end    
            
            nTrial = length(allRT{iSet, iFile});
            fistTestIndex = max(cfg.minStationarySegmentStart, nTrial-cfg.stationarySegmentLength);
            testIndices = fistTestIndex:nTrial;
            nTestIndices = length(testIndices);
            RT = allRT{iSet, iFile}(:,testIndices);
            isOwnChoice = allOwnChoice{iSet, iFile}(:,testIndices);
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
rewardRTgroupLabel = {'macaques separate', 'macaques joint', 'humans separate', 'humans joint'};

figure('Name', 'reward distribution plot');
set( axes,'fontsize', fontSize,  'FontName', fontType);%'FontName', 'Times');
for iPlot = 1:2
  subplot(1,2,iPlot);
  boxplot(groupRTdiff{iPlot},groupRewardClass{iPlot}, 'Widths', 0.7);
  title(rewardPlotTitle{iPlot}, 'fontsize', fontSize,  'FontName', fontType);
  set( gca, 'fontsize', fontSize,  'FontName', fontType, 'XTickLabel', rewardRTgroupLabel, 'XTickLabelRotation', 45);%'FontName', 'Times');
  %axis([0.5, nSetGroupForReward + 0.5, 1.0, 4.01]);
  %xlabel('grou', 'fontsize', fontSize, 'FontName', fontType);
  if iPlot == 1
    ylabel('reaction time differences', 'fontsize', fontSize, 'FontName', fontType);
  end
  set( gca, 'fontsize', fontSize, 'FontName', fontType);%'FontName', 'Times');
end
%{
for iPlot = 1:2
  subplot(1,4,2 + iPlot);
  boxplot(groupedLargeRTshare{iPlot},groupIndexRTshare{iPlot}, 'Widths', 0.8);
  title(rewardPlotTitle{iPlot}, 'fontsize', fontSize,  'FontName', fontType);
  set( gca, 'fontsize', fontSize,  'FontName', fontType, 'XTickLabel', labelGroupForReward);%'FontName', 'Times');
  %axis([0.5, 2.5, 1.0, 4.01]);
  xlabel('species', 'fontsize', fontSize, 'FontName', fontType);
  if iPlot == 1
    ylabel('share of trials with dRT > 150', 'fontsize', fontSize, 'FontName', fontType);
  end
  set( gca, 'fontsize', fontSize, 'FontName', fontType);%'FontName', 'Times');
end
%}
set( gcf, 'PaperUnits','centimeters' );
xSize = 16; ySize = 14;
xLeft = 0; yTop = 0;
set( gcf,'PaperPosition', [ xLeft yTop xSize ySize ] );
print ( '-depsc', '-r600','RTandCoordinationPerSpecies');
print('-dpdf', 'RTandCoordinationPerSpecies', '-r600');
print('-dpng', 'RTandCoordinationPerSpecies', '-r600');

rewardRTgroupLabel = {'macaques, choice delay', 'macaques, no delay', 'humans, choice delay', 'humans, no delay'};

figure('Name', 'reward distribution plot');
set( axes,'fontsize', fontSize,  'FontName', fontType);%'FontName', 'Times');

for iPlot = 1:2
  nPoint = length(rewardConfPerCategory(:,iPlot));
  subplot(1,2,iPlot);
  errorbar(rewardPerCategory(:,iPlot),rewardConfPerCategory(:,iPlot), 's','MarkerSize',5,...
    'MarkerEdgeColor','red','MarkerFaceColor','red');
  title(rewardPlotTitle{iPlot}, 'fontsize', fontSize,  'FontName', fontType);
  set( gca, 'fontsize', fontSize,  'FontName', fontType, 'XTick', 1:nPoint, 'XTickLabel', rewardRTgroupLabel, 'XTickLabelRotation', 45);%'FontName', 'Times');
  axis([0.5, nPoint + 0.5, 2.95, 3.45]);
  %xlabel('grou', 'fontsize', fontSize, 'FontName', fontType);
  if iPlot == 1
    ylabel('average reward', 'fontsize', fontSize, 'FontName', fontType);
  end
  set( gca, 'fontsize', fontSize, 'FontName', fontType);%'FontName', 'Times');
end
%{
for iPlot = 1:2
  subplot(1,4,2 + iPlot);
  boxplot(groupedLargeRTshare{iPlot},groupIndexRTshare{iPlot}, 'Widths', 0.8);
  title(rewardPlotTitle{iPlot}, 'fontsize', fontSize,  'FontName', fontType);
  set( gca, 'fontsize', fontSize,  'FontName', fontType, 'XTickLabel', labelGroupForReward);%'FontName', 'Times');
  %axis([0.5, 2.5, 1.0, 4.01]);
  xlabel('species', 'fontsize', fontSize, 'FontName', fontType);
  if iPlot == 1
    ylabel('share of trials with dRT > 150', 'fontsize', fontSize, 'FontName', fontType);
  end
  set( gca, 'fontsize', fontSize, 'FontName', fontType);%'FontName', 'Times');
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
set( axes,'fontsize', fontSize,  'FontName', fontType);%'FontName', 'Times');
for iPlot = 1:2
  maxStrategyProb = max(max(strategyDistribution{iPlot}));
  subplot(2,1,iPlot);
  hold on
  bar(strategyDistribution{iPlot}');
  plot([basicStrategyBorder,basicStrategyBorder], [0, maxStrategyProb + 0.05], 'k--')
  hold off
  title(rewardPlotTitle{iPlot}, 'fontsize', fontSize,  'FontName', fontType);
  set( gca, 'fontsize', fontSize,  'FontName', fontType, 'XTickLabel', strategyLabels, 'XTickLabelRotation',45);%'FontName', 'Times');
  axis([0.5, nStrategy + 1.5, 0, maxStrategyProb + 0.02]);
  if iPlot == 1
    legendHandle = legend(labelGroupForReward, 'location', 'NorthEast');
    set(legendHandle, 'fontsize', fontSize,  'FontName', fontType);%'FontName', 'Times', 'Interpreter', 'latex');
  end      
 % if iPlot == 2
 %     xlabel('strategy', 'fontsize', fontSize, 'FontName', fontType);
 % end
  ylabel('relative frequency', 'fontsize', fontSize, 'FontName', fontType);
  set( gca, 'fontsize', fontSize, 'FontName', fontType);%'FontName', 'Times');
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
set( axes,'fontsize', fontSize,  'FontName', fontType);%'FontName', 'Times');

subplot(2,4,1:2);
hold on
fill([blockBorder{iSet}(iFile,:), blockBorder{iSet}(iFile,2:-1:1)], ...
    [-0.01, -0.01, 1.55, 1.55], [0.8,0.8,0.8]);
h1 = plot(movmean(isOwnChoice(1,:), 8), 'r-', 'linewidth', lineWidth+1);
h2 = plot(movmean(isOwnChoice(2,:), 8), 'b-', 'linewidth', lineWidth);
hold off
set( gca, 'fontsize', fontSize,  'FontName', fontType, 'yTick', [0,0.5,1], 'XTick', []);%'FontName', 'Times');
axis([0.8, maxXvalue + 0.01, -0.01, 1.9]);
ylabel( {'Share of own', ' choice in 8 rounds'}, 'fontsize', fontSize, 'FontName', fontType);
title('(a)', 'fontsize', fontSize,  'FontName', fontType);%'FontName', 'Times', 'Interpreter', 'latex');
legendHandle = legend([h1, h2], 'Human confederate', 'Monkey', 'location', 'NorthWest');
set(legendHandle, 'fontsize', fontSize,  'FontName', fontType);%'FontName', 'Times', 'Interpreter', 'latex');


totalReward = 1 + 2.5*(isOwnChoice(1,:)+isOwnChoice(2,:));
totalReward(totalReward == 6) = 2;
subplot(2,4,5:6);
hold on
fill([blockBorder{iSet}(iFile,:), blockBorder{iSet}(iFile,2:-1:1)], ...
    [0.9, 0.9, 3.6, 3.6], [0.8,0.8,0.8]);
h1 = plot(totalReward, 'm-', 'linewidth', lineWidth);
hold off
set( gca, 'fontsize', fontSize,  'FontName', fontType);%'FontName', 'Times');
axis([0.8, maxXvalue + 0.2, 0.9, 3.6]);
ylabel( ' Average reward ', 'fontsize', fontSize, 'FontName', fontType);
title('(b)', 'fontsize', fontSize,  'FontName', fontType);%'FontName', 'Times', 'Interpreter', 'latex');


subplot(2,4,3)
boxplot(vertcat(miValueBlock{monkeyBlockSetIndex}));
ylabel('Mutual information', 'fontsize', fontSize,  'FontName', fontType);
set( gca, 'fontsize', fontSize,  'FontName', fontType, 'XTick', []);%'FontName', 'Times');
axis([0.5,3.5, -0.03, 0.77]);
title('(c)', 'fontsize', fontSize,  'FontName', fontType);%'FontName', 'Times', 'Interpreter', 'latex');

subplot(2,4,4)
boxplot(vertcat(miValueBlock{humanBlockSetIndex}));
set( gca, 'fontsize', fontSize,  'FontName', fontType, 'XTick', []);%'FontName', 'Times');
axis([0.5,3.5, -0.03, 0.77]);
title('(d)', 'fontsize', fontSize,  'FontName', fontType);%'FontName', 'Times', 'Interpreter', 'latex');

subplot(2,4,7)
boxplot(vertcat(teBlock1{monkeyBlockSetIndex}));
ylabel('Transfer entropy', 'fontsize', fontSize,  'FontName', fontType);
set( gca, 'fontsize', fontSize,  'FontName', fontType, 'XTickLabel', {'before', 'block', 'after'});%'FontName', 'Times');
axis([0.5,3.5, -0.01, 0.34]);
title('(e)', 'fontsize', fontSize,  'FontName', fontType);%'FontName', 'Times', 'Interpreter', 'latex');

subplot(2,4,8)
boxplot(vertcat(teBlock1{humanBlockSetIndex}));
set( gca, 'fontsize', fontSize,  'FontName', fontType, 'XTickLabel', {'before', 'block', 'after'});%'FontName', 'Times');
axis([0.5,3.5, -0.01, 0.34]);
title('(f)', 'fontsize', fontSize,  'FontName', fontType);%'FontName', 'Times', 'Interpreter', 'latex');

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
        set( axes,'fontsize', fontSize,  'FontName', fontType);%'FontName', 'Times');
        totalReward = 1 + 2.5*(isOwnChoice(1,:)+isOwnChoice(2,:));
        totalReward(totalReward == 6) = 2;
        subplot(5, 1, 1);
        plot(totalReward, 'k-', 'linewidth', lineWidth);
        set( gca, 'fontsize', fontSize,  'FontName', fontType);%'FontName', 'Times');
        axis([0.8, maxXvalue + 0.2, 0.5, 4.9]);
        legendHandle = legend('Joint reward', 'location', 'NorthWest');
        set(legendHandle, 'fontsize', fontSize-6,  'FontName', fontType);%'FontName', 'Times', 'Interpreter', 'latex');
        title(titleList{trueFileIndex}, 'fontsize', fontSize,  'FontName', fontType);%'FontName', 'Times', 'Interpreter', 'latex');
        
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
        set( gca, 'fontsize', fontSize,  'FontName', fontType, 'yTick', [0,0.5,1]);%'FontName', 'Times');
        axis([0.8, maxXvalue + 0.01, -0.01, 1.8]);
        legendHandle = legend([h1, h2], 'Share own choices P1', 'Share own choices P2', 'location', 'NorthWest');
        set(legendHandle, 'fontsize', fontSize-6,  'FontName', fontType);%'FontName', 'Times', 'Interpreter', 'latex');
        
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
        set( gca, 'fontsize', fontSize,  'FontName', fontType);%'FontName', 'Times');
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
        set( gca, 'fontsize', fontSize,  'FontName', fontType, 'yTick', [0,0.5,1]);%'FontName', 'Times');
        axis([0.8, maxXvalue + 0.2, -0.01, 1.8]);
        legendHandle = legend([h1, h2], 'Share left choices P1', 'Share left choices P2', 'location', 'NorthWest');
        set(legendHandle, 'fontsize', fontSize-6,  'FontName', fontType);%'FontName', 'Times', 'Interpreter', 'latex');
        
        subplot(5, 1, 5);
        hold on
        if (~isempty(blockBorder{iSet}))
            fill([blockBorder{iSet}(iFile,:), blockBorder{iSet}(iFile,2:-1:1)], ...
                [0, 0, 1.01*maxMIvalue, 1.01*maxMIvalue], [0.8,0.8,0.8]);
        end
        h1 = plot(locMutualInf{iSet, trueFileIndex}, 'Color', [0.7, 0.3, 0.7], 'linewidth', lineWidth);
        h2 = plot(mutualInf{iSet, trueFileIndex}, 'Color', [0.4, 0.1, 0.4], 'linewidth', lineWidth+1);
        hold off
        set( gca, 'fontsize', fontSize,  'FontName', fontType);%'FontName', 'Times');
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