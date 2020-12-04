function browseDrivesListCallback(hObject, ~)
%function browseDrivesListCallback(hObject, ~)
%Popup Menu Drive List ui Callback.
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

    hjFileChooser = hjBrowserFileChooserPtr('get');

    asNewDir = get(hObject, 'String');
    sNewDir  = char(asNewDir(get(hObject, 'Value')));
    
    if ispc
        sNewDir = sNewDir(end-3:end-1);
    end

    if ~strcmpi(sNewDir(end), '/') && ...
       ~strcmpi(sNewDir(end), '\')
        sNewDir = [sNewDir '/'];      
    end

    asNewPath = dir(sNewDir);
    sNewPath = asNewPath(1).folder;


    set(edtBrowserCurrentDirectoryPtr('get'), 'String', sNewPath);

    browserUpdateDirectoryWindow(sNewPath);

    hjFileChooser.setCurrentDirectory(java.io.File(sNewPath));        
end