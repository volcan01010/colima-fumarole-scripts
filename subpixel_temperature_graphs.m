% This script loads the thermal data, works out actual pixel temperatures
% and plots graphs for sub-pixel temperature estimation as required for UGM
% presentation.

%--------------------------------------------------------------------------
% This part loads and does actual pixel temperature analysis on all the
% data that we have that is any good:

% Make a list of all the files in the directory, then remove the ones that
% aren't actually data
tic
direc=dir;
filenames={};
[filenames{1:length(direc),1}]=deal(direc.name);
[list]=regexpi(filenames, '\w+.-.\w+.asc','match');
filelist={};
for j=1:length(list)
filelist{j,1}=char(list{j});
end
filelist( strcmp(filelist,'') )=[];

% The files are then loaded into a data structure called data.
for j=1:length(filelist)
    j
    data(j).filename=char( filelist(j) );
    [time, temp]=infraread( data(j).filename );
    data(j).date=datestr( min(time), 'dd-mmm-yyyy' );
    [time, temp]=cloudremove( time, temp );
    if sum(time)==0
        data(j).time=[];
        data(j).temp=[];
        data(j).prop=[];
        data(j).rad=[];
    else
        data(j).time=time;
        data(j).temp=temp;
        [time, temp]=permin(time,temp);
        [prop, rad]=subpix(temp);
        data(j).prop=prop;
        data(j).rad=rad;
    end
end

% Discard all the data that was too cloudy.
for j=1:length( data)
    keep(j)=length( data(j).time );
    keep(j)= keep(j) ~= 0;
end
keep=logical(keep);
data=data(keep);
clear keep;

save 'Files for subpixel temperature estimation'
clear
load 'Files for subpixel temperature estimation'

% This part does some errorbar plotting
for j=1:length(data)
mean_prop(j)=mean(data(j).prop);
mode_prop(j)=mode(data(j).prop);
std_prop(j)=std(data(j).prop);
std_rad(j)=std(data(j).rad);

% This bit finds the values of rad that correspond to the props.  These
% are the ones the are closest to the mean or to the mode.  There may
% be more than one value that is equally close.
dist_from_mean=abs(data(j).prop - mean(data(j).prop));
closest_mean=min(dist_from_mean);
location_mean= closest_mean == dist_from_mean;
dist_from_mode=abs(data(j).prop - mode(data(j).prop));
closest_mode=min(dist_from_mode);
location_mode= closest_mode == dist_from_mode;

% The locations of the corresponding radiances are found.
mean_rad_locs= data(j).rad (location_mean);
mode_rad_locs= data(j).rad (location_mode);

% The first one is then chosen
mean_rad(j)= mean_rad_locs(1);
mode_rad(j)= mode_rad_locs(1);
end

% This part works out upper and lower temperatures from the STD, then uses
% them to calculate the errors.
upper_rad=mean_rad + std_rad;
lower_rad=mean_rad - std_rad;
mean_temp=rad2temp300(mean_rad);
upper_temp=rad2temp300(upper_rad);
lower_temp=rad2temp300(lower_rad);
upper_error=upper_temp-mean_temp;
lower_error=mean_temp-lower_temp;
mode_temp=rad2temp300(mode_rad);

% Arrange the data in chronological order
for j=1:length(data)
dates(j)=datenum(data(j).date);
end
%dates=dates';
to_sort=[dates' mean_temp' mode_temp' lower_error' upper_error'];
to_sort=sortrows(to_sort, 1);
dates=to_sort(:,1);
mean_temp=to_sort(:,2);
mode_temp=to_sort(:,3);
lower_error=to_sort(:,4);
upper_error=to_sort(:,5);
clear to_sort;

% Plot the chart of the means and the standard deviations
figure
errorbar(dates, mean_temp, lower_error, upper_error);
hold on
plot(dates,mean_temp,'-kx', 'LineWidth', 1)
title('Estimated fumarole temperatures', 'Fontsize', 12, 'Fontweight', 'bold');
ylabel('Fumarole temperature (degC)');
xlim([ (min(dates)-30) (max(dates)+30) ]);
ylim([-250 300]);
datetick('x', 28, 'keepticks', 'keeplimits');
% print('-djpeg95', '-r300', 'Estimated temperatures - means only');

% Plot the chart with mode for comparison
figure
errorbar(dates,mean_temp, lower_error, upper_error, 'LineWidth', 1);
hold on
plot(dates,mode_temp, ':b', dates ,mode_temp, 'xb', 'LineWidth', 1);
handle=gca;
set(handle,'YLim', [-200 900])
title('Estimated fumarole temperatures', 'Fontsize', 12, 'Fontweight', 'bold');
ylabel('Fumarole temperature (degC)');
xlim([ (min(dates)-30) (max(dates)+30) ]);
datetick('x', 28, 'keepticks', 'keeplimits');
%% Create legend
legend1 = legend({'Mean','Mode'},...
'LineWidth',1,...
'Location','SouthOutside',...
'Orientation','horizontal');
% print('-djpeg95', '-r300', 'Estimated temperatures - means and mode');


%--------------------------------------------------------------------------
% This section makes a jpeg of the data graphs tiled together for easy
% comparison
scrsz = get(0,'ScreenSize');
figure('Position',[scrsz(1) scrsz(2) scrsz(3) scrsz(4)], 'color', 'none');
for j=1:length(data)
subplot(ceil( (length(data)/4) ),4,j)
plot(data(j).temp)
handle=gca;
set(handle, 'Fontsize',6, 'YLim', [-10 60])
title(data(j).filename, 'fontsize', 8)
end
% print('-djpeg95', '-r300', 'Graphs of temperature trends');

figure('Position',[scrsz(1) scrsz(2) scrsz(3) scrsz(4)], 'color', 'none');
for j=1:length(data)
subplot(ceil( (length(data)/4)),4,j)
hist(data(j).prop,10)
handle=gca;
set(handle, 'Fontsize',6, 'XLim',[0 1])
title(data(j).filename, 'fontsize', 8)
end
% print('-djpeg95', '-r300', 'Histograms of fumarole proportions');

toc
