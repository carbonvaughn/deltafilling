function [Infill_sensitivity] = get_Infill_sensitivity(time,Discharge_prist,ChannelSlope,QRiver_converted)
[Infill_total] = get_Infill(time,Discharge_prist,ChannelSlope,QRiver_converted);
Infill_sensitivity=sum(Infill_total(:,end));
    