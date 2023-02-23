function [Africa_Carbon,NorthandCentral_America_Carbon,SouthAmerica_Carbon,NorthernEurope_Carbon,Southern_Asia_Carbon,Caribbean_Carbon,N_Mediterranean_Carbon,MiddleEast_Carbon,E_Asia_Carbon,Oceania_Carbon,Russia_Carbon,Africa_mean_POC,NorthandCentral_America_mean_POC,SouthAmerica_mean_POC,NorthernEurope_mean_POC,Southern_Asia_mean_POC,Caribbean_mean_POC,N_Mediterranean_mean_POC,MiddleEast_mean_POC,E_Asia_mean_POC,Oceania_mean_POC,Russia_mean_POC,Africa_Carbon_per_delivered,NorthandCentral_America_Carbon_per_delivered,SouthAmerica_Carbon_per_delivered,NorthernEurope_Carbon_per_delivered,Southern_Asia_Carbon_per_delivered,Caribbean_Carbon_per_delivered,N_Mediterranean_Carbon_per_delivered,MiddleEast_Carbon_per_delivered,E_Asia_Carbon_per_delivered,Oceania_Carbon_per_delivered,Russia_Carbon_per_delivered,Africa_Carbon_Export,NorthandCentral_America_Carbon_Export,SouthAmerica_Carbon_Export,NorthernEurope_Carbon_Export,Southern_Asia_Carbon_Export,Caribbean_Carbon_Export,N_Mediterranean_Carbon_Export,MiddleEast_Carbon_Export,E_Asia_Carbon_Export,Oceania_Carbon_Export,Russia_Carbon_Export,Africa_Carbon_Nonburial,NorthandCentral_America_Carbon_Nonburial,SouthAmerica_Carbon_Nonburial,NorthernEurope_Carbon_Nonburial,Southern_Asia_Carbon_Nonburial,Caribbean_Carbon_Nonburial,N_Mediterranean_Carbon_Nonburial,MiddleEast_Carbon_Nonburial,E_Asia_Carbon_Nonburial,Oceania_Carbon_Nonburial,Russia_Carbon_Nonburial,Africa_Carbon_Lost,NorthandCentral_America_Carbon_Lost,SouthAmerica_Carbon_Lost,NorthernEurope_Carbon_Lost,Southern_Asia_Carbon_Lost,Caribbean_Carbon_Lost,N_Mediterranean_Carbon_Lost,MiddleEast_Carbon_Lost,E_Asia_Carbon_Lost,Oceania_Carbon_Lost,Russia_Carbon_Lost] = get_Carbon_regions(time,delta_poc,Discharge_prist,ChannelSlope,QRiver_converted,MouthLat,Region)

[Carbon_Infill,Carbon_per_delivered,Carbon_Nonburial,Carbon_Export,Carbon_Lost] = get_Carbon(time,delta_poc,Discharge_prist,ChannelSlope,QRiver_converted);

Africa_Carbon=Carbon_Infill((Region==1|Region==3|Region==11),:);
NorthandCentral_America_Carbon=Carbon_Infill((Region==5|Region==6|Region==12|Region==13),:);
SouthAmerica_Carbon=Carbon_Infill((Region==18|Region==19),:);
NorthernEurope_Carbon=Carbon_Infill((Region==15|Region==4),:);
Southern_Asia_Carbon=Carbon_Infill((Region==20|Region==2|Region==17),:);
Caribbean_Carbon=Carbon_Infill((Region==7),:);
N_Mediterranean_Carbon=Carbon_Infill((Region==14),:);
MiddleEast_Carbon=Carbon_Infill((Region==10),:);
E_Asia_Carbon=Carbon_Infill((Region==9),:);
Oceania_Carbon=Carbon_Infill((Region==16),:);
Russia_Carbon=Carbon_Infill((Region==8),:);

Africa_mean_POC=mean(delta_poc((Region==1|Region==3|Region==11),:),2);
NorthandCentral_America_mean_POC=mean(delta_poc((Region==5|Region==6|Region==12|Region==13),:),2);
SouthAmerica_mean_POC=mean(delta_poc((Region==18|Region==19),:),2);
NorthernEurope_mean_POC=mean(delta_poc((Region==15|Region==4),:),2);
Southern_Asia_mean_POC=mean(delta_poc((Region==20|Region==2|Region==17),:),2);
Caribbean_mean_POC=mean(delta_poc((Region==7),:),2);
N_Mediterranean_mean_POC=mean(delta_poc((Region==14),:),2);
MiddleEast_mean_POC=mean(delta_poc((Region==10),:),2);
E_Asia_mean_POC=mean(delta_poc((Region==9),:),2);
Oceania_mean_POC=mean(delta_poc((Region==16),:),2);
Russia_mean_POC=mean(delta_poc((Region==8),:),2);

Africa_Carbon_per_delivered=(Africa_Carbon./(sum(12.*Africa_mean_POC))).*100;
NorthandCentral_America_Carbon_per_delivered=(NorthandCentral_America_Carbon./(sum(12.*NorthandCentral_America_mean_POC))).*100;
SouthAmerica_Carbon_per_delivered=(SouthAmerica_Carbon./(sum(12.*SouthAmerica_mean_POC))).*100;
NorthernEurope_Carbon_per_delivered=(NorthernEurope_Carbon./(sum(12.*NorthernEurope_mean_POC))).*100;
Southern_Asia_Carbon_per_delivered=(Southern_Asia_Carbon./(sum(12.*Southern_Asia_mean_POC))).*100;
Caribbean_Carbon_per_delivered=(Caribbean_Carbon./(sum(12.*Caribbean_mean_POC))).*100;
N_Mediterranean_Carbon_per_delivered=(N_Mediterranean_Carbon./(sum(12.*N_Mediterranean_mean_POC))).*100;
MiddleEast_Carbon_per_delivered=(MiddleEast_Carbon./(sum(12.*MiddleEast_mean_POC))).*100;
E_Asia_Carbon_per_delivered=(E_Asia_Carbon./(sum(12.*E_Asia_mean_POC))).*100;
Oceania_Carbon_per_delivered=(Oceania_Carbon./(sum(12.*Oceania_mean_POC))).*100;
Russia_Carbon_per_delivered=(Russia_Carbon./(sum(12.*Russia_mean_POC))).*100;

Africa_Carbon_Export=Carbon_Export((Region==1|Region==3|Region==11),:);
NorthandCentral_America_Carbon_Export=Carbon_Export((Region==5|Region==6|Region==12|Region==13),:);
SouthAmerica_Carbon_Export=Carbon_Export((Region==18|Region==19),:);
NorthernEurope_Carbon_Export=Carbon_Export((Region==15|Region==4),:);
Southern_Asia_Carbon_Export=Carbon_Export((Region==20|Region==2|Region==17),:);
Caribbean_Carbon_Export=Carbon_Export((Region==7),:);
N_Mediterranean_Carbon_Export=Carbon_Export((Region==14),:);
MiddleEast_Carbon_Export=Carbon_Export((Region==10),:);
E_Asia_Carbon_Export=Carbon_Export((Region==9),:);
Oceania_Carbon_Export=Carbon_Export((Region==16),:);
Russia_Carbon_Export=Carbon_Export((Region==8),:);

Africa_Carbon_Nonburial=Carbon_Nonburial((Region==1|Region==3|Region==11),:);
NorthandCentral_America_Carbon_Nonburial=Carbon_Nonburial((Region==5|Region==6|Region==12|Region==13),:);
SouthAmerica_Carbon_Nonburial=Carbon_Nonburial((Region==18|Region==19),:);
NorthernEurope_Carbon_Nonburial=Carbon_Nonburial((Region==15|Region==4),:);
Southern_Asia_Carbon_Nonburial=Carbon_Nonburial((Region==20|Region==2|Region==17),:);
Caribbean_Carbon_Nonburial=Carbon_Nonburial((Region==7),:);
N_Mediterranean_Carbon_Nonburial=Carbon_Nonburial((Region==14),:);
MiddleEast_Carbon_Nonburial=Carbon_Nonburial((Region==10),:);
E_Asia_Carbon_Nonburial=Carbon_Nonburial((Region==9),:);
Oceania_Carbon_Nonburial=Carbon_Nonburial((Region==16),:);
Russia_Carbon_Nonburial=Carbon_Nonburial((Region==8),:);

Africa_Carbon_Lost=Carbon_Lost((Region==1|Region==3|Region==11),:);
NorthandCentral_America_Carbon_Lost=Carbon_Lost((Region==5|Region==6|Region==12|Region==13),:);
SouthAmerica_Carbon_Lost=Carbon_Lost((Region==18|Region==19),:);
NorthernEurope_Carbon_Lost=Carbon_Lost((Region==15|Region==4),:);
Southern_Asia_Carbon_Lost=Carbon_Lost((Region==20|Region==2|Region==17),:);
Caribbean_Carbon_Lost=Carbon_Lost((Region==7),:);
N_Mediterranean_Carbon_Lost=Carbon_Lost((Region==14),:);
MiddleEast_Carbon_Lost=Carbon_Lost((Region==10),:);
E_Asia_Carbon_Lost=Carbon_Lost((Region==9),:);
Oceania_Carbon_Lost=Carbon_Lost((Region==16),:);
Russia_Carbon_Lost=Carbon_Lost((Region==8),:);




