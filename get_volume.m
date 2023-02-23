function [Modeled_Volume] = get_volume(Discharge_prist,ChannelSlope)

%volume equation
Modeled_Volume=3.9523E05.*((log(Discharge_prist)).^6.1417).*ChannelSlope.^0.10671;