function [Modeled_Volume_dist] = get_volume_montecarlo(Discharge_prist,ChannelSlope)

f_dist = @(x) (0.25+(1.5*rand(x,1)));
Vol_dist = nan(length(Discharge_prist),2000,'single');
len = numel(Discharge_prist);

for ii=1:2000,
    
    Discharge_prist_r = Discharge_prist.*f_dist(len);  
    ChannelSlope_r = ChannelSlope.*f_dist(len);
           
    [Modeled_Volume_dist(:,ii)] = get_volume(Discharge_prist_r,ChannelSlope_r);
    
end

end
% Estimate uncertainty with a monte carlo analysis where we vary each input
% parameter randomly between -75% to +75% of its default estimate. The
% reported uncertainty is the standard error of the mean from 2000 sediment
% retention simulations. We also test for systematic errors. A sensitivity
% analysis indicates that delta topset retention estimates are most
% sensitive to delta age and fluvial sediment supply.