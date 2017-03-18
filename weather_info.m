% Copyright 2016 Bahar Zarin
function  []= weather_info(t_start,t_end,url_address)
rain=0;
fog=0;
tic
table=[];
for t=t_start:days(1):t_end
    t, snow, rain, fog
a= month(t);
b= day(t);
url = sprintf(url_address, a, b);

filename = [datestr(t) '.txt'];
options = weboptions('Timeout',Inf);
outfilename=websave(filename,url,options);
try
html=readtable(filename,'delimiter',',');
html(:,14) = regexprep(table2array(html(:,14)),'<.*?>','');
html=table2cell(html);

snow = snow + length(find(cellfun('length',regexp(lower(html(:,11)),'snow')) == 1));
rain = rain + length(find(cellfun('length',regexp(lower(html(:,11)),'rain')) == 1));
fog = fog + length(find(cellfun('length',regexp(lower(html(:,11)),'fog')) == 1));

table=[table; html];
table=cell2table(table,'VariableNames',{'TimeEDT','TemperatureF','DewPointF','Humidity','SeaLevelPressureIn','VisibilityMPH','WindDirection','WindSpeedMPH','GustSpeedMPH','PrecipitationIn','Events','Conditions','WindDirDegrees','DateUTC'});

delete (filename);
catch
    disp('Error ')
end
end
toc
