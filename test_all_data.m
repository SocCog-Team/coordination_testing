% Common abbreviations: MI - mutual information, TE - transfer entropy

%% prepare dataset for processing
%folder = '';
addpath(genpath('WhittleSurrogates'));
if ispc
  folder = 'Z:\taskcontroller\SCP_DATA\ANALYSES\PC1000\2018\CoordinationCheck';
else
  folder = fullfile('/', 'Volumes', 'social_neuroscience_data', 'taskcontroller', 'SCP_DATA', 'ANALYSES', 'PC1000', '2018', 'CoordinationCheck');
end

magnusCurius = {'DATA_20171108T140407.A_Magnus.B_Curius.SCP_01.triallog.A.Magnus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
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
  'DATA_20171123T101549.A_Magnus.B_Curius.SCP_01.triallog.A.Magnus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
  'DATA_20180212T164357.A_Magnus.B_Curius.SCP_01.triallog.A.Magnus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
  'DATA_20180213T152733.A_Magnus.B_Curius.SCP_01.triallog.A.Magnus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ... 
  'DATA_20180214T171119.A_Magnus.B_Curius.SCP_01.triallog.A.Magnus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice'};

magnusCuriusCaption = { '08.11.17', ...
            '09.11.17', ...
            '10.11.17', ...
            '13.11.17',...
            '14.11.17',...
            '15.11.17', ...
            '16.11.17', ...
            '16.11.17',...
            '17.11.17',...
            '20.11.17',...
            '21.11.17',...
            '22.11.17',... 
            '23.11.17',...
            '12.02.18',...
            '13.02.18',... 
            '14.02.18'};    


flaffusCurius = {'DATA_20171019T132932.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
  'DATA_20171020T124628.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
  'DATA_20171026T150942.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
  'DATA_20171027T145027.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice',...
  'DATA_20171031T124333.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice',...
  'DATA_20171101T123413.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
  'DATA_20171102T102500.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice',...
  'DATA_20171103T143324.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice',...
  'DATA_20171107T131228.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice',...
  'DATA_20180418T143951.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice',...
  'DATA_20180419T141311.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice',...
  'DATA_20180420T151954.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice',...
  'DATA_20180424T121937.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice',...
  'DATA_20180425T133936.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice',...
  'DATA_20180426T171117.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice',...
  'DATA_20180427T142541.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice',...
  'DATA_20180427T153406.A_Flaffus.B_Curius.SCP_01.triallog.A.Flaffus.B.Curius_IC_JointTrials.isOwnChoice_sideChoice',...
  'DATA_20180501T124452.A_Curius.B_Flaffus.SCP_01.triallog.A.Curius.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice'
  };
  
flaffusCuriusCaption = {'2017.10.19', ...
  '2017.10.20', ...
  '2017.10.26', ...
  '2017.10.27',...
  '2017.10.31',...
  '2017.11.01', ...
  '2017.11.02',...
  '2017.11.03',...
  '2017.11.07',...
  '2018.04.18',...
  '2018.04.19',...
  '2018.04.20',...
  '2018.04.24',...
  '2018.04.25',...
  '2018.04.26',...
  '2018.04.27',...
  '2018.04.27',...
  '2018.05.01'};


flaffusEC = {'DATA_20171116T115210.A_EC.B_Flaffus.SCP_01.triallog.A.EC.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
  'DATA_20171117T093215.A_EC.B_Flaffus.SCP_01.triallog.A.EC.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
  'DATA_20171121T133541.A_EC.B_Flaffus.SCP_01.triallog.A.EC.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
  'DATA_20171122T133949.A_EC.B_Flaffus.SCP_01.triallog.A.EC.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice', ...
  'DATA_20171124T131200.A_EC.B_Flaffus.SCP_01.triallog.A.EC.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice'};     
  
flaffusECCaption = {'2017.11.16, 11:52:10', ...
  '2017.11.17, 09:32:15', ...
  '2017.11.21, 13:35:41', ...
  '2017.11.22, 13:39:49', ...
  '2017.11.24, 13:12:00'};


SMCurius = {'DATA_20171124T094821.A_SM.B_Curius.SCP_01.triallog.A.SM.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
            'DATA_20171128T143855.A_SM.B_Curius.SCP_01.triallog.A.SM.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
            'DATA_20171129T151523.A_SM.B_Curius.SCP_01.triallog.A.SM.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
            'DATA_20171130T121204.A_SM.B_Curius.SCP_01.triallog.A.SM.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
            'DATA_20171201T132029.A_SM.B_Curius.SCP_01.triallog.A.SM.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
            'DATA_20171205T140719.A_SM.B_Curius.SCP_01.triallog.A.SM.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
            'DATA_20171206T141710.A_SM.B_Curius.SCP_01.triallog.A.SM.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
            'DATA_20171208T140548.A_SM.B_Curius.SCP_01.triallog.A.SM.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
            'DATA_20171211T110911.A_SM.B_Curius.SCP_01.triallog.A.SM.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ... 
            'DATA_20171212T104819.A_SM.B_Curius.SCP_01.triallog.A.SM.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
            'DATA_20180111T130920.A_SM.B_Curius.SCP_01.triallog.A.SM.B.Curius_IC_JointTrials.isOwnChoice_sideChoice',...
            'DATA_20180112T103626.A_SM.B_Curius.SCP_01.triallog.A.SM.B.Curius_IC_JointTrials.isOwnChoice_sideChoice',...
            'DATA_20180118T120304.A_SM.B_Curius.SCP_01.triallog.A.SM.B.Curius_IC_JointTrials.isOwnChoice_sideChoice',...
            'DATA_20180420T150912.A_SM.B_Curius.SCP_01.triallog.A.SM.B.Curius_IC_JointTrials.isOwnChoice_sideChoice',...
            'DATA_20180423T162330.A_SM.B_Curius.SCP_01.triallog.A.SM.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
            };

SMCuriusCaption = {'24.11.17', ...
                   '28.11.17', ...
                   '29.11.17', ...
                   '30.11.17', ...
                   '01.12.17', ...
                   '05.12.17', ...
                   '06.12.17', ...   
                   '08.12.17', ...
                   '11.12.17', ...                    
                   '12.12.17', ...    
                   '11.01.18', ...                    
                   '12.01.18', ...                   
                   '18.01.18', ...                   
                   '20.04.18', ...                   
                   '23.04.18'};           

                
 SMCuriusBlock = {'DATA_20171213T112521.A_SM.B_Curius.SCP_01.triallog.A.SM.B.Curius_IC_JointTrials.isOwnChoice_sideChoice',...
                  'DATA_20171215T122633.A_SM.B_Curius.SCP_01.triallog.A.SM.B.Curius_IC_JointTrials.isOwnChoice_sideChoice',...
                  'DATA_20171221T135010.A_SM.B_Curius.SCP_01.triallog.A.SM.B.Curius_IC_JointTrials.isOwnChoice_sideChoice',...  
                  'DATA_20171222T104137.A_SM.B_Curius.SCP_01.triallog.A.SM.B.Curius_IC_JointTrials.isOwnChoice_sideChoice',...
                  'DATA_20180119T123000.A_SM.B_Curius.SCP_01.triallog.A.SM.B.Curius_IC_JointTrials.isOwnChoice_sideChoice',... 
                  'DATA_20180123T132012.A_SM.B_Curius.SCP_01.triallog.A.SM.B.Curius_IC_JointTrials.isOwnChoice_sideChoice',...
                  'DATA_20180124T141322.A_SM.B_Curius.SCP_01.triallog.A.SM.B.Curius_IC_JointTrials.isOwnChoice_sideChoice',...
                  'DATA_20180125T140345.A_SM.B_Curius.SCP_01.triallog.A.SM.B.Curius_IC_JointTrials.isOwnChoice_sideChoice',...
                  'DATA_20180126T132629.A_SM.B_Curius.SCP_01.triallog.A.SM.B.Curius_IC_JointTrials.isOwnChoice_sideChoice'
            };

SMCuriusBlockCaption = {'13.12.2017', ...
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
   
      
SMFlaffus =      {'DATA_20180131T155005.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice',...                                                              
                  'DATA_20180201T162341.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice',...                                                              
                  'DATA_20180202T144348.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice',...                                                              
                  'DATA_20180205T122214.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice',...                                                              
                  'DATA_20180209T145624.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice',...                                                              
                  'DATA_20180213T133932.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice',...                                                              
                  'DATA_20180214T141456.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice',...                                                          
                  'DATA_20180215T131327.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice',...                                                              
                  'DATA_20180216T140913.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice',...                                                              
                  'DATA_20180220T133215.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice',...                                                              
                  'DATA_20180221T133419.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice',...                                                              
                  'DATA_20180222T121106.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice',...                                                              
                  'DATA_20180223T143339.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice',...                                                              
                  'DATA_20180227T151756.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice',...                                                              
                  'DATA_20180228T132647.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice'...                                                              
                  };
                
SMFlaffusCaption = {'31.01.18', ...
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
                   '28.02.18'};                 

                 
FlaffusSM = {'DATA_20180406T111431.A_Flaffus.B_SM.SCP_01.triallog.A.Flaffus.B.SM_IC_JointTrials.isOwnChoice_sideChoice',...
             'DATA_20180409T145457.A_Flaffus.B_SM.SCP_01.triallog.A.Flaffus.B.SM_IC_JointTrials.isOwnChoice_sideChoice',...
             'DATA_20180410T125708.A_Flaffus.B_SM.SCP_01.triallog.A.Flaffus.B.SM_IC_JointTrials.isOwnChoice_sideChoice',...
             'DATA_20180411T104941.A_Flaffus.B_SM.SCP_01.triallog.A.Flaffus.B.SM_IC_JointTrials.isOwnChoice_sideChoice',...
             'DATA_20180413T113720.A_Flaffus.B_SM.SCP_01.triallog.A.Flaffus.B.SM_IC_JointTrials.isOwnChoice_sideChoice',...
             'DATA_20180416T122545.A_Flaffus.B_SM.SCP_01.triallog.A.Flaffus.B.SM_IC_JointTrials.isOwnChoice_sideChoice',...             
             'DATA_20180416T124439.A_Flaffus.B_SM.SCP_01.triallog.A.Flaffus.B.SM_IC_JointTrials.isOwnChoice_sideChoice',...
             'DATA_20180417T161836.A_Flaffus.B_SM.SCP_01.triallog.A.Flaffus.B.SM_IC_JointTrials.isOwnChoice_sideChoice',...
             'DATA_20180423T141825.A_Flaffus.B_SM.SCP_01.triallog.A.Flaffus.B.SM_IC_JointTrials.isOwnChoice_sideChoice'...
                  };
                
FlaffusSMCaption = {'06.04.18', ...
                   '09.04.18', ...
                   '10.04.18', ...
                   '11.04.18', ...
                   '13.04.18', ...
                   '16.04.18', ...
                   '16.04.18', ...
                   '17.04.18', ...
                   '23.04.18'};                            
                 
                 
SMFlaffusBlock = {'DATA_20180301T122505.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice',...  
                  'DATA_20180302T151740.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice',...
                  'DATA_20180306T112342.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice',...
                  'DATA_20180307T100718.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice',...
                  'DATA_20180308T121753.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice',...
                  'DATA_20180309T110024.A_SM.B_Flaffus.SCP_01.triallog.A.SM.B.Flaffus_IC_JointTrials.isOwnChoice_sideChoice'...
                 };
               
SMFlaffusBlockCaption = {'01.03.18', ...
                         '02.03.18', ...
                         '06.03.18', ...
                         '07.03.18', ...                         
                         '08.03.18', ...                         
                         '09.03.18' ... 
                  };               

TNCurius = {'DATA_20180406T135926.A_TN.B_Curius.SCP_01.triallog.A.TN.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
            'DATA_20180410T144850.A_TN.B_Curius.SCP_01.triallog.A.TN.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
            'DATA_20180411T145314.A_TN.B_Curius.SCP_01.triallog.A.TN.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
            'DATA_20180413T143841.A_TN.B_Curius.SCP_01.triallog.A.TN.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
            'DATA_20180417T130643.A_TN.B_Curius.SCP_01.triallog.A.TN.B.Curius_IC_JointTrials.isOwnChoice_sideChoice', ...
            };

TNCuriusCaption = {'06.04.18', ...                    
                   '10.04.18', ...   
                   '11.04.18', ...                    
                   '13.04.18', ...                   
                   '17.04.18'};      
                 
                 
 humanPair = {'DATA_20170425T160951.A_21001.B_22002.SCP_00.triallog.A.21001.B.22002_IC_JointTrials.isOwnChoice_sideChoice',...
              'DATA_20170426T102304.A_21003.B_22004.SCP_00.triallog.A.21003.B.22004_IC_JointTrials.isOwnChoice_sideChoice',...
              'DATA_20170426T133343.A_21005.B_12006.SCP_00.triallog.A.21005.B.12006_IC_JointTrials.isOwnChoice_sideChoice',...
              'DATA_20170427T092352.A_21007.B_12008.SCP_00.triallog.A.21007.B.12008_IC_JointTrials.isOwnChoice_sideChoice',...
              'DATA_20170427T132036.A_21009.B_12010.SCP_00.triallog.A.21009.B.12010_IC_JointTrials.isOwnChoice_sideChoice',...
              'DATA_20171113T162815.A_20011.B_10012.SCP_01.triallog.A.20011.B.10012_IC_JointTrials.isOwnChoice_sideChoice',...
              'DATA_20171115T165545.A_20013.B_10014.SCP_01.triallog.A.20013.B.10014_IC_JointTrials.isOwnChoice_sideChoice',...
              'DATA_20171116T164137.A_20015.B_10016.SCP_01.triallog.A.20015.B.10016_IC_JointTrials.isOwnChoice_sideChoice',...  
              'DATA_20171121T165717.A_10018.B_20017.SCP_01.triallog.A.10018.B.20017_IC_JointTrials.isOwnChoice_sideChoice',...
              'DATA_20171121T175909.A_10018.B_20017.SCP_01.triallog.A.10018.B.20017_IC_JointTrials.isOwnChoice_sideChoice',... 
              'DATA_20171123T165158.A_20019.B_10020.SCP_01.triallog.A.20019.B.10020_IC_JointTrials.isOwnChoice_sideChoice',...
              'DATA_20171127T164730.A_20021.B_20022.SCP_01.triallog.A.20021.B.20022_IC_JointTrials.isOwnChoice_sideChoice',...
              'DATA_20171128T165159.A_20024.B_10023.SCP_01.triallog.A.20024.B.10023_IC_JointTrials.isOwnChoice_sideChoice',...
              'DATA_20171130T145412.A_20025.B_20026.SCP_01.triallog.A.20025.B.20026_IC_JointTrials.isOwnChoice_sideChoice',...
              'DATA_20171130T164300.A_20027.B_10028.SCP_01.triallog.A.20027.B.10028_IC_JointTrials.isOwnChoice_sideChoice',...
              'DATA_20171205T163542.A_20029.B_10030.SCP_01.triallog.A.20029.B.10030_IC_JointTrials.isOwnChoice_sideChoice',...
            };

humanPairCaption = {'01vs02', ...
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

                                   
humanPairBlocked = {'DATA_20180319T155543.A_31001.B_31002.SCP_01.triallog.A.31001.B.31002_IC_JointTrials.isOwnChoice_sideChoice',...
                    'DATA_20180320T142201.A_32003.B_32004.SCP_01.triallog.A.32003.B.32004_IC_JointTrials.isOwnChoice_sideChoice',...
                    'DATA_20180321T134216.A_31005.B_32006.SCP_01.triallog.A.31005.B.32006_IC_JointTrials.isOwnChoice_sideChoice',...
                    'DATA_20180322T110101.A_31007.B_32008.SCP_01.triallog.A.31007.B.32008_IC_JointTrials.isOwnChoice_sideChoice',...
                    'DATA_20180322T164348.A_32009.B_32010.SCP_01.triallog.A.32009.B.32010_IC_JointTrials.isOwnChoice_sideChoice'...
                    };

humanPairBlockedCaption = {'01vs02', ...
                           '03vs04', ...
                           '05vs06', ... 
                           '07vs08', ...
                           '09vs10'};       
                         
                         
SMhumanBlocked = {'DATA_20180417T185908.A_SM.B_52001.SCP_01.triallog.A.SM.B.52001_IC_JointTrials.isOwnChoice_sideChoice',...
                  'DATA_20180418T111112.A_SM.B_52002.SCP_01.triallog.A.SM.B.52002_IC_JointTrials.isOwnChoice_sideChoice',...
                  'DATA_20180419T112118.A_SM.B_51003.SCP_01.triallog.A.SM.B.51003_IC_JointTrials.isOwnChoice_sideChoice',...
                  'DATA_20180420T171629.A_SM.B_52004.SCP_01.triallog.A.SM.B.52004_IC_JointTrials.isOwnChoice_sideChoice',...
                  'DATA_20180420T192826.A_SM.B_52005.SCP_01.triallog.A.SM.B.52005_IC_JointTrials.isOwnChoice_sideChoice'...
                 };

SMhumanBlockedCaption = {'Human Confederate 1', ...
                         'Human Confederate 2', ...
                         'Human Confederate 3', ... 
                         'Human Confederate 4', ...
                         'Human Confederate 5'};                        
                    
                       
% flag indicating whether to scan all datasets or only selected ones
SCAN_ALL_DATASET = 1; 
%SCAN_ALL_DATASET = 0;

% filename - list of all files related to specific Set
% fileCaption - captions of files, adjacent files may have the same caption
% but the they are merged
if (SCAN_ALL_DATASET)
  filename = {magnusCurius, flaffusCurius, flaffusEC, SMCurius, SMCuriusBlock, TNCurius, SMFlaffus, SMFlaffusBlock, FlaffusSM, humanPair, humanPairBlocked, SMhumanBlocked};
  fileCaption = {magnusCuriusCaption, flaffusCuriusCaption, flaffusECCaption, SMCuriusCaption, SMCuriusBlockCaption, TNCuriusCaption, SMFlaffusCaption, SMFlaffusBlockCaption, FlaffusSMCaption, humanPairCaption, humanPairBlockedCaption, SMhumanBlockedCaption};
  setName = {'MagnusCurius', 'FlaffusCurius', 'FlaffusEC', 'SMCurius', 'SMCuriusBlock', 'TNCurius', 'SMFlaffus', 'SMFlaffusBlock', 'FlaffusSM', 'HumanPairs', 'humanPairBlocked', 'SMhumanBlocked'};
else
  filename = {SMhumanBlocked};
  fileCaption = {SMhumanBlockedCaption};
  setName = {'SMhumanBlocked'};
end
plotName = {'TEtarget', 'MutualInf', 'surprise_pos'};             

%% plotting parameters
FontSize = 11;
lineWidth = 1.0;

%% set parameters of the methods
pValueForMI = 0.01;
memoryLength = 1; % number of previous trials that affect the choices on the current trils
%minSampleNum = 1.5*(2.^(memoryLength+1))*(2.^memoryLength);
minSampleNum = 6*(2.^(memoryLength+1))*(2.^memoryLength);
stationarySegmentLength = 200;  % number of last trials supposedly corresponding to equilibrium state
minStationarySegmentStart = 20; % earliest possible start of equilibrium state

%% initialization
nSet = length(setName);
nFile = cell2mat(cellfun(@(x) length(unique(x)), fileCaption, 'UniformOutput',false));

% by-trial quantities
allOwnChoice = cell(nSet, max(nFile));  % target choice (0 - other, 1 - own)
allSideChoice = cell(nSet, max(nFile)); % side choice (0 - objective right, 1 - objective left)

% by-trial coordination metrics computed over window of minSampleNum trials 
mutualInf = cell(nSet, max(nFile));       % target local MI
locMutualInf = cell(nSet, max(nFile));    % target MI
targetTE1 = cell(nSet, max(nFile));       % target (averaged) TE
targetTE2 = cell(nSet, max(nFile));
localTargetTE1 = cell(nSet, max(nFile));  % target local TE
localTargetTE2 = cell(nSet, max(nFile));

% coordination metrics computed for each session (over supposedly equilibrium trials) 
miValueWhole = cell(nSet, max(nFile));      % target MI
miSignifWhole = cell(nSet, max(nFile));     % target MI significance
sideMIvalueWhole = cell(nSet, max(nFile));  % side MI
sideMIsignifWhole = cell(nSet, max(nFile)); % side MI significance
teWhole1 = cell(nSet, max(nFile));          % target TE
teWhole2 = cell(nSet, max(nFile));          
sideTEwhole1 = cell(nSet, max(nFile));      % side TE
sideTEwhole2 = cell(nSet, max(nFile));
averReward = cell(nSet, max(nFile));    % average reward of two players
dltReward = cell(nSet, max(nFile));     % non-random reward component of each player
dltSignif = cell(nSet, max(nFile));     % significance of non-random reward components
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
sideMIvalueBlock = cell(nSet, 1);   % side MI
sideMIsignifBlock = cell(nSet, 1);  % side MI significance
teBlock1 = cell(nSet, 1);           % target TE
teBlock2 = cell(nSet, 1);
sideTEblock1 = cell(nSet, 1);       % side TE
sideTEblock2 = cell(nSet, 1);
averageRewardBlock = cell(nSet, 1); % average reward of two players
deltaRewardBlock = cell(nSet, 1);   % non-random reward component of each player
deltaSignifBlock = cell(nSet, 1);   % significance of non-random reward components
coordStructBlock = cell(nSet, 3);   % outcomes of coordination tests

blockBorder = cell(nSet, 1);

%% dataset processing
totalFileIndex = 1;
for iSet = 1:nSet 
  disp(['Processing dataset' num2str(iSet)]);
  maxValue = 0;
  minValue = 0;
  minMIvalue = 0;
  maxMIvalue = 0;

  % preallocate blockwise quanities
  miValueBlock{iSet} = NaN(nFile(iSet), 3);
  miSignifBlock{iSet} = NaN(nFile(iSet), 3);
  sideMIvalueBlock{iSet} = NaN(nFile(iSet), 3);
  sideMIsignifBlock{iSet} = NaN(nFile(iSet), 3);
  teBlock1{iSet} = NaN(nFile(iSet), 3);
  teBlock2{iSet} = NaN(nFile(iSet), 3);
  sideTEblock1{iSet} = NaN(nFile(iSet), 3);
  sideTEblock2{iSet} = NaN(nFile(iSet), 3);
  averageRewardBlock{iSet} = NaN(nFile(iSet), 3);
  deltaRewardBlock{iSet} = NaN(nFile(iSet), 3);
  deltaSignifBlock{iSet} = NaN(nFile(iSet), 3);
  
  if (strcmp(setName{iSet}, 'SMCuriusBlock'))  
    blockBorder{iSet} = SMCuriusBlockBorder;   % predefined by constants
  else  
    blockBorder{iSet} = zeros(nFile(iSet), 2); % will be taken from file
  end
  
  playerStrategy{iSet} = zeros(nFile(iSet), 8);
  playerNStateVisit{iSet} = zeros(nFile(iSet), 8);
  
  % analyse all sessions for the given players pair
  filenameIndex = 1;
  for iFile = 1:nFile(iSet)
    % merge data for all files having the same caption
    i = filenameIndex;
    isOwnChoice = [];
    sideChoice = [];
    while(length(filename{iSet}) >= i)
      if (~strcmp(fileCaption{iSet}{i}, fileCaption{iSet}{filenameIndex}))
        break;
      end      
      clear isOwnChoiceArray sideChoiceObjectiveArray
      load(fullfile(folder, [filename{iSet}{i}, '.mat']), 'isOwnChoiceArray', 'sideChoiceObjectiveArray', 'PerTrialStruct'); 
      if (exist('isOwnChoiceArray', 'var'))
        isOwnChoice = [isOwnChoice, isOwnChoiceArray];
      else
        temp = isOwnChoice;
        load([filename{iSet}{i}, '.mat'], 'isOwnChoice');
        isOwnChoice = [temp, isOwnChoice];
      end 
      if (exist('sideChoiceObjectiveArray', 'var'))
        sideChoice = [sideChoice, sideChoiceObjectiveArray];
      else
        load([filename{iSet}{i}, '.mat'], 'isBottomChoice');
        sideChoice = [sideChoice, isBottomChoice];
      end       
      i = i + 1;
    end 
    filenameIndex = i;    
    allOwnChoice{iSet, iFile} = isOwnChoice;
    allSideChoice{iSet, iFile} = sideChoice;
    
    % here we consider only equilibrium (stabilized) values
    testIndices = max(minStationarySegmentStart, length(isOwnChoice) - stationarySegmentLength):length(isOwnChoice);
    nTestIndices = length(testIndices);

    % estimate strategy over equilibrium trials
    [playerStrategy{iSet, iFile}, ...
     playerNStateVisit{iSet, iFile}] = ...
         estimate_strategy(isOwnChoice(:, testIndices), sideChoice(:,testIndices));

    [averReward{iSet, iFile}, ...
     dltReward{iSet, iFile}, ...
     dltSignif{iSet, iFile}] = ...
       calc_total_average_reward(isOwnChoice(:,testIndices), sideChoice(:,testIndices));    
   
    %target choices quantities
    x = isOwnChoice(1, testIndices);
    y = isOwnChoice(2, testIndices);
    [miValueWhole{iSet, iFile}, miSignifWhole{iSet, iFile}] = ...
        calc_whole_mutual_information(x, y, pValueForMI);            
    teValue = calc_transfer_entropy(y, x, memoryLength, nTestIndices);        
    teWhole1{iSet, iFile} = teValue(1);
    teValue = calc_transfer_entropy(x, y, memoryLength, nTestIndices); 
    teWhole2{iSet, iFile} = teValue(1);
        
    %side choices quantities
    x = sideChoice(1, testIndices);
    y = sideChoice(2, testIndices);
    [sideMIvalueWhole{iSet, iFile}, sideMIsignifWhole{iSet, iFile}] = ...
         calc_whole_mutual_information(x, y, pValueForMI);            
    teValue = calc_transfer_entropy(y, x, memoryLength, nTestIndices);        
    sideTEwhole1{iSet, iFile} = teValue(1);
    teValue = calc_transfer_entropy(x, y, memoryLength, nTestIndices); 
    sideTEwhole2{iSet, iFile} = teValue(1);
     
    % perform coordination tests. 
    % To simplify visual inspection, results of all tests are qathered in single table 
    coordStruct(totalFileIndex) = ...
            check_coordination(isOwnChoice(:,testIndices), sideChoice(:,testIndices));
    totalFileIndex = totalFileIndex + 1;

    % compute MI and TE, as well as local MI and TE in windows
    x = isOwnChoice(1, :);
    y = isOwnChoice(2, :);
    targetTE1{iSet, iFile} = calc_transfer_entropy(y, x, memoryLength, minSampleNum);
    targetTE2{iSet, iFile} = calc_transfer_entropy(x, y, memoryLength, minSampleNum);
    localTargetTE1{iSet, iFile} = calc_local_transfer_entropy(y, x, memoryLength, minSampleNum);
    localTargetTE2{iSet, iFile} = calc_local_transfer_entropy(x, y, memoryLength, minSampleNum);    
    locMutualInf{iSet, iFile} = calc_local_mutual_information(x, y, minSampleNum);
    mutualInf{iSet, iFile} = calc_mutual_information(x, y, minSampleNum);
    minValue = min([minValue, min(localTargetTE1{iSet, iFile}), min(localTargetTE2{iSet, iFile})]);
    maxValue = max([maxValue, max(localTargetTE1{iSet, iFile}), max(localTargetTE2{iSet, iFile})]);
    minMIvalue = min([minMIvalue, min(locMutualInf{iSet, iFile})]);
    maxMIvalue = max([maxMIvalue, max(locMutualInf{iSet, iFile})]);
    
    % if there are blocked segments, compute statistics for each blcok       
    dataLength = length(x);
    minBlockLength = 40;
    blockIndices = cell(1,3);
    invisibleStart = find(PerTrialStruct.isTrialInvisible_AB == 1, 1, 'first');
    invisibleEnd = find(PerTrialStruct.isTrialInvisible_AB == 1, 1, 'last');    
    if (~isempty(invisibleStart))
      blockBorder{iSet}(iFile,:) = invisibleStart;
    end  
    if (~isempty(invisibleEnd))
      blockBorder{iSet}(iFile,2) = invisibleEnd;
    end      
    if (blockBorder{iSet}(iFile,1) > 0)   
      blockIndices{1} = minStationarySegmentStart:invisibleStart-1;
      blockIndices{2} = (invisibleStart+minStationarySegmentStart):invisibleEnd;
      if (invisibleEnd+1+minStationarySegmentStart+minBlockLength <= dataLength)
      	blockIndices{3} = (invisibleEnd+1+minStationarySegmentStart):dataLength;
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
            calc_whole_mutual_information(x(index), y(index), pValueForMI);            
        teValue = calc_transfer_entropy(y(index), x(index), memoryLength, blockLength);        
        teBlock1{iSet}(iFile, iBlock) = teValue(1);
        teValue = calc_transfer_entropy(x(index), y(index), memoryLength, blockLength); 
        teBlock2{iSet}(iFile, iBlock) = teValue(1);
        
        %side choices quantities
        [sideMIvalueBlock{iSet}(iFile, iBlock), sideMIsignifBlock{iSet}(iFile, iBlock)] = ...
            calc_whole_mutual_information(sideChoice(1,index), sideChoice(2,index), pValueForMI);            
        teValue = calc_transfer_entropy(sideChoice(2,index), sideChoice(1,index), memoryLength, blockLength);        
        sideTEblock1{iSet}(iFile, iBlock) = teValue(1);
        teValue = calc_transfer_entropy(sideChoice(1,index), sideChoice(2,index), memoryLength, blockLength); 
        sideTEblock2{iSet}(iFile, iBlock) = teValue(1);
        
        coordStructBlock{iSet, iBlock}(iFile) = ...
          check_coordination(isOwnChoice(:,index), sideChoice(:,index), 5*10^-5);
      end  
    end
    %isBottomChoice = sideChoiceObjectiveArray;    
  end  
  
  %---------------------
  %---- plot resuts ----
  %---------------------
  
  % plot per-session MI, TE, average and non-random reward 
  figure('Name',[setName{iSet}, ' per-session summary']);
  set( axes,'fontsize', FontSize,  'FontName', 'Arial');%'FontName', 'Times'); 

  nPlot = 6;
  maxTE = max(max([teWhole2{iSet, :}; teWhole1{iSet, :}; sideTEwhole2{iSet, :}; sideTEwhole1{iSet, :}]));
  for iPlot = 1:nPlot
    subplot(nPlot/2, 2, iPlot);
    if (iPlot == 1) 
      bar([miValueWhole{iSet, :}]);
      ylabel( {'target mutual information'}, 'fontsize', FontSize, 'FontName', 'Arial');
      axis([0.4, nFile(iSet) + 0.6, 0, 1.0]); 
    elseif (iPlot == 2) 
      bar([sideMIvalueWhole{iSet, :}]);
      ylabel( {'side mutual information'}, 'fontsize', FontSize, 'FontName', 'Arial');
      axis([0.4, nFile(iSet) + 0.6, 0, 1.0]); 
    elseif (iPlot == 3)     
      bar([teWhole2{iSet, :}; teWhole1{iSet, :}]');
      ylabel( {'target transfer entropy'}, 'fontsize', FontSize, 'FontName', 'Arial');
      axis([0.4, nFile(iSet) + 0.6, 0, maxTE + 0.01]); 
    elseif (iPlot == 4) 
      bar([sideTEwhole2{iSet, :}; sideTEwhole1{iSet, :}]');
      ylabel( {'side transfer entropy'}, 'fontsize', FontSize, 'FontName', 'Arial');
      axis([0.4, nFile(iSet) + 0.6, 0, maxTE + 0.01]); 
    elseif (iPlot == 5) 
      bar([averReward{iSet, :}]);
      ylabel( {'average reward'}, 'fontsize', FontSize, 'FontName', 'Arial');
      axis([0.4, nFile(iSet) + 0.6, 2, 3.6]); 
    elseif (iPlot == 6) 
      bar([dltReward{iSet, :}]);
      ylabel( {'non-random reward'}, 'fontsize', FontSize, 'FontName', 'Arial');
      axis([0.4, nFile(iSet) + 0.6, -0.05, 1.0]);    
    end  
    %if (iPlot >= nPlot - 1) 
    %  xlabel('Session number', 'fontsize', FontSize, 'FontName', 'Arial');
    %end  
    set( gca, 'fontsize', FontSize-2, 'XTick', 1:nFile(iSet), 'XTickLabel', unique(fileCaption{iSet}), 'XTickLabelRotation',45, 'FontName', 'Arial');%'FontName', 'Times'); 
    %set( gca, 'fontsize', FontSize, 'FontName', 'Arial');%'FontName', 'Times'); 
    %title(setName{1}, 'fontsize', FontSize,  'FontName', 'Arial');%'FontName', 'Times', 'Interpreter', 'latex');
  end
  set( gcf, 'PaperUnits','centimeters' );
  xSize = 18; ySize = 18;
  xLeft = 0; yTop = 0;
  set( gcf,'PaperPosition', [ xLeft yTop xSize ySize ] );
  print ( '-depsc', '-r600', ['perSession', '_', setName{iSet}]);
  print('-dpdf', ['perSession', '_', setName{iSet}], '-r600');
  
  % plot MI and TE dynamics over each session
  nFileCol = floor(sqrt(2*nFile(iSet)));
  nFileRow = ceil(nFile(iSet)/nFileCol); 
  figureTitle = {' Transfer Entropy', ' Mutual Information'};
  for iPlot = 1:2
    figure('Name',[setName{iSet}, figureTitle{iPlot}]);
    set( axes,'fontsize', FontSize,  'FontName', 'Arial');%'FontName', 'Times'); 

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
      set( gca, 'fontsize', FontSize,  'FontName', 'Arial');%'FontName', 'Times');      
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
        set(legendHandle, 'fontsize', FontSize-1, 'FontName', 'Times', 'Interpreter', 'latex');
      end  

      title(fileCaption{iSet}{iFile}, 'fontsize', FontSize,  'FontName', 'Arial');%'FontName', 'Times', 'Interpreter', 'latex');
    end  
    set( gcf, 'PaperUnits','centimeters' );
    xSize = 29; ySize = 21;
    xLeft = 0; yTop = 0;
    set( gcf,'PaperPosition', [ xLeft yTop xSize ySize ] );
    set(gcf,'PaperSize',fliplr(get(gcf,'PaperSize')))   
    print ( '-depsc', '-r600', [plotName{iPlot}, '_', setName{iSet}]);
    print('-dpdf', [plotName{iPlot}, '_', setName{iSet}], '-r600');
  end
  
  % If there are 3 blocks (sessions with trial blocking): plot boxplots for
  % each trial block (before, during and after the blocking) representing
  % distribution of MI, TE and non-random reward component for given block
  if (blockBorder{iSet}(1,1) > 0)
     figure('Name', [setName{iSet} ' block-wise plot']);
     set( axes,'fontsize', FontSize,  'FontName', 'Arial');%'FontName', 'Times'); 
     subplot(1,4,1)
     boxplot(miValueBlock{iSet});
     title('Mutual information (target)', 'fontsize', FontSize,  'FontName', 'Arial');
     set( gca, 'fontsize', FontSize,  'FontName', 'Arial', 'XTickLabel', {'before', 'block', 'after'});%'FontName', 'Times');      

     subplot(1,4,2)
     boxplot(sideMIvalueBlock{iSet});
     title('Mutual information (side)', 'fontsize', FontSize,  'FontName', 'Arial');
     set( gca, 'fontsize', FontSize,  'FontName', 'Arial', 'XTickLabel', {'before', 'block', 'after'});%'FontName', 'Times');      
 
     subplot(1,4,3)
     boxplot(teBlock1{iSet});
     title('Transfer entropy', 'fontsize', FontSize,  'FontName', 'Arial');
     set( gca, 'fontsize', FontSize,  'FontName', 'Arial', 'XTickLabel', {'before', 'block', 'after'});%'FontName', 'Times');      
 
     subplot(1,4,4)
     boxplot(deltaRewardBlock{iSet});
     title('Non-random reward', 'fontsize', FontSize,  'FontName', 'Arial');
     set( gca, 'fontsize', FontSize,  'FontName', 'Arial', 'XTickLabel', {'before', 'block', 'after'});%'FontName', 'Times');      
 
     set( gcf, 'PaperUnits','centimeters' );
    set(gcf,'PaperSize',fliplr(get(gcf,'PaperSize'))) 
    xSize = 30; ySize = 7;
    xLeft = 0; yTop = 0;
    set( gcf,'PaperPosition', [ xLeft yTop xSize ySize ] );
    print ( '-depsc', '-r600', ['set', num2str(iSet), '_boxplot']);
    print('-r600', ['set', num2str(iSet), '_boxplot'],'-dtiff');
  end
end




%% blocked trials figure
monkeyBlockSetIndex = [find(strcmp(setName, 'SMCuriusBlock')), find(strcmp(setName, 'SMFlaffusBlock'))];
humanBlockSetIndex = find(strcmp(setName, 'SMhumanBlocked'));
iSet = monkeyBlockSetIndex(2);
iFile = 6;

isOwnChoice = allOwnChoice{iSet,iFile};
sideChoice = allSideChoice{iSet,iFile};
maxXvalue = length(isOwnChoice(1,:));

FontSize = 8;
figure('Name', [setName{iSet} ' block-wise plot']);
set( axes,'fontsize', FontSize,  'FontName', 'Arial');%'FontName', 'Times'); 

subplot(2,4,1:2);
hold on
fill([blockBorder{iSet}(iFile,:), blockBorder{iSet}(iFile,2:-1:1)], ...
           [-0.01, -0.01, 1.55, 1.55], [0.8,0.8,0.8]);    
h1 = plot(movmean(isOwnChoice(1,:), 8), 'r-', 'linewidth', lineWidth+1);
h2 = plot(movmean(isOwnChoice(2,:), 8), 'b-', 'linewidth', lineWidth);
hold off
set( gca, 'fontsize', FontSize,  'FontName', 'Arial', 'yTick', [0,0.5,1], 'XTick', []);%'FontName', 'Times');  
axis([0.8, maxXvalue + 0.01, -0.01, 1.9]);
ylabel( {'Share of own', ' choice in 8 rounds'}, 'fontsize', FontSize, 'FontName', 'Arial');
title('(a)', 'fontsize', FontSize,  'FontName', 'Arial');%'FontName', 'Times', 'Interpreter', 'latex');
legendHandle = legend([h1, h2], 'Human confederate', 'Monkey', 'location', 'NorthWest');  
set(legendHandle, 'fontsize', FontSize,  'FontName', 'Arial');%'FontName', 'Times', 'Interpreter', 'latex'); 


totalReward = 1 + 2.5*(isOwnChoice(1,:)+isOwnChoice(2,:));
totalReward(totalReward == 6) = 2;
subplot(2,4,5:6);
hold on
fill([blockBorder{iSet}(iFile,:), blockBorder{iSet}(iFile,2:-1:1)], ...
           [0.9, 0.9, 3.6, 3.6], [0.8,0.8,0.8]);    
h1 = plot(totalReward, 'm-', 'linewidth', lineWidth);
hold off
set( gca, 'fontsize', FontSize,  'FontName', 'Arial');%'FontName', 'Times');  
axis([0.8, maxXvalue + 0.2, 0.9, 3.6]);
ylabel( ' Average reward ', 'fontsize', FontSize, 'FontName', 'Arial');  
title('(b)', 'fontsize', FontSize,  'FontName', 'Arial');%'FontName', 'Times', 'Interpreter', 'latex');


subplot(2,4,3)
boxplot(vertcat(miValueBlock{monkeyBlockSetIndex}));
ylabel('Mutual information', 'fontsize', FontSize,  'FontName', 'Arial');
set( gca, 'fontsize', FontSize,  'FontName', 'Arial', 'XTick', []);%'FontName', 'Times');      
axis([0.5,3.5, -0.03, 0.77]);
title('(c)', 'fontsize', FontSize,  'FontName', 'Arial');%'FontName', 'Times', 'Interpreter', 'latex');

subplot(2,4,4)
boxplot(vertcat(miValueBlock{humanBlockSetIndex}));
set( gca, 'fontsize', FontSize,  'FontName', 'Arial', 'XTick', []);%'FontName', 'Times');      
axis([0.5,3.5, -0.03, 0.77]);
title('(d)', 'fontsize', FontSize,  'FontName', 'Arial');%'FontName', 'Times', 'Interpreter', 'latex');

subplot(2,4,7)
boxplot(vertcat(teBlock1{monkeyBlockSetIndex}));
ylabel('Transfer entropy', 'fontsize', FontSize,  'FontName', 'Arial');
set( gca, 'fontsize', FontSize,  'FontName', 'Arial', 'XTickLabel', {'before', 'block', 'after'});%'FontName', 'Times');      
axis([0.5,3.5, -0.01, 0.34]);
title('(e)', 'fontsize', FontSize,  'FontName', 'Arial');%'FontName', 'Times', 'Interpreter', 'latex');

subplot(2,4,8)
boxplot(vertcat(teBlock1{humanBlockSetIndex}));
set( gca, 'fontsize', FontSize,  'FontName', 'Arial', 'XTickLabel', {'before', 'block', 'after'});%'FontName', 'Times');      
axis([0.5,3.5, -0.01, 0.34]);
title('(f)', 'fontsize', FontSize,  'FontName', 'Arial');%'FontName', 'Times', 'Interpreter', 'latex');

set( gcf, 'PaperUnits','centimeters' );
%    set(gcf,'PaperSize',fliplr(get(gcf,'PaperSize'))) 
xSize = 18; ySize = 8; xLeft = 0; yTop = 0;
set( gcf,'PaperPosition', [ xLeft yTop xSize ySize ] );
print ( '-depsc', '-r600', 'Fig4_blocks');
print('-r600', 'Fig4_blocks','-dtiff');


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
  titleList = unique(fileCaption{iSet}, 'stable');
  for iFile = 1:nFileOfInterest     
    trueFileIndex = fileOfInterest{iSet}(iFile);
    isOwnChoice = allOwnChoice{iSet,trueFileIndex};
    sideChoice = allSideChoice{iSet,trueFileIndex};
    maxXvalue = length(isOwnChoice(1,:));
    figure
    set( axes,'fontsize', FontSize,  'FontName', 'Arial');%'FontName', 'Times');  
    totalReward = 1 + 2.5*(isOwnChoice(1,:)+isOwnChoice(2,:));
    totalReward(totalReward == 6) = 2;
    subplot(5, 1, 1);
    plot(totalReward, 'k-', 'linewidth', lineWidth);
    set( gca, 'fontsize', FontSize,  'FontName', 'Arial');%'FontName', 'Times');  
    axis([0.8, maxXvalue + 0.2, 0.5, 4.9]);
    legendHandle = legend('Joint reward', 'location', 'NorthWest');  
    set(legendHandle, 'fontsize', FontSize-6,  'FontName', 'Arial');%'FontName', 'Times', 'Interpreter', 'latex');
    title(titleList{trueFileIndex}, 'fontsize', FontSize,  'FontName', 'Arial');%'FontName', 'Times', 'Interpreter', 'latex');

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
    set( gca, 'fontsize', FontSize,  'FontName', 'Arial', 'yTick', [0,0.5,1]);%'FontName', 'Times');  
    axis([0.8, maxXvalue + 0.01, -0.01, 1.8]);
    legendHandle = legend([h1, h2], 'Share own choices P1', 'Share own choices P2', 'location', 'NorthWest');  
    set(legendHandle, 'fontsize', FontSize-6,  'FontName', 'Arial');%'FontName', 'Times', 'Interpreter', 'latex'); 

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
    set( gca, 'fontsize', FontSize,  'FontName', 'Arial');%'FontName', 'Times');  
    axis([0.8, maxXvalue + 0.2, 1.01*minValue, 1.1*maxValue]);  
    legendHandle = legend([h1, h2, h3, h4], '$\mathrm{te_{P1\rightarrow P2}}$', '$\mathrm{te_{P2\rightarrow P1}}$', '$\mathrm{TE_{P1\rightarrow P2}}$', '$\mathrm{TE_{P2\rightarrow P1}}$', 'location', 'NorthWest');  
    set(legendHandle, 'fontsize', FontSize-6, 'FontName', 'Times', 'Interpreter', 'latex');

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
    set( gca, 'fontsize', FontSize,  'FontName', 'Arial', 'yTick', [0,0.5,1]);%'FontName', 'Times');  
    axis([0.8, maxXvalue + 0.2, -0.01, 1.8]);
    legendHandle = legend([h1, h2], 'Share left choices P1', 'Share left choices P2', 'location', 'NorthWest');  
    set(legendHandle, 'fontsize', FontSize-6,  'FontName', 'Arial');%'FontName', 'Times', 'Interpreter', 'latex'); 

    subplot(5, 1, 5);
    hold on
    if (~isempty(blockBorder{iSet}))
      fill([blockBorder{iSet}(iFile,:), blockBorder{iSet}(iFile,2:-1:1)], ...
           [0, 0, 1.01*maxMIvalue, 1.01*maxMIvalue], [0.8,0.8,0.8]);
    end 
    h1 = plot(locMutualInf{iSet, trueFileIndex}, 'Color', [0.7, 0.3, 0.7], 'linewidth', lineWidth);
    h2 = plot(mutualInf{iSet, trueFileIndex}, 'Color', [0.4, 0.1, 0.4], 'linewidth', lineWidth+1);      
    hold off
    set( gca, 'fontsize', FontSize,  'FontName', 'Arial');%'FontName', 'Times');  
    %axis([0.8, maxXvalue + 0.2, 1.01*minMIvalue, 1.01*maxMIvalue]);  
    axis([0.8, maxXvalue + 0.2, 0, 1.01*maxMIvalue]);  
    legendHandle = legend([h1, h2], '$\mathrm{i(P1,P2)}$', '$\mathrm{MI(P1,P2)}$', 'location', 'NorthWest');  
    set(legendHandle, 'fontsize', FontSize-6, 'FontName', 'Times', 'Interpreter', 'latex');


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