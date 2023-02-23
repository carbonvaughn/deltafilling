clear % removes everything from workspace
data_dir=''
filename='GlobalDeltaData.mat'
%filename='GlobalDeltaProfile.mat'
load([data_dir filename])

find(BasinID==108677)
idx=1315; % Used 1083, 1188 seems pretty good

ch_len=rmmissing(channel_len(idx,:)); % removing nans from channel to combine with shelf
sh_len=-1000.*rmmissing(shelf_len(idx,1:7)); % removing nans from shelf to combine with channel
channel_height=0:20;
nanposition=find(isnan(channel_len(idx,:))); % finding positions of nans in channel length
ch_height=channel_height; % applying the length nan positions to channel height to remove their corresponding heights
ch_height(nanposition)=[];

shelf_len_limit=-1000*shelf_len(idx,1:7);
profile_len=[fliplr(shelf_len_limit) ch_len];
profile_len_un=unique(profile_len);
sh_depth=0:-20:-120;
profile_height=[fliplr(sh_depth) ch_height];
channel=ch_len(1):ch_len(end);

% can't use repeated measurements with signchange so using unique values
[ch_len_un,ind]=unique(ch_len); % looking for repititions in ch_len, which indicates get two or more increases in elevation at the same distance
duplicate_ind=setdiff(ch_height(2:end),ch_height(ind));
ch_height_un=ch_height;
ch_height_un(duplicate_ind)=[];

figure
plot(ch_len, ch_height, 'Color',[0 0.5 0],'LineWidth',2,'DisplayName','Channel Profile')
hold on
plot(-1000*shelf_len(idx,1:7),sh_depth,'b','LineWidth',2,'DisplayName','Shelf Profile')
yline(0,'--','Color',[0 0.5 0.5],'LineWidth',1.5,'DisplayName','sea-level');
xlabel('Distance (m)'),
ylabel('Height/Depth (m)')

% plotting basement slope from LGM
%plot([profile_len(1),profile_len(end)],[profile_height(1),profile_height(end)])
m=(profile_height(end)-profile_height(1))/(profile_len(end)-profile_len(1));
y1=profile_height(end);
x1=profile_len(end);
b=y1-(m*x1);
basement_x=[profile_len(1),profile_len(end)];
basement_y=[profile_height(1),profile_height(end)];
profile=profile_len_un(1):profile_len_un(end);
model_profile_height=(m*profile)+b;
plot(profile,model_profile_height,'--k','LineWidth',1.5,'DisplayName','Basement Slope')

% plotting linear interpolation of current river profile
B = [ch_len_un(:) ones(size(ch_len_un(:)))] \ ch_height_un(:);
Slope = B(1)
Intercept = B(2)
X_Intercept = -B(2)/B(1)
plot(ch_len_un, [ch_len_un(:) ones(size(ch_len_un(:)))]*B, '--r','LineWidth',1.5,'DisplayName','Linear Interpolation');
ch_linear_y=(Slope*ch_len_un)+Intercept;
legend

% Find crossing of basement slope with linear interpolation
fnUP=@(x) interp1(ch_len_un,ch_linear_y,channel); % linear interp of river profile
fnBA=@(x) interp1(profile,model_profile_height,channel); % basement profile
%fnPR=@(x) polyval([m y1],profile_len_un-x1);
sign_change=find((fnUP(channel)-fnBA(channel))<=0,1);
% x0=fsolve(@(x) fnBA(x)-fnUP(x),channel(sign_change)); % try to find interesection of two
distance=channel(sign_change)
% sealeveldistance=((0-y1)/m)+x1; not relevant anymore but keeping anyways
% just in case

% distance for last point of channel profile
%distance=ch_len_un(end)

% cone volume equation: V = pi * r^2 * h/3
d=5267;
infill_vol=(pi*((d/2)^2)*(distance/3))/2

Discharge_prist(idx)
Discharge_dist(idx)
QRiver_prist(idx)
QRiver_dist(idx)
ChannelSlope(idx)

%% Finding equation
clear % removes everything from workspace
data_dir=''
filename='River Valley Parameters.xlsx';
T=readtable([data_dir filename]);
BasinID=T{:,1};
idx=T{:,2};
Infill_vol=T{:,7};
Discharge_prist=T{:,8};
Q_prist=T{:,10};
Ch_slope=T{:,12};
independents=[Discharge_prist,Ch_slope];

modelfun=@(b,x)b(1).*x(:,1).^b(2).*x(:,2).^b(3);
initial_values=[8000000 2 -0.1];
mdl1=fitnlm(independents,Infill_vol,modelfun,initial_values)
% results
% b1     4.1259E08
% b2     0.67683
% b3     0.06749
% R-Squared: 0.651
model1=4.1259E08.*Discharge_prist.^0.67683.*Ch_slope.^0.06749;
diff=Infill_vol-model1;
meandiff=mean(diff) % -1.6049E09
scatter(model1,Infill_vol)
hold on
title('Multiplication and Exponentials only')
xlabel('Model')
ylabel('Measured')

modelfun=@(b,x)b(1).*x(:,1).*(log(x(:,2)));
initial_values=[8000];
mdl3=fitnlm(independents,Infill_vol,modelfun,initial_values)
% b1     -7.7418E05
% R-Squared: 0.569
model3=-7.7418E05.*Discharge_prist.*log(Ch_slope);
diff=Infill_vol-model3;
meandiff=mean(diff) % 7.4019E09


modelfun=@(b,x)b(1).*((log(x(:,1))).^b(2)).*x(:,2).^b(3);
initial_values=[300000 5 -1];
mdl19=fitnlm(independents,Infill_vol,modelfun,initial_values)
% Results
% b1     3.9523E05
% b2     6.1417
% b3     0.10671
% R-Squared: 0.664
model19=3.9523E05.*((log(Discharge_prist)).^6.1417).*Ch_slope.^0.10671;
diff=Infill_vol-model19;
meandiff=mean(diff) % 7.3386E07
scatter(model19,Infill_vol)
hold on
title('Multiplication and Exponentials only')
xlabel('Model')
ylabel('Measured')


modelfun=@(b,x)b(1).*x(:,1).^b(2).*(log(x(:,2).^b(3)));
initial_values=[1500000 1 -3];
mdl11=fitnlm(independents,Infill_vol,modelfun,initial_values)
% results
% b1     3.9433E06
% b2     0.64008
% b3     -7.8866
% R-Squared: 0.629
model11=3.9433E06.*Discharge_prist.^0.64008.*(log((Ch_slope).^-7.8866));
diff=Infill_vol-model11;
meandiff=mean(diff) % -3.3443E10


modelfun=@(b,x)b(1).*((log(x(:,1))).^b(2)).*(log(x(:,2)));
initial_values=[-126000 5];
mdl20=fitnlm(independents,Infill_vol,modelfun,initial_values)
% Results
% b1     -29891
% b2     5.808
% R-Squared: 0.631
model20=-29891.*((log(Discharge_prist)).^5.808).*(log(Ch_slope));
diff=Infill_vol-model20;
meandiff=mean(diff) % 1.1639E09



%% Best model (natural log)
modelfun=@(b,x)b(1).*((log(x(:,1))).^b(2)).*x(:,2).^b(3);
initial_values=[300000 5 -1];
mdl19=fitnlm(independents,Infill_vol,modelfun,initial_values)
% Results
% b1     3.9523E05
% b2     6.1417
% b3     0.10671
% R-Squared: 0.664
model19=3.9523E05.*((log(Discharge_prist)).^6.1417).*Ch_slope.^0.10671;
diff=Infill_vol-model19;
meandiff=mean(diff) % 7.3386E07
scatter(model19,Infill_vol)
hold on
title('Multiplication and Exponentials only')
xlabel('Model')
ylabel('Measured')

