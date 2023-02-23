% This code takes the best valley volume model, determined by the Valley
% Volume model code, and estimates valley volume for all rivers in the
% dataset. The volumes and uncertainties are then plotted against sediment
% discharge.
% Code also estimates the amount of sediment delivered to the valleys and
% determine, based on this delivery and valley volume, how long it takes
% the valley to fill assuming 100% burial efficiency. 

clear
% data_dir = enter your data directory here
filename='GlobalDeltaData.mat'
load([data_dir filename])

%% Removing channels with nan for a slope
index=isnan(ChannelSlope);
ChannelSlope(index)=[];
Discharge_prist(index)=[];
QRiver_prist(index)=[];
BasinID(index)=[];
MouthLat(index)=[];
MouthLon(index)=[];
Region(index)=[];
BasinArea(index)=[];

%% Estimating Valley Volume
[Modeled_Volume] = get_volume(Discharge_prist,ChannelSlope);
[Modeled_Volume_dist] = get_volume_montecarlo(Discharge_prist,ChannelSlope); 
Volume_uncertainty_mean=mean(Modeled_Volume_dist,2);
sum(Volume_uncertainty_mean)
[M,I]=min(Modeled_Volume);
Volume_uncertainty_max=Volume_uncertainty_mean(I);

%% Sediment Discharge
% Q is in kg/s --> convert to m^3, 
% use a sediment density of 1600 kg/m3 based on Sharma 1997
% need to multiply by 19,710... 19,710 comes from 365, if use 365.25 get 19,723.5
QRiver_converted=QRiver_prist.*19710;
time=6000;

%% Discharge vs. Volume graph
scatter(QRiver_converted,Modeled_Volume,...
    max(10,(sqrt(QRiver_converted))/100),[0.8 0.8 0.8],'filled')
set(gca,'XScale','log','YScale','log','XLim',[1e3 1e9],'YLim',[1e0 1e12],'box','on')
hold on
x_edg=[logspace(3,9,10)];
%x_edg=[1E3 1.5E3 1E4 1.5E4 1E5 1.5E5 1E6 1.5E6 1E7 1.5E7 1E8 max(QRiver_converted)];
[y]=discretize(QRiver_converted(QRiver_converted>1E3),x_edg);
Volume_y=accumarray(y,Modeled_Volume(QRiver_converted>1E3),[],@nanmedian);
%Volume_y_std=accumarray(y,var(Modeled_Volume_dist(QRiver_converted>1E3),1,1),[],@(x)(sqrt(nanmean(x))./sqrt(numel(x))));
Volume_y_std=accumarray(y,Volume_uncertainty_mean(QRiver_converted>1E3),[],@(x)(sqrt(nanmean(x))./sqrt(numel(x))));
errorbar([x_edg(1:end-1)+diff(x_edg(1:end))/2],Volume_y(1:end),Volume_y_std(1:end),'-ok','MarkerFaceColor','k','LineWidth',1.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
set(gca,'XScale','log','FontSize',13)
xlabel('Fluvial Sediment Flux (m^3 yr^-^1)','FontSize',14)
ylabel('Valley Volume (m^3)','FontSize',14)
[~,objh]=legend({"Modeled Volumes","Binned Medians" + newline + "\pm std error of the mean"},'FontSize',14)
objh1=findobj(objh,'type','scatter');
set(objh1,'Markersize',14);
%legend boxoff

%% OverUnder and Infill Estimtes - using get_Infill.m function
[OverUnder,Infill_total] = get_Infill(time,Discharge_prist,ChannelSlope,QRiver_converted,MouthLat);
[Under_dist,Over_dist,Vol2Fill_dist,Infill_total_dist] = get_infill_montecarlo(time,Discharge_prist,ChannelSlope,QRiver_converted,MouthLat);

OverUnder_end=OverUnder(:,500);
idx_Over=OverUnder_end<0;
OverUnder_end(idx_Over,:)=-1;
idx_Under=OverUnder_end>0;
OverUnder_end(idx_Under,:)=1;

Under=(sum(OverUnder>0)/length(OverUnder))*100;
Under_dist_SE=(std(Under_dist,[],2))./(sqrt(size(Under_dist,2)));
Over=(sum(OverUnder<0)/length(OverUnder))*100;
Over_dist_SE=(std(Over_dist,[],2))./(sqrt(size(Over_dist,2)));
Vol2Fill=sum((OverUnder>0).*OverUnder);
Vol2Fill_dist_SE=(std(Vol2Fill_dist,[],2))./(sqrt(size(Vol2Fill_dist,2)));
Infill_total_sum=sum(Infill_total);
Infill_total_dist_SE=(std(Infill_total_dist,[],2))./(sqrt(size(Infill_total_dist,2)));

save('sedimentresults')