function [Carbon_Infill,Carbon_per_delivered,Carbon_Nonburial,Carbon_Export,Carbon_Lost] = get_Carbon(time,delta_poc,Discharge_prist,ChannelSlope,QRiver_converted)

time=6000;
datapoints=500;
time_sediment=linspace(0,time,datapoints);
Modeled_Volume=(3.9523E05.*((log(Discharge_prist)).^6.1417).*ChannelSlope.^0.10671);
GlobalQ_Infill=QRiver_converted.*time_sediment; 
OverUnder_Fill=(GlobalQ_Infill-Modeled_Volume)<0;
OverUnder_Lose=(GlobalQ_Infill-Modeled_Volume)>0;
%OverUnder_Sum=sum((GlobalQ_Infill-Modeled_Volume)<0,2);
mean_POC=mean(delta_poc,2);
Carbon_Infill=0.22.*12.*mean_POC.*OverUnder_Fill;
Carbon_per_delivered=(Carbon_Infill./(sum(12.*mean_POC))).*100;
Carbon_Nonburial=(1-0.22).*12.*mean_POC.*OverUnder_Fill;
Carbon_Export=12.*mean_POC.*OverUnder_Lose; % does not need 0.22 because there is no burial factor
Carbon_Lost=Carbon_Nonburial+Carbon_Export;

