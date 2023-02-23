% Carbon Data code description
% First portion of code loads carbon data collected by Wim Joost at Utrecht
% University. Within this portion, we fit his lat/lon with ours so that we
% can match rivers. 

clear
load('sedimentresults.mat')

%% Carbon Data - Wim Joost data
% neglecting POCa (autochthonous), assuming it gets used up

data_dir=''
ncfile='POCt_export.nc';
POCt = ncread(ncfile,'DETRITUShighCNloadOUT');
%convert to kg carbon
POCt = permute(POCt,[3 2 1]).*12011;
POCt(isnan(POCt)) = 0;

time = ncread(ncfile,'time');
%convert time to datenum
time = datenum(1900,1,1)+(time/24);

lat = ncread(ncfile,'lat')';
lon = ncread(ncfile,'lon')';

%extract carbon fluxes at river mouths
z = geotiffread('outlets_pcrglob.tif');
basins = geotiffread('basins_pcrglob.tif');
cellarea = ncread('cellarea30min.nc','cellarea30min_map')./1e6';

%label connected outlets
L = bwlabel(z>0);

%find outlets connected to the ocean (eliminate endorheic basins)
[y,x] = find(L==1 & z==1); 
idx = sub2ind(size(z),y,x);

%plot gridded POC data
% figure,imagesc(squeeze(POCt(100,:,:)),[0 1e9])
% hold on
% scatter(x,y,'or'), axis ij

%put all poc fluxes to the ocean in array
rm_poct = POCt(:,idx);

%megatonnes export to ocean: 
mean(nansum(POCt(:,idx),2))./1e9 % 224 Megatons = 224 x 109 kg/yr

%global POC flux? (timestep is years)
%plot timeseries
% figure
% plot(time,nansum(POCt(:,idx),2)) 
% datetick('x'), xlabel('Year'), ylabel('POC flux to oceans (kg/yr)')

%complicated function to extract drainage basin area for the POC grid
basins(basins<1) = 9999;
basinarea = accumarray(basins(:),cellarea(:),[],@sum); basinarea = basinarea(1:2104);
[bb,id_b] = unique(basins(idx));
basinarea_poc = cellarea(idx);
basinarea_poc(id_b(1:end-1)) = basinarea(bb(1:end-1)); %in km2


%% Matching Wim's data with ours

%get delta data
out = load('GlobalDeltaData.mat');
out.MouthLon(out.MouthLon>180) = out.MouthLon(out.MouthLon>180)-360;

% figure, scatter(out.MouthLon,out.MouthLat,'b'), hold on
% scatter(lon(x),lat(y),'r')

%first define a matching parameter (i.e. points need to be close to each
%other, and their drainage basin sizes must be comparable
delta_coor = out.MouthLon+1i.*out.MouthLat;
poc_coor = lon(x)+1i.*lat(y);
blub = abs(poc_coor-delta_coor) +...
    (abs((basinarea_poc'-out.BasinArea)./out.BasinArea.*log10(out.BasinArea)))+...
    (abs(poc_coor-delta_coor)>8).*10;

idx2 = zeros(size(out.MouthLon));
delta_poc = zeros(length(out.MouthLon),length(time));
[~,delta_idx] = sort(out.BasinArea,'descend');
%now go from large to small drainage basin area and find best match
% poca
for ii=delta_idx'
    [d,idx2(ii)] = min(blub(ii,:));
    
    %don't match if machting parameter exceeds 50
    if d>50, idx2(ii) = 0; continue, end
    
    %set blub to infinite to make sure a POC flux is not matched twice
    blub(:,idx2(ii)) = inf;
    delta_poct(ii,:) = rm_poct(:,idx2(ii));
end

%figure, plot([rot90(delta_coor((1:50))); poc_coor(idx2(1:50))],'-o')

%plot amazon;
% plot(time,delta_poct(out.delta_name=='Amazon',:)), datetick('x'), xlabel('Year'), ylabel('POC flux to amazon (kg/yr)')
% gives 1.2-2.4 x 10^10

%total POC flux in megaton to all deltas (it seems that about 90% of POC
%drains through deltas, rest drains through non-deltaic river mouths (also greenland)
sum(mean(delta_poct,2))./1e9 % 218

%% Determine total POC flux over time in Individual Rivers
delta_poc=delta_poct;
delta_poc(index,:)=[];

[Carbon_Infill,Carbon_per_delivered,Carbon_Nonburial,Carbon_Export,Carbon_Lost] = get_Carbon(time,delta_poc,Discharge_prist,ChannelSlope,QRiver_converted);
[Carbon_sum_dist,Carbon_Infill_sum_dist,Carbon_cum_dist,Carbon_per_delivered_dist,Carbon_Export_dist,Carbon_Nonburial_dist,Carbon_Lost_dist] = get_carbon_montecarlo(time,delta_poc,Discharge_prist,ChannelSlope,QRiver_converted);
Carbon_Sum_uncertainty_mean=mean(Carbon_sum_dist,2);
Carbon_Infill_Sum_uncertainty_mean=mean(Carbon_Infill_sum_dist,2);
Carbon_Cum_uncertainty_mean=mean(Carbon_cum_dist,2);
Carbon_perdelivered_uncertainty_mean=mean(Carbon_per_delivered_dist,2);
Carbon_Export_uncertainty_mean=mean(Carbon_Export_dist,2);
Carbon_Nonburial_uncertainty_mean=mean(Carbon_Nonburial_dist,2);
Carbon_Lost_uncertainty_mean=mean(Carbon_Lost_dist,2);


time=6000;
datapoints=500;
time_sediment=linspace(0,time,datapoints);
x_edg=linspace(0,time,12);
[y]=discretize(time_sediment',x_edg);
Carbon_y=accumarray(y,(sum(cumsum(Carbon_Infill,2),1))/1E12,[],@nanmedian);
%Carbon_y_std=accumarray(y,var((Carbon_cum_dist/1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(numel(x))));
Carbon_y_std=accumarray(y,(Carbon_Cum_uncertainty_mean/1E12),[],@(x)(sqrt(nanmean(x))./sqrt(numel(x))));
errorbar([x_edg(1:end-1)+diff(x_edg(1:end))/2],Carbon_y(1:end),Carbon_y_std(1:end),'-ok','MarkerFaceColor','k','LineWidth',1.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
xlabel('Time (ka B.P.)')
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Cumulative POC Burial (10^1^2 kg)')

Carbon_Infill_sum=sum(Carbon_Infill./1E12);
Carbon_sum_dist_SE=(std(Carbon_sum_dist,[],2))./(sqrt(size(Carbon_sum_dist,2)));
Carbon_percent=sum(Carbon_per_delivered);
Carbon_percent_dist_SE=(std(Carbon_per_delivered_dist,[],2))./(sqrt(size(Carbon_per_delivered_dist,2)));
Carbon_Infill_cum=cumsum(sum(Carbon_Infill./1E12));
Carbon_cum_dist_SE=(std(Carbon_cum_dist,[],2))./(sqrt(size(Carbon_cum_dist,2)));
Carbon_Lost_cum=cumsum(sum(Carbon_Lost./1E12));
Carbon_Lost_cum_dist_SE=(std(Carbon_Lost_dist,[],2))./(sqrt(size(Carbon_Lost_dist,2)));
Carbon_Over_cum=cumsum(sum(Carbon_Export./1E12));
Carbon_Over_cum_dist_SE=(std(Carbon_Export_dist,[],2))./(sqrt(size(Carbon_Export_dist,2)));
Carbon_Nonburial_cum=cumsum(sum(Carbon_Nonburial./1E12));
Carbon_Nonburial_cum_dist_SE=(std(Carbon_Nonburial_dist,[],2))./(sqrt(size(Carbon_Nonburial_dist,2)));



save('carbondata')

