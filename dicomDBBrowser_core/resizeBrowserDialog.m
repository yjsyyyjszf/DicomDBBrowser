function resizeBrowserDialog(hObject, ~)
%function resizeBrowserDialog(hObject, ~)
%Resize all ui and dialog base on Main Dialog Size and Position.
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

    dScreenSize  = get(groot  , 'Screensize');
    dDlgPosition = get(hObject, 'position');

    dDialogSize = dScreenSize(4) * dDlgPosition(4); 
    yPosition   = dDialogSize - 30;

    xSize = dScreenSize(3) * dDlgPosition(3); 
    ySize = dDialogSize - 30;

    if xSize < 970
        xSize = 970;
    end         

    if ~isempty(uiBrowserMainWindowPtr('get'))
        set(uiBrowserMainWindowPtr('get'), ...
            'position', [0 ...
                         30 ...
                         xSize ...
                         ySize-30 ...
                         ] ...
           );
    end

    if ~isempty(uiBrowserProgressWindowPtr('get'))
        set(uiBrowserProgressWindowPtr('get'), ...
            'position', [0 ...
                         0 ...
                         xSize ...
                         30 ...
                         ] ...
           );
    end

    if ~isempty(uiBrowserSearchByPtr('get'))
        set(uiBrowserSearchByPtr('get'), ...
            'position', [5 ...
                         yPosition ...
                         153 ...
                         25 ...
                         ] ...
           );
    end

    if ~isempty(edtBrowserFindValuePtr('get'))
        set(edtBrowserFindValuePtr('get'), ...
            'position', [160 ...
                         yPosition ...
                         200 ...
                         25 ...
                         ] ...
           );
    end

    if ~isempty(btnBrowserSearchTagPtr('get'))
        set(btnBrowserSearchTagPtr('get'), ...
            'position', [360 ...
                         yPosition-1 ...
                         50 ...
                         27 ...
                         ] ...
           );
    end

    if ~isempty(btnBrowserOptionsPtr('get'))
        set(btnBrowserOptionsPtr('get'), ...
            'position', [420 ...
                         yPosition ...
                         100 ...
                         25 ...
                         ] ...
           );
    end

    if ~isempty(btnBrowserViewHeaderPtr('get'))
        set(btnBrowserViewHeaderPtr('get'), ...
            'position', [521 ...
                         yPosition ...
                         100 ...
                         25 ...
                         ] ...
           );
    end

    if ~isempty(btnBrowserDicomViewerPtr('get'))
        set(btnBrowserDicomViewerPtr('get'), ...
            'position', [622 ...
                         yPosition ...
                         100 ...
                         25 ...
                         ] ...
           );
    end 
    
    if ~isempty(btnBrowserCerrPtr('get'))
        set(btnBrowserCerrPtr('get'), ...
            'position', [723 ...
                         yPosition ...
                         100 ...
                         25 ...
                         ] ...
           );
    end 
    
    if ~isempty(btnBrowserRunCommandPtr('get'))
        set(btnBrowserRunCommandPtr('get'), ...
            'position', [833 ...
                         yPosition ...
                         200 ...
                         25 ...
                         ] ...
           );
    end

    if ~isempty(lbBrowserDBWindowPtr('get'))
        set(lbBrowserDBWindowPtr('get'), ...
            'position', [0 ...
                         dDialogSize-75-250 ...
                         300 ...
                         250 ...
                         ] ...
           );
    end

    if ~isempty(btnBrowserAddDBPtr('get'))
        set(btnBrowserAddDBPtr('get'), ...
            'position', [0 ...
                         dDialogSize-75-250-20 ...
                         300 ...
                         20 ...
                         ] ...
           );
    end

    if ~isempty(txtBrowserCurrentDirectoryPtr('get'))          
        set(txtBrowserCurrentDirectoryPtr('get'), ...
            'position', [5 ...
                         dDialogSize-75-250-20-10 ...
                         290 ...
                         20 ...
                         ] ...
           );            
    end

    if ~isempty(edtBrowserCurrentDirectoryPtr('get'))
        set(edtBrowserCurrentDirectoryPtr('get'), ...
            'position', [5 ...
                         dDialogSize-75-250-20-40 ...
                         290 ...
                         25 ...
                         ] ...
           );            
    end

    if ~isempty(edtBrowserPathSelectPtr('get'))
        set(edtBrowserPathSelectPtr('get'), ...
            'position', [5 ...
                         dDialogSize-75-250-20-70 ...
                         290 ...
                         25 ...
                         ] ...
           );            
    end        

    if ~isempty(lbBrowserDirectoryWindowPtr('get'))    
        set(lbBrowserDirectoryWindowPtr('get'), ...
            'position', [5 ...
                         5 ...
                         290 ...
                         dDialogSize-75-250-20-110 ...
                         ] ...
           );            
    end                         

    if ~isempty(lbBrowserMainWindowPtr('get'))
        set(lbBrowserMainWindowPtr('get'), ...
            'position', [300 ...
                         0 ...
                         xSize-300 ...
                         dDialogSize-100 ...
                         ] ...
           );
    end                    

    if ~isempty(btnBrowserPatientNamePtr('get'))
        set(btnBrowserPatientNamePtr('get'), ...
            'position', [300 ...
                         dDialogSize-100 ...
                         180 ...
                         20 ...
                         ] ...
           );
    end

    if ~isempty(btnBrowserPatientIDPtr('get'))
        set(btnBrowserPatientIDPtr('get'), ...
            'position', [480 ...
                         dDialogSize-100 ...
                         95 ...
                         20 ...
                         ] ...
           );
    end

    if ~isempty(btnBrowserStudyDatePtr('get'))
        set(btnBrowserStudyDatePtr('get'), ...
            'position', [575 ...
                         dDialogSize-100 ...
                         95 ...
                         20 ...
                         ] ...
           );
    end

    if ~isempty(btnBrowserAccessionPtr('get'))
        set(btnBrowserAccessionPtr('get'), ...
            'position', [670 ...
                         dDialogSize-100 ...
                         95 ...
                         20 ...
                         ] ...
           );
    end

    if ~isempty(btnBrowserStudyDescPtr('get'))
        set(btnBrowserStudyDescPtr('get'), ...
            'position', [765 ...
                         dDialogSize-100 ...
                         250 ...
                         20 ...
                         ] ...
           );
    end

    if ~isempty(btnBrowserSeriesDescPtr('get'))
        set(btnBrowserSeriesDescPtr('get'), ...
            'position', [1015 ...
                         dDialogSize-100 ...
                         325 ...
                         20 ...
                         ] ...
           );
    end        

    if ~isempty(btnBrowserLocationPtr('get'))
        set(btnBrowserLocationPtr('get'), ...
            'position', [1340 ...
                         dDialogSize-100 ...
                         xSize-1243 ...
                         20 ...
                         ] ...
           );
    end    

    if ~isempty(btnBrowserHelpPtr('get'))
        set(btnBrowserHelpPtr('get'), ...
            'position', [xSize-106 ...
                         yPosition ...
                         50 ...
                         25 ...
                         ] ...
           );
    end

    if ~isempty(btnBrowserAboutPtr('get'))
        set(btnBrowserAboutPtr('get'), ...
            'position', [xSize-55 ...
                         yPosition ...
                         50 ...
                         25 ...
                         ] ...
           );
    end

end
