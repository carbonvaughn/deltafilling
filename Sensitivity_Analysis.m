%% Sensitivity Analyses
% Increase or decrease a parameter and see response
% Look at sensitivity of model output (e.g. Infilling, POC) by varying 

clear
load('carbondata')

%set(gcf, 'Units', 'Centimeters', 'OuterPosition', [0, 0, 18.3, 10]);
%set(gca, 'FontSize', 8,'FontName','Helvetica')
%saveas(gcf,'FigS2_sensitivity.svg')

%% Volume Sensitivity Analysis
Vol_mat = zeros(2,16); % 8 rows and 16 columns all with 0s, Original volume is 1.4345e13

for jj=1:2,
    
    f = ones(2,16);
    f(jj,:) = 0.5:0.1:2.0; % this part keeps 8 rows with all 1, 9th row starts at 0.5 and increases by 0.1 to 2.0, I think 0.5 means using half of the original value and 2.0 means doubling 
    
    for ii=1:size(f,2),
        [Vol] = get_volume(Discharge_prist.*f(1,ii),ChannelSlope.*f(2,ii));
         Vol_mat(jj,ii) = mean(sum(Vol));
    end % first line: size(f,2) refers to the 2nd dimension size of f (16); second line: looks like the only parameter that changes is the one applied to the 9th row of f, which is t_delta  

end

figure,plot((0.5:0.1:2),Vol_mat(1,:)/1E12,'--or','MarkerFaceColor','r','LineWidth',2.0), hold on, grid on % 'filled','MarkerEdgeColor','k'
plot((0.5:0.1:2),Vol_mat(2,:)/1E12,'--ob','MarkerFaceColor','b','LineWidth',2.0)
set(gca,'FontSize',13)
ylabel('Mean Global Valley Volume (10^1^2 km^3)')
xlabel('Parameter (compared to default estimate)')
legend('Discharge','Channel Slope')
hold off

% set(gcf, 'Units', 'Centimeters', 'OuterPosition', [0, 0, 18.3, 10]);
% set(gca, 'FontSize', 8,'FontName','Helvetica')
% saveas(gcf,'Volume_sensitivity.svg')

%% Overfilled Sensitivity Analysis
Over_mat = zeros(4,16); % 8 rows and 16 columns all with 0s, Original volume is 1.4345e13

for jj=1:4,
    
    f = ones(4,16);
    f(jj,:) = 0.5:0.1:2.0; % this part keeps 8 rows with all 1, 9th row starts at 0.5 and increases by 0.1 to 2.0, I think 0.5 means using half of the original value and 2.0 means doubling 
    
    for ii=1:size(f,2),
        [Overfilled_Identity] = get_OverUnder(QRiver_converted.*f(1,ii),time.*f(2,ii),Discharge_prist.*f(3,ii),ChannelSlope.*f(4,ii));
         Over_mat(jj,ii) = mean(sum(Overfilled_Identity));
    end % first line: size(f,2) refers to the 2nd dimension size of f (16); second line: looks like the only parameter that changes is the one applied to the 9th row of f, which is t_delta  

end

figure,plot((0.5:0.1:2),Over_mat(1,:),'--or','MarkerFaceColor','r','LineWidth',2.0), hold on, grid on
plot((0.5:0.1:2),Over_mat(2,:),'--ob','MarkerFaceColor','b','LineWidth',2.0)
plot((0.5:0.1:2),Over_mat(3,:),'--og','MarkerFaceColor','g','LineWidth',2.0)
plot((0.5:0.1:2),Over_mat(4,:),'--ok','MarkerFaceColor','k','LineWidth',2.0)
set(gca,'FontSize',13)
ylabel('Number of Overfilled Valleys')
xlabel('Parameter (compared to default estimate)')
legend('Sediment Discharge','Time/Time Points','River Discharge','Channel Slope') % Sediment Discharge and Time give same values since they're both multiplied by the same factor in the same term
hold off

Over_mat_Z_sediment = zscore(Over_mat(1,:));
Over_mat_Z_time = zscore(Over_mat(2,:));
Over_mat_Z_river = zscore(Over_mat(3,:));
Over_mat_Z_slope = zscore(Over_mat(4,:));
figure,plot((0.5:0.1:2),Over_mat_Z_sediment,'--or','MarkerFaceColor','r','LineWidth',2.0), hold on, grid on
plot((0.5:0.1:2),Over_mat_Z_time,'--ob','MarkerFaceColor','b','LineWidth',2.0)
plot((0.5:0.1:2),Over_mat_Z_river,'--og','MarkerFaceColor','g','LineWidth',2.0)
plot((0.5:0.1:2),Over_mat_Z_slope,'--ok','MarkerFaceColor','k','LineWidth',2.0)
legend('Sediment Discharge','Time/Time Points','River Discharge','Channel Slope') % Sediment Discharge and Time give same values since they're both multiplied by the same factor in the same term
hold off

%% Infill Sensitivity Analysis

Infill_sensitivity = zeros(5,16); % 8 rows and 16 columns all with 0s, Original volume is 1.4345e13

for jj=1:5,
    
    f = ones(5,16);
    f(jj,:) = 0.5:0.1:2.0; % this part keeps 8 rows with all 1, 9th row starts at 0.5 and increases by 0.1 to 2.0, I think 0.5 means using half of the original value and 2.0 means doubling 
    
    for ii=1:size(f,2),
        [OverUnder,Infill_total] = get_Infill(time.*f(1,ii),Discharge_prist.*f(2,ii),ChannelSlope.*f(3,ii),QRiver_converted.*f(4,ii),MouthLat.*f(5,ii));
        Infill_sensitivity(jj,ii) = sum(Infill_total(:,end));
        
        %[Infill_sensitivity(jj,ii)] = get_Infill_sensitivity(time.*f(1,ii),Discharge_prist.*f(2,ii),ChannelSlope.*f(3,ii),QRiver_converted.*f(4,ii));
         %Infill_mat(jj,ii) = mean(Infill_Summation(500));
         %Infill_mat(jj,ii) = sum(Infill_total(:,end));
         %Infill_mat(jj,ii) = sum(Infill_sensitivity);
         %Infill_mat(jj,ii) = Infill_sensitivity;
    end % first line: size(f,2) refers to the 2nd dimension size of f (16); second line: looks like the only parameter that changes is the one applied to the 9th row of f, which is t_delta  

end

% Total (original) infill should be 1.1818e13 or 11.82e12, and it is here
figure,plot((0.5:0.1:2),Infill_sensitivity(1,:)/1E12,'--or','MarkerFaceColor','r','LineWidth',2.0), hold on, grid on
plot((0.5:0.1:2),Infill_sensitivity(2,:)/1E12,'--ob','MarkerFaceColor','b','LineWidth',2.0)
plot((0.5:0.1:2),Infill_sensitivity(3,:)/1E12,'--og','MarkerFaceColor','g','LineWidth',2.0)
plot((0.5:0.1:2),Infill_sensitivity(4,:)/1E12,'--ok','MarkerFaceColor','k','LineWidth',2.0)
set(gca,'FontSize',13)
ylabel('Total Sediment Infill (10^3 km^3)')
xlabel('Parameter (compared to default estimate)')
legend('Time/Time Points','River Discharge','Channel Slope','Sediment Discharge') % Sediment Discharge and Time give same values since they're both multiplied by the same factor in the same term
hold off


Infill_sensitivity_Z_time = zscore(Infill_sensitivity(1,:));
Infill_sensitivity_Z_river = zscore(Infill_sensitivity(2,:));
Infill_sensitivity_Z_slope = zscore(Infill_sensitivity(3,:));
Infill_sensitivity_Z_sediment = zscore(Infill_sensitivity(4,:));
figure,plot((0.5:0.1:2),Infill_sensitivity_Z_time,'--or','MarkerFaceColor','r','LineWidth',2.0), hold on, grid on
plot((0.5:0.1:2),Infill_sensitivity_Z_river,'--ob','MarkerFaceColor','b','LineWidth',2.0)
plot((0.5:0.1:2),Infill_sensitivity_Z_slope,'--og','MarkerFaceColor','g','LineWidth',2.0)
plot((0.5:0.1:2),Infill_sensitivity_Z_sediment,'--ok','MarkerFaceColor','k','LineWidth',2.0)
legend('Time/Time Points','River Discharge','Channel Slope','Sediment Discharge') % Sediment Discharge and Time give same values since they're both multiplied by the same factor in the same term
hold off

%% Carbon Sensitivity Analysis

Carbon_mat = zeros(5,16); % 8 rows and 16 columns all with 0s, Original volume is 1.4345e13

for jj=1:5,
    
    f = ones(5,16);
    f(jj,:) = 0.5:0.1:2.0; % this part keeps 8 rows with all 1, 9th row starts at 0.5 and increases by 0.1 to 2.0, I think 0.5 means using half of the original value and 2.0 means doubling 
    
    for ii=1:size(f,2),
        [Carbon_Infill,Carbon_per_delivered,Carbon_Nonburial,Carbon_Export,Carbon_Lost] = get_Carbon(time.*f(1,ii),delta_poc.*f(2,ii),Discharge_prist.*f(3,ii),ChannelSlope.*f(4,ii),QRiver_converted.*f(5,ii));
        Carbon_sum=sum(cumsum(Carbon_Infill,2),1); 
        Carbon_mat(jj,ii) = mean(Carbon_sum(:,500));
    end % first line: size(f,2) refers to the 2nd dimension size of f (16); second line: looks like the only parameter that changes is the one applied to the 9th row of f, which is t_delta  

end

figure,plot((0.5:0.1:2),Carbon_mat(1,:)./1E12,'--or','MarkerFaceColor','r','LineWidth',2.0), hold on, grid on
plot((0.5:0.1:2),Carbon_mat(2,:)./1E12,'--om','MarkerFaceColor','m','LineWidth',2.0)
plot((0.5:0.1:2),Carbon_mat(3,:)./1E12,'--ob','MarkerFaceColor','b','LineWidth',2.0)
plot((0.5:0.1:2),Carbon_mat(4,:)./1E12,'--og','MarkerFaceColor','g','LineWidth',2.0)
plot((0.5:0.1:2),Carbon_mat(5,:)./1E12,'--ok','MarkerFaceColor','k','LineWidth',2.0)
set(gca,'FontSize',13)
ylabel('Total POC Infill (10^1^2 kg)')
xlabel('Parameter (compared to default estimate)')
legend('Time/Time Points','POC','River Discharge','Channel Slope','Sediment Discharge') % Sediment Discharge and Time give same values since they're both multiplied by the same factor in the same term
hold off

Carbon_mat_Z_time = zscore(Carbon_mat(1,:));
Carbon_mat_Z_POC = zscore(Carbon_mat(2,:));
Carbon_mat_Z_river = zscore(Carbon_mat(3,:));
Carbon_mat_Z_slope = zscore(Carbon_mat(4,:));
Carbon_mat_Z_sediment = zscore(Carbon_mat(5,:));
figure,plot((0.5:0.1:2),Carbon_mat_Z_time,'--or','MarkerFaceColor','r','LineWidth',2.0), hold on, grid on
plot((0.5:0.1:2),Carbon_mat_Z_POC,'--om','MarkerFaceColor','m','LineWidth',2.0)
plot((0.5:0.1:2),Carbon_mat_Z_river,'--ob','MarkerFaceColor','b','LineWidth',2.0)
plot((0.5:0.1:2),Carbon_mat_Z_slope,'--og','MarkerFaceColor','g','LineWidth',2.0)
plot((0.5:0.1:2),Carbon_mat_Z_sediment,'--ok','MarkerFaceColor','k','LineWidth',2.0)
legend('Time/Time Points','POC','River Discharge','Channel Slope','Sediment Discharge') % Sediment Discharge and Time give same values since they're both multiplied by the same factor in the same term
hold off
