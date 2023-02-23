clear
load('carbondata')
%load('sedimentresults')

% valley size and sediment discharge is in m^3

% Dividing based on Regions (20), some of which are combined (11 when
% combined)
% Combining Regions: Africa, North and Central America, South America,
% Northern Europe, Southern Asia
% Individual Regions: Caribbean, North Mediterranean, Middle East, East Asia,
% Oceania, Russia (Eurasian Arctic)


%% Sediment Plots
[Africa_OverUnder,NorthandCentral_America_OverUnder,SouthAmerica_OverUnder,NorthernEurope_OverUnder,Southern_Asia_OverUnder,Caribbean_OverUnder,N_Mediterranean_OverUnder,MiddleEast_OverUnder,E_Asia_OverUnder,Oceania_OverUnder,Russia_OverUnder,Africa_Infill,NorthandCentral_America_Infill,SouthAmerica_Infill,NorthernEurope_Infill,Southern_Asia_Infill,Caribbean_Infill,N_Mediterranean_Infill,MiddleEast_Infill,E_Asia_Infill,Oceania_Infill,Russia_Infill] = get_Infill_regions(time,Discharge_prist,ChannelSlope,QRiver_converted,MouthLat,Region);
[Africa_Infill_dist,NorthandCentral_America_Infill_dist,SouthAmerica_Infill_dist,NorthernEurope_Infill_dist,Southern_Asia_Infill_dist,Caribbean_Infill_dist,N_Mediterranean_Infill_dist,MiddleEast_Infill_dist,E_Asia_Infill_dist,Oceania_Infill_dist,Russia_Infill_dist,Africa_Under_dist,NorthandCentral_America_Under_dist,SouthAmerica_Under_dist,NorthernEurope_Under_dist,Southern_Asia_Under_dist,Caribbean_Under_dist,N_Mediterranean_Under_dist,MiddleEast_Under_dist,E_Asia_Under_dist,Oceania_Under_dist,Russia_Under_dist,Africa_Over_dist,NorthandCentral_America_Over_dist,SouthAmerica_Over_dist,NorthernEurope_Over_dist,Southern_Asia_Over_dist,Caribbean_Over_dist,N_Mediterranean_Over_dist,MiddleEast_Over_dist,E_Asia_Over_dist,Oceania_Over_dist,Russia_Over_dist,Africa_Vol2Fill_dist,NorthandCentral_America_Vol2Fill_dist,SouthAmerica_Vol2Fill_dist,NorthernEurope_Vol2Fill_dist,Southern_Asia_Vol2Fill_dist,Caribbean_Vol2Fill_dist,N_Mediterranean_Vol2Fill_dist,MiddleEast_Vol2Fill_dist,E_Asia_Vol2Fill_dist,Oceania_Vol2Fill_dist,Russia_Vol2Fill_dist] = get_Infill_regions_montecarlo(time,Discharge_prist,ChannelSlope,QRiver_converted,MouthLat,Region);

%% Plotting number of underfilled valleys with error. 
% Errors are smaller than symbol sizes and there's quite a bit of white space.
x_edg=linspace(0,time,12);
datapoints=500;
[y]=discretize(time_sediment',x_edg);
figure;
% All Rivers - number of underfilled valleys
subplot(3,4,1)
Under_y=accumarray(y,((sum(OverUnder>0)))',[],@nanmedian);
Under_y_std=accumarray(y,var((Under_dist),1,2),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Under_y=[sum(OverUnder(:,1)>0); Under_y; sum(OverUnder(:,500)>0)];
Under_y_std=[(sqrt(var(Under_dist(1,:))))./(sqrt(2000));Under_y_std;(sqrt(var(Under_dist(500,:))))./(sqrt(2000))];
x_error=[x_edg(1:end-1)+diff(x_edg(1:end))/2];
x_error=[0,x_error,6000];
errorbar(x_error,Under_y(1:end),Under_y_std(1:end),'-ob','MarkerFaceColor','b','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Global')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Number of Unfilled Valleys')
% Africa
subplot(3,4,2)
Under_Africa_y=accumarray(y,((sum(Africa_OverUnder>0)))',[],@nanmedian);
Under_Africa_y_std=accumarray(y,var((Africa_Under_dist)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Under_Africa_y=[sum(Africa_OverUnder(:,1)>0); Under_Africa_y;sum(Africa_OverUnder(:,500)>0)];
Under_Africa_y_std=[(sqrt(var(Africa_Under_dist(1,:))))./(sqrt(2000));Under_Africa_y_std;(sqrt(var(Africa_Under_dist(500,:))))./(sqrt(2000))];
errorbar(x_error,Under_Africa_y(1:end),Under_Africa_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Africa')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Number of Unfilled Valleys')
% NorthandCentral_America
subplot(3,4,7)
Under_NorthandCentral_America_y=accumarray(y,((sum(NorthandCentral_America_OverUnder>0)))',[],@nanmedian);
Under_NorthandCentral_America_y_std=accumarray(y,var((NorthandCentral_America_Under_dist)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Under_NorthandCentral_America_y=[sum(NorthandCentral_America_OverUnder(:,1)>0); Under_NorthandCentral_America_y;sum(NorthandCentral_America_OverUnder(:,500)>0)];
Under_NorthandCentral_America_y_std=[(sqrt(var(NorthandCentral_America_Under_dist(1,:))))./(sqrt(2000));Under_NorthandCentral_America_y_std;(sqrt(var(NorthandCentral_America_Under_dist(500,:))))./(sqrt(2000))];
errorbar(x_error,Under_NorthandCentral_America_y(1:end),Under_NorthandCentral_America_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('North and Central America')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Number of Unfilled Valleys')
% SouthAmerica
subplot(3,4,11)
Under_SouthAmerica_y=accumarray(y,((sum(SouthAmerica_OverUnder>0)))',[],@nanmedian);
Under_SouthAmerica_y_std=accumarray(y,var((SouthAmerica_Under_dist)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Under_SouthAmerica_y=[sum(SouthAmerica_OverUnder(:,1)>0); Under_SouthAmerica_y;sum(SouthAmerica_OverUnder(:,500)>0)];
Under_SouthAmerica_y_std=[(sqrt(var(SouthAmerica_Under_dist(1,:))))./(sqrt(2000));Under_SouthAmerica_y_std;(sqrt(var(SouthAmerica_Under_dist(500,:))))./(sqrt(2000))];
errorbar(x_error,Under_SouthAmerica_y(1:end),Under_SouthAmerica_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('South America')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Number of Unfilled Valleys')
% NorthernEurope
subplot(3,4,8)
Under_NorthernEurope_y=accumarray(y,((sum(NorthernEurope_OverUnder>0)))',[],@nanmedian);
Under_NorthernEurope_y_std=accumarray(y,var((NorthernEurope_Under_dist)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Under_NorthernEurope_y=[sum(NorthernEurope_OverUnder(:,1)>0); Under_NorthernEurope_y;sum(NorthernEurope_OverUnder(:,500)>0)];
Under_NorthernEurope_y_std=[(sqrt(var(NorthernEurope_Under_dist(1,:))))./(sqrt(2000));Under_NorthernEurope_y_std;(sqrt(var(NorthernEurope_Under_dist(500,:))))./(sqrt(2000))];
errorbar(x_error,Under_NorthernEurope_y(1:end),Under_NorthernEurope_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Northern Europe')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Number of Unfilled Valleys')
% Southern_Asia
subplot(3,4,12)
Under_Southern_Asia_y=accumarray(y,((sum(Southern_Asia_OverUnder>0)))',[],@nanmedian);
Under_Southern_Asia_y_std=accumarray(y,var((Southern_Asia_Under_dist)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Under_Southern_Asia_y=[sum(Southern_Asia_OverUnder(:,1)>0); Under_Southern_Asia_y;sum(Southern_Asia_OverUnder(:,500)>0)];
Under_Southern_Asia_y_std=[(sqrt(var(Southern_Asia_Under_dist(1,:))))./(sqrt(2000));Under_Southern_Asia_y_std;(sqrt(var(Southern_Asia_Under_dist(500,:))))./(sqrt(2000))];
errorbar(x_error,Under_Southern_Asia_y(1:end),Under_Southern_Asia_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Southern Asia')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Number of Unfilled Valleys')
% Caribbean
subplot(3,4,3)
Under_Caribbean_y=accumarray(y,((sum(Caribbean_OverUnder>0)))',[],@nanmedian);
Under_Caribbean_y_std=accumarray(y,var((Caribbean_Under_dist)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Under_Caribbean_y=[sum(Caribbean_OverUnder(:,1)>0); Under_Caribbean_y;sum(Caribbean_OverUnder(:,500)>0)];
Under_Caribbean_y_std=[(sqrt(var(Caribbean_Under_dist(1,:))))./(sqrt(numel(2000));Under_Caribbean_y_std;(sqrt(var(Caribbean_Under_dist(500,:))))./(sqrt(2000))];
errorbar(x_error,Under_Caribbean_y(1:end),Under_Caribbean_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Caribbean')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Number of Unfilled Valleys')
% N_Mediterranean
subplot(3,4,9)
Under_N_Mediterranean_y=accumarray(y,((sum(N_Mediterranean_OverUnder>0)))',[],@nanmedian);
Under_N_Mediterranean_y_std=accumarray(y,var((N_Mediterranean_Under_dist)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Under_N_Mediterranean_y=[sum(N_Mediterranean_OverUnder(:,1)>0); Under_N_Mediterranean_y;sum(N_Mediterranean_OverUnder(:,500)>0)];
Under_N_Mediterranean_y_std=[(sqrt(var(N_Mediterranean_Under_dist(1,:))))./(sqrt(2000));Under_N_Mediterranean_y_std;(sqrt(var(N_Mediterranean_Under_dist(500,:))))./(sqrt(2000))];
errorbar(x_error,Under_N_Mediterranean_y(1:end),Under_N_Mediterranean_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Northern Mediterranean')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Number of Unfilled Valleys')
% MiddleEast
subplot(3,4,6)
Under_MiddleEast_y=accumarray(y,((sum(MiddleEast_OverUnder>0)))',[],@nanmedian);
Under_MiddleEast_y_std=accumarray(y,var((MiddleEast_Under_dist)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Under_MiddleEast_y=[sum(MiddleEast_OverUnder(:,1)>0); Under_MiddleEast_y;sum(MiddleEast_OverUnder(:,500)>0)];
Under_MiddleEast_y_std=[(sqrt(var(MiddleEast_Under_dist(1,:))))./(sqrt(2000));Under_MiddleEast_y_std;(sqrt(var(MiddleEast_Under_dist(500,:))))./(sqrt(2000))];
errorbar(x_error,Under_MiddleEast_y(1:end),Under_MiddleEast_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Middle East')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Number of Unfilled Valleys')
% E_Asia
subplot(3,4,4)
Under_E_Asia_y=accumarray(y,((sum(E_Asia_OverUnder>0)))',[],@nanmedian);
Under_E_Asia_y_std=accumarray(y,var((E_Asia_Under_dist)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Under_E_Asia_y=[sum(E_Asia_OverUnder(:,1)>0); Under_E_Asia_y;sum(E_Asia_OverUnder(:,500)>0)];
Under_E_Asia_y_std=[(sqrt(var(E_Asia_Under_dist(1,:))))./(sqrt(2000));Under_E_Asia_y_std;(sqrt(var(E_Asia_Under_dist(500,:))))./(sqrt(2000))];
errorbar(x_error,Under_E_Asia_y(1:end),Under_E_Asia_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Eastern Asia')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Number of Unfilled Valleys')
% Oceania
subplot(3,4,10)
Under_Oceania_y=accumarray(y,((sum(Oceania_OverUnder>0)))',[],@nanmedian);
Under_Oceania_y_std=accumarray(y,var((Oceania_Under_dist)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Under_Oceania_y=[sum(Oceania_OverUnder(:,1)>0); Under_Oceania_y;sum(Oceania_OverUnder(:,500)>0)];
Under_Oceania_y_std=[(sqrt(var(Oceania_Under_dist(1,:))))./(sqrt(2000));Under_Oceania_y_std;(sqrt(var(Oceania_Under_dist(500,:))))./(sqrt(2000))];
errorbar(x_error,Under_Oceania_y(1:end),Under_Oceania_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Oceania')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Number of Unfilled Valleys')
% Russia
subplot(3,4,5)
Under_Russia_y=accumarray(y,((sum(Russia_OverUnder>0)))',[],@nanmedian);
Under_Russia_y_std=accumarray(y,var((Russia_Under_dist)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Under_Russia_y=[sum(Russia_OverUnder(:,1)>0); Under_Russia_y;sum(Russia_OverUnder(:,500)>0)];
Under_Russia_y_std=[(sqrt(var(Russia_Under_dist(1,:))))./(sqrt(2000));Under_Russia_y_std;(sqrt(var(Russia_Under_dist(500,:))))./(sqrt(2000))];
errorbar(x_error,Under_Russia_y(1:end),Under_Russia_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Eurasian Arctic')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Number of Unfilled Valleys')

%% Percent underfilled valleys
% All Rivers
figure;
subplot(3,4,1)
OverUnder_y=accumarray(y,((sum(OverUnder>0))./(size(OverUnder,1)).*100)',[],@nanmedian);
OverUnder_y_std=accumarray(y,var(((Under_dist./Under_dist(1,1)).*100)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
OverUnder_y=[100;OverUnder_y;(sum(OverUnder(:,500)>0))./(size(OverUnder,1)).*100];
OverUnder_y_std=[(sqrt(var(Under_dist(1,:)./Under_dist(1,1)).*100))./(sqrt(2000));OverUnder_y_std;(sqrt(var(Under_dist(500,:)./Under_dist(1,1)).*100))./(sqrt(2000))];
errorbar(x_error,OverUnder_y(1:end),OverUnder_y_std(1:end),'-ob','MarkerFaceColor','b','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Global')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Percent Unfilled Valleys (%)')
% Africa
subplot(3,4,2)
Under_Africa_y=accumarray(y,(((sum(Africa_OverUnder>0))./size(Africa_OverUnder,1)).*100)',[],@nanmedian);
Under_Africa_y_std=accumarray(y,var(((Africa_Under_dist./size(Africa_OverUnder,1)).*100)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Under_Africa_y=[100; Under_Africa_y;(sum(Africa_OverUnder(:,500)>0))./(size(Africa_OverUnder,1)).*100];
Under_Africa_y_std=[(sqrt(var(Africa_Under_dist(1,:)./Africa_Under_dist(1,1)).*100))./(sqrt(2000));Under_Africa_y_std;(sqrt(var(Africa_Under_dist(500,:)./Africa_Under_dist(1,1)).*100))./(sqrt(2000))];
errorbar(x_error,Under_Africa_y(1:end),Under_Africa_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Africa')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Percent Unfilled Valleys (%)')
% NorthandCentral_America
subplot(3,4,7)
Under_NorthandCentral_America_y=accumarray(y,(((sum(NorthandCentral_America_OverUnder>0))./size(NorthandCentral_America_OverUnder,1)).*100)',[],@nanmedian);
Under_NorthandCentral_America_y_std=accumarray(y,var(((NorthandCentral_America_Under_dist./size(NorthandCentral_America_OverUnder,1)).*100)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Under_NorthandCentral_America_y=[100; Under_NorthandCentral_America_y;(sum(NorthandCentral_America_OverUnder(:,500)>0))./(size(NorthandCentral_America_OverUnder,1)).*100];
Under_NorthandCentral_America_y_std=[(sqrt(var(NorthandCentral_America_Under_dist(1,:)./NorthandCentral_America_Under_dist(1,1)).*100))./(sqrt(2000));Under_NorthandCentral_America_y_std;(sqrt(var(NorthandCentral_America_Under_dist(500,:)./NorthandCentral_America_Under_dist(1,1)).*100))./(sqrt(2000))];
errorbar(x_error,Under_NorthandCentral_America_y(1:end),Under_NorthandCentral_America_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('North and Central America')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Percent Unfilled Valleys (%)')
% SouthAmerica
subplot(3,4,11)
Under_SouthAmerica_y=accumarray(y,(((sum(SouthAmerica_OverUnder>0))./size(SouthAmerica_OverUnder,1)).*100)',[],@nanmedian);
Under_SouthAmerica_y_std=accumarray(y,var(((SouthAmerica_Under_dist./size(SouthAmerica_OverUnder,1)).*100)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Under_SouthAmerica_y=[100; Under_SouthAmerica_y;(sum(SouthAmerica_OverUnder(:,500)>0))./(size(SouthAmerica_OverUnder,1)).*100];
Under_SouthAmerica_y_std=[(sqrt(var(SouthAmerica_Under_dist(1,:)./SouthAmerica_Under_dist(1,1)).*100))./(sqrt(2000));Under_SouthAmerica_y_std;(sqrt(var(SouthAmerica_Under_dist(500,:)./SouthAmerica_Under_dist(1,1)).*100))./(sqrt(2000))];
errorbar(x_error,Under_SouthAmerica_y(1:end),Under_SouthAmerica_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('South America')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Percent Unfilled Valleys (%)')
% NorthernEurope
subplot(3,4,8)
Under_NorthernEurope_y=accumarray(y,(((sum(NorthernEurope_OverUnder>0))./size(NorthernEurope_OverUnder,1)).*100)',[],@nanmedian);
Under_NorthernEurope_y_std=accumarray(y,var(((NorthernEurope_Under_dist./size(NorthernEurope_OverUnder,1)).*100)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Under_NorthernEurope_y=[100; Under_NorthernEurope_y;(sum(NorthernEurope_OverUnder(:,500)>0))./(size(NorthernEurope_OverUnder,1)).*100];
Under_NorthernEurope_y_std=[(sqrt(var(NorthernEurope_Under_dist(1,:)./NorthernEurope_Under_dist(1,1)).*100))./(sqrt(2000));Under_NorthernEurope_y_std;(sqrt(var(NorthernEurope_Under_dist(500,:)./NorthernEurope_Under_dist(1,1)).*100))./(sqrt(2000))];
errorbar(x_error,Under_NorthernEurope_y(1:end),Under_NorthernEurope_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Northern Europe')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Percent Unfilled Valleys (%)')
% Southern_Asia
subplot(3,4,12)
Under_Southern_Asia_y=accumarray(y,(((sum(Southern_Asia_OverUnder>0))./size(Southern_Asia_OverUnder,1)).*100)',[],@nanmedian);
Under_Southern_Asia_y_std=accumarray(y,var(((Southern_Asia_Under_dist./size(Southern_Asia_OverUnder,1)).*100)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Under_Southern_Asia_y=[100; Under_Southern_Asia_y;(sum(Southern_Asia_OverUnder(:,500)>0))./(size(Southern_Asia_OverUnder,1)).*100];
Under_Southern_Asia_y_std=[(sqrt(var(Southern_Asia_Under_dist(1,:)./Southern_Asia_Under_dist(1,1)).*100))./(sqrt(2000));Under_Southern_Asia_y_std;(sqrt(var(Southern_Asia_Under_dist(500,:)./Southern_Asia_Under_dist(1,1)).*100))./(sqrt(2000))];
errorbar(x_error,Under_Southern_Asia_y(1:end),Under_Southern_Asia_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Southern Asia')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Percent Unfilled Valleys (%)')
% Caribbean
subplot(3,4,3)
Under_Caribbean_y=accumarray(y,(((sum(Caribbean_OverUnder>0))./size(Caribbean_OverUnder,1)).*100)',[],@nanmedian);
Under_Caribbean_y_std=accumarray(y,var(((Caribbean_Under_dist./size(Caribbean_OverUnder,1)).*100)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Under_Caribbean_y=[100; Under_Caribbean_y;(sum(Caribbean_OverUnder(:,500)>0))./(size(Caribbean_OverUnder,1)).*100];
Under_Caribbean_y_std=[(sqrt(var(Caribbean_Under_dist(1,:)./Caribbean_Under_dist(1,1)).*100))./(sqrt(2000));Under_Caribbean_y_std;(sqrt(var(Caribbean_Under_dist(500,:)./Caribbean_Under_dist(1,1)).*100))./(sqrt(2000))];
errorbar(x_error,Under_Caribbean_y(1:end),Under_Caribbean_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Caribbean')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Percent Unfilled Valleys (%)')
% N_Mediterranean
subplot(3,4,9)
Under_N_Mediterranean_y=accumarray(y,(((sum(N_Mediterranean_OverUnder>0))./size(N_Mediterranean_OverUnder,1)).*100)',[],@nanmedian);
Under_N_Mediterranean_y_std=accumarray(y,var(((N_Mediterranean_Under_dist./size(N_Mediterranean_OverUnder,1)).*100)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Under_N_Mediterranean_y=[100; Under_N_Mediterranean_y;(sum(N_Mediterranean_OverUnder(:,500)>0))./(size(N_Mediterranean_OverUnder,1)).*100];
Under_N_Mediterranean_y_std=[(sqrt(var(N_Mediterranean_Under_dist(1,:)./N_Mediterranean_Under_dist(1,1)).*100))./(sqrt(2000));Under_N_Mediterranean_y_std;(sqrt(var(N_Mediterranean_Under_dist(500,:)./N_Mediterranean_Under_dist(1,1)).*100))./(sqrt(2000))];
errorbar(x_error,Under_N_Mediterranean_y(1:end),Under_N_Mediterranean_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Northern Mediterranean')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Percent Unfilled Valleys (%)')
% MiddleEast
subplot(3,4,6)
Under_MiddleEast_y=accumarray(y,(((sum(MiddleEast_OverUnder>0))./size(MiddleEast_OverUnder,1)).*100)',[],@nanmedian);
Under_MiddleEast_y_std=accumarray(y,var(((MiddleEast_Under_dist./size(MiddleEast_OverUnder,1)).*100)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Under_MiddleEast_y=[100; Under_MiddleEast_y;(sum(MiddleEast_OverUnder(:,500)>0))./(size(MiddleEast_OverUnder,1)).*100];
Under_MiddleEast_y_std=[(sqrt(var(MiddleEast_Under_dist(1,:)./MiddleEast_Under_dist(1,1)).*100))./(sqrt(2000));Under_MiddleEast_y_std;(sqrt(var(MiddleEast_Under_dist(500,:)./MiddleEast_Under_dist(1,1)).*100))./(sqrt(2000))];
errorbar(x_error,Under_MiddleEast_y(1:end),Under_MiddleEast_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Middle East')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Percent Unfilled Valleys (%)')
% E_Asia
subplot(3,4,4)
Under_E_Asia_y=accumarray(y,(((sum(E_Asia_OverUnder>0))./size(E_Asia_OverUnder,1)).*100)',[],@nanmedian);
Under_E_Asia_y_std=accumarray(y,var(((E_Asia_Under_dist./size(E_Asia_OverUnder,1)).*100)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Under_E_Asia_y=[100; Under_E_Asia_y;(sum(E_Asia_OverUnder(:,500)>0))./(size(E_Asia_OverUnder,1)).*100];
Under_E_Asia_y_std=[(sqrt(var(E_Asia_Under_dist(1,:)./E_Asia_Under_dist(1,1)).*100))./(sqrt(2000));Under_E_Asia_y_std;(sqrt(var(E_Asia_Under_dist(500,:)./E_Asia_Under_dist(1,1)).*100))./(sqrt(2000))];
errorbar(x_error,Under_E_Asia_y(1:end),Under_E_Asia_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Eastern Asia')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Percent Unfilled Valleys (%)')
% Oceania
subplot(3,4,10)
Under_Oceania_y=accumarray(y,(((sum(Oceania_OverUnder>0))./size(Oceania_OverUnder,1)).*100)',[],@nanmedian);
Under_Oceania_y_std=accumarray(y,var(((Oceania_Under_dist./size(Oceania_OverUnder,1)).*100)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Under_Oceania_y=[100; Under_Oceania_y;(sum(Oceania_OverUnder(:,500)>0))./(size(Oceania_OverUnder,1)).*100];
Under_Oceania_y_std=[(sqrt(var(Oceania_Under_dist(1,:)./Oceania_Under_dist(1,1)).*100))./(sqrt(2000));Under_Oceania_y_std;(sqrt(var(Oceania_Under_dist(500,:)./Oceania_Under_dist(1,1)).*100))./(sqrt(2000))];
errorbar(x_error,Under_Oceania_y(1:end),Under_Oceania_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Oceania')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Percent Unfilled Valleys (%)')
% Russia
subplot(3,4,5)
Under_Russia_y=accumarray(y,(((sum(Russia_OverUnder>0))./size(Russia_OverUnder,1)).*100)',[],@nanmedian);
Under_Russia_y_std=accumarray(y,var(((Russia_Under_dist./size(Russia_OverUnder,1)).*100)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Under_Russia_y=[100; Under_Russia_y;(sum(Russia_OverUnder(:,500)>0))./(size(Russia_OverUnder,1)).*100];
Under_Russia_y_std=[(sqrt(var(Russia_Under_dist(1,:)./Russia_Under_dist(1,1)).*100))./(sqrt(2000));Under_Russia_y_std;(sqrt(var(Russia_Under_dist(500,:)./Russia_Under_dist(1,1)).*100))./(sqrt(2000))];
errorbar(x_error,Under_Russia_y(1:end),Under_Russia_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Eurasian Arctic')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Percent Unfilled Valleys (%)')

%% Plotting Number of Overfilled Valleys
% All Rivers
figure;
subplot(3,4,1)
Over_y=accumarray(y,(sum(OverUnder<0))',[],@nanmedian);
Over_y_std=accumarray(y,var((Over_dist)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Over_y=[0;Over_y;sum(OverUnder(:,500)<0)];
Over_y_std=[(sqrt(var(Over_dist(1,:))))./(sqrt(2000));Over_y_std;(sqrt(var(Over_dist(500,:))))./(sqrt(2000))];
errorbar(x_error,Over_y(1:end),Over_y_std(1:end),'-ob','MarkerFaceColor','b','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Global')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Number of Overfilled Valleys')
% Africa
subplot(3,4,2)
Over_Africa_y=accumarray(y,(sum(Africa_OverUnder<0))',[],@nanmedian);
Over_Africa_y_std=accumarray(y,var((Africa_Over_dist)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Over_Africa_y=[0;Over_Africa_y;sum(Africa_OverUnder(:,500)<0)];
Over_Africa_y_std=[(sqrt(var(Africa_Over_dist(1,:))))./(sqrt(2000));Over_Africa_y_std;(sqrt(var(Africa_Over_dist(500,:))))./(sqrt(2000))];
errorbar(x_error,Over_Africa_y(1:end),Over_Africa_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Africa')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Number of Overfilled Valleys')
% NorthandCentral_America
subplot(3,4,7)
Over_NorthandCentral_America_y=accumarray(y,(sum(NorthandCentral_America_OverUnder<0))',[],@nanmedian);
Over_NorthandCentral_America_y_std=accumarray(y,var((NorthandCentral_America_Over_dist)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Over_NorthandCentral_America_y=[0;Over_NorthandCentral_America_y;sum(NorthandCentral_America_OverUnder(:,500)<0)];
Over_NorthandCentral_America_y_std=[(sqrt(var(NorthandCentral_America_Over_dist(1,:))))./(sqrt(2000));Over_NorthandCentral_America_y_std;(sqrt(var(NorthandCentral_America_Over_dist(500,:))))./(sqrt(2000))];
errorbar(x_error,Over_NorthandCentral_America_y(1:end),Over_NorthandCentral_America_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('North and Central America')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Number of Overfilled Valleys')
% SouthAmerica
subplot(3,4,11)
Over_SouthAmerica_y=accumarray(y,(sum(SouthAmerica_OverUnder<0))',[],@nanmedian);
Over_SouthAmerica_y_std=accumarray(y,var((SouthAmerica_Over_dist)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Over_SouthAmerica_y=[0;Over_SouthAmerica_y;sum(SouthAmerica_OverUnder(:,500)<0)];
Over_SouthAmerica_y_std=[(sqrt(var(SouthAmerica_Over_dist(1,:))))./(sqrt(2000));Over_SouthAmerica_y_std;(sqrt(var(SouthAmerica_Over_dist(500,:))))./(sqrt(2000))];
errorbar(x_error,Over_SouthAmerica_y(1:end),Over_SouthAmerica_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('South America')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Number of Overfilled Valleys')
% NorthernEurope
subplot(3,4,8)
Over_NorthernEurope_y=accumarray(y,(sum(NorthernEurope_OverUnder<0))',[],@nanmedian);
Over_NorthernEurope_y_std=accumarray(y,var((NorthernEurope_Over_dist)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Over_NorthernEurope_y=[0;Over_NorthernEurope_y;sum(NorthernEurope_OverUnder(:,500)<0)];
Over_NorthernEurope_y_std=[(sqrt(var(NorthernEurope_Over_dist(1,:))))./(sqrt(2000));Over_NorthernEurope_y_std;(sqrt(var(NorthernEurope_Over_dist(500,:))))./(sqrt(2000))];
errorbar(x_error,Over_NorthernEurope_y(1:end),Over_NorthernEurope_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Northern Europe')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Number of Overfilled Valleys')
% Southern_Asia
subplot(3,4,12)
Over_Southern_Asia_y=accumarray(y,(sum(Southern_Asia_OverUnder<0))',[],@nanmedian);
Over_Southern_Asia_y_std=accumarray(y,var((Southern_Asia_Over_dist)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Over_Southern_Asia_y=[0;Over_Southern_Asia_y;sum(Southern_Asia_OverUnder(:,500)<0)];
Over_Southern_Asia_y_std=[(sqrt(var(Southern_Asia_Over_dist(1,:))))./(sqrt(2000));Over_Southern_Asia_y_std;(sqrt(var(Southern_Asia_Over_dist(500,:))))./(sqrt(2000))];
errorbar(x_error,Over_Southern_Asia_y(1:end),Over_Southern_Asia_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Southern Asia')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Number of Overfilled Valleys')
% Caribbean
subplot(3,4,3)
Over_Caribbean_y=accumarray(y,(sum(Caribbean_OverUnder<0))',[],@nanmedian);
Over_Caribbean_y_std=accumarray(y,var((Caribbean_Over_dist)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Over_Caribbean_y=[0;Over_Caribbean_y;sum(Caribbean_OverUnder(:,500)<0)];
Over_Caribbean_y_std=[(sqrt(var(Caribbean_Over_dist(1,:))))./(sqrt(2000));Over_Caribbean_y_std;(sqrt(var(Caribbean_Over_dist(500,:))))./(sqrt(2000))];
errorbar(x_error,Over_Caribbean_y(1:end),Over_Caribbean_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Caribbean')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Number of Overfilled Valleys')
% N_Mediterranean
subplot(3,4,9)
Over_N_Mediterranean_y=accumarray(y,(sum(N_Mediterranean_OverUnder<0))',[],@nanmedian);
Over_N_Mediterranean_y_std=accumarray(y,var((N_Mediterranean_Over_dist)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Over_N_Mediterranean_y=[0;Over_N_Mediterranean_y;sum(N_Mediterranean_OverUnder(:,500)<0)];
Over_N_Mediterranean_y_std=[(sqrt(var(N_Mediterranean_Over_dist(1,:))))./(sqrt(2000));Over_N_Mediterranean_y_std;(sqrt(var(N_Mediterranean_Over_dist(500,:))))./(sqrt(2000))];
errorbar(x_error,Over_N_Mediterranean_y(1:end),Over_N_Mediterranean_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Northern Mediterranean')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Number of Overfilled Valleys')
% MiddleEast
subplot(3,4,6)
Over_MiddleEast_y=accumarray(y,(sum(MiddleEast_OverUnder<0))',[],@nanmedian);
Over_MiddleEast_y_std=accumarray(y,var((MiddleEast_Over_dist)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Over_MiddleEast_y=[0;Over_MiddleEast_y;sum(MiddleEast_OverUnder(:,500)<0)];
Over_MiddleEast_y_std=[(sqrt(var(MiddleEast_Over_dist(1,:))))./(sqrt(2000));Over_MiddleEast_y_std;(sqrt(var(MiddleEast_Over_dist(500,:))))./(sqrt(2000))];
errorbar(x_error,Over_MiddleEast_y(1:end),Over_MiddleEast_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Middle East')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Number of Overfilled Valleys')
% E_Asia
subplot(3,4,4)
Over_E_Asia_y=accumarray(y,(sum(E_Asia_OverUnder<0))',[],@nanmedian);
Over_E_Asia_y_std=accumarray(y,var((E_Asia_Over_dist)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Over_E_Asia_y=[0;Over_E_Asia_y;sum(E_Asia_OverUnder(:,500)<0)];
Over_E_Asia_y_std=[(sqrt(var(E_Asia_Over_dist(1,:))))./(sqrt(2000));Over_E_Asia_y_std;(sqrt(var(E_Asia_Over_dist(500,:))))./(sqrt(2000))];
errorbar(x_error,Over_E_Asia_y(1:end),Over_E_Asia_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Eastern Asia')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Number of Overfilled Valleys')
% Oceania
subplot(3,4,10)
Over_Oceania_y=accumarray(y,(sum(Oceania_OverUnder<0))',[],@nanmedian);
Over_Oceania_y_std=accumarray(y,var((Oceania_Over_dist)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Over_Oceania_y=[0;Over_Oceania_y;sum(Oceania_OverUnder(:,500)<0)];
Over_Oceania_y_std=[(sqrt(var(Oceania_Over_dist(1,:))))./(sqrt(2000));Over_Oceania_y_std;(sqrt(var(Oceania_Over_dist(500,:))))./(sqrt(2000))];
errorbar(x_error,Over_Oceania_y(1:end),Over_Oceania_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Oceania')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Number of Overfilled Valleys')
% Russia
subplot(3,4,5)
Over_Russia_y=accumarray(y,(sum(Russia_OverUnder<0))',[],@nanmedian);
Over_Russia_y_std=accumarray(y,var((Russia_Over_dist)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Over_Russia_y=[0;Over_Russia_y;sum(Russia_OverUnder(:,500)<0)];
Over_Russia_y_std=[(sqrt(var(Russia_Over_dist(1,:))))./(sqrt(2000));Over_Russia_y_std;(sqrt(var(Russia_Over_dist(500,:))))./(sqrt(2000))];
errorbar(x_error,Over_Russia_y(1:end),Over_Russia_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Eurasian Arctic')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Number of Overfilled Valleys')

%% Percent of Overfilled Valleys
figure;
subplot(3,4,1)
Over_y=accumarray(y,((sum(OverUnder<0)/length(OverUnder))*100)',[],@nanmedian);
Over_y_std=accumarray(y,var(((Over_dist./Under_dist(1,1)).*100)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Over_y=[0;Over_y;(sum(OverUnder(:,500)<0))./(size(OverUnder,1)).*100];
Over_y_std=[(sqrt(var(Over_dist(1,:)./Under_dist(1,1)).*100))./(sqrt(2000));Over_y_std;(sqrt(var(Over_dist(500,:)./Under_dist(1,1)).*100))./(sqrt(2000))];
errorbar(x_error,Over_y(1:end),Over_y_std(1:end),'-ob','MarkerFaceColor','b','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Global')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Percent Overfilled Valleys (%)')
% Africa
subplot(3,4,2)
Over_Africa_y=accumarray(y,(((sum(Africa_OverUnder<0))./size(Africa_OverUnder,1)).*100)',[],@nanmedian);
Over_Africa_y_std=accumarray(y,var(((Africa_Over_dist./size(Africa_OverUnder,1)).*100)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Over_Africa_y=[0; Over_Africa_y;(sum(Africa_OverUnder(:,500)<0))./(size(Africa_OverUnder,1)).*100];
Over_Africa_y_std=[(sqrt(var(Africa_Over_dist(1,:)./Africa_Under_dist(1,1)).*100))./(sqrt(2000));Over_Africa_y_std;(sqrt(var(Africa_Over_dist(500,:)./Africa_Under_dist(1,1)).*100))./(sqrt(2000))];
errorbar(x_error,Over_Africa_y(1:end),Over_Africa_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Africa')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Percent Overfilled Valleys (%)')
% NorthandCentral_America
subplot(3,4,7)
Over_NorthandCentral_America_y=accumarray(y,(((sum(NorthandCentral_America_OverUnder<0))./size(NorthandCentral_America_OverUnder,1)).*100)',[],@nanmedian);
Over_NorthandCentral_America_y_std=accumarray(y,var(((NorthandCentral_America_Over_dist./size(NorthandCentral_America_OverUnder,1)).*100)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Over_NorthandCentral_America_y=[0; Over_NorthandCentral_America_y;(sum(NorthandCentral_America_OverUnder(:,500)<0))./(size(NorthandCentral_America_OverUnder,1)).*100];
Over_NorthandCentral_America_y_std=[(sqrt(var(NorthandCentral_America_Over_dist(1,:)./NorthandCentral_America_Under_dist(1,1)).*100))./(sqrt(2000));Over_NorthandCentral_America_y_std;(sqrt(var(NorthandCentral_America_Over_dist(500,:)./NorthandCentral_America_Under_dist(1,1)).*100))./(sqrt(2000))];
errorbar(x_error,Over_NorthandCentral_America_y(1:end),Over_NorthandCentral_America_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('North and Central America')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Percent Overfilled Valleys (%)')
ylim([0 100])
% SouthAmerica
subplot(3,4,11)
Over_SouthAmerica_y=accumarray(y,(((sum(SouthAmerica_OverUnder<0))./size(SouthAmerica_OverUnder,1)).*100)',[],@nanmedian);
Over_SouthAmerica_y_std=accumarray(y,var(((SouthAmerica_Over_dist./size(SouthAmerica_OverUnder,1)).*100)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Over_SouthAmerica_y=[0; Over_SouthAmerica_y;(sum(SouthAmerica_OverUnder(:,500)<0))./(size(SouthAmerica_OverUnder,1)).*100];
Over_SouthAmerica_y_std=[(sqrt(var(SouthAmerica_Over_dist(1,:)./SouthAmerica_Under_dist(1,1)).*100))./(sqrt(2000));Over_SouthAmerica_y_std;(sqrt(var(SouthAmerica_Over_dist(500,:)./SouthAmerica_Under_dist(1,1)).*100))./(sqrt(2000))];
errorbar(x_error,Over_SouthAmerica_y(1:end),Over_SouthAmerica_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('South America')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Percent Overfilled Valleys (%)')
% NorthernEurope
subplot(3,4,8)
Over_NorthernEurope_y=accumarray(y,(((sum(NorthernEurope_OverUnder<0))./size(NorthernEurope_OverUnder,1)).*100)',[],@nanmedian);
Over_NorthernEurope_y_std=accumarray(y,var(((NorthernEurope_Over_dist./size(NorthernEurope_OverUnder,1)).*100)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Over_NorthernEurope_y=[0; Over_NorthernEurope_y;(sum(NorthernEurope_OverUnder(:,500)<0))./(size(NorthernEurope_OverUnder,1)).*100];
Over_NorthernEurope_y_std=[(sqrt(var(NorthernEurope_Over_dist(1,:)./NorthernEurope_Under_dist(1,1)).*100))./(sqrt(2000));Over_NorthernEurope_y_std;(sqrt(var(NorthernEurope_Over_dist(500,:)./NorthernEurope_Under_dist(1,1)).*100))./(sqrt(2000))];
errorbar(x_error,Over_NorthernEurope_y(1:end),Over_NorthernEurope_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Northern Europe')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Percent Overfilled Valleys (%)')
% Southern_Asia
subplot(3,4,12)
Over_Southern_Asia_y=accumarray(y,(((sum(Southern_Asia_OverUnder<0))./size(Southern_Asia_OverUnder,1)).*100)',[],@nanmedian);
Over_Southern_Asia_y_std=accumarray(y,var(((Southern_Asia_Over_dist./size(Southern_Asia_OverUnder,1)).*100)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Over_Southern_Asia_y=[0; Over_Southern_Asia_y;(sum(Southern_Asia_OverUnder(:,500)<0))./(size(Southern_Asia_OverUnder,1)).*100];
Over_Southern_Asia_y_std=[(sqrt(var(Southern_Asia_Over_dist(1,:)./Southern_Asia_Under_dist(1,1)).*100))./(sqrt(2000));Over_Southern_Asia_y_std;(sqrt(var(Southern_Asia_Over_dist(500,:)./Southern_Asia_Under_dist(1,1)).*100))./(sqrt(2000))];
errorbar(x_error,Over_Southern_Asia_y(1:end),Over_Southern_Asia_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Southern Asia')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Percent Overfilled Valleys (%)')
% Caribbean
subplot(3,4,3)
Over_Caribbean_y=accumarray(y,(((sum(Caribbean_OverUnder<0))./size(Caribbean_OverUnder,1)).*100)',[],@nanmedian);
Over_Caribbean_y_std=accumarray(y,var(((Caribbean_Over_dist./size(Caribbean_OverUnder,1)).*100)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Over_Caribbean_y=[0; Over_Caribbean_y;(sum(Caribbean_OverUnder(:,500)<0))./(size(Caribbean_OverUnder,1)).*100];
Over_Caribbean_y_std=[(sqrt(var(Caribbean_Over_dist(1,:)./Caribbean_Under_dist(1,1)).*100))./(sqrt(2000));Over_Caribbean_y_std;(sqrt(var(Caribbean_Over_dist(500,:)./Caribbean_Under_dist(1,1)).*100))./(sqrt(2000))];
errorbar(x_error,Over_Caribbean_y(1:end),Over_Caribbean_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Caribbean')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Percent Overfilled Valleys (%)')
% N_Mediterranean
subplot(3,4,9)
Over_N_Mediterranean_y=accumarray(y,(((sum(N_Mediterranean_OverUnder<0))./size(N_Mediterranean_OverUnder,1)).*100)',[],@nanmedian);
Over_N_Mediterranean_y_std=accumarray(y,var(((N_Mediterranean_Over_dist./size(N_Mediterranean_OverUnder,1)).*100)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Over_N_Mediterranean_y=[0; Over_N_Mediterranean_y;(sum(N_Mediterranean_OverUnder(:,500)<0))./(size(N_Mediterranean_OverUnder,1)).*100];
Over_N_Mediterranean_y_std=[(sqrt(var(N_Mediterranean_Over_dist(1,:)./N_Mediterranean_Under_dist(1,1)).*100))./(sqrt(2000));Over_N_Mediterranean_y_std;(sqrt(var(N_Mediterranean_Over_dist(500,:)./N_Mediterranean_Under_dist(1,1)).*100))./(sqrt(2000))];
errorbar(x_error,Over_N_Mediterranean_y(1:end),Over_N_Mediterranean_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Northern Mediterranean')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Percent Overfilled Valleys (%)')
% MiddleEast
subplot(3,4,6)
Over_MiddleEast_y=accumarray(y,(((sum(MiddleEast_OverUnder<0))./size(MiddleEast_OverUnder,1)).*100)',[],@nanmedian);
Over_MiddleEast_y_std=accumarray(y,var(((MiddleEast_Over_dist./size(MiddleEast_OverUnder,1)).*100)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Over_MiddleEast_y=[0; Over_MiddleEast_y;(sum(MiddleEast_OverUnder(:,500)<0))./(size(MiddleEast_OverUnder,1)).*100];
Over_MiddleEast_y_std=[(sqrt(var(MiddleEast_Over_dist(1,:)./MiddleEast_Under_dist(1,1)).*100))./(sqrt(2000));Over_MiddleEast_y_std;(sqrt(var(MiddleEast_Over_dist(500,:)./MiddleEast_Under_dist(1,1)).*100))./(sqrt(2000))];
errorbar(x_error,Over_MiddleEast_y(1:end),Over_MiddleEast_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Middle East')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Percent Overfilled Valleys (%)')
ylim([0 100])
% E_Asia
subplot(3,4,4)
Over_E_Asia_y=accumarray(y,(((sum(E_Asia_OverUnder<0))./size(E_Asia_OverUnder,1)).*100)',[],@nanmedian);
Over_E_Asia_y_std=accumarray(y,var(((E_Asia_Over_dist./size(E_Asia_OverUnder,1)).*100)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Over_E_Asia_y=[0; Over_E_Asia_y;(sum(E_Asia_OverUnder(:,500)<0))./(size(E_Asia_OverUnder,1)).*100];
Over_E_Asia_y_std=[(sqrt(var(E_Asia_Over_dist(1,:)./E_Asia_Under_dist(1,1)).*100))./(sqrt(2000));Over_E_Asia_y_std;(sqrt(var(E_Asia_Over_dist(500,:)./E_Asia_Under_dist(1,1)).*100))./(sqrt(2000))];
errorbar(x_error,Over_E_Asia_y(1:end),Over_E_Asia_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Eastern Asia')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Percent Overfilled Valleys (%)')
% Oceania
subplot(3,4,10)
Over_Oceania_y=accumarray(y,(((sum(Oceania_OverUnder<0))./size(Oceania_OverUnder,1)).*100)',[],@nanmedian);
Over_Oceania_y_std=accumarray(y,var(((Oceania_Over_dist./size(Oceania_OverUnder,1)).*100)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Over_Oceania_y=[0; Over_Oceania_y;(sum(Oceania_OverUnder(:,500)<0))./(size(Oceania_OverUnder,1)).*100];
Over_Oceania_y_std=[(sqrt(var(Oceania_Over_dist(1,:)./Oceania_Under_dist(1,1)).*100))./(sqrt(2000));Over_Oceania_y_std;(sqrt(var(Oceania_Over_dist(500,:)./Oceania_Under_dist(1,1)).*100))./(sqrt(2000))];
errorbar(x_error,Over_Oceania_y(1:end),Over_Oceania_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Oceania')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Percent Overfilled Valleys (%)')
% Russia
subplot(3,4,5)
Over_Russia_y=accumarray(y,(((sum(Russia_OverUnder<0))./size(Russia_OverUnder,1)).*100)',[],@nanmedian);
Over_Russia_y_std=accumarray(y,var(((Russia_Over_dist./size(Russia_OverUnder,1)).*100)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Over_Russia_y=[0; Over_Russia_y;(sum(Russia_OverUnder(:,500)<0))./(size(Russia_OverUnder,1)).*100];
Over_Russia_y_std=[(sqrt(var(Russia_Over_dist(1,:)./Russia_Under_dist(1,1)).*100))./(sqrt(2000));Over_Russia_y_std;(sqrt(var(Russia_Over_dist(500,:)./Russia_Under_dist(1,1)).*100))./(sqrt(2000))];
errorbar(x_error,Over_Russia_y(1:end),Over_Russia_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Eurasian Arctic')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Percent Overfilled Valleys (%)')


%% Volume Available to Fill
figure;
subplot(3,4,1)
Vol2Fill_y=accumarray(y,((sum((OverUnder>0).*OverUnder))./1E12)',[],@nanmedian);
Vol2Fill_y_std=accumarray(y,var((Vol2Fill_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Vol2Fill_y=[(sum((OverUnder(:,1)>0).*OverUnder(:,1)))./1E12; Vol2Fill_y;(sum((OverUnder(:,500)>0).*OverUnder(:,500)))./1E12];
Vol2Fill_y_std=[(sqrt(var(Vol2Fill_dist(1,:)./1E12)))./(sqrt(2000));Vol2Fill_y_std;(sqrt(var(Vol2Fill_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,Vol2Fill_y(1:end),Vol2Fill_y_std(1:end),'-ob','MarkerFaceColor','b','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Global')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Volume Available (10^3 km^3)')
% Africa
subplot(3,4,2)
Underfilled_Africa=sum((Africa_OverUnder>0).*Africa_OverUnder); 
Underfilled_Africa_SE=(std(Africa_Vol2Fill_dist,[],2))./(sqrt(size(Africa_Vol2Fill_dist,2)));
Vol2Fill_Africa_y=accumarray(y,(sum((Africa_OverUnder>0).*Africa_OverUnder)./1E12)',[],@nanmedian);
Vol2Fill_Africa_y_std=accumarray(y,var((Africa_Vol2Fill_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Vol2Fill_Africa_y=[(sum(Africa_OverUnder(:,1)))./1E12;Vol2Fill_Africa_y;(sum((Africa_OverUnder(:,500)>0).*Africa_OverUnder(:,500)))./1E12];
Vol2Fill_Africa_y_std=[(sqrt(var(Africa_Vol2Fill_dist(1,:)./1E12)))./(sqrt(2000));Vol2Fill_Africa_y_std;(sqrt(var(Africa_Vol2Fill_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,Vol2Fill_Africa_y(1:end),Vol2Fill_Africa_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Africa')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Volume Available (10^3 km^3)')
% NorthandCentral_America
subplot(3,4,7)
Underfilled_NorthandCentral_America=sum((NorthandCentral_America_OverUnder>0).*NorthandCentral_America_OverUnder); 
Underfilled_NorthandCentral_America_SE=(std(NorthandCentral_America_Vol2Fill_dist,[],2))./(sqrt(size(NorthandCentral_America_Vol2Fill_dist,2)));
Vol2Fill_NorthandCentral_America_y=accumarray(y,(sum((NorthandCentral_America_OverUnder>0).*NorthandCentral_America_OverUnder)./1E12)',[],@nanmedian);
Vol2Fill_NorthandCentral_America_y_std=accumarray(y,var((NorthandCentral_America_Vol2Fill_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Vol2Fill_NorthandCentral_America_y=[(sum(NorthandCentral_America_OverUnder(:,1)))./1E12;Vol2Fill_NorthandCentral_America_y;(sum((NorthandCentral_America_OverUnder(:,500)>0).*NorthandCentral_America_OverUnder(:,500)))./1E12];
Vol2Fill_NorthandCentral_America_y_std=[(sqrt(var(NorthandCentral_America_Vol2Fill_dist(1,:)./1E12)))./(sqrt(2000));Vol2Fill_NorthandCentral_America_y_std;(sqrt(var(NorthandCentral_America_Vol2Fill_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,Vol2Fill_NorthandCentral_America_y(1:end),Vol2Fill_NorthandCentral_America_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('North and Central America')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Volume Available (10^3 km^3)')
% SouthAmerica
subplot(3,4,11)
Underfilled_SouthAmerica=sum((SouthAmerica_OverUnder>0).*SouthAmerica_OverUnder); 
Underfilled_SouthAmerica_SE=(std(SouthAmerica_Vol2Fill_dist,[],2))./(sqrt(size(SouthAmerica_Vol2Fill_dist,2)));
Vol2Fill_SouthAmerica_y=accumarray(y,(sum((SouthAmerica_OverUnder>0).*SouthAmerica_OverUnder)./1E12)',[],@nanmedian);
Vol2Fill_SouthAmerica_y_std=accumarray(y,var((SouthAmerica_Vol2Fill_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Vol2Fill_SouthAmerica_y=[(sum(SouthAmerica_OverUnder(:,1)))./1E12;Vol2Fill_SouthAmerica_y;(sum((SouthAmerica_OverUnder(:,500)>0).*SouthAmerica_OverUnder(:,500)))./1E12];
Vol2Fill_SouthAmerica_y_std=[(sqrt(var(SouthAmerica_Vol2Fill_dist(1,:)./1E12)))./(sqrt(2000));Vol2Fill_SouthAmerica_y_std;(sqrt(var(SouthAmerica_Vol2Fill_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,Vol2Fill_SouthAmerica_y(1:end),Vol2Fill_SouthAmerica_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('South America')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Volume Available (10^3 km^3)')
% NorthernEurope
subplot(3,4,8)
Underfilled_NorthernEurope=sum((NorthernEurope_OverUnder>0).*NorthernEurope_OverUnder); 
Underfilled_NorthernEurope_SE=(std(NorthernEurope_Vol2Fill_dist,[],2))./(sqrt(size(NorthernEurope_Vol2Fill_dist,2)));
Vol2Fill_NorthernEurope_y=accumarray(y,(sum((NorthernEurope_OverUnder>0).*NorthernEurope_OverUnder)./1E12)',[],@nanmedian);
Vol2Fill_NorthernEurope_y_std=accumarray(y,var((NorthernEurope_Vol2Fill_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Vol2Fill_NorthernEurope_y=[(sum(NorthernEurope_OverUnder(:,1)))./1E12;Vol2Fill_NorthernEurope_y;(sum((NorthernEurope_OverUnder(:,500)>0).*NorthernEurope_OverUnder(:,500)))./1E12];
Vol2Fill_NorthernEurope_y_std=[(sqrt(var(NorthernEurope_Vol2Fill_dist(1,:)./1E12)))./(sqrt(2000));Vol2Fill_NorthernEurope_y_std;(sqrt(var(NorthernEurope_Vol2Fill_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,Vol2Fill_NorthernEurope_y(1:end),Vol2Fill_NorthernEurope_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Northern Europe')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Volume Available (10^3 km^3)')
% Southern_Asia
subplot(3,4,12)
Underfilled_Southern_Asia=sum((Southern_Asia_OverUnder>0).*Southern_Asia_OverUnder); 
Underfilled_Southern_Asia_SE=(std(Southern_Asia_Vol2Fill_dist,[],2))./(sqrt(size(Southern_Asia_Vol2Fill_dist,2)));
Vol2Fill_Southern_Asia_y=accumarray(y,(sum((Southern_Asia_OverUnder>0).*Southern_Asia_OverUnder)./1E12)',[],@nanmedian);
Vol2Fill_Southern_Asia_y_std=accumarray(y,var((Southern_Asia_Vol2Fill_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Vol2Fill_Southern_Asia_y=[(sum(Southern_Asia_OverUnder(:,1)))./1E12;Vol2Fill_Southern_Asia_y;(sum((Southern_Asia_OverUnder(:,500)>0).*Southern_Asia_OverUnder(:,500)))./1E12];
Vol2Fill_Southern_Asia_y_std=[(sqrt(var(Southern_Asia_Vol2Fill_dist(1,:)./1E12)))./(sqrt(2000));Vol2Fill_Southern_Asia_y_std;(sqrt(var(Southern_Asia_Vol2Fill_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,Vol2Fill_Southern_Asia_y(1:end),Vol2Fill_Southern_Asia_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Southern Asia')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Volume Available (10^3 km^3)')
% Caribbean
subplot(3,4,3)
Underfilled_Caribbean=sum((Caribbean_OverUnder>0).*Caribbean_OverUnder); 
Underfilled_Caribbean_SE=(std(Caribbean_Vol2Fill_dist,[],2))./(sqrt(size(Caribbean_Vol2Fill_dist,2)));
Vol2Fill_Caribbean_y=accumarray(y,(sum((Caribbean_OverUnder>0).*Caribbean_OverUnder)./1E12)',[],@nanmedian);
Vol2Fill_Caribbean_y_std=accumarray(y,var((Caribbean_Vol2Fill_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Vol2Fill_Caribbean_y=[(sum(Caribbean_OverUnder(:,1)))./1E12;Vol2Fill_Caribbean_y;(sum((Caribbean_OverUnder(:,500)>0).*Caribbean_OverUnder(:,500)))./1E12];
Vol2Fill_Caribbean_y_std=[(sqrt(var(Caribbean_Vol2Fill_dist(1,:)./1E12)))./(sqrt(2000));Vol2Fill_Caribbean_y_std;(sqrt(var(Caribbean_Vol2Fill_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,Vol2Fill_Caribbean_y(1:end),Vol2Fill_Caribbean_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Caribbean')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Volume Available (10^3 km^3)')
% N_Mediterranean
subplot(3,4,9)
Underfilled_N_Mediterranean=sum((N_Mediterranean_OverUnder>0).*N_Mediterranean_OverUnder); 
Underfilled_N_Mediterranean_SE=(std(N_Mediterranean_Vol2Fill_dist,[],2))./(sqrt(size(N_Mediterranean_Vol2Fill_dist,2)));
Vol2Fill_N_Mediterranean_y=accumarray(y,(sum((N_Mediterranean_OverUnder>0).*N_Mediterranean_OverUnder)./1E12)',[],@nanmedian);
Vol2Fill_N_Mediterranean_y_std=accumarray(y,var((N_Mediterranean_Vol2Fill_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Vol2Fill_N_Mediterranean_y=[(sum(N_Mediterranean_OverUnder(:,1)))./1E12;Vol2Fill_N_Mediterranean_y;(sum((N_Mediterranean_OverUnder(:,500)>0).*N_Mediterranean_OverUnder(:,500)))./1E12];
Vol2Fill_N_Mediterranean_y_std=[(sqrt(var(N_Mediterranean_Vol2Fill_dist(1,:)./1E12)))./(sqrt(2000));Vol2Fill_N_Mediterranean_y_std;(sqrt(var(N_Mediterranean_Vol2Fill_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,Vol2Fill_N_Mediterranean_y(1:end),Vol2Fill_N_Mediterranean_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Northern Mediterranean')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Volume Available (10^3 km^3)')
% MiddleEast
subplot(3,4,6)
Underfilled_MiddleEast=sum((MiddleEast_OverUnder>0).*MiddleEast_OverUnder); 
Underfilled_MiddleEast_SE=(std(MiddleEast_Vol2Fill_dist,[],2))./(sqrt(size(MiddleEast_Vol2Fill_dist,2)));
Vol2Fill_MiddleEast_y=accumarray(y,(sum((MiddleEast_OverUnder>0).*MiddleEast_OverUnder)./1E12)',[],@nanmedian);
Vol2Fill_MiddleEast_y_std=accumarray(y,var((MiddleEast_Vol2Fill_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Vol2Fill_MiddleEast_y=[(sum(MiddleEast_OverUnder(:,1)))./1E12;Vol2Fill_MiddleEast_y;(sum((MiddleEast_OverUnder(:,500)>0).*MiddleEast_OverUnder(:,500)))./1E12];
Vol2Fill_MiddleEast_y_std=[(sqrt(var(MiddleEast_Vol2Fill_dist(1,:)./1E12)))./(sqrt(2000));Vol2Fill_MiddleEast_y_std;(sqrt(var(MiddleEast_Vol2Fill_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,Vol2Fill_MiddleEast_y(1:end),Vol2Fill_MiddleEast_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Middle East')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Volume Available (10^3 km^3)')
% E_Asia
subplot(3,4,4)
Underfilled_E_Asia=sum((E_Asia_OverUnder>0).*E_Asia_OverUnder); 
Underfilled_E_Asia_SE=(std(E_Asia_Vol2Fill_dist,[],2))./(sqrt(size(E_Asia_Vol2Fill_dist,2)));
Vol2Fill_E_Asia_y=accumarray(y,(sum((E_Asia_OverUnder>0).*E_Asia_OverUnder)./1E12)',[],@nanmedian);
Vol2Fill_E_Asia_y_std=accumarray(y,var((E_Asia_Vol2Fill_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Vol2Fill_E_Asia_y=[(sum(E_Asia_OverUnder(:,1)))./1E12;Vol2Fill_E_Asia_y;(sum((E_Asia_OverUnder(:,500)>0).*E_Asia_OverUnder(:,500)))./1E12];
Vol2Fill_E_Asia_y_std=[(sqrt(var(E_Asia_Vol2Fill_dist(1,:)./1E12)))./(sqrt(2000));Vol2Fill_E_Asia_y_std;(sqrt(var(E_Asia_Vol2Fill_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,Vol2Fill_E_Asia_y(1:end),Vol2Fill_E_Asia_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Eastern Asia')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Volume Available (10^3 km^3)')
% Oceania
subplot(3,4,10)
Underfilled_Oceania=sum((Oceania_OverUnder>0).*Oceania_OverUnder); 
Underfilled_Oceania_SE=(std(Oceania_Vol2Fill_dist,[],2))./(sqrt(size(Oceania_Vol2Fill_dist,2)));
Vol2Fill_Oceania_y=accumarray(y,(sum((Oceania_OverUnder>0).*Oceania_OverUnder)./1E12)',[],@nanmedian);
Vol2Fill_Oceania_y_std=accumarray(y,var((Oceania_Vol2Fill_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Vol2Fill_Oceania_y=[(sum(Oceania_OverUnder(:,1)))./1E12;Vol2Fill_Oceania_y;(sum((Oceania_OverUnder(:,500)>0).*Oceania_OverUnder(:,500)))./1E12];
Vol2Fill_Oceania_y_std=[(sqrt(var(Oceania_Vol2Fill_dist(1,:)./1E12)))./(sqrt(2000));Vol2Fill_Oceania_y_std;(sqrt(var(Oceania_Vol2Fill_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,Vol2Fill_Oceania_y(1:end),Vol2Fill_Oceania_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Oceania')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Volume Available (10^3 km^3)')
% Russia
subplot(3,4,5)
Underfilled_Russia=sum((Russia_OverUnder>0).*Russia_OverUnder); 
Underfilled_Russia_SE=(std(Russia_Vol2Fill_dist,[],2))./(sqrt(size(Russia_Vol2Fill_dist,2)));
Vol2Fill_Russia_y=accumarray(y,(sum((Russia_OverUnder>0).*Russia_OverUnder)./1E12)',[],@nanmedian);
Vol2Fill_Russia_y_std=accumarray(y,var((Russia_Vol2Fill_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Vol2Fill_Russia_y=[(sum(Russia_OverUnder(:,1)))./1E12;Vol2Fill_Russia_y;(sum((Russia_OverUnder(:,500)>0).*Russia_OverUnder(:,500)))./1E12];
Vol2Fill_Russia_y_std=[(sqrt(var(Russia_Vol2Fill_dist(1,:)./1E12)))./(sqrt(2000));Vol2Fill_Russia_y_std;(sqrt(var(Russia_Vol2Fill_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,Vol2Fill_Russia_y(1:end),Vol2Fill_Russia_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Eurasian Arctic')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Volume Available (10^3 km^3)')

%% Total Sediment Infill
figure;
subplot(3,4,1)
Infill_y=accumarray(y,(sum(Infill_total./1E12))',[],@nanmedian);
Infill_y_std=accumarray(y,var((Infill_total_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Infill_y=[0;Infill_y;sum((Infill_total(:,500))./1E12)];
Infill_y_std=[(sqrt(var(Infill_total_dist(1,:)./1E12)))./(sqrt(2000));Infill_y_std;(sqrt(var(Infill_total_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,Infill_y(1:end),Infill_y_std(1:end),'-ob','MarkerFaceColor','b','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Global')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Sediment Infill (10^3 km^3)')
% Africa
subplot(3,4,2)
Infill_Africa=sum(Africa_Infill);
Infill_Africa_SE=(std(Africa_Infill_dist,[],2))./(sqrt(size(Africa_Infill_dist,2)));
Infill_Africa_y=accumarray(y,(sum(Africa_Infill./1E12))',[],@nanmedian);
Infill_Africa_y_std=accumarray(y,var((Africa_Infill_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Infill_Africa_y=[0;Infill_Africa_y;sum((Africa_Infill(:,500))./1E12)];
Infill_Africa_y_std=[(sqrt(var(Africa_Infill_dist(1,:)./1E12)))./(sqrt(2000));Infill_Africa_y_std;(sqrt(var(Africa_Infill_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,Infill_Africa_y(1:end),Infill_Africa_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Africa')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Total Sediment in Valleys (10^3 km^3)')
% NorthandCentral_America
subplot(3,4,7)
Infill_NorthandCentral_America=sum(NorthandCentral_America_Infill);
Infill_NorthandCentral_America_SE=(std(NorthandCentral_America_Infill_dist,[],2))./(sqrt(size(NorthandCentral_America_Infill_dist,2)));
Infill_NorthandCentral_America_y=accumarray(y,(sum(NorthandCentral_America_Infill./1E12))',[],@nanmedian);
Infill_NorthandCentral_America_y_std=accumarray(y,var((NorthandCentral_America_Infill_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Infill_NorthandCentral_America_y=[0;Infill_NorthandCentral_America_y;sum((NorthandCentral_America_Infill(:,500))./1E12)];
Infill_NorthandCentral_America_y_std=[(sqrt(var(NorthandCentral_America_Infill_dist(1,:)./1E12)))./(sqrt(2000));Infill_NorthandCentral_America_y_std;(sqrt(var(NorthandCentral_America_Infill_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,Infill_NorthandCentral_America_y(1:end),Infill_NorthandCentral_America_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('North and Central America')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Sediment Infill (10^3 km^3)')
% SouthAmerica
subplot(3,4,11)
Infill_SouthAmerica=sum(SouthAmerica_Infill);
Infill_SouthAmerica_SE=(std(SouthAmerica_Infill_dist,[],2))./(sqrt(size(SouthAmerica_Infill_dist,2)));
Infill_SouthAmerica_y=accumarray(y,(sum(SouthAmerica_Infill./1E12))',[],@nanmedian);
Infill_SouthAmerica_y_std=accumarray(y,var((SouthAmerica_Infill_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Infill_SouthAmerica_y=[0;Infill_SouthAmerica_y;sum((SouthAmerica_Infill(:,500))./1E12)];
Infill_SouthAmerica_y_std=[(sqrt(var(SouthAmerica_Infill_dist(1,:)./1E12)))./(sqrt(2000));Infill_SouthAmerica_y_std;(sqrt(var(SouthAmerica_Infill_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,Infill_SouthAmerica_y(1:end),Infill_SouthAmerica_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('South America')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Sediment Infill (10^3 km^3)')
% NorthernEurope
subplot(3,4,8)
Infill_NorthernEurope=sum(NorthernEurope_Infill);
Infill_NorthernEurope_SE=(std(NorthernEurope_Infill_dist,[],2))./(sqrt(size(NorthernEurope_Infill_dist,2)));
Infill_NorthernEurope_y=accumarray(y,(sum(NorthernEurope_Infill./1E12))',[],@nanmedian);
Infill_NorthernEurope_y_std=accumarray(y,var((NorthernEurope_Infill_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Infill_NorthernEurope_y=[0;Infill_NorthernEurope_y;sum((NorthernEurope_Infill(:,500))./1E12)];
Infill_NorthernEurope_y_std=[(sqrt(var(NorthernEurope_Infill_dist(1,:)./1E12)))./(sqrt(2000));Infill_NorthernEurope_y_std;(sqrt(var(NorthernEurope_Infill_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,Infill_NorthernEurope_y(1:end),Infill_NorthernEurope_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Northern Europe')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Sediment Infill (10^3 km^3)')
% Southern_Asia
subplot(3,4,12)
Infill_Southern_Asia=sum(Southern_Asia_Infill);
Infill_Southern_Asia_SE=(std(Southern_Asia_Infill_dist,[],2))./(sqrt(size(Southern_Asia_Infill_dist,2)));
Infill_Southern_Asia_y=accumarray(y,(sum(Southern_Asia_Infill./1E12))',[],@nanmedian);
Infill_Southern_Asia_y_std=accumarray(y,var((Southern_Asia_Infill_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Infill_Southern_Asia_y=[0;Infill_Southern_Asia_y;sum((Southern_Asia_Infill(:,500))./1E12)];
Infill_Southern_Asia_y_std=[(sqrt(var(Southern_Asia_Infill_dist(1,:)./1E12)))./(sqrt(2000));Infill_Southern_Asia_y_std;(sqrt(var(Southern_Asia_Infill_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,Infill_Southern_Asia_y(1:end),Infill_Southern_Asia_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Southern Asia')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Sediment Infill (10^3 km^3)')
% Caribbean
subplot(3,4,3)
Infill_Caribbean=sum(Caribbean_Infill);
Infill_Caribbean_SE=(std(Caribbean_Infill_dist,[],2))./(sqrt(size(Caribbean_Infill_dist,2)));
Infill_Caribbean_y=accumarray(y,(sum(Caribbean_Infill./1E12))',[],@nanmedian);
Infill_Caribbean_y_std=accumarray(y,var((Caribbean_Infill_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Infill_Caribbean_y=[0;Infill_Caribbean_y;sum((Caribbean_Infill(:,500))./1E12)];
Infill_Caribbean_y_std=[(sqrt(var(Caribbean_Infill_dist(1,:)./1E12)))./(sqrt(2000));Infill_Caribbean_y_std;(sqrt(var(Caribbean_Infill_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,Infill_Caribbean_y(1:end),Infill_Caribbean_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Caribbean')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Sediment Infill (10^3 km^3)')
% N_Mediterranean
subplot(3,4,9)
Infill_N_Mediterranean=sum(N_Mediterranean_Infill);
Infill_N_Mediterranean_SE=(std(N_Mediterranean_Infill_dist,[],2))./(sqrt(size(N_Mediterranean_Infill_dist,2)));
Infill_N_Mediterranean_y=accumarray(y,(sum(N_Mediterranean_Infill./1E12))',[],@nanmedian);
Infill_N_Mediterranean_y_std=accumarray(y,var((N_Mediterranean_Infill_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Infill_N_Mediterranean_y=[0;Infill_N_Mediterranean_y;sum((N_Mediterranean_Infill(:,500))./1E12)];
Infill_N_Mediterranean_y_std=[(sqrt(var(N_Mediterranean_Infill_dist(1,:)./1E12)))./(sqrt(2000));Infill_N_Mediterranean_y_std;(sqrt(var(N_Mediterranean_Infill_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,Infill_N_Mediterranean_y(1:end),Infill_N_Mediterranean_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Northern Mediterranean')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Sediment Infill (10^3 km^3)')
% MiddleEast
subplot(3,4,6)
Infill_MiddleEast=sum(MiddleEast_Infill);
Infill_MiddleEast_SE=(std(MiddleEast_Infill_dist,[],2))./(sqrt(size(MiddleEast_Infill_dist,2)));
Infill_MiddleEast_y=accumarray(y,(sum(MiddleEast_Infill./1E12))',[],@nanmedian);
Infill_MiddleEast_y_std=accumarray(y,var((MiddleEast_Infill_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Infill_MiddleEast_y=[0;Infill_MiddleEast_y;sum((MiddleEast_Infill(:,500))./1E12)];
Infill_MiddleEast_y_std=[(sqrt(var(MiddleEast_Infill_dist(1,:)./1E12)))./(sqrt(2000));Infill_MiddleEast_y_std;(sqrt(var(MiddleEast_Infill_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,Infill_MiddleEast_y(1:end),Infill_MiddleEast_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Middle East')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Sediment Infill (10^3 km^3)')
% E_Asia
subplot(3,4,4)
Infill_E_Asia=sum(E_Asia_Infill);
Infill_E_Asia_SE=(std(E_Asia_Infill_dist,[],2))./(sqrt(size(E_Asia_Infill_dist,2)));
Infill_E_Asia_y=accumarray(y,(sum(E_Asia_Infill./1E12))',[],@nanmedian);
Infill_E_Asia_y_std=accumarray(y,var((E_Asia_Infill_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Infill_E_Asia_y=[0;Infill_E_Asia_y;sum((E_Asia_Infill(:,500))./1E12)];
Infill_E_Asia_y_std=[(sqrt(var(E_Asia_Infill_dist(1,:)./1E12)))./(sqrt(2000));Infill_E_Asia_y_std;(sqrt(var(E_Asia_Infill_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,Infill_E_Asia_y(1:end),Infill_E_Asia_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Eastern Asia')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Sediment Infill (10^3 km^3)')
% Oceania
subplot(3,4,10)
Infill_Oceania=sum(Oceania_Infill);
Infill_Oceania_SE=(std(Oceania_Infill_dist,[],2))./(sqrt(size(Oceania_Infill_dist,2)));
Infill_Oceania_y=accumarray(y,(sum(Oceania_Infill./1E12))',[],@nanmedian);
Infill_Oceania_y_std=accumarray(y,var((Oceania_Infill_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Infill_Oceania_y=[0;Infill_Oceania_y;sum((Oceania_Infill(:,500))./1E12)];
Infill_Oceania_y_std=[(sqrt(var(Oceania_Infill_dist(1,:)./1E12)))./(sqrt(2000));Infill_Oceania_y_std;(sqrt(var(Oceania_Infill_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,Infill_Oceania_y(1:end),Infill_Oceania_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Oceania')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Sediment Infill (10^3 km^3)')
% Russia
subplot(3,4,5)
Infill_Russia=sum(Russia_Infill);
Infill_Russia_SE=(std(Russia_Infill_dist,[],2))./(sqrt(size(Russia_Infill_dist,2)));
Infill_Russia_y=accumarray(y,(sum(Russia_Infill./1E12))',[],@nanmedian);
Infill_Russia_y_std=accumarray(y,var((Russia_Infill_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Infill_Russia_y=[0;Infill_Russia_y;sum((Russia_Infill(:,500))./1E12)];
Infill_Russia_y_std=[(sqrt(var(Russia_Infill_dist(1,:)./1E12)))./(sqrt(2000));Infill_Russia_y_std;(sqrt(var(Russia_Infill_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,Infill_Russia_y(1:end),Infill_Russia_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Eurasian Arctic')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Sediment Infill (10^3 km^3)')

%% POC Plots
[Africa_Carbon,NorthandCentral_America_Carbon,SouthAmerica_Carbon,NorthernEurope_Carbon,Southern_Asia_Carbon,Caribbean_Carbon,N_Mediterranean_Carbon,MiddleEast_Carbon,E_Asia_Carbon,Oceania_Carbon,Russia_Carbon,Africa_mean_POC,NorthandCentral_America_mean_POC,SouthAmerica_mean_POC,NorthernEurope_mean_POC,Southern_Asia_mean_POC,Caribbean_mean_POC,N_Mediterranean_mean_POC,MiddleEast_mean_POC,E_Asia_mean_POC,Oceania_mean_POC,Russia_mean_POC,Africa_Carbon_per_delivered,NorthandCentral_America_Carbon_per_delivered,SouthAmerica_Carbon_per_delivered,NorthernEurope_Carbon_per_delivered,Southern_Asia_Carbon_per_delivered,Caribbean_Carbon_per_delivered,N_Mediterranean_Carbon_per_delivered,MiddleEast_Carbon_per_delivered,E_Asia_Carbon_per_delivered,Oceania_Carbon_per_delivered,Russia_Carbon_per_delivered,Africa_Carbon_Export,NorthandCentral_America_Carbon_Export,SouthAmerica_Carbon_Export,NorthernEurope_Carbon_Export,Southern_Asia_Carbon_Export,Caribbean_Carbon_Export,N_Mediterranean_Carbon_Export,MiddleEast_Carbon_Export,E_Asia_Carbon_Export,Oceania_Carbon_Export,Russia_Carbon_Export,Africa_Carbon_Nonburial,NorthandCentral_America_Carbon_Nonburial,SouthAmerica_Carbon_Nonburial,NorthernEurope_Carbon_Nonburial,Southern_Asia_Carbon_Nonburial,Caribbean_Carbon_Nonburial,N_Mediterranean_Carbon_Nonburial,MiddleEast_Carbon_Nonburial,E_Asia_Carbon_Nonburial,Oceania_Carbon_Nonburial,Russia_Carbon_Nonburial,Africa_Carbon_Lost,NorthandCentral_America_Carbon_Lost,SouthAmerica_Carbon_Lost,NorthernEurope_Carbon_Lost,Southern_Asia_Carbon_Lost,Caribbean_Carbon_Lost,N_Mediterranean_Carbon_Lost,MiddleEast_Carbon_Lost,E_Asia_Carbon_Lost,Oceania_Carbon_Lost,Russia_Carbon_Lost]=get_Carbon_regions(time,delta_poc,Discharge_prist,ChannelSlope,QRiver_converted,MouthLat,Region);
[Africa_Carbonsum_dist,NorthandCentral_America_Carbonsum_dist,SouthAmerica_Carbonsum_dist,NorthernEurope_Carbonsum_dist,Southern_Asia_Carbonsum_dist,Caribbean_Carbonsum_dist,N_Mediterranean_Carbonsum_dist,MiddleEast_Carbonsum_dist,E_Asia_Carbonsum_dist,Oceania_Carbonsum_dist,Russia_Carbonsum_dist,Africa_Carbon_per_delivered_dist,NorthandCentral_America_Carbon_per_delivered_dist,SouthAmerica_Carbon_per_delivered_dist,NorthernEurope_Carbon_per_delivered_dist,Southern_Asia_Carbon_per_delivered_dist,Caribbean_Carbon_per_delivered_dist,N_Mediterranean_Carbon_per_delivered_dist,MiddleEast_Carbon_per_delivered_dist,E_Asia_Carbon_per_delivered_dist,Oceania_Carbon_per_delivered_dist,Russia_Carbon_per_delivered_dist,Africa_Carboncum_dist,NorthandCentral_America_Carboncum_dist,SouthAmerica_Carboncum_dist,NorthernEurope_Carboncum_dist,Southern_Asia_Carboncum_dist,Caribbean_Carboncum_dist,N_Mediterranean_Carboncum_dist,MiddleEast_Carboncum_dist,E_Asia_Carboncum_dist,Oceania_Carboncum_dist,Russia_Carboncum_dist,Africa_Carbon_Export_dist,NorthandCentral_America_Carbon_Export_dist,SouthAmerica_Carbon_Export_dist,NorthernEurope_Carbon_Export_dist,Southern_Asia_Carbon_Export_dist,Caribbean_Carbon_Export_dist,N_Mediterranean_Carbon_Export_dist,MiddleEast_Carbon_Export_dist,E_Asia_Carbon_Export_dist,Oceania_Carbon_Export_dist,Russia_Carbon_Export_dist,Africa_Carbon_Nonburial_dist,NorthandCentral_America_Carbon_Nonburial_dist,SouthAmerica_Carbon_Nonburial_dist,NorthernEurope_Carbon_Nonburial_dist,Southern_Asia_Carbon_Nonburial_dist,Caribbean_Carbon_Nonburial_dist,N_Mediterranean_Carbon_Nonburial_dist,MiddleEast_Carbon_Nonburial_dist,E_Asia_Carbon_Nonburial_dist,Oceania_Carbon_Nonburial_dist,Russia_Carbon_Nonburial_dist,Africa_Carbon_Lost_dist,NorthandCentral_America_Carbon_Lost_dist,SouthAmerica_Carbon_Lost_dist,NorthernEurope_Carbon_Lost_dist,Southern_Asia_Carbon_Lost_dist,Caribbean_Carbon_Lost_dist,N_Mediterranean_Carbon_Lost_dist,MiddleEast_Carbon_Lost_dist,E_Asia_Carbon_Lost_dist,Oceania_Carbon_Lost_dist,Russia_Carbon_Lost_dist] = get_Carbon_regions_montecarlo(time,delta_poc,Discharge_prist,ChannelSlope,QRiver_converted,MouthLat,Region);

% POC Burial (not cumulative)
figure;
subplot(3,4,1)
Carbon_y=accumarray(y,(sum(Carbon_Infill./1E12))',[],@nanmedian);
Carbon_y_std=accumarray(y,var((Carbon_sum_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Carbon_y=[(sum(Carbon_Infill(:,1)./1E12));Carbon_y;(sum(Carbon_Infill(:,500)./1E12))];
Carbon_y_std=[(sqrt(var(Carbon_sum_dist(1,:)./1E12)))./(sqrt(2000));Carbon_y_std;(sqrt(var(Carbon_sum_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,Carbon_y(1:end),Carbon_y_std(1:end),'-ob','MarkerFaceColor','b','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Global')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('POC Burial (10^1^2 kg)')
% Africa
subplot(3,4,2)
Africa_Carbon_y=accumarray(y,(sum(Africa_Carbon./1E12))',[],@nanmedian);
Africa_Carbon_y_std=accumarray(y,var((Africa_Carbonsum_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Africa_Carbon_y=[(sum(Africa_Carbon(:,1)./1E12));Africa_Carbon_y;(sum(Africa_Carbon(:,500)./1E12))];
Africa_Carbon_y_std=[(sqrt(var(Africa_Carbonsum_dist(1,:)./1E12)))./(sqrt(2000));Africa_Carbon_y_std;(sqrt(var(Africa_Carbonsum_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,Africa_Carbon_y(1:end),Africa_Carbon_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Africa')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('POC Burial (10^1^2 kg)')
% NorthandCentral_America
subplot(3,4,7)
NorthandCentral_America_Carbon_y=accumarray(y,(sum(NorthandCentral_America_Carbon./1E12))',[],@nanmedian);
NorthandCentral_America_Carbon_y_std=accumarray(y,var((NorthandCentral_America_Carbonsum_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
NorthandCentral_America_Carbon_y=[(sum(NorthandCentral_America_Carbon(:,1)./1E12));NorthandCentral_America_Carbon_y;(sum(NorthandCentral_America_Carbon(:,500)./1E12))];
NorthandCentral_America_Carbon_y_std=[(sqrt(var(NorthandCentral_America_Carbonsum_dist(1,:)./1E12)))./(sqrt(2000));NorthandCentral_America_Carbon_y_std;(sqrt(var(NorthandCentral_America_Carbonsum_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,NorthandCentral_America_Carbon_y(1:end),NorthandCentral_America_Carbon_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('North and Central America')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('POC Burial (10^1^2 kg)')
% SouthAmerica
subplot(3,4,11)
SouthAmerica_Carbon_y=accumarray(y,(sum(SouthAmerica_Carbon./1E12))',[],@nanmedian);
SouthAmerica_Carbon_y_std=accumarray(y,var((SouthAmerica_Carbonsum_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
SouthAmerica_Carbon_y=[(sum(SouthAmerica_Carbon(:,1)./1E12));SouthAmerica_Carbon_y;(sum(SouthAmerica_Carbon(:,500)./1E12))];
SouthAmerica_Carbon_y_std=[(sqrt(var(SouthAmerica_Carbonsum_dist(1,:)./1E12)))./(sqrt(2000));SouthAmerica_Carbon_y_std;(sqrt(var(SouthAmerica_Carbonsum_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,SouthAmerica_Carbon_y(1:end),SouthAmerica_Carbon_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('South America')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('POC Burial (10^1^2 kg)')
% NorthernEurope
subplot(3,4,8)
NorthernEurope_Carbon_y=accumarray(y,(sum(NorthernEurope_Carbon./1E12))',[],@nanmedian);
NorthernEurope_Carbon_y_std=accumarray(y,var((NorthernEurope_Carbonsum_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
NorthernEurope_Carbon_y=[(sum(NorthernEurope_Carbon(:,1)./1E12));NorthernEurope_Carbon_y;(sum(NorthernEurope_Carbon(:,500)./1E12))];
NorthernEurope_Carbon_y_std=[(sqrt(var(NorthernEurope_Carbonsum_dist(1,:)./1E12)))./(sqrt(2000));NorthernEurope_Carbon_y_std;(sqrt(var(NorthernEurope_Carbonsum_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,NorthernEurope_Carbon_y(1:end),NorthernEurope_Carbon_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Northern Europe')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('POC Burial (10^1^2 kg)')
% Southern_Asia
subplot(3,4,12)
Southern_Asia_Carbon_y=accumarray(y,(sum(Southern_Asia_Carbon./1E12))',[],@nanmedian);
Southern_Asia_Carbon_y_std=accumarray(y,var((Southern_Asia_Carbonsum_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Southern_Asia_Carbon_y=[(sum(Southern_Asia_Carbon(:,1)./1E12));Southern_Asia_Carbon_y;(sum(Southern_Asia_Carbon(:,500)./1E12))];
Southern_Asia_Carbon_y_std=[(sqrt(var(Southern_Asia_Carbonsum_dist(1,:)./1E12)))./(sqrt(2000));Southern_Asia_Carbon_y_std;(sqrt(var(Southern_Asia_Carbonsum_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,Southern_Asia_Carbon_y(1:end),Southern_Asia_Carbon_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Southern Asia')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('POC Burial (10^1^2 kg)')
% Caribbean
subplot(3,4,3)
Caribbean_Carbon_y=accumarray(y,(sum(Caribbean_Carbon./1E12))',[],@nanmedian);
Caribbean_Carbon_y_std=accumarray(y,var((Caribbean_Carbonsum_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Caribbean_Carbon_y=[(sum(Caribbean_Carbon(:,1)./1E12));Caribbean_Carbon_y;(sum(Caribbean_Carbon(:,500)./1E12))];
Caribbean_Carbon_y_std=[(sqrt(var(Caribbean_Carbonsum_dist(1,:)./1E12)))./(sqrt(2000));Caribbean_Carbon_y_std;(sqrt(var(Caribbean_Carbonsum_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,Caribbean_Carbon_y(1:end),Caribbean_Carbon_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Caribbean')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('POC Burial (10^1^2 kg)')
% N_Mediterranean
subplot(3,4,9)
N_Mediterranean_Carbon_y=accumarray(y,(sum(N_Mediterranean_Carbon./1E12))',[],@nanmedian);
N_Mediterranean_Carbon_y_std=accumarray(y,var((N_Mediterranean_Carbonsum_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
N_Mediterranean_Carbon_y=[(sum(N_Mediterranean_Carbon(:,1)./1E12));N_Mediterranean_Carbon_y;(sum(N_Mediterranean_Carbon(:,500)./1E12))];
N_Mediterranean_Carbon_y_std=[(sqrt(var(N_Mediterranean_Carbonsum_dist(1,:)./1E12)))./(sqrt(2000));N_Mediterranean_Carbon_y_std;(sqrt(var(N_Mediterranean_Carbonsum_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,N_Mediterranean_Carbon_y(1:end),N_Mediterranean_Carbon_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Northern Mediterranean')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('POC Burial (10^1^2 kg)')
% MiddleEast
subplot(3,4,6)
MiddleEast_Carbon_y=accumarray(y,(sum(MiddleEast_Carbon./1E12))',[],@nanmedian);
MiddleEast_Carbon_y_std=accumarray(y,var((MiddleEast_Carbonsum_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
MiddleEast_Carbon_y=[(sum(MiddleEast_Carbon(:,1)./1E12));MiddleEast_Carbon_y;(sum(MiddleEast_Carbon(:,500)./1E12))];
MiddleEast_Carbon_y_std=[(sqrt(var(MiddleEast_Carbonsum_dist(1,:)./1E12)))./(sqrt(2000));MiddleEast_Carbon_y_std;(sqrt(var(MiddleEast_Carbonsum_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,MiddleEast_Carbon_y(1:end),MiddleEast_Carbon_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Middle East')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('POC Burial (10^1^2 kg)')
% E_Asia
subplot(3,4,4)
E_Asia_Carbon_y=accumarray(y,(sum(E_Asia_Carbon./1E12))',[],@nanmedian);
E_Asia_Carbon_y_std=accumarray(y,var((E_Asia_Carbonsum_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
E_Asia_Carbon_y=[(sum(E_Asia_Carbon(:,1)./1E12));E_Asia_Carbon_y;(sum(E_Asia_Carbon(:,500)./1E12))];
E_Asia_Carbon_y_std=[(sqrt(var(E_Asia_Carbonsum_dist(1,:)./1E12)))./(sqrt(2000));E_Asia_Carbon_y_std;(sqrt(var(E_Asia_Carbonsum_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,E_Asia_Carbon_y(1:end),E_Asia_Carbon_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Eastern Asia')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('POC Burial (10^1^2 kg)')
% Oceania
subplot(3,4,10)
Oceania_Carbon_y=accumarray(y,(sum(Oceania_Carbon./1E12))',[],@nanmedian);
Oceania_Carbon_y_std=accumarray(y,var((Oceania_Carbonsum_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Oceania_Carbon_y=[(sum(Oceania_Carbon(:,1)./1E12));Oceania_Carbon_y;(sum(Oceania_Carbon(:,500)./1E12))];
Oceania_Carbon_y_std=[(sqrt(var(Oceania_Carbonsum_dist(1,:)./1E12)))./(sqrt(2000));Oceania_Carbon_y_std;(sqrt(var(Oceania_Carbonsum_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,Oceania_Carbon_y(1:end),Oceania_Carbon_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Oceania')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('POC Burial (10^1^2 kg)')
% Russia
subplot(3,4,5)
Russia_Carbon_y=accumarray(y,(sum(Russia_Carbon./1E12))',[],@nanmedian);
Russia_Carbon_y_std=accumarray(y,var((Russia_Carbonsum_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Russia_Carbon_y=[(sum(Russia_Carbon(:,1)./1E12));Russia_Carbon_y;(sum(Russia_Carbon(:,500)./1E12))];
Russia_Carbon_y_std=[(sqrt(var(Russia_Carbonsum_dist(1,:)./1E12)))./(sqrt(2000));Russia_Carbon_y_std;(sqrt(var(Russia_Carbonsum_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,Russia_Carbon_y(1:end),Russia_Carbon_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Eurasian Arctic')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('POC Burial (10^1^2 kg)')

%% Percent Burial
% All Rivers 
figure;
subplot(3,4,1)
Carbon_per_y=accumarray(y,(sum(Carbon_per_delivered))',[],@nanmedian);
Carbon_per_y_std=accumarray(y,var((Carbon_per_delivered_dist)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Carbon_per_y=[(sum(Carbon_per_delivered(:,1)));Carbon_per_y;(sum(Carbon_per_delivered(:,500)))];
Carbon_per_y_std=[(sqrt(var(Carbon_per_delivered_dist(1,:))))./(sqrt(2000));Carbon_per_y_std;(sqrt(var(Carbon_per_delivered_dist(500,:))))./(sqrt(2000))];
errorbar(x_error,Carbon_per_y(1:end),Carbon_per_y_std(1:end),'-ob','MarkerFaceColor','b','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Global')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('POC Burial (%)')
% Africa
subplot(3,4,2)
Africa_Carbon_percent_y=accumarray(y,(sum(Africa_Carbon_per_delivered))',[],@nanmedian);
Africa_Carbon_percent_y_std=accumarray(y,var((Africa_Carbon_per_delivered_dist)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Africa_Carbon_percent_y=[(sum(Africa_Carbon_per_delivered(:,1)));Africa_Carbon_percent_y;(sum(Africa_Carbon_per_delivered(:,500)))];
Africa_Carbon_percent_y_std=[(sqrt(var(Africa_Carbon_per_delivered_dist(1,:))))./(sqrt(2000));Africa_Carbon_percent_y_std;(sqrt(var(Africa_Carbon_per_delivered_dist(500,:))))./(sqrt(2000))];
errorbar(x_error,Africa_Carbon_percent_y(1:end),Africa_Carbon_percent_y_std(1:end),'-or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Africa')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('POC Burial (%)')
% NorthandCentral_America
subplot(3,4,7)
NorthandCentral_America_Carbon_percent_y=accumarray(y,(sum(NorthandCentral_America_Carbon_per_delivered))',[],@nanmedian);
NorthandCentral_America_Carbon_percent_y_std=accumarray(y,var((NorthandCentral_America_Carbon_per_delivered_dist)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
NorthandCentral_America_Carbon_percent_y=[(sum(NorthandCentral_America_Carbon_per_delivered(:,1)));NorthandCentral_America_Carbon_percent_y;(sum(NorthandCentral_America_Carbon_per_delivered(:,500)))];
NorthandCentral_America_Carbon_percent_y_std=[(sqrt(var(NorthandCentral_America_Carbon_per_delivered_dist(1,:))))./(sqrt(2000));NorthandCentral_America_Carbon_percent_y_std;(sqrt(var(NorthandCentral_America_Carbon_per_delivered_dist(500,:))))./(sqrt(2000))];
errorbar(x_error,NorthandCentral_America_Carbon_percent_y(1:end),NorthandCentral_America_Carbon_percent_y_std(1:end),'-or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('North and Central America')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('POC Burial (%)')
% SouthAmerica
subplot(3,4,11)
SouthAmerica_Carbon_percent_y=accumarray(y,(sum(SouthAmerica_Carbon_per_delivered))',[],@nanmedian);
SouthAmerica_Carbon_percent_y_std=accumarray(y,var((SouthAmerica_Carbon_per_delivered_dist)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
SouthAmerica_Carbon_percent_y=[(sum(SouthAmerica_Carbon_per_delivered(:,1)));SouthAmerica_Carbon_percent_y;(sum(SouthAmerica_Carbon_per_delivered(:,500)))];
SouthAmerica_Carbon_percent_y_std=[(sqrt(var(SouthAmerica_Carbon_per_delivered_dist(1,:))))./(sqrt(2000));SouthAmerica_Carbon_percent_y_std;(sqrt(var(SouthAmerica_Carbon_per_delivered_dist(500,:))))./(sqrt(2000))];
errorbar(x_error,SouthAmerica_Carbon_percent_y(1:end),SouthAmerica_Carbon_percent_y_std(1:end),'-or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('South America')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('POC Burial (%)')
% NorthernEurope
subplot(3,4,8)
NorthernEurope_Carbon_percent_y=accumarray(y,(sum(NorthernEurope_Carbon_per_delivered))',[],@nanmedian);
NorthernEurope_Carbon_percent_y_std=accumarray(y,var((NorthernEurope_Carbon_per_delivered_dist)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
NorthernEurope_Carbon_percent_y=[(sum(NorthernEurope_Carbon_per_delivered(:,1)));NorthernEurope_Carbon_percent_y;(sum(NorthernEurope_Carbon_per_delivered(:,500)))];
NorthernEurope_Carbon_percent_y_std=[(sqrt(var(NorthernEurope_Carbon_per_delivered_dist(1,:))))./(sqrt(2000));NorthernEurope_Carbon_percent_y_std;(sqrt(var(NorthernEurope_Carbon_per_delivered_dist(500,:))))./(sqrt(2000))];
errorbar(x_error,NorthernEurope_Carbon_percent_y(1:end),NorthernEurope_Carbon_percent_y_std(1:end),'-or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Northern Europe')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('POC Burial (%)')
% Southern_Asia
subplot(3,4,12)
Southern_Asia_Carbon_percent_y=accumarray(y,(sum(Southern_Asia_Carbon_per_delivered))',[],@nanmedian);
Southern_Asia_Carbon_percent_y_std=accumarray(y,var((Southern_Asia_Carbon_per_delivered_dist)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Southern_Asia_Carbon_percent_y=[(sum(Southern_Asia_Carbon_per_delivered(:,1)));Southern_Asia_Carbon_percent_y;(sum(Southern_Asia_Carbon_per_delivered(:,500)))];
Southern_Asia_Carbon_percent_y_std=[(sqrt(var(Southern_Asia_Carbon_per_delivered_dist(1,:))))./(sqrt(2000));Southern_Asia_Carbon_percent_y_std;(sqrt(var(Southern_Asia_Carbon_per_delivered_dist(500,:))))./(sqrt(2000))];
errorbar(x_error,Southern_Asia_Carbon_percent_y(1:end),Southern_Asia_Carbon_percent_y_std(1:end),'-or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Southern Asia')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('POC Burial (%)')
% Caribbean
subplot(3,4,3)
Caribbean_Carbon_percent_y=accumarray(y,(sum(Caribbean_Carbon_per_delivered))',[],@nanmedian);
Caribbean_Carbon_percent_y_std=accumarray(y,var((Caribbean_Carbon_per_delivered_dist)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Caribbean_Carbon_percent_y=[(sum(Caribbean_Carbon_per_delivered(:,1)));Caribbean_Carbon_percent_y;(sum(Caribbean_Carbon_per_delivered(:,500)))];
Caribbean_Carbon_percent_y_std=[(sqrt(var(Caribbean_Carbon_per_delivered_dist(1,:))))./(sqrt(2000));Caribbean_Carbon_percent_y_std;(sqrt(var(Caribbean_Carbon_per_delivered_dist(500,:))))./(sqrt(2000))];
errorbar(x_error,Caribbean_Carbon_percent_y(1:end),Caribbean_Carbon_percent_y_std(1:end),'-or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Caribbean')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('POC Burial (%)')
% N_Mediterranean
subplot(3,4,9)
N_Mediterranean_Carbon_percent_y=accumarray(y,(sum(N_Mediterranean_Carbon_per_delivered))',[],@nanmedian);
N_Mediterranean_Carbon_percent_y_std=accumarray(y,var((N_Mediterranean_Carbon_per_delivered_dist)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
N_Mediterranean_Carbon_percent_y=[(sum(N_Mediterranean_Carbon_per_delivered(:,1)));N_Mediterranean_Carbon_percent_y;(sum(N_Mediterranean_Carbon_per_delivered(:,500)))];
N_Mediterranean_Carbon_percent_y_std=[(sqrt(var(N_Mediterranean_Carbon_per_delivered_dist(1,:))))./(sqrt(2000));N_Mediterranean_Carbon_percent_y_std;(sqrt(var(N_Mediterranean_Carbon_per_delivered_dist(500,:))))./(sqrt(2000))];
errorbar(x_error,N_Mediterranean_Carbon_percent_y(1:end),N_Mediterranean_Carbon_percent_y_std(1:end),'-or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Northern Mediterranean')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('POC Burial (%)')
% MiddleEast
subplot(3,4,6)
MiddleEast_Carbon_percent_y=accumarray(y,(sum(MiddleEast_Carbon_per_delivered))',[],@nanmedian);
MiddleEast_Carbon_percent_y_std=accumarray(y,var((MiddleEast_Carbon_per_delivered_dist)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
MiddleEast_Carbon_percent_y=[(sum(MiddleEast_Carbon_per_delivered(:,1)));MiddleEast_Carbon_percent_y;(sum(MiddleEast_Carbon_per_delivered(:,500)))];
MiddleEast_Carbon_percent_y_std=[(sqrt(var(MiddleEast_Carbon_per_delivered_dist(1,:))))./(sqrt(2000));MiddleEast_Carbon_percent_y_std;(sqrt(var(MiddleEast_Carbon_per_delivered_dist(500,:))))./(sqrt(2000))];
errorbar(x_error,MiddleEast_Carbon_percent_y(1:end),MiddleEast_Carbon_percent_y_std(1:end),'-or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Middle East')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('POC Burial (%)')
% E_Asia
subplot(3,4,4)
E_Asia_Carbon_percent_y=accumarray(y,(sum(E_Asia_Carbon_per_delivered))',[],@nanmedian);
E_Asia_Carbon_percent_y_std=accumarray(y,var((E_Asia_Carbon_per_delivered_dist)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
E_Asia_Carbon_percent_y=[(sum(E_Asia_Carbon_per_delivered(:,1)));E_Asia_Carbon_percent_y;(sum(E_Asia_Carbon_per_delivered(:,500)))];
E_Asia_Carbon_percent_y_std=[(sqrt(var(E_Asia_Carbon_per_delivered_dist(1,:))))./(sqrt(2000));E_Asia_Carbon_percent_y_std;(sqrt(var(E_Asia_Carbon_per_delivered_dist(500,:))))./(sqrt(2000))];
errorbar(x_error,E_Asia_Carbon_percent_y(1:end),E_Asia_Carbon_percent_y_std(1:end),'-or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Eastern Asia')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('POC Burial (%)')
% Oceania
subplot(3,4,10)
Oceania_Carbon_percent_y=accumarray(y,(sum(Oceania_Carbon_per_delivered))',[],@nanmedian);
Oceania_Carbon_percent_y_std=accumarray(y,var((Oceania_Carbon_per_delivered_dist)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Oceania_Carbon_percent_y=[(sum(Oceania_Carbon_per_delivered(:,1)));Oceania_Carbon_percent_y;(sum(Oceania_Carbon_per_delivered(:,500)))];
Oceania_Carbon_percent_y_std=[(sqrt(var(Oceania_Carbon_per_delivered_dist(1,:))))./(sqrt(2000));Oceania_Carbon_percent_y_std;(sqrt(var(Oceania_Carbon_per_delivered_dist(500,:))))./(sqrt(2000))];
errorbar(x_error,Oceania_Carbon_percent_y(1:end),Oceania_Carbon_percent_y_std(1:end),'-or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Oceania')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('POC Burial (%)')
% Russia
subplot(3,4,5)
Russia_Carbon_percent_y=accumarray(y,(sum(Russia_Carbon_per_delivered))',[],@nanmedian);
Russia_Carbon_percent_y_std=accumarray(y,var((Russia_Carbon_per_delivered_dist)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Russia_Carbon_percent_y=[(sum(Russia_Carbon_per_delivered(:,1)));Russia_Carbon_percent_y;(sum(Russia_Carbon_per_delivered(:,500)))];
Russia_Carbon_percent_y_std=[(sqrt(var(Russia_Carbon_per_delivered_dist(1,:))))./(sqrt(2000));Russia_Carbon_percent_y_std;(sqrt(var(Russia_Carbon_per_delivered_dist(500,:))))./(sqrt(2000))];
errorbar(x_error,Russia_Carbon_percent_y(1:end),Russia_Carbon_percent_y_std(1:end),'-or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Eurasian Arctic')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('POC Burial (%)')

%% Cumulative C Burial
figure;
subplot(3,4,1)
Carbon_cum_y=accumarray(y,(cumsum(sum(Carbon_Infill./1E12)))',[],@nanmedian);
Carbon_cum_y_std=accumarray(y,var((Carbon_cum_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Cumulative=cumsum(sum(Carbon_Infill./1E12));
Carbon_cum_y=[0;Carbon_cum_y;Cumulative(1,500)];
Carbon_cum_y_std=[(sqrt(var(Carbon_cum_dist(1,:)./1E12)))./(sqrt(2000));Carbon_cum_y_std;(sqrt(var(Carbon_cum_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,Carbon_cum_y(1:end),Carbon_cum_y_std(1:end),'-ob','MarkerFaceColor','b','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Global')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Cumulative POC Burial (10^1^2 kg)')
ylim([0 120])
% Africa
subplot(3,4,2)
Africa_Carbon_cum_y=accumarray(y,(cumsum(sum(Africa_Carbon./1E12)))',[],@nanmedian);
Africa_Carbon_cum_y_std=accumarray(y,var((Africa_Carboncum_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Africa_Carbon_cum_final=cumsum(sum(Africa_Carbon))./1E12;
Africa_Carbon_cum_y=[0;Africa_Carbon_cum_y;Africa_Carbon_cum_final(:,end)];
Africa_Carbon_cum_y_std=[(sqrt(var(Africa_Carboncum_dist(1,:)./1E12)))./(sqrt(2000));Africa_Carbon_cum_y_std;(sqrt(var(Africa_Carboncum_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,Africa_Carbon_cum_y(1:end),Africa_Carbon_cum_y_std(1:end),'-or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Africa')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Cumulative POC Burial (10^1^2 kg)')
% NorthandCentral_America
subplot(3,4,7)
NorthandCentral_America_Carbon_cum_y=accumarray(y,(cumsum(sum(NorthandCentral_America_Carbon./1E12)))',[],@nanmedian);
NorthandCentral_America_Carbon_cum_y_std=accumarray(y,var((NorthandCentral_America_Carboncum_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
NorthandCentral_America_Carbon_cum_final=cumsum(sum(NorthandCentral_America_Carbon))./1E12;
NorthandCentral_America_Carbon_cum_y=[0;NorthandCentral_America_Carbon_cum_y;NorthandCentral_America_Carbon_cum_final(:,end)];
NorthandCentral_America_Carbon_cum_y_std=[(sqrt(var(NorthandCentral_America_Carboncum_dist(1,:)./1E12)))./(sqrt(2000));NorthandCentral_America_Carbon_cum_y_std;(sqrt(var(NorthandCentral_America_Carboncum_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,NorthandCentral_America_Carbon_cum_y(1:end),NorthandCentral_America_Carbon_cum_y_std(1:end),'-or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('North and Central America')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Cumulative POC Burial (10^1^2 kg)')
% SouthAmerica
subplot(3,4,11)
SouthAmerica_Carbon_cum_y=accumarray(y,(cumsum(sum(SouthAmerica_Carbon./1E12)))',[],@nanmedian);
SouthAmerica_Carbon_cum_y_std=accumarray(y,var((SouthAmerica_Carboncum_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
SouthAmerica_Carbon_cum_final=cumsum(sum(SouthAmerica_Carbon))./1E12;
SouthAmerica_Carbon_cum_y=[0;SouthAmerica_Carbon_cum_y;SouthAmerica_Carbon_cum_final(:,end)];
SouthAmerica_Carbon_cum_y_std=[(sqrt(var(SouthAmerica_Carboncum_dist(1,:)./1E12)))./(sqrt(2000));SouthAmerica_Carbon_cum_y_std;(sqrt(var(SouthAmerica_Carboncum_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,SouthAmerica_Carbon_cum_y(1:end),SouthAmerica_Carbon_cum_y_std(1:end),'-or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('South America')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Cumulative POC Burial (10^1^2 kg)')
% NorthernEurope
subplot(3,4,8)
NorthernEurope_Carbon_cum_y=accumarray(y,(cumsum(sum(NorthernEurope_Carbon./1E12)))',[],@nanmedian);
NorthernEurope_Carbon_cum_y_std=accumarray(y,var((NorthernEurope_Carboncum_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
NorthernEurope_Carbon_cum_final=cumsum(sum(NorthernEurope_Carbon))./1E12;
NorthernEurope_Carbon_cum_y=[0;NorthernEurope_Carbon_cum_y;NorthernEurope_Carbon_cum_final(:,end)];
NorthernEurope_Carbon_cum_y_std=[(sqrt(var(NorthernEurope_Carboncum_dist(1,:)./1E12)))./(sqrt(2000));NorthernEurope_Carbon_cum_y_std;(sqrt(var(NorthernEurope_Carboncum_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,NorthernEurope_Carbon_cum_y(1:end),NorthernEurope_Carbon_cum_y_std(1:end),'-or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Northern Europe')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Cumulative POC Burial (10^1^2 kg)')
% Southern_Asia
subplot(3,4,12)
Southern_Asia_Carbon_cum_y=accumarray(y,(cumsum(sum(Southern_Asia_Carbon./1E12)))',[],@nanmedian);
Southern_Asia_Carbon_cum_y_std=accumarray(y,var((Southern_Asia_Carboncum_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Southern_Asia_Carbon_cum_final=cumsum(sum(Southern_Asia_Carbon))./1E12;
Southern_Asia_Carbon_cum_y=[0;Southern_Asia_Carbon_cum_y;Southern_Asia_Carbon_cum_final(:,end)];
Southern_Asia_Carbon_cum_y_std=[(sqrt(var(Southern_Asia_Carboncum_dist(1,:)./1E12)))./(sqrt(2000));Southern_Asia_Carbon_cum_y_std;(sqrt(var(Southern_Asia_Carboncum_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,Southern_Asia_Carbon_cum_y(1:end),Southern_Asia_Carbon_cum_y_std(1:end),'-or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Southern Asia')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Cumulative POC Burial (10^1^2 kg)')
% Caribbean
subplot(3,4,3)
Caribbean_Carbon_cum_y=accumarray(y,(cumsum(sum(Caribbean_Carbon./1E12)))',[],@nanmedian);
Caribbean_Carbon_cum_y_std=accumarray(y,var((Caribbean_Carboncum_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Caribbean_Carbon_cum_final=cumsum(sum(Caribbean_Carbon))./1E12;
Caribbean_Carbon_cum_y=[0;Caribbean_Carbon_cum_y;Caribbean_Carbon_cum_final(:,end)];
Caribbean_Carbon_cum_y_std=[(sqrt(var(Caribbean_Carboncum_dist(1,:)./1E12)))./(sqrt(2000));Caribbean_Carbon_cum_y_std;(sqrt(var(Caribbean_Carboncum_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,Caribbean_Carbon_cum_y(1:end),Caribbean_Carbon_cum_y_std(1:end),'-or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Caribbean')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Cumulative POC Burial (10^1^2 kg)')
% N_Mediterranean
subplot(3,4,9)
N_Mediterranean_Carbon_cum_y=accumarray(y,(cumsum(sum(N_Mediterranean_Carbon./1E12)))',[],@nanmedian);
N_Mediterranean_Carbon_cum_y_std=accumarray(y,var((N_Mediterranean_Carboncum_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
N_Mediterranean_Carbon_cum_final=cumsum(sum(N_Mediterranean_Carbon))./1E12;
N_Mediterranean_Carbon_cum_y=[0;N_Mediterranean_Carbon_cum_y;N_Mediterranean_Carbon_cum_final(:,end)];
N_Mediterranean_Carbon_cum_y_std=[(sqrt(var(N_Mediterranean_Carboncum_dist(1,:)./1E12)))./(sqrt(2000));N_Mediterranean_Carbon_cum_y_std;(sqrt(var(N_Mediterranean_Carboncum_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,N_Mediterranean_Carbon_cum_y(1:end),N_Mediterranean_Carbon_cum_y_std(1:end),'-or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Northern Mediterranean')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Cumulative POC Burial (10^1^2 kg)')
% MiddleEast
subplot(3,4,6)
MiddleEast_Carbon_cum_y=accumarray(y,(cumsum(sum(MiddleEast_Carbon./1E12)))',[],@nanmedian);
MiddleEast_Carbon_cum_y_std=accumarray(y,var((MiddleEast_Carboncum_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
MiddleEast_Carbon_cum_final=cumsum(sum(MiddleEast_Carbon))./1E12;
MiddleEast_Carbon_cum_y=[0;MiddleEast_Carbon_cum_y;MiddleEast_Carbon_cum_final(:,end)];
MiddleEast_Carbon_cum_y_std=[(sqrt(var(MiddleEast_Carboncum_dist(1,:)./1E12)))./(sqrt(2000));MiddleEast_Carbon_cum_y_std;(sqrt(var(MiddleEast_Carboncum_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,MiddleEast_Carbon_cum_y(1:end),MiddleEast_Carbon_cum_y_std(1:end),'-or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Middle East')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Cumulative POC Burial (10^1^2 kg)')
% E_Asia
subplot(3,4,4)
E_Asia_Carbon_cum_y=accumarray(y,(cumsum(sum(E_Asia_Carbon./1E12)))',[],@nanmedian);
E_Asia_Carbon_cum_y_std=accumarray(y,var((E_Asia_Carboncum_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
E_Asia_Carbon_cum_final=cumsum(sum(E_Asia_Carbon))./1E12;
E_Asia_Carbon_cum_y=[0;E_Asia_Carbon_cum_y;E_Asia_Carbon_cum_final(:,end)];
E_Asia_Carbon_cum_y_std=[(sqrt(var(E_Asia_Carboncum_dist(1,:)./1E12)))./(sqrt(2000));E_Asia_Carbon_cum_y_std;(sqrt(var(E_Asia_Carboncum_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,E_Asia_Carbon_cum_y(1:end),E_Asia_Carbon_cum_y_std(1:end),'-or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Eastern Asia')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Cumulative POC Burial (10^1^2 kg)')
% Oceania
subplot(3,4,10)
Oceania_Carbon_cum_y=accumarray(y,(cumsum(sum(Oceania_Carbon./1E12)))',[],@nanmedian);
Oceania_Carbon_cum_y_std=accumarray(y,var((Oceania_Carboncum_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Oceania_Carbon_cum_final=cumsum(sum(Oceania_Carbon))./1E12;
Oceania_Carbon_cum_y=[0;Oceania_Carbon_cum_y;Oceania_Carbon_cum_final(:,end)];
Oceania_Carbon_cum_y_std=[(sqrt(var(Oceania_Carboncum_dist(1,:)./1E12)))./(sqrt(2000));Oceania_Carbon_cum_y_std;(sqrt(var(Oceania_Carboncum_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,Oceania_Carbon_cum_y(1:end),Oceania_Carbon_cum_y_std(1:end),'-or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Oceania')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Cumulative POC Burial (10^1^2 kg)')
% Russia
subplot(3,4,5)
Russia_Carbon_cum_y=accumarray(y,(cumsum(sum(Russia_Carbon./1E12)))',[],@nanmedian);
Russia_Carbon_cum_y_std=accumarray(y,var((Russia_Carboncum_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Russia_Carbon_cum_final=cumsum(sum(Russia_Carbon))./1E12;
Russia_Carbon_cum_y=[0;Russia_Carbon_cum_y;Russia_Carbon_cum_final(:,end)];
Russia_Carbon_cum_y_std=[(sqrt(var(Russia_Carboncum_dist(1,:)./1E12)))./(sqrt(2000));Russia_Carbon_cum_y_std;(sqrt(var(Russia_Carboncum_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,Russia_Carbon_cum_y(1:end),Russia_Carbon_cum_y_std(1:end),'-or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Eurasian Arctic')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Cumulative POC Burial (10^1^2 kg)')

%% Cumulative POC Lost From Overfilling
% All Rivers 
figure;
subplot(3,4,1)
Carbon_Export_y=accumarray(y,(cumsum(sum(Carbon_Export./1E12)))',[],@nanmedian);
Carbon_Export_y_std=accumarray(y,var((Carbon_Export_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
C_Ex=cumsum(sum(Carbon_Export./1E12));
Carbon_Export_y=[0;Carbon_Export_y;C_Ex(1,500)];
Carbon_Export_y_std=[(sqrt(var(Carbon_Export_dist(1,:)./1E12)))./(sqrt(2000));Carbon_Export_y_std;(sqrt(var(Carbon_Export_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,Carbon_Export_y(1:end),Carbon_Export_y_std(1:end),'-ob','MarkerFaceColor','b','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Global')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Overfilling POC Loss (10^1^2 kg)') 
% Africa
subplot(3,4,2)
Africa_Carbon_Export_y=accumarray(y,(cumsum(sum(Africa_Carbon_Export./1E12)))',[],@nanmedian);
Africa_Carbon_Export_y_std=accumarray(y,var((Africa_Carbon_Export_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
C_Ex_Africa=cumsum(sum(Africa_Carbon_Export./1E12));
Africa_Carbon_Export_y=[0;Africa_Carbon_Export_y;C_Ex_Africa(1,500)];
Africa_Carbon_Export_y_std=[(sqrt(var(Africa_Carbon_Export_dist(1,:)./1E12)))./(sqrt(2000));Africa_Carbon_Export_y_std;(sqrt(var(Africa_Carbon_Export_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,Africa_Carbon_Export_y(1:end),Africa_Carbon_Export_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Africa')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Overfilling POC Loss (10^1^2 kg)') 
% NorthandCentral_America
subplot(3,4,7)
NorthandCentral_America_Carbon_Export_y=accumarray(y,(cumsum(sum(NorthandCentral_America_Carbon_Export./1E12)))',[],@nanmedian);
NorthandCentral_America_Carbon_Export_y_std=accumarray(y,var((NorthandCentral_America_Carbon_Export_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
C_Ex_NorthandCentral_America=cumsum(sum(NorthandCentral_America_Carbon_Export./1E12));
NorthandCentral_America_Carbon_Export_y=[0;NorthandCentral_America_Carbon_Export_y;C_Ex_NorthandCentral_America(1,500)];
NorthandCentral_America_Carbon_Export_y_std=[(sqrt(var(NorthandCentral_America_Carbon_Export_dist(1,:)./1E12)))./(sqrt(2000));NorthandCentral_America_Carbon_Export_y_std;(sqrt(var(NorthandCentral_America_Carbon_Export_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,NorthandCentral_America_Carbon_Export_y(1:end),NorthandCentral_America_Carbon_Export_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('North and Central America')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Overfilling POC Loss (10^1^2 kg)') 
% SouthAmerica
subplot(3,4,11)
SouthAmerica_Carbon_Export_y=accumarray(y,(cumsum(sum(SouthAmerica_Carbon_Export./1E12)))',[],@nanmedian);
SouthAmerica_Carbon_Export_y_std=accumarray(y,var((SouthAmerica_Carbon_Export_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
C_Ex_SouthAmerica=cumsum(sum(SouthAmerica_Carbon_Export./1E12));
SouthAmerica_Carbon_Export_y=[0;SouthAmerica_Carbon_Export_y;C_Ex_SouthAmerica(1,500)];
SouthAmerica_Carbon_Export_y_std=[(sqrt(var(SouthAmerica_Carbon_Export_dist(1,:)./1E12)))./(sqrt(2000));SouthAmerica_Carbon_Export_y_std;(sqrt(var(SouthAmerica_Carbon_Export_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,SouthAmerica_Carbon_Export_y(1:end),SouthAmerica_Carbon_Export_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('South America')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Overfilling POC Loss (10^1^2 kg)') 
% NorthernEurope
subplot(3,4,8)
NorthernEurope_Carbon_Export_y=accumarray(y,(cumsum(sum(NorthernEurope_Carbon_Export./1E12)))',[],@nanmedian);
NorthernEurope_Carbon_Export_y_std=accumarray(y,var((NorthernEurope_Carbon_Export_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
C_Ex_NorthernEurope=cumsum(sum(NorthernEurope_Carbon_Export./1E12));
NorthernEurope_Carbon_Export_y=[0;NorthernEurope_Carbon_Export_y;C_Ex_NorthernEurope(1,500)];
NorthernEurope_Carbon_Export_y_std=[(sqrt(var(NorthernEurope_Carbon_Export_dist(1,:)./1E12)))./(sqrt(2000));NorthernEurope_Carbon_Export_y_std;(sqrt(var(NorthernEurope_Carbon_Export_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,NorthernEurope_Carbon_Export_y(1:end),NorthernEurope_Carbon_Export_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Northern Europe')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Overfilling POC Loss (10^1^2 kg)') 
% Southern_Asia
subplot(3,4,12)
Southern_Asia_Carbon_Export_y=accumarray(y,(cumsum(sum(Southern_Asia_Carbon_Export./1E12)))',[],@nanmedian);
Southern_Asia_Carbon_Export_y_std=accumarray(y,var((Southern_Asia_Carbon_Export_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
C_Ex_Southern_Asia=cumsum(sum(Southern_Asia_Carbon_Export./1E12));
Southern_Asia_Carbon_Export_y=[0;Southern_Asia_Carbon_Export_y;C_Ex_Southern_Asia(1,500)];
Southern_Asia_Carbon_Export_y_std=[(sqrt(var(Southern_Asia_Carbon_Export_dist(1,:)./1E12)))./(sqrt(2000));Southern_Asia_Carbon_Export_y_std;(sqrt(var(Southern_Asia_Carbon_Export_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,Southern_Asia_Carbon_Export_y(1:end),Southern_Asia_Carbon_Export_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Southern Asia')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Overfilling POC Loss (10^1^2 kg)') 
% Caribbean
subplot(3,4,3)
Caribbean_Carbon_Export_y=accumarray(y,(cumsum(sum(Caribbean_Carbon_Export./1E12)))',[],@nanmedian);
Caribbean_Carbon_Export_y_std=accumarray(y,var((Caribbean_Carbon_Export_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
C_Ex_Caribbean=cumsum(sum(Caribbean_Carbon_Export./1E12));
Caribbean_Carbon_Export_y=[0;Caribbean_Carbon_Export_y;C_Ex_Caribbean(1,500)];
Caribbean_Carbon_Export_y_std=[(sqrt(var(Caribbean_Carbon_Export_dist(1,:)./1E12)))./(sqrt(2000));Caribbean_Carbon_Export_y_std;(sqrt(var(Caribbean_Carbon_Export_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,Caribbean_Carbon_Export_y(1:end),Caribbean_Carbon_Export_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Caribbean')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Overfilling POC Loss (10^1^2 kg)') 
% N_Mediterranean
subplot(3,4,9)
N_Mediterranean_Carbon_Export_y=accumarray(y,(cumsum(sum(N_Mediterranean_Carbon_Export./1E12)))',[],@nanmedian);
N_Mediterranean_Carbon_Export_y_std=accumarray(y,var((N_Mediterranean_Carbon_Export_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
C_Ex_N_Mediterranean=cumsum(sum(N_Mediterranean_Carbon_Export./1E12));
N_Mediterranean_Carbon_Export_y=[0;N_Mediterranean_Carbon_Export_y;C_Ex_N_Mediterranean(1,500)];
N_Mediterranean_Carbon_Export_y_std=[(sqrt(var(N_Mediterranean_Carbon_Export_dist(1,:)./1E12)))./(sqrt(2000));N_Mediterranean_Carbon_Export_y_std;(sqrt(var(N_Mediterranean_Carbon_Export_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,N_Mediterranean_Carbon_Export_y(1:end),N_Mediterranean_Carbon_Export_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Northern Mediterranean')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Overfilling POC Loss (10^1^2 kg)') 
% MiddleEast
subplot(3,4,6)
MiddleEast_Carbon_Export_y=accumarray(y,(cumsum(sum(MiddleEast_Carbon_Export./1E12)))',[],@nanmedian);
MiddleEast_Carbon_Export_y_std=accumarray(y,var((MiddleEast_Carbon_Export_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
C_Ex_MiddleEast=cumsum(sum(MiddleEast_Carbon_Export./1E12));
MiddleEast_Carbon_Export_y=[0;MiddleEast_Carbon_Export_y;C_Ex_MiddleEast(1,500)];
MiddleEast_Carbon_Export_y_std=[(sqrt(var(MiddleEast_Carbon_Export_dist(1,:)./1E12)))./(sqrt(2000));MiddleEast_Carbon_Export_y_std;(sqrt(var(MiddleEast_Carbon_Export_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,MiddleEast_Carbon_Export_y(1:end),MiddleEast_Carbon_Export_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Middle East')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Overfilling POC Loss (10^1^2 kg)') 
% E_Asia
subplot(3,4,4)
E_Asia_Carbon_Export_y=accumarray(y,(cumsum(sum(E_Asia_Carbon_Export./1E12)))',[],@nanmedian);
E_Asia_Carbon_Export_y_std=accumarray(y,var((E_Asia_Carbon_Export_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
C_Ex_E_Asia=cumsum(sum(E_Asia_Carbon_Export./1E12));
E_Asia_Carbon_Export_y=[0;E_Asia_Carbon_Export_y;C_Ex_E_Asia(1,500)];
E_Asia_Carbon_Export_y_std=[(sqrt(var(E_Asia_Carbon_Export_dist(1,:)./1E12)))./(sqrt(2000));E_Asia_Carbon_Export_y_std;(sqrt(var(E_Asia_Carbon_Export_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,E_Asia_Carbon_Export_y(1:end),E_Asia_Carbon_Export_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Eastern Asia')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Overfilling POC Loss (10^1^2 kg)') 
% Oceania
subplot(3,4,10)
Oceania_Carbon_Export_y=accumarray(y,(cumsum(sum(Oceania_Carbon_Export./1E12)))',[],@nanmedian);
Oceania_Carbon_Export_y_std=accumarray(y,var((Oceania_Carbon_Export_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
C_Ex_Oceania=cumsum(sum(Oceania_Carbon_Export./1E12));
Oceania_Carbon_Export_y=[0;Oceania_Carbon_Export_y;C_Ex_Oceania(1,500)];
Oceania_Carbon_Export_y_std=[(sqrt(var(Oceania_Carbon_Export_dist(1,:)./1E12)))./(sqrt(2000));Oceania_Carbon_Export_y_std;(sqrt(var(Oceania_Carbon_Export_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,Oceania_Carbon_Export_y(1:end),Oceania_Carbon_Export_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Oceania')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Overfilling POC Loss (10^1^2 kg)') 
% Russia
subplot(3,4,5)
Russia_Carbon_Export_y=accumarray(y,(cumsum(sum(Russia_Carbon_Export./1E12)))',[],@nanmedian);
Russia_Carbon_Export_y_std=accumarray(y,var((Russia_Carbon_Export_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
C_Ex_Russia=cumsum(sum(Russia_Carbon_Export./1E12));
Russia_Carbon_Export_y=[0;Russia_Carbon_Export_y;C_Ex_Russia(1,500)];
Russia_Carbon_Export_y_std=[(sqrt(var(Russia_Carbon_Export_dist(1,:)./1E12)))./(sqrt(2000));Russia_Carbon_Export_y_std;(sqrt(var(Russia_Carbon_Export_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,Russia_Carbon_Export_y(1:end),Russia_Carbon_Export_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Eurasian Arctic')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Overfilling POC Loss (10^1^2 kg)') 

%% Loss from Nonburial
% All rivers
figure;
subplot(3,4,1)
Carbon_Nonburial_y=accumarray(y,(cumsum(sum(Carbon_Nonburial./1E12)))',[],@nanmedian);
Carbon_Nonburial_y_std=accumarray(y,var((Carbon_Nonburial_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
C_Nonbur=cumsum(sum(Carbon_Nonburial./1E12));
Carbon_Nonburial_y=[0;Carbon_Nonburial_y;C_Nonbur(1,500)];
Carbon_Nonburial_y_std=[(sqrt(var(Carbon_Nonburial_dist(1,:)./1E12)))./(sqrt(2000));Carbon_Nonburial_y_std;(sqrt(var(Carbon_Nonburial_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,Carbon_Nonburial_y(1:end),Carbon_Nonburial_y_std(1:end),'-ob','MarkerFaceColor','b','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Global')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Non-Burial POC Loss (10^1^2 kg)') 
% Africa
subplot(3,4,2)
Africa_Carbon_Nonburial_y=accumarray(y,(cumsum(sum(Africa_Carbon_Nonburial./1E12)))',[],@nanmedian);
Africa_Carbon_Nonburial_y_std=accumarray(y,var((Africa_Carbon_Nonburial_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Africa_C_Nonbur=cumsum(sum(Africa_Carbon_Nonburial./1E12));
Africa_Carbon_Nonburial_y=[0;Africa_Carbon_Nonburial_y;Africa_C_Nonbur(1,500)];
Africa_Carbon_Nonburial_y_std=[(sqrt(var(Africa_Carbon_Nonburial_dist(1,:)./1E12)))./(sqrt(2000));Africa_Carbon_Nonburial_y_std;(sqrt(var(Africa_Carbon_Nonburial_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,Africa_Carbon_Nonburial_y(1:end),Africa_Carbon_Nonburial_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Africa')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Non-Burial POC Loss (10^1^2 kg)')
% NorthandCentral_America
subplot(3,4,7)
NorthandCentral_America_Carbon_Nonburial_y=accumarray(y,(cumsum(sum(NorthandCentral_America_Carbon_Nonburial./1E12)))',[],@nanmedian);
NorthandCentral_America_Carbon_Nonburial_y_std=accumarray(y,var((NorthandCentral_America_Carbon_Nonburial_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
NorthandCentral_America_C_Nonbur=cumsum(sum(NorthandCentral_America_Carbon_Nonburial./1E12));
NorthandCentral_America_Carbon_Nonburial_y=[0;NorthandCentral_America_Carbon_Nonburial_y;NorthandCentral_America_C_Nonbur(1,500)];
NorthandCentral_America_Carbon_Nonburial_y_std=[(sqrt(var(NorthandCentral_America_Carbon_Nonburial_dist(1,:)./1E12)))./(sqrt(2000));NorthandCentral_America_Carbon_Nonburial_y_std;(sqrt(var(NorthandCentral_America_Carbon_Nonburial_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,NorthandCentral_America_Carbon_Nonburial_y(1:end),NorthandCentral_America_Carbon_Nonburial_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('North and Central America')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Non-Burial POC Loss (10^1^2 kg)')
% SouthAmerica
subplot(3,4,11)
SouthAmerica_Carbon_Nonburial_y=accumarray(y,(cumsum(sum(SouthAmerica_Carbon_Nonburial./1E12)))',[],@nanmedian);
SouthAmerica_Carbon_Nonburial_y_std=accumarray(y,var((SouthAmerica_Carbon_Nonburial_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
SouthAmerica_C_Nonbur=cumsum(sum(SouthAmerica_Carbon_Nonburial./1E12));
SouthAmerica_Carbon_Nonburial_y=[0;SouthAmerica_Carbon_Nonburial_y;SouthAmerica_C_Nonbur(1,500)];
SouthAmerica_Carbon_Nonburial_y_std=[(sqrt(var(SouthAmerica_Carbon_Nonburial_dist(1,:)./1E12)))./(sqrt(2000));SouthAmerica_Carbon_Nonburial_y_std;(sqrt(var(SouthAmerica_Carbon_Nonburial_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,SouthAmerica_Carbon_Nonburial_y(1:end),SouthAmerica_Carbon_Nonburial_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('South America')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Non-Burial POC Loss (10^1^2 kg)')
% NorthernEurope
subplot(3,4,8)
NorthernEurope_Carbon_Nonburial_y=accumarray(y,(cumsum(sum(NorthernEurope_Carbon_Nonburial./1E12)))',[],@nanmedian);
NorthernEurope_Carbon_Nonburial_y_std=accumarray(y,var((NorthernEurope_Carbon_Nonburial_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
NorthernEurope_C_Nonbur=cumsum(sum(NorthernEurope_Carbon_Nonburial./1E12));
NorthernEurope_Carbon_Nonburial_y=[0;NorthernEurope_Carbon_Nonburial_y;NorthernEurope_C_Nonbur(1,500)];
NorthernEurope_Carbon_Nonburial_y_std=[(sqrt(var(NorthernEurope_Carbon_Nonburial_dist(1,:)./1E12)))./(sqrt(2000));NorthernEurope_Carbon_Nonburial_y_std;(sqrt(var(NorthernEurope_Carbon_Nonburial_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,NorthernEurope_Carbon_Nonburial_y(1:end),NorthernEurope_Carbon_Nonburial_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Northern Europe')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Non-Burial POC Loss (10^1^2 kg)')
% Southern_Asia
subplot(3,4,12)
Southern_Asia_Carbon_Nonburial_y=accumarray(y,(cumsum(sum(Southern_Asia_Carbon_Nonburial./1E12)))',[],@nanmedian);
Southern_Asia_Carbon_Nonburial_y_std=accumarray(y,var((Southern_Asia_Carbon_Nonburial_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Southern_Asia_C_Nonbur=cumsum(sum(Southern_Asia_Carbon_Nonburial./1E12));
Southern_Asia_Carbon_Nonburial_y=[0;Southern_Asia_Carbon_Nonburial_y;Southern_Asia_C_Nonbur(1,500)];
Southern_Asia_Carbon_Nonburial_y_std=[(sqrt(var(Southern_Asia_Carbon_Nonburial_dist(1,:)./1E12)))./(sqrt(2000));Southern_Asia_Carbon_Nonburial_y_std;(sqrt(var(Southern_Asia_Carbon_Nonburial_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,Southern_Asia_Carbon_Nonburial_y(1:end),Southern_Asia_Carbon_Nonburial_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Southern Asia')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Non-Burial POC Loss (10^1^2 kg)')
% Caribbean
subplot(3,4,3)
Caribbean_Carbon_Nonburial_y=accumarray(y,(cumsum(sum(Caribbean_Carbon_Nonburial./1E12)))',[],@nanmedian);
Caribbean_Carbon_Nonburial_y_std=accumarray(y,var((Caribbean_Carbon_Nonburial_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Caribbean_C_Nonbur=cumsum(sum(Caribbean_Carbon_Nonburial./1E12));
Caribbean_Carbon_Nonburial_y=[0;Caribbean_Carbon_Nonburial_y;Caribbean_C_Nonbur(1,500)];
Caribbean_Carbon_Nonburial_y_std=[(sqrt(var(Caribbean_Carbon_Nonburial_dist(1,:)./1E12)))./(sqrt(2000));Caribbean_Carbon_Nonburial_y_std;(sqrt(var(Caribbean_Carbon_Nonburial_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,Caribbean_Carbon_Nonburial_y(1:end),Caribbean_Carbon_Nonburial_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Caribbean')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Non-Burial POC Loss (10^1^2 kg)')
% N_Mediterranean
subplot(3,4,9)
N_Mediterranean_Carbon_Nonburial_y=accumarray(y,(cumsum(sum(N_Mediterranean_Carbon_Nonburial./1E12)))',[],@nanmedian);
N_Mediterranean_Carbon_Nonburial_y_std=accumarray(y,var((N_Mediterranean_Carbon_Nonburial_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
N_Mediterranean_C_Nonbur=cumsum(sum(N_Mediterranean_Carbon_Nonburial./1E12));
N_Mediterranean_Carbon_Nonburial_y=[0;N_Mediterranean_Carbon_Nonburial_y;N_Mediterranean_C_Nonbur(1,500)];
N_Mediterranean_Carbon_Nonburial_y_std=[(sqrt(var(N_Mediterranean_Carbon_Nonburial_dist(1,:)./1E12)))./(sqrt(2000));N_Mediterranean_Carbon_Nonburial_y_std;(sqrt(var(N_Mediterranean_Carbon_Nonburial_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,N_Mediterranean_Carbon_Nonburial_y(1:end),N_Mediterranean_Carbon_Nonburial_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Northern Mediterranean')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Non-Burial POC Loss (10^1^2 kg)')
% MiddleEast
subplot(3,4,6)
MiddleEast_Carbon_Nonburial_y=accumarray(y,(cumsum(sum(MiddleEast_Carbon_Nonburial./1E12)))',[],@nanmedian);
MiddleEast_Carbon_Nonburial_y_std=accumarray(y,var((MiddleEast_Carbon_Nonburial_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
MiddleEast_C_Nonbur=cumsum(sum(MiddleEast_Carbon_Nonburial./1E12));
MiddleEast_Carbon_Nonburial_y=[0;MiddleEast_Carbon_Nonburial_y;MiddleEast_C_Nonbur(1,500)];
MiddleEast_Carbon_Nonburial_y_std=[(sqrt(var(MiddleEast_Carbon_Nonburial_dist(1,:)./1E12)))./(sqrt(2000));MiddleEast_Carbon_Nonburial_y_std;(sqrt(var(MiddleEast_Carbon_Nonburial_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,MiddleEast_Carbon_Nonburial_y(1:end),MiddleEast_Carbon_Nonburial_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Middle East')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Non-Burial POC Loss (10^1^2 kg)')
% E_Asia
subplot(3,4,4)
E_Asia_Carbon_Nonburial_y=accumarray(y,(cumsum(sum(E_Asia_Carbon_Nonburial./1E12)))',[],@nanmedian);
E_Asia_Carbon_Nonburial_y_std=accumarray(y,var((E_Asia_Carbon_Nonburial_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
E_Asia_C_Nonbur=cumsum(sum(E_Asia_Carbon_Nonburial./1E12));
E_Asia_Carbon_Nonburial_y=[0;E_Asia_Carbon_Nonburial_y;E_Asia_C_Nonbur(1,500)];
E_Asia_Carbon_Nonburial_y_std=[(sqrt(var(E_Asia_Carbon_Nonburial_dist(1,:)./1E12)))./(sqrt(2000));E_Asia_Carbon_Nonburial_y_std;(sqrt(var(E_Asia_Carbon_Nonburial_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,E_Asia_Carbon_Nonburial_y(1:end),E_Asia_Carbon_Nonburial_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Eastern Asia')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Non-Burial POC Loss (10^1^2 kg)')
% Oceania
subplot(3,4,10)
Oceania_Carbon_Nonburial_y=accumarray(y,(cumsum(sum(Oceania_Carbon_Nonburial./1E12)))',[],@nanmedian);
Oceania_Carbon_Nonburial_y_std=accumarray(y,var((Oceania_Carbon_Nonburial_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Oceania_C_Nonbur=cumsum(sum(Oceania_Carbon_Nonburial./1E12));
Oceania_Carbon_Nonburial_y=[0;Oceania_Carbon_Nonburial_y;Oceania_C_Nonbur(1,500)];
Oceania_Carbon_Nonburial_y_std=[(sqrt(var(Oceania_Carbon_Nonburial_dist(1,:)./1E12)))./(sqrt(2000));Oceania_Carbon_Nonburial_y_std;(sqrt(var(Oceania_Carbon_Nonburial_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,Oceania_Carbon_Nonburial_y(1:end),Oceania_Carbon_Nonburial_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Oceania')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Non-Burial POC Loss (10^1^2 kg)')
% Russia
subplot(3,4,5)
Russia_Carbon_Nonburial_y=accumarray(y,(cumsum(sum(Russia_Carbon_Nonburial./1E12)))',[],@nanmedian);
Russia_Carbon_Nonburial_y_std=accumarray(y,var((Russia_Carbon_Nonburial_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Russia_C_Nonbur=cumsum(sum(Russia_Carbon_Nonburial./1E12));
Russia_Carbon_Nonburial_y=[0;Russia_Carbon_Nonburial_y;Russia_C_Nonbur(1,500)];
Russia_Carbon_Nonburial_y_std=[(sqrt(var(Russia_Carbon_Nonburial_dist(1,:)./1E12)))./(sqrt(2000));Russia_Carbon_Nonburial_y_std;(sqrt(var(Russia_Carbon_Nonburial_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,Russia_Carbon_Nonburial_y(1:end),Russia_Carbon_Nonburial_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Eurasian Arctic')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Non-Burial POC Loss (10^1^2 kg)')

%% Total Loss - Nonburial and Overfilling
figure;
subplot(3,4,1)
Carbon_Lost_y=accumarray(y,(cumsum(sum(Carbon_Lost./1E12)))',[],@nanmedian);
Carbon_Lost_y_std=accumarray(y,var((Carbon_Lost_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
C_Lost=cumsum(sum(Carbon_Lost./1E12));
Carbon_Lost_y=[0;Carbon_Lost_y;C_Lost(1,500)];
Carbon_Lost_y_std=[(sqrt(var(Carbon_Lost_dist(1,:)./1E12)))./(sqrt(2000));Carbon_Lost_y_std;(sqrt(var(Carbon_Lost_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,Carbon_Lost_y(1:end),Carbon_Lost_y_std(1:end),'-ob','MarkerFaceColor','b','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Global')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Total POC Loss (10^1^2 kg)')
% Africa
subplot(3,4,2)
Africa_Carbon_Lost_y=accumarray(y,(cumsum(sum(Africa_Carbon_Lost./1E12)))',[],@nanmedian);
Africa_Carbon_Lost_y_std=accumarray(y,var((Africa_Carbon_Lost_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Africa_C_Lost=cumsum(sum(Africa_Carbon_Lost./1E12));
Africa_Carbon_Lost_y=[0;Africa_Carbon_Lost_y;Africa_C_Lost(1,500)];
Africa_Carbon_Lost_y_std=[(sqrt(var(Africa_Carbon_Lost_dist(1,:)./1E12)))./(sqrt(2000));Africa_Carbon_Lost_y_std;(sqrt(var(Africa_Carbon_Lost_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,Africa_Carbon_Lost_y(1:end),Africa_Carbon_Lost_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Africa')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Total POC Loss (10^1^2 kg)')
% NorthandCentral_America
subplot(3,4,7)
NorthandCentral_America_Carbon_Lost_y=accumarray(y,(cumsum(sum(NorthandCentral_America_Carbon_Lost./1E12)))',[],@nanmedian);
NorthandCentral_America_Carbon_Lost_y_std=accumarray(y,var((NorthandCentral_America_Carbon_Lost_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
NorthandCentral_America_C_Lost=cumsum(sum(NorthandCentral_America_Carbon_Lost./1E12));
NorthandCentral_America_Carbon_Lost_y=[0;NorthandCentral_America_Carbon_Lost_y;NorthandCentral_America_C_Lost(1,500)];
NorthandCentral_America_Carbon_Lost_y_std=[(sqrt(var(NorthandCentral_America_Carbon_Lost_dist(1,:)./1E12)))./(sqrt(2000));NorthandCentral_America_Carbon_Lost_y_std;(sqrt(var(NorthandCentral_America_Carbon_Lost_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,NorthandCentral_America_Carbon_Lost_y(1:end),NorthandCentral_America_Carbon_Lost_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('North and Central America')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Total POC Loss (10^1^2 kg)')
% SouthAmerica
subplot(3,4,11)
SouthAmerica_Carbon_Lost_y=accumarray(y,(cumsum(sum(SouthAmerica_Carbon_Lost./1E12)))',[],@nanmedian);
SouthAmerica_Carbon_Lost_y_std=accumarray(y,var((SouthAmerica_Carbon_Lost_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
SouthAmerica_C_Lost=cumsum(sum(SouthAmerica_Carbon_Lost./1E12));
SouthAmerica_Carbon_Lost_y=[0;SouthAmerica_Carbon_Lost_y;SouthAmerica_C_Lost(1,500)];
SouthAmerica_Carbon_Lost_y_std=[(sqrt(var(SouthAmerica_Carbon_Lost_dist(1,:)./1E12)))./(sqrt(2000));SouthAmerica_Carbon_Lost_y_std;(sqrt(var(SouthAmerica_Carbon_Lost_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,SouthAmerica_Carbon_Lost_y(1:end),SouthAmerica_Carbon_Lost_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('South America')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Total POC Loss (10^1^2 kg)')
% NorthernEurope
subplot(3,4,8)
NorthernEurope_Carbon_Lost_y=accumarray(y,(cumsum(sum(NorthernEurope_Carbon_Lost./1E12)))',[],@nanmedian);
NorthernEurope_Carbon_Lost_y_std=accumarray(y,var((NorthernEurope_Carbon_Lost_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
NorthernEurope_C_Lost=cumsum(sum(NorthernEurope_Carbon_Lost./1E12));
NorthernEurope_Carbon_Lost_y=[0;NorthernEurope_Carbon_Lost_y;NorthernEurope_C_Lost(1,500)];
NorthernEurope_Carbon_Lost_y_std=[(sqrt(var(NorthernEurope_Carbon_Lost_dist(1,:)./1E12)))./(sqrt(2000));NorthernEurope_Carbon_Lost_y_std;(sqrt(var(NorthernEurope_Carbon_Lost_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,NorthernEurope_Carbon_Lost_y(1:end),NorthernEurope_Carbon_Lost_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Northern Europe')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Total POC Loss (10^1^2 kg)')
% Southern_Asia
subplot(3,4,12)
Southern_Asia_Carbon_Lost_y=accumarray(y,(cumsum(sum(Southern_Asia_Carbon_Lost./1E12)))',[],@nanmedian);
Southern_Asia_Carbon_Lost_y_std=accumarray(y,var((Southern_Asia_Carbon_Lost_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Southern_Asia_C_Lost=cumsum(sum(Southern_Asia_Carbon_Lost./1E12));
Southern_Asia_Carbon_Lost_y=[0;Southern_Asia_Carbon_Lost_y;Southern_Asia_C_Lost(1,500)];
Southern_Asia_Carbon_Lost_y_std=[(sqrt(var(Southern_Asia_Carbon_Lost_dist(1,:)./1E12)))./(sqrt(2000));Southern_Asia_Carbon_Lost_y_std;(sqrt(var(Southern_Asia_Carbon_Lost_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,Southern_Asia_Carbon_Lost_y(1:end),Southern_Asia_Carbon_Lost_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Southern Asia')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Total POC Loss (10^1^2 kg)')
% Caribbean
subplot(3,4,3)
Caribbean_Carbon_Lost_y=accumarray(y,(cumsum(sum(Caribbean_Carbon_Lost./1E12)))',[],@nanmedian);
Caribbean_Carbon_Lost_y_std=accumarray(y,var((Caribbean_Carbon_Lost_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Caribbean_C_Lost=cumsum(sum(Caribbean_Carbon_Lost./1E12));
Caribbean_Carbon_Lost_y=[0;Caribbean_Carbon_Lost_y;Caribbean_C_Lost(1,500)];
Caribbean_Carbon_Lost_y_std=[(sqrt(var(Caribbean_Carbon_Lost_dist(1,:)./1E12)))./(sqrt(2000));Caribbean_Carbon_Lost_y_std;(sqrt(var(Caribbean_Carbon_Lost_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,Caribbean_Carbon_Lost_y(1:end),Caribbean_Carbon_Lost_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Caribbean')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Total POC Loss (10^1^2 kg)')
% N_Mediterranean
subplot(3,4,9)
N_Mediterranean_Carbon_Lost_y=accumarray(y,(cumsum(sum(N_Mediterranean_Carbon_Lost./1E12)))',[],@nanmedian);
N_Mediterranean_Carbon_Lost_y_std=accumarray(y,var((N_Mediterranean_Carbon_Lost_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
N_Mediterranean_C_Lost=cumsum(sum(N_Mediterranean_Carbon_Lost./1E12));
N_Mediterranean_Carbon_Lost_y=[0;N_Mediterranean_Carbon_Lost_y;N_Mediterranean_C_Lost(1,500)];
N_Mediterranean_Carbon_Lost_y_std=[(sqrt(var(N_Mediterranean_Carbon_Lost_dist(1,:)./1E12)))./(sqrt(2000));N_Mediterranean_Carbon_Lost_y_std;(sqrt(var(N_Mediterranean_Carbon_Lost_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,N_Mediterranean_Carbon_Lost_y(1:end),N_Mediterranean_Carbon_Lost_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Northern Mediterranean')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Total POC Loss (10^1^2 kg)')
% MiddleEast
subplot(3,4,6)
MiddleEast_Carbon_Lost_y=accumarray(y,(cumsum(sum(MiddleEast_Carbon_Lost./1E12)))',[],@nanmedian);
MiddleEast_Carbon_Lost_y_std=accumarray(y,var((MiddleEast_Carbon_Lost_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
MiddleEast_C_Lost=cumsum(sum(MiddleEast_Carbon_Lost./1E12));
MiddleEast_Carbon_Lost_y=[0;MiddleEast_Carbon_Lost_y;MiddleEast_C_Lost(1,500)];
MiddleEast_Carbon_Lost_y_std=[(sqrt(var(MiddleEast_Carbon_Lost_dist(1,:)./1E12)))./(sqrt(2000));MiddleEast_Carbon_Lost_y_std;(sqrt(var(MiddleEast_Carbon_Lost_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,MiddleEast_Carbon_Lost_y(1:end),MiddleEast_Carbon_Lost_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Middle East')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Total POC Loss (10^1^2 kg)')
% E_Asia
subplot(3,4,4)
E_Asia_Carbon_Lost_y=accumarray(y,(cumsum(sum(E_Asia_Carbon_Lost./1E12)))',[],@nanmedian);
E_Asia_Carbon_Lost_y_std=accumarray(y,var((E_Asia_Carbon_Lost_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
E_Asia_C_Lost=cumsum(sum(E_Asia_Carbon_Lost./1E12));
E_Asia_Carbon_Lost_y=[0;E_Asia_Carbon_Lost_y;E_Asia_C_Lost(1,500)];
E_Asia_Carbon_Lost_y_std=[(sqrt(var(E_Asia_Carbon_Lost_dist(1,:)./1E12)))./(sqrt(2000));E_Asia_Carbon_Lost_y_std;(sqrt(var(E_Asia_Carbon_Lost_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,E_Asia_Carbon_Lost_y(1:end),E_Asia_Carbon_Lost_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Eastern Asia')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Total POC Loss (10^1^2 kg)')
% Oceania
subplot(3,4,10)
Oceania_Carbon_Lost_y=accumarray(y,(cumsum(sum(Oceania_Carbon_Lost./1E12)))',[],@nanmedian);
Oceania_Carbon_Lost_y_std=accumarray(y,var((Oceania_Carbon_Lost_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Oceania_C_Lost=cumsum(sum(Oceania_Carbon_Lost./1E12));
Oceania_Carbon_Lost_y=[0;Oceania_Carbon_Lost_y;Oceania_C_Lost(1,500)];
Oceania_Carbon_Lost_y_std=[(sqrt(var(Oceania_Carbon_Lost_dist(1,:)./1E12)))./(sqrt(2000));Oceania_Carbon_Lost_y_std;(sqrt(var(Oceania_Carbon_Lost_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,Oceania_Carbon_Lost_y(1:end),Oceania_Carbon_Lost_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Oceania')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Total POC Loss (10^1^2 kg)')
% Russia
subplot(3,4,5)
Russia_Carbon_Lost_y=accumarray(y,(cumsum(sum(Russia_Carbon_Lost./1E12)))',[],@nanmedian);
Russia_Carbon_Lost_y_std=accumarray(y,var((Russia_Carbon_Lost_dist./1E12)',1,1),[],@(x)(sqrt(nanmean(x))./sqrt(2000)));
Russia_C_Lost=cumsum(sum(Russia_Carbon_Lost./1E12));
Russia_Carbon_Lost_y=[0;Russia_Carbon_Lost_y;Russia_C_Lost(1,500)];
Russia_Carbon_Lost_y_std=[(sqrt(var(Russia_Carbon_Lost_dist(1,:)./1E12)))./(sqrt(2000));Russia_Carbon_Lost_y_std;(sqrt(var(Russia_Carbon_Lost_dist(500,:)./1E12)))./(sqrt(2000))];
errorbar(x_error,Russia_Carbon_Lost_y(1:end),Russia_Carbon_Lost_y_std(1:end),'-.or','MarkerFaceColor','r','LineWidth',2.0), %diff function calculates differences between adjacent elements of X along the first array dimension whos size does not equal 1
title('Russia')
xlabel('Time (ka B.P.)')
xticks([0 1000 2000 3000 4000 5000 6000])
xticklabels({'6','5','4','3','2','1','0'})
ylabel('Total POC Loss (10^1^2 kg)')

save('RegionSeparations')






