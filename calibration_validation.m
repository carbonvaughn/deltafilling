%% Checking Calibration
clear
load('sedimentresults')
oldFolder=cd('')
filename='SedimentInfillCalibration.xlsx'
Calibration_BasinID=xlsread(filename,1,'B2:B101');
% [num,Calibration_Visual,raw]=xlsread(filename,1,'D2:D101'); % creates a cell array with Over and Under
Calibration_Visual=xlsread(filename,1,'E2:E101');
BasinID_rownumber=find(ismember(BasinIDnanremoved,Calibration_BasinID));
BasinID_rownumber(62)=[];

GlobalQ_Infill=QRiver_converted.*time_sediment;
OverUnder_19=Modeled_Volume_19-GlobalQ_Infill;
Final_OverUnder=OverUnder_19(BasinID_rownumber,500);

T=zeros(size(Final_OverUnder));
for ii = 1:length(Final_OverUnder)
    if Final_OverUnder(ii)>0
        T(ii)=1; % Underfilled
    else
        T(ii)=0; % Overfilled
    end
end

Accuracy=Calibration_Visual==T;
Correct=sum(Accuracy)
Incorrect=100-Correct

Accuracy_NoChange=Calibration_Visual==T;

New_Incorrect = Accuracy-Accuracy_NoChange;
Added_Incorrect=sum(New_Incorrect) 

% No Change in Sediment = 81 correctly identified
% Multiply Sediment by 2 = 73 correctly identified
% Multiply Sediment by 4 = 76 correct
% Multiply Sediment by 6 = 77 correct
% Multply by 8 = 75 correct... keeps being 75 with each increase after 8
% Multiply by 0.25 = 58 correct, 42 incorrect
% Multiply by 0.5 = 73 correct, 27 incorrect
% Multiply by 0.75, 0.80, 0.73, 0.72, 0.715 = 81 correct, 19 incorrect
% Multiply by 0.70, 71 = 80 correct, 19 incorrect
% Multiply by 7 = 75 correct
% Multiply by 5, 5.5, 6.2 = 77 correct
% Multiply by 6.5, 6.3 = 76 correct 

