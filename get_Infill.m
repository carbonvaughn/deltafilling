function [OverUnder,Infill_total] = get_Infill(time,Discharge_prist,ChannelSlope,QRiver_converted,MouthLat)

time=6000;
datapoints=500;
time_sediment=linspace(0,time,datapoints);
Modeled_Volume=3.9523E05.*((log(Discharge_prist)).^6.1417).*ChannelSlope.^0.10671;
GlobalQ_Infill=QRiver_converted.*time_sediment; 
OverUnder=Modeled_Volume-GlobalQ_Infill;
Infill=GlobalQ_Infill.*(OverUnder>0);

a=(OverUnder<0)==1;
% [rows,columns]=size(Infill);
% lastNonZeroColumn=zeros(rows,1);
% dataValues=zeros(rows,1);
% for row=1:rows
%     col=find(Infill(row,:),1,'last');
%     if ~isempty(col)
%         lastNonZeroColumn(row)=col;
%         dataValues(row)=Infill(row,col);
%     end
% end
%M=dataValues';
%Infill_end=a.*dataValues;
Infill_end=a.*Modeled_Volume;
Infill_total=Infill+Infill_end;
