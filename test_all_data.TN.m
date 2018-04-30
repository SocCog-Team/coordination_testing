FontSize = 11;
lineWidth = 1.0;

order = 1;
%minSampleNum = 1.5*(2.^(order+1))*(2.^order);
%minSampleNum = 6*(2.^(order+1))*(2.^order);
minSampleNum = 6*(2.^(order+1))*(2.^order);

%folder = '';
folder = 'Z:\taskcontroller\SCP_DATA\ANALYSES\PC1000\2018\CoordinationCheck';

folder = fullfile('/', 'Volumes', 'social_neuroscience_data', 'taskcontroller', 'SCP_DATA', 'ANALYSES', 'PC1000', '2018', 'CoordinationCheck');
                 
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
  '2018.04.24'};

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
    
%Last points in each block
SMFlaffusBlockBorder = [172,	332; 164,	299; 166,	332; 162,	321; 168,	328; 161,	323];                
                  

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
                    
% filename - list of all files related to specific Set
% fileCaption - captions of files, adjacent files may have the same caption
% but the they are merged
SCAN_ALL_DATASET = 1;
%SCAN_ALL_DATASET = 0;
if (SCAN_ALL_DATASET)
  filename = {magnusCurius, flaffusCurius, flaffusEC, SMCurius, SMCuriusBlock, TNCurius, SMFlaffus, SMFlaffusBlock, FlaffusSM, humanPair, humanPairBlocked, SMhumanBlocked};
  fileCaption = {magnusCuriusCaption, flaffusCuriusCaption, flaffusECCaption, SMCuriusCaption, SMCuriusBlockCaption, TNCuriusCaption, SMFlaffusCaption, SMFlaffusBlockCaption, FlaffusSMCaption, humanPairCaption, humanPairBlockedCaption, SMhumanBlockedCaption};
  setName = {'MagnusCurius', 'FlaffusCurius', 'FlaffusEC', 'SMCurius', 'SMCuriusBlock', 'TNCurius', 'SMFlaffus', 'SMFlaffusBlock', 'FlaffusSM', 'HumanPairs', 'humanPairBlocked', 'SMhumanBlocked'};
else
  filename = {SMCuriusBlock, humanPairBlocked};
  fileCaption = {SMCuriusBlockCaption, humanPairBlockedCaption};
  setName = {'SMCuriusBlock', 'humanPairBlocked'};
end
plotName = {'TEtarget', 'MutualInf', 'surprise_pos'};             

nSet = length(setName);
nFile = cell2mat(cellfun(@(x) length(unique(x)), fileCaption, 'UniformOutput',false));
playerStrategy = cell(nSet, max(nFile));
playerNStateVisit = cell(nSet, max(nFile));
targetTE1 = cell(nSet, max(nFile));
targetTE2 = cell(nSet, max(nFile));
localTargetTE1 = cell(nSet, max(nFile));
localTargetTE2 = cell(nSet, max(nFile));
locMutualInf = cell(nSet, max(nFile));
mutualInf = cell(nSet, max(nFile));
allOwnChoice = cell(nSet, max(nFile));
allSideChoice = cell(nSet, max(nFile));
averReward = cell(nSet, max(nFile));
dltRewardBlock = cell(nSet, max(nFile));
dltSignif = cell(nSet, max(nFile));

miValueWhole = cell(nSet, max(nFile));
miSignifWhole = cell(nSet, max(nFile));
teWhole1 = cell(nSet, max(nFile));
teWhole2 = cell(nSet, max(nFile));
sideMIvalueWhole = cell(nSet, max(nFile));
sideMIsignifWhole = cell(nSet, max(nFile));
sideTEwhole1 = cell(nSet, max(nFile));
sideTEwhole2 = cell(nSet, max(nFile));


miValueBlock = cell(nSet, 1);
miSignifBlock = cell(nSet, 1);
teBlock1 = cell(nSet, 1);
teBlock2 = cell(nSet, 1);

sideMIvalueBlock = cell(nSet, 1);
sideMIsignifBlock = cell(nSet, 1);
sideTEblock1 = cell(nSet, 1);
sideTEblock2 = cell(nSet, 1);

coordStructBlock = cell(nSet, 3);
averageRewardBlock = cell(nSet, 1);
deltaRewardBlock = cell(nSet, 1);
deltaSignifBlock = cell(nSet, 1);

blockBorder = cell(nSet, 1);

pValueForMI = 0.01;

totalFileIndex = 1;
for iSet = 1:nSet 
  disp(['Processing dataset' num2str(iSet)]);
  maxValue = 0;
  minValue = 0;
  minMIvalue = 0;
  maxMIvalue = 0;

  miValueBlock{iSet} = NaN(nFile(iSet), 3);
  miSignifBlock{iSet} = NaN(nFile(iSet), 3);
  teBlock1{iSet} = NaN(nFile(iSet), 3);
  teBlock2{iSet} = NaN(nFile(iSet), 3);
  sideMIvalueBlock{iSet} = NaN(nFile(iSet), 3);
  sideMIsignifBlock{iSet} = NaN(nFile(iSet), 3);
  sideTEblock1{iSet} = NaN(nFile(iSet), 3);
  sideTEblock2{iSet} = NaN(nFile(iSet), 3);
  averageRewardBlock{iSet} = NaN(nFile(iSet), 3);
  deltaRewardBlock{iSet} = NaN(nFile(iSet), 3);
  deltaSignifBlock{iSet} = NaN(nFile(iSet), 3);
  
  if (strcmp(setName{iSet}, 'SMCuriusBlock'))  
    blockBorder{iSet} = SMCuriusBlockBorder;  
  else  
    blockBorder{iSet} = zeros(nFile(iSet), 2);
  end
  
  playerStrategy{iSet} = zeros(nFile(iSet), 8);
  playerNStateVisit{iSet} = zeros(nFile(iSet), 8);
  
  filenameIndex = 1;
  for iFile = 1:nFile(iSet)
    i = filenameIndex;
    isOwnChoice = [];
    sideChoice = [];
    % merge data for all files having the same caption
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
    
    % here we consider only stationary (stabilized) values
    testIndices = max(20, length(isOwnChoice) - 200):length(isOwnChoice);
%     [playerStrategy{iSet, iFile}, ...
%      playerNStateVisit{iSet, iFile}] = ...
%          estimate_strategy(isOwnChoice(:, testIndices), sideChoice(:,testIndices));

    [averReward{iSet, iFile}, ...
     dltReward{iSet, iFile}, ...
     dltSignif{iSet, iFile}] = ...
       calc_total_average_reward(isOwnChoice(:,testIndices), sideChoice(:,testIndices));    

    x = isOwnChoice(1, testIndices);
    y = isOwnChoice(2, testIndices);
    nTestIndices = length(testIndices);
    %target choices quantities
    [miValueWhole{iSet, iFile}, miSignifWhole{iSet, iFile}] = ...
        calc_whole_mutual_information(x, y, pValueForMI);            
    teValue = calc_transfer_entropy(y, x, order, nTestIndices);        
    teWhole1{iSet, iFile} = teValue(1);
    teValue = calc_transfer_entropy(x, y, order, nTestIndices); 
    teWhole2{iSet, iFile} = teValue(1);
        
    %side choices quantities
    x = sideChoice(1, testIndices);
    y = sideChoice(2, testIndices);
    [sideMIvalueWhole{iSet, iFile}, sideMIsignifWhole{iSet, iFile}] = ...
         calc_whole_mutual_information(x, y, pValueForMI);            
    teValue = calc_transfer_entropy(y, x, order, nTestIndices);        
    sideTEwhole1{iSet, iFile} = teValue(1);
    teValue = calc_transfer_entropy(x, y, order, nTestIndices); 
    sideTEwhole2{iSet, iFile} = teValue(1);
     
     
    coordStruct(totalFileIndex) = ...
            check_coordination(isOwnChoice(:,testIndices), sideChoice(:,testIndices));
    totalFileIndex = totalFileIndex + 1;
    
    %average joint reward
    totalReward = 1 + 2.5*(isOwnChoice(1,:)+isOwnChoice(2,:));
    totalReward(totalReward == 6) = 2;

    % compute local TE, MI and TE in windows
    x = isOwnChoice(1, :);
    y = isOwnChoice(2, :);
    targetTE1{iSet, iFile} = calc_transfer_entropy(y, x, order, minSampleNum);
    targetTE2{iSet, iFile} = calc_transfer_entropy(x, y, order, minSampleNum);
    localTargetTE1{iSet, iFile} = calc_local_transfer_entropy(y, x, order, minSampleNum);
    localTargetTE2{iSet, iFile} = calc_local_transfer_entropy(x, y, order, minSampleNum);
    
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
      blockIndices{1} = 20:invisibleStart-1;
      blockIndices{2} = (invisibleStart+20):invisibleEnd;
      if (invisibleEnd+21+minBlockLength <= dataLength)
      	blockIndices{3} = (invisibleEnd+21):dataLength;
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
        teValue = calc_transfer_entropy(y(index), x(index), order, blockLength);        
        teBlock1{iSet}(iFile, iBlock) = teValue(1);
        teValue = calc_transfer_entropy(x(index), y(index), order, blockLength); 
        teBlock2{iSet}(iFile, iBlock) = teValue(1);
        
        %side choices quantities
        [sideMIvalueBlock{iSet}(iFile, iBlock), sideMIsignifBlock{iSet}(iFile, iBlock)] = ...
            calc_whole_mutual_information(sideChoice(1,index), sideChoice(2,index), pValueForMI);            
        teValue = calc_transfer_entropy(sideChoice(2,index), sideChoice(1,index), order, blockLength);        
        sideTEblock1{iSet}(iFile, iBlock) = teValue(1);
        teValue = calc_transfer_entropy(sideChoice(1,index), sideChoice(2,index), order, blockLength); 
        sideTEblock2{iSet}(iFile, iBlock) = teValue(1);
        
        coordStructBlock{iSet, iBlock}(iFile) = ...
          check_coordination(isOwnChoice(:,index), sideChoice(:,index), 5*10^-5);
      end  
    end
    %isBottomChoice = sideChoiceObjectiveArray;    
  end  
  
  nFileCol = floor(sqrt(2*nFile(iSet)));
  nFileRow = ceil(nFile(iSet)/nFileCol); 
  figureTitle = {' Mutual Information', ' Transfer Entropy'};
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
