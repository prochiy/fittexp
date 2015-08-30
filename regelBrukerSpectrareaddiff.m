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
%regelBrukerSpectraread.m reads a binary Bruker spectrum file from disk.
%2-4-'97

%try
  %if (QmatNMR.buttonList == 1)				%OK-button 
    %watch;
    disp('Please wait while matNMR is reading the spectrum ...');
  
    %QmatNMR.Fname = QmatNMR.uiInput1;
    %QTEMP = findstr(QmatNMR.Fname, filesep);		%extract the filename and path depending on the platform
    
    %QmatNMR.Xpath = deblank(QmatNMR.uiInput1(1:QTEMP(length(QTEMP))));
    %QmatNMR.Xfilename = deblank(QmatNMR.uiInput1((QTEMP(length(QTEMP))+1):length(QmatNMR.uiInput1)));
      
    %QmatNMR.namelast = QmatNMR.uiInput8;
    DiffNMR.namelast = 'QTEMPSpec';
    DiffNMR.ReadImaginaryFlag = 1;
    DiffNMR.ReadParameterFilesFlag = 1;
    DiffNMR.LoadINTOmatNMRDirectly = 0; 	%load into matNMR directly?
  
    %use standard parameter files for sizes etc
    QTEMP1 = DetermineBrukerSpectraRead(DiffNMR.PathName);
    DiffNMR.size1last = QTEMP1(1);
    DiffNMR.size2last = QTEMP1(2);
    DiffNMR.BlockingTD2 = QTEMP1(3);
    %
    %If no blocking is specified then the full size will be taken
    %
    if (DiffNMR.BlockingTD2 == 0)
       QTEMP3 = DiffNMR.size1last;
    else
        QTEMP3 = DiffNMR.BlockingTD2;
    end
  
    DiffNMR.BlockingTD1 = QTEMP1(4);
    %
    %If no blocking is specified then the full size will be taken
    %
    if (DiffNMR.BlockingTD1 == 0)
        QTEMP4 = DiffNMR.size2last;
    else
        QTEMP4 = DiffNMR.BlockingTD1;
    end
    DiffNMR.BrukerByteOrdering = QTEMP1(5);
      
    %
    %next we see whether we need to read in the imaginary parts as well
    %
    if (DiffNMR.ReadImaginaryFlag) 	%try to read the imaginary parts as well?
      if strcmp(DiffNMR.FileName, '1r')
        %check whether the imaginary parts exist on disk
        QTEMP21 = DiffNMR.Fname;
        QTEMP21(end-1:end) = '1i';
        if exist(QTEMP21, 'file')
          QTEMP20 = 1;
        else
          %
          %imaginary parts cannot be found on disk
          %
          DiffNMR.ReadImaginaryFlag = 0;
          disp('matNMR NOTICE: imaginary parts could not be found on disk and will be ignored!');
        end
  
      elseif strcmp(DiffNMR.FileName, '2rr')
        %check whether the imaginary parts exist on disk
        %If only 2ii is found then a non-hypercomplex matrix is assumed
        
        QTEMP23 = DiffNMR.Fname;
        QTEMP23(end-2:end) = '2ii';
        
        if (exist(QTEMP23, 'file'))
          QTEMP20 = 3; 		%no hypercomplex part
          disp('matNMR NOTICE: no hypercomplex parts were found, only loading the imaginary part');
        else
          %
          %imaginary parts cannot be found on disk
          %
          DiffNMR.ReadImaginaryFlag = 0;
          disp('matNMR NOTICE: imaginary/hypercomplex parts could not be found on disk and will be ignored!');
        end
      else
        %
        %filename is not 1r or 2rr and so we will neglect this option
        %
        DiffNMR.ReadImaginaryFlag = 0;
        disp('matNMR NOTICE: filename is not 1r or 2rr and therefore matNMR will NOT read the imaginary parts!');
      end
    end
  
  
    %
    %read the spectrum into the workspace
    %
       
    %spectral parameters found -> result is a matNMR structure
    eval([DiffNMR.namelast ' = GenerateMatNMRStructure;']);
    eval([DiffNMR.namelast '.SpectralFrequencyTD2 = QTEMP1(7);']);
    eval([DiffNMR.namelast '.SweepWidthTD2 = QTEMP1(8);']);
    eval([DiffNMR.namelast '.DefaultAxisRefPPMTD2 = QTEMP1(9);']);
    eval([DiffNMR.namelast '.DefaultAxisRefkHzTD2 = QTEMP1(10);']);
    if (length(QTEMP1) > 10) %здесь индексы увеличил на 2
        eval([DiffNMR.namelast '.SpectralFrequencyTD1 = QTEMP1(11);']);
        eval([DiffNMR.namelast '.SweepWidthTD1 = QTEMP1(12);']);
        %Вычисление гиромагнитного отношения Герц/Гаусс
        if  (400*0.99 < QTEMP1(11)) && (QTEMP1(11) < 400*1.01)
            if (400*0.99 < QTEMP1(7)) && (QTEMP1(7) < 400*1.01) % 1H
                eval([DiffNMR.namelast '.Gamma=26.75222208e+3/(2*pi);'])
            elseif (376.5*0.99 < QTEMP1(7)) && (QTEMP1(7) < 376.5*1.01) %19F
                eval([DiffNMR.namelast '.Gamma=25.16233e+3/(2*pi);'])
            elseif (155.5*0.99 < QTEMP1(7)) &&(QTEMP1(7) < 155.5*1.01)  %7Li
                eval([DiffNMR.namelast '.Gamma=10.397704e+3/(2*pi);']) 
            elseif (128.4*0.99 < QTEMP1(7)) && (QTEMP1(7) < 128.4*1.01) %11B
                eval([DiffNMR.namelast '.Gamma=8.584707e+3/(2*pi);'])
            elseif (61.4*0.99 < QTEMP1(7)) && (QTEMP1(7)< 61.4*1.01)    %2D
                eval([DiffNMR.namelast '.Gamma=4.10662919e+3/(2*pi);'])
            else
                disp('А для остальных ядер я еще не написал определение гиромагнитного отношения (см regelBrukerSpectrareaddiff.m)')
                beep
            end
        else
            disp('Для других спектрометров прописывать частоты для гиромагнитных отношений не хочется (см regelBrukerSpectrareaddiff.m)')
            beep
        end
    end
    eval([DiffNMR.namelast '.DefaultAxisCarrierIndexTD2 = floor(DiffNMR.size1last/2)+1;']);
    eval([DiffNMR.namelast '.DefaultAxisCarrierIndexTD1 = floor(DiffNMR.size2last/2)+1;']);
    eval([DiffNMR.namelast '.Spectrum = readBrukerProcessedData(DiffNMR.Fname, DiffNMR.size1last, DiffNMR.size2last, QTEMP3, QTEMP4, DiffNMR.BrukerByteOrdering);']);
  
    %set the FID status to spectrum for TD2 and TD1
    eval([DiffNMR.namelast '.FIDstatusTD2 = 1;']);
    eval([DiffNMR.namelast '.FIDstatusTD1 = 1;']);
  
    %store the file name in the structure
    eval([DiffNMR.namelast '.DataPath = DiffNMR.PathName;']);
    eval([DiffNMR.namelast '.DataFile = DiffNMR.FileName;']);
    if (DiffNMR.ReadImaginaryFlag) 	%try to read the imaginary parts as well
        if (QTEMP20 == 1)		%1D spectrum
          QTEMP21 = DiffNMR.Fname;
  	QTEMP21(end-1:end) = '1i';
          eval([DiffNMR.namelast '.Spectrum = ' DiffNMR.namelast '.Spectrum + sqrt(-1)*readBrukerProcessedData(QTEMP21, DiffNMR.size1last, DiffNMR.size2last, QTEMP3, QTEMP4, DiffNMR.BrukerByteOrdering);']);
  
          if (QTEMP1(6) == 1)		%if asked for reverse the spectrum
           eval([DiffNMR.namelast '.Spectrum = flipud(' DiffNMR.namelast '.Spectrum);']);
      	
          elseif (QTEMP1(6) == 2) 	%set status to FID
            eval([DiffNMR.namelast '.Spectrum = flipud(' DiffNMR.namelast '.Spectrum);']);
            eval([DiffNMR.namelast '.FIDstatusTD1 = 2;']);
          end
  
        
  
        elseif (QTEMP20 == 3) 	%2D spectrum without hypercomplex parts
          %then define the imaginary part and add that to the already-loaded real part
          QTEMP22 = DiffNMR.Fname;
  	QTEMP22(end-2:end) = '2ii';
          eval([DiffNMR.namelast '.Spectrum = ' DiffNMR.namelast '.Spectrum + sqrt(-1)*readBrukerProcessedData(QTEMP22, DiffNMR.size1last, DiffNMR.size2last, QTEMP3, QTEMP4, DiffNMR.BrukerByteOrdering);']);
  
          %reverse spectrum is asked for
          if (QTEMP1(6) == 1)		%if asked for reverse the spectrum
            eval([DiffNMR.namelast '.Spectrum = flipud(' DiffNMR.namelast '.Spectrum);']);
      	
          elseif (QTEMP1(6) == 2) 	%set status to FID
            eval([DiffNMR.namelast '.Spectrum = flipud(' DiffNMR.namelast '.Spectrum);']);
            eval([DiffNMR.namelast '.FIDstatusTD1 = 2;']);
          end
      end
  
    else	%no imaginary part
  
        if (QTEMP1(6) == 1)		%if asked for reverse the spectrum
          eval([DiffNMR.namelast '.Spectrum = flipud(' DiffNMR.namelast '.Spectrum);']);
    	
        elseif (QTEMP1(6) == 2) 	%set status to FID
          eval([DiffNMR.namelast '.Spectrum = flipud(' DiffNMR.namelast '.Spectrum);']);
          eval([DiffNMR.namelast '.FIDstatusTD1 = 2;']);
        end
    end
    
    
    % Чтение файла 'difflist', если конечно такой существует. Идею данного
    % код я подсмотрел в файле ReadParameterFile
    if exist([DiffNMR.PathName filesep filesep '..' filesep '..' filesep 'difflist'], 'file')
      QTEMP1 = ReadParameterFile([DiffNMR.PathName filesep '..' filesep '..' filesep 'difflist']);
      eval([DiffNMR.namelast '.DiffList = str2num(QTEMP1);']);
      eval([DiffNMR.namelast '.AxisTD1 = str2num(QTEMP1);']);
    else
        disp('файл difflist не существует')
      
    end
    
    
    %Чтение длительности диффузионного импульза, времени диффузии, и
    %времени между первыми двумя радиочастотными импульсами из файла acqus Идею данного
    %кода я подсмотрел в файле regeldefparDiff.
    if exist([DiffNMR.PathName filesep filesep '..' filesep '..' filesep 'acqus'], 'file')
      QTEMP_fp=fopen([DiffNMR.PathName filesep filesep '..' filesep '..' filesep 'acqus'],'r');
      while(feof(QTEMP_fp)==0)
          QTEMP_line=fgetl(QTEMP_fp);
          
          %диффузии и длительность диффузионного импульса записаны после
          %##$D= (0.. 21 число в массиве QTEMP_numsp - это время
          %диффузии, а 22 число длитетьность градиенного импульса.
          if strncmp(QTEMP_line,'##$D= (0..', 5)
              QTEMP_line=fgetl(QTEMP_fp);
              QTEMP_num1=sscanf(QTEMP_line,'%f ',inf);
              QTEMP_line=fgetl(QTEMP_fp);
              QTEMP_num2=sscanf(QTEMP_line,'%f ',inf);
              QTEMP_numsd=[QTEMP_num1;QTEMP_num2];
          end
      end
      
      DiffNMR.BigDelta=QTEMP_numsd(21); 
      DiffNMR.LittleDelta=QTEMP_numsd(22);
      DiffNMR.Tau=sum(QTEMP_numsd([19 17 3 10])); %время между в торым и первым радиочастотным импульсом.
      
  
      fclose(QTEMP_fp);
      eval([DiffNMR.namelast '.BigDelta = DiffNMR.BigDelta;']);
      eval([DiffNMR.namelast '.LittleDelta = DiffNMR.LittleDelta;']);
      eval([DiffNMR.namelast '.Tau = DiffNMR.Tau;']);
    else
        disp('Ну это уже мистика')
        beep;
        return
    end
    
    %расчет оси частот
    QTEMP=size(QTEMPSpec.Spectrum,2);
    QTEMP1=QTEMPSpec.SweepWidthTD2*1000/QTEMPSpec.SpectralFrequencyTD2/(QTEMP-1);
    QTEMPSpec.AxisTD2=((0:QTEMP-1)-QTEMP/2)*QTEMP1+QTEMPSpec.DefaultAxisRefPPMTD2;
    
    
  
  
    %
    %display status output
    %
    disp(['Finished loading Bruker spectrum ', DiffNMR.Fname, '. (', num2str(DiffNMR.size1last), ' x ', num2str(DiffNMR.size2last), ' points).']);
    disp(['The spectrum was saved in workspace as: ' DiffNMR.namelast]);
    %Arrowhead;
  
    %
    %finish by either loading the spectrum into matNMR or by only adding the name of the list
    %
    
    
  %сохраняем прочитанный спктр в рабочей области и структуре DiffNMR
  evalin('base','global Spec;')
  DiffNMR.newspec = QTEMPSpec;
  DiffNMR.Gamma = DiffNMR.newspec.Gamma;
  evalin('base','Spec = DiffNMR.newspec;') 
  %plotspecdiff;
  
  
  clear QTEMP*
  


