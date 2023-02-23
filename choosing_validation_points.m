load('GlobalDeltaData.mat','BasinID2','MouthLat','MouthLon','Discharge_prist')

%all deltas
idx1 = (1:length(BasinID2))';
%100 largest deltas
[~,idx2] = maxk(Discharge_prist,100);
%eliminate 100 largest from the list of all deltas
idx1(idx2) = [];

%draw 100 random other deltas
idx1 = idx1(randi(length(idx1),[100 1]));


%validation 100 (50 largest deltas+50 random deltas)
idx_val = [idx1(1:50); idx2(1:50)];
%calibration (?? perhaps for retention efficiency/amount of marine infilling) 100 (51 to 100th largest deltas+50 random deltas)
idx_cal = [idx1(51:100); idx2(51:100)];

s = shaperead([dropbox filesep 'WorldDeltas' filesep 'scripts' filesep 'GlobalDeltaData.shp'],'UseGeoCoords', true);

%have 1-100 be a name, have BasinID2 in the description
kmlwrite('GlobalDeltaFilling_validation.kml',s(idx_val),'name',string(1:100),'description',string(BasinID2(idx_val)),'FaceColor',colormap(prism(100)))
%have 1-100 be a name, have BasinID2 in the description
kmlwrite('GlobalDeltaFilling_calibration.kml',s(idx_cal),'name',string(1:100),'description',string(BasinID2(idx_cal)),'FaceColor',colormap(prism(100)))