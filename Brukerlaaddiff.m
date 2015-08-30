%
%
%
% matNMR v. 3.9.0 - A processing toolbox for NMR/EPR under MATLAB
%
% Copyright (c) 1997-2009  Jacco van Beek
% jabe@users.sourceforge.net
%
%
% This program is free software; you can redistribute it and/or
% modify it under the terms of the GNU General Public License
% as published by the Free Software Foundation; either version 2
% of the License, or (at your option) any later version.
% 
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software
% Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
%
% --> gpl.txt
%
% Should yo be too lazy to do this, please remember:
%    - The code may be altered under the condition that all changes are clearly marked 
%      with your name and the date and that none of the names currently present in the 
%      code are removed.
%
% Furthermore:
%    -Please update the BugFixes.txt (i.e. the changelog file)!
%    -Please inform me of useful changes and annoying bugs!
%
% Jacco
%
%
% ====================================================================================
%
%
%Brukerlaad.m calls a routine with which binary Bruker files can be read from disk
%20-07-'00

%try
  DiffNMR.Mode = 'spec';
  %Убураем второй график, он нам сейчас будет только мешаться.
  set(handles.mDisplayDifferens,'Checked','off')
  set(handles.axes2,'Visible','off')
  guidata(hObject,handles)
  
  %удаляю остатки от axes2, смотри файл plotdiff
  delete(allchild(handles.axes2))
      
  
  
  DiffNMR.FileName = 0;
  QmatNMR.Xtext = '';
  
  if isfield(DiffNMR,'PathName')
      [QTEMP1, QTEMP2] = uigetfile('*.*', 'Select Bruker Spectrum File to Open',[DiffNMR.PathName filesep '2rr']);
  else
    [QTEMP1, QTEMP2] = uigetfile('*.*', 'Select Bruker Spectrum File to Open',[pwd filesep '2rr']);
  end
  
  if (~isequal(QTEMP1, 0) & ~isequal(QTEMP2, 0))
    DiffNMR.FileName = QTEMP1;
    DiffNMR.PathName = QTEMP2;
    if strcmp(DiffNMR.FileName,'2rr')
        DiffNMR.Fname = [DiffNMR.PathName DiffNMR.FileName];
        DiffNMR.Xsize = dir(DiffNMR.Fname);
        regelBrukerSpectrareaddiff %этот скрипт производит чтение из файла
        set(DiffNMR.MainFigure,'Name',['Fittexp ' DiffNMR.PathName DiffNMR.FileName])
        DiffNMR.NSpec=1; %Это счетчик для кнопок Next и Back
        
        %Нижеследующий код производит заполнение полей edit данными считанными из
        %файла оброботки диффузиноного затухания.
        set(handles.edTau,'String',num2str(DiffNMR.Tau*1e+3));
        set(handles.edBigdelta,'String',num2str(DiffNMR.BigDelta*1e+3));
        set(handles.edLittledelta,'String',num2str(DiffNMR.LittleDelta*1e+3));
        switch round(DiffNMR.Gamma);   %Hz/G
            case 4258           %1H
                set(handles.pmNucleus,'Value',2);
            case 654            %2D 
                set(handles.pmNucleus,'Value',3);
            case 1655           %7Li
                set(handles.pmNucleus,'Value',4);
            case 1366           %11B
                set(handles.pmNucleus,'Value',5);
            case 4005           %19F
                set(handles.pmNucleus,'Value',6);
        end
        
        set(handles.edCoefDiff1,'String','CoefDiff'); %этот блок отвечает за 
        set(handles.edCoef1,'String','coef');      %обнуление полей данных 
        set(handles.edCoefDiff2,'String','CoefDiff');
        set(handles.edCoef2,'String','coef');
        set(handles.edCoefDiff3,'String','CoefDiff');
        set(handles.edCoef3,'String','coef');
        set(handles.edCoefDiff4,'String','CoefDiff');
        set(handles.edCoef4,'String','coef');
    else
        error('Дурак, не тот файл открываешь')
    end
  end

%catch
%
%call the generic error handler routine if anything goes wrong
%
%  errorhandler
%end


