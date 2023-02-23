function [Carbon_sum_dist,Carbon_Infill_sum_dist,Carbon_cum_dist,Carbon_per_delivered_dist,Carbon_Export_dist,Carbon_Nonburial_dist,Carbon_Lost_dist] = get_carbon_montecarlo(time,delta_poc,Discharge_prist,ChannelSlope,QRiver_converted,MouthLat)

time=6000;
f_dist = @(x) (0.25+(1.5*rand(x,1)));
%Carbon_dist = nan(length(Discharge_prist),2000,'single');
len = numel(Discharge_prist);

for ii=1:2000,
    
    delta_poc_r = (mean(delta_poc,2)).*f_dist(len);
    QRiver_converted_r = QRiver_converted.*f_dist(len);
    time_r = (time-1000)+(f_dist(len).*1000);
    Discharge_prist_r = Discharge_prist.*f_dist(len);  
    ChannelSlope_r = ChannelSlope.*f_dist(len);
    
    [Carbon_Infill,Carbon_per_delivered,Carbon_Nonburial,Carbon_Export,Carbon_Lost] = get_Carbon(time_r,delta_poc_r,Discharge_prist_r,ChannelSlope_r,QRiver_converted_r);
    [Carbon_sum_dist(:,ii)] = sum(Carbon_Infill)';
    [Carbon_Infill_sum_dist(:,ii)] = sum(Carbon_Infill,2)';
    [Carbon_cum_dist(:,ii)] = cumsum(sum(Carbon_Infill))';
    [Carbon_per_delivered_dist(:,ii)]=sum(Carbon_per_delivered)';
    [Carbon_Export_dist(:,ii)]=sum(Carbon_Export)';
    [Carbon_Nonburial_dist(:,ii)]=sum(Carbon_Nonburial)';
    [Carbon_Lost_dist(:,ii)]=sum(Carbon_Lost)';

end

end
% Estimate uncertainty with a monte carlo analysis where we vary each input
% parameter randomly between -75% to +75% of its default estimate. The
% reported uncertainty is the standard error of the mean from 2000 sediment
% retention simulations. We also test for systematic errors. A sensitivity
% analysis indicates that delta topset retention estimates are most
% sensitive to delta age and fluvial sediment supply.

% Go through 2000 distributions individually, so each 1 goes through all
% rivers before going to the next distribution