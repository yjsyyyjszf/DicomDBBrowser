function dicomDBBrowser(varargin)      
%function dicomDBBrowser(varargin)
%DICOM Database Browser.
%See dicomDBBrowser.doc (or pdf) for more information about options.
%
%Note: option settings must fit on one line and can contain one semicolon at most.
%Options can be strings, cell arrays of strings, or numerical arrays.
%
%Author: Daniel Lafontaine, lafontad@mskcc.org
%
%Last specifications modified:
%
% Copyright 2020, Daniel Lafontaine, on behalf of the TriDFusion development team.
% 
% This file is part of The DICOM Database Browser (dicomDBBrowser).
% 
% TriDFusion development has been led by: Daniel Lafontaine
% 
% TriDFusion is distributed under the terms of the Lesser GNU Public License. 
% 
%     This version of dicomDBBrowser is free software: you can redistribute it and/or modify
%     it under the terms of the GNU General Public License as published by
%     the Free Software Foundation, either version 3 of the License, or
%     (at your option) any later version.
% 
% dicomDBBrowser is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
% without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
% See the GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
% along with dicomDBBrowser.  If not, see <http://www.gnu.org/licenses/>.

    initBrowserGlobal();
    
    initBrowserRootPath();
  
    browserMultiThread('set', false);
    browserFastSearch ('set', false);
    
    dScreenSize  = get(groot  , 'Screensize');

    dMainWindowSizeX = dScreenSize(3);
    dMainWindowSizeY = dScreenSize(4);

    dPositionX = (dScreenSize(3) /2) - (dMainWindowSizeX /2);
    dPositionY = (dScreenSize(4) /2) - (dMainWindowSizeY /2);    
   
    dlgWindows = ...
        dialog('Position', [dPositionX ...
                            dPositionY ...
                            dMainWindowSizeX ...
                            dMainWindowSizeY ...
                            ],...
                'Name'    , 'DICOM DB Browser',...
                'units'   , 'normalized',...
                'resize'  , 'on',...
                'SizeChangedFcn',@resizeBrowserDialog...
              );
    dlgBrowserWindowsPtr('set', dlgWindows);
    
    dDlgPosition = get(dlgWindows, 'position');

    dDialogSize = dScreenSize(4) * dDlgPosition(4); 
    yPosition   = dDialogSize - 30;

    xSize = dScreenSize(3) * dDlgPosition(3); 
    ySize = dDialogSize - 30;                    
    
    uiMainWindow = ...
        uipanel(dlgWindows,...
                'Units'   , 'pixels',...
                'position', [0 ...
                             30 ...
                             xSize ...
                             ySize-30 ...
                             ],...
                'title'   , 'DICOM Database List'...
                );
    uiBrowserMainWindowPtr('set', uiMainWindow);
                    
    uiProgressWindow = ...
        uipanel(dlgWindows,...
                'Units'   , 'pixels',...
                'position', [0 ...
                             0 ...
                             xSize ...
                             30 ...
                             ],...
                'title'   , 'Ready'...
                );                    
    uiBrowserProgressWindowPtr('set', uiProgressWindow);
                    
    lbDBWindow = ...
        uicontrol(uiMainWindow,...
                  'style'   , 'listbox',...
                  'position', [0 ...
                               dDialogSize-75-250 ...
                               300 ...
                               250 ...
                               ],...
                  'fontsize', 10,...
                  'Fontname', 'Monospaced',...
                  'Value'   , 1 ,...
                  'Selected', 'on',...
                  'enable'  , 'on',...
                  'string'  , ' ',...
                  'Callback', @lbBrowserDBWindowCallback...
                  );
    lbBrowserDBWindowPtr('set', lbDBWindow);
    
    set(lbDBWindow,'Max',1,'Min',0);
 
    initBrowserJFolderChooser();

    txtCurrentDirectory =  ...
        uicontrol(dlgWindows,...
                  'style'     , 'text',...
                  'string'    , 'Current Directory',...
                  'FontWeight', 'Bold', ...
                  'horizontalalignment', 'center',...
                  'position'  , [5 ...
                                 dDialogSize-75-250-20-10 ...
                                 290 ...
                                 20 ...
                                 ]...
                  );
    txtBrowserCurrentDirectoryPtr('set', txtCurrentDirectory);
                           
    edtCurrentDirectory =  ...
        uicontrol(dlgWindows,...
                  'enable'    , 'on',...
                  'style'     , 'edit',...
                  'Background', 'white',...
                  'string'    , '',...
                  'position'  , [5 ...
                                 dDialogSize-75-250-20-40 ...
                                 290 ...
                                 25 ...
                                 ],...
                  'Callback'  , @browserCurrentDirectoryCallback...
                  );   
    edtBrowserCurrentDirectoryPtr('set', edtCurrentDirectory);
 
    uiPathSelect = ...
        uicontrol(dlgWindows, ...
                  'Style'   , 'popup', ...
                  'position', [5 ...
                               dDialogSize-75-250-20-70 ...
                               290 ...
                               25 ...
                               ],...
                  'String'  , getBrowserDrivesList(), ...
                  'Value'   , 1,...
                  'FontSize', 10, ...
                  'Enable'  , 'on', ...
                  'Callback', @browseDrivesListCallback...
                  );  
    edtBrowserPathSelectPtr('set', uiPathSelect);
  
    lbDirectoryWindow = ...
        uicontrol(uiMainWindow,...
                  'style'   , 'listbox',...
                  'position', [5 ...
                               5 ...
                               290 ...
                               dDialogSize-75-250-20-110 ...
                               ],...
                  'fontsize', 10,...
                  'Fontname', 'Monospaced',...
                  'Value'   , 1 ,...
                  'Selected', 'on',...
                  'enable'  , 'on',...
                  'string'  , ' ',...
                  'Callback', @lbBrowserDirectoryWindowCallback...
                  );
    lbBrowserDirectoryWindowPtr('set', lbDirectoryWindow);

    set(lbDirectoryWindow,'Max',1,'Min',0);
    
    lbMainWindow = ...
       uicontrol(uiMainWindow,...
                 'style'   , 'listbox',...
                 'position', [300 ...
                              0 ...
                              xSize-300 ...
                              dDialogSize-100 ...
                              ],...
                 'fontsize', 10,...
                 'Fontname', 'Monospaced',...
                 'Value'   , 1 ,...
                 'Selected', 'on',...
                 'enable'  , 'on',...
                 'string'  , ' ',...
                 'Callback', @lbBrowserMainWindowCallback...
                 );
    lbBrowserMainWindowPtr('set', lbMainWindow);
                    
    set(lbMainWindow, 'Max',2, 'Min',0);
                     
    btnPatientName = ...
         uicontrol(uiMainWindow,...
                   'Position', [300 ...
                                dDialogSize-100 ...
                                180 ...
                                20 ...
                                ],...
                   'enable'  , 'off',...
                   'String'  , 'PATIENTNAME',...
                   'Callback', @browserSortCallback...                   
                   );    
    btnBrowserPatientNamePtr('set', btnPatientName);
                   
    btnPatientID = ...
         uicontrol(uiMainWindow,...
                   'Position', [480 ...
                                dDialogSize-100 ...
                                95 ...
                                20 ...
                                ],...
                   'enable'  , 'off',...
                   'String'  , 'PATIENTID',...
                   'Callback', @browserSortCallback...                   
                   );    
    btnBrowserPatientIDPtr('set', btnPatientID);
                    
    btnStudyDate = ...
         uicontrol(uiMainWindow,...
                   'Position', [575 ...
                                dDialogSize-100 ...
                                95 ...
                                20 ...
                                ],...
                   'enable'  , 'off',...
                   'String'  , 'STUDYDATE',...
                   'Callback', @browserSortCallback...                   
                   ); 
    btnBrowserStudyDatePtr('set', btnStudyDate);
                    
    btnAccession = ...
         uicontrol(uiMainWindow,...
                   'Position', [670 ...
                                dDialogSize-100 ...
                                95 ...
                                20 ...
                                ],...
                   'enable'  , 'off',...
                   'String'  , 'ACCESSION',...
                   'Callback', @browserSortCallback...                   
                   ); 
    btnBrowserAccessionPtr('set', btnAccession);
                    
    btnStudyDesc = ...
         uicontrol(uiMainWindow,...
                   'Position', [765 ...
                                dDialogSize-100 ...
                                250 ...
                                20 ...
                                ],...
                   'enable'  , 'off',...
                   'String'  , 'STUDYDESCRIPTION',...
                   'Callback', @browserSortCallback...                   
                   ); 
    btnBrowserStudyDescPtr('set', btnStudyDesc);
                    
    btnSeriesDesc = ...
         uicontrol(uiMainWindow,...
                   'Position', [1015 ...
                                dDialogSize-100 ...
                                325 ...
                                20 ...
                                ],...
                   'enable'  , 'off',...
                   'String'  , 'SERIESDESCRIPTION',...
                   'Callback', @browserSortCallback...                   
                   ); 
    btnBrowserSeriesDescPtr('set', btnSeriesDesc);
                    
    btnLocation = ...
         uicontrol(uiMainWindow,...
                   'Position', [1340 ...
                                dDialogSize-100 ...
                                xSize-1243 ...
                                20 ...
                                ],...
                   'enable'  , 'off',...
                   'String'  , 'LOCATION',...
                   'Callback', @browserSortCallback...                   
                   ); 
    btnBrowserLocationPtr('set', btnLocation);
                    
    uiSearchBy = ...
        uicontrol(dlgWindows, ...
                  'Style'   , 'popup', ...
                  'position', [5 ...
                               yPosition ...
                               153 ...
                               25 ...
                               ],...
                  'String'  , {'Patient Name'      , ...
                               'Patient ID'        , ...
                               'Study Date'        , ...
                               'Study description' , ...
                               'Series description', ...
                               'Accession Number' ...
                               }, ...
                  'Value'   , 2 ,...
                  'FontSize', 10, ...
                  'Enable'  , 'on' ...
                  );  
    uiBrowserSearchByPtr('set', uiSearchBy);
                         
    edtFindValue =  ...
        uicontrol(dlgWindows,...
                  'enable'    , 'on',...
                  'style'     , 'edit',...
                  'Background', 'white',...
                  'string'    , '',...
                  'position'  , [160 ...
                                 yPosition ...
                                 200 ...
                                 25 ...
                                 ],...
                  'Callback'  , @browserSearchTagCallback...
                  );   
    edtBrowserFindValuePtr('set', edtFindValue);
                     
    btnSearchTag = ...
        uicontrol(dlgWindows,...
                  'Position', [360 ...
                               yPosition-1 ...
                               50 ...
                               27 ...
                               ],...
                  'enable'  , 'on',...
                  'String'  , 'Search',...
                  'Callback', @browserSearchTagCallback...
                  );                     
    btnBrowserSearchTagPtr('set', btnSearchTag);                    
                    
    btnAddDB = ...
         uicontrol(uiMainWindow,...
                   'Position', [0 ...
                                dDialogSize-75-250-20 ...
                                300 ...
                                20 ...
                                ],...
                   'enable'  , 'on',...
                   'String'  , 'Add Database',...
                   'Callback', @browserAddDBCallback...
                   ); 
    btnBrowserAddDBPtr('set', btnAddDB);                    
                                        
    btnOptions = ...
         uicontrol(dlgWindows,...
                   'Position', [420 ...
                                yPosition ...
                                100 ...
                                25 ...
                                ],...
                   'String'  , 'Options',...
                   'enable'  , 'on',...
                   'Callback', @setBrowserOptionsCallback...
                   );
    btnBrowserOptionsPtr('set', btnOptions);                    
                    
    btnViewHeader = ...
         uicontrol(dlgWindows,...
                   'Position', [521 ...
                                yPosition ...
                                100 ...
                                25 ...
                                ],...
                   'enable'  , 'off',...
                   'String'  , 'View Header',...
                   'Callback', @browserViewHeaderCallback...
                   );                      
    btnBrowserViewHeaderPtr('set', btnViewHeader);                    
                    
    btnDicomViewer = ...
         uicontrol(dlgWindows,...
                   'Position', [622 ...
                                yPosition ...
                                100 ...
                                25 ...
                                ],...
                   'enable'  , 'off',...
                   'String'  , 'TriDFusion',...
                   'Callback', @browserDicomViewerCallback...
                   );    
    btnBrowserDicomViewerPtr('set', btnDicomViewer);                    
    
    btnCerr = ...
         uicontrol(dlgWindows,...
                   'Position', [723 ...
                                yPosition ...
                                100 ...
                                25 ...
                                ],...
                   'enable'  , 'off',...
                   'String'  , 'CERR',...
                   'Callback', @browserCerrCallbak...
                   );    
    btnBrowserCerrPtr('set', btnCerr);     
    
    btnRunCommand = ...
         uicontrol(dlgWindows,...
                   'Style'        , 'pushbutton', ...
                   'Position'     , [833 ...
                                     yPosition ...
                                     200 ...
                                     25 ...
                                     ],...
                   'enable'       , 'off',...
                   'ButtonDownFcn', @btnBrowserMenuCallback,...
                   'Callback'     , @btnBrowserRunCallback...
                   ); 
    btnBrowserRunCommandPtr('set', btnRunCommand);                         
               
    btnBrowserHelp = ...
        uicontrol(dlgWindows,...
                  'Position', [xSize-106 ...
                               yPosition ...
                               50 ...
                               25 ...
                               ],...
                  'enable'  , 'on',...
                  'String'  , 'Help',...
                  'Callback', @helpBrowserCallback...
                  );                 
    btnBrowserHelpPtr('set', btnBrowserHelp);
    
    btnBrowserAbout = ...
        uicontrol(dlgWindows,...
                  'Position', [xSize-55 ...
                               yPosition ...
                               50 ...
                               25 ...
                               ],...
                  'enable'  , 'on',...
                  'String'  , 'About',...
                  'Callback', @aboutBrowserCallback...
                  );                          
    btnBrowserAboutPtr('set', btnBrowserAbout);
                  
    dlgWindows.WindowState = 'maximized';
    waitfor(dlgWindows, 'WindowState', 'maximized');
        
%    warning('off','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');  
    
%    javaFrame = get(dlgWindows, 'JavaFrame');
%    javaFrame.setFigureIcon(javax.swing.ImageIcon('./logo.png'));
    
%   [img,map] = imread('.\icons\play.png');
%   img = double(img)/255;
%   set(btnRunCommand,'CData', img);           
               
    set(dlgWindows, 'WindowButtonDownFcn', @browserClickDown);

    gsBrowserMainWindowDisplayPtr('set', '');    

    initBrowserDcm4che3();

    browserCurrentDBPath('set', '');
    browserDBList('clear');
    browserCancelSearch('set', false);
    browserRunAppList('set', '');
    
    uiBar = uipanel(uiBrowserProgressWindowPtr('get'));
    uiBrowserProgressBarPtr('set', uiBar);
    
    initBrowserDisclamer();           
  
    initBrowserDatabase();

    initBrowserRunApplication();
    
    initBrowserDoubleClick('Open Containing Folder');               

end



