%This is the section to make the graphs that show how changing weather can
%affect an apparent temperature
temps=[-5:1:15];
relhums=[30:2:90];
atmchg=zeros(length(temps), length(relhums));
index=[1:30];

tic
for m=1:length(temps)
    for n=1:length(relhums)
        [profile]=apparent_temperature_models(47.9, relhums(n), temps(m), 106.6);
        atmchg(m,n)=profile(58);
    end
end
toc

%plot contour plot with no axis ticks
scrsz = get(0,'ScreenSize');
 figure('Position',[200 100 900 600], 'paperpositionmode', 'auto')
[C,h]=contour(atmchg, [26:1:42])
ax1=gca;
clabel(C,h)
handles=get(gca, 'Children');
lines=min(handles);
set(lines, 'Linecolor', [0 0 0], 'Linestyle', ':', 'Linewidth',1)
set(ax1, 'Xtick', [])
set(ax1, 'Ytick', [])
legend('Apparent temperature (\circC)', 'location', 'se');

%overlay relative humidity - temperature scale
ax2 = axes('Position',get(ax1,'Position'),...
           'Color','none',...
           'XColor','k','YColor','k');
hold on
xlim([min(relhums) max(relhums)]);
ylim([min(temps) max(temps)]);
set(ax2, 'Xticklabel', [30:10:90])
set(ax2, 'Yticklabel', [-5:5:15])
errorbar( 64, 5, 1.6, 'kx')
errorbar_x( 64, 5 , 12.5, 'kx')

%title('Effect of atmospheric conditions on apparent temperature', 'fontsize', 12', 'fontweight', 'demi')
xlabel('Relative Humidity (%)', 'fontsize', 12)
ylabel('Ambient temperature (\circC)', 'fontsize', 12)

 % Label the graph for the official figure
xlm=xlim; ylm=ylim; text( xlm(1)+0.01*(diff(xlm)), ylm(1)+0.97*(diff(ylm)), 'b)' , 'fontweight', 'bold');

print('-dtiff', '-r300', 'Figure 2 - changing weather');


%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% % This set of code prepares changing apparent temperatures for varying
% % outputs - increase by 25, 50, 75, 100% 
% 
% temps=[50 100 150 200];
% areas=[101.9146 36.1105 19.2038 12.055];
% dist=[0:100:6500];
% 
% % This part creates the profiles
% figure
% for j=1:4
%     [outputs(j).profile]=apparent_temperature_models(temps(j), 60, 9, areas(j));
%     plot(dist, outputs(j).profile)
%     hold on
% end
% pause
% 
% %now the apparent temperature models are changed to increase fumrad by 25%,
% %and the process is repeated.
% figure
% for j=1:4
%     [outputs(j).profile25]=apparent_temperature_models(temps(j), 60, 9, areas(j));
%     plot(dist, outputs(j).profile25)
%     hold on
% end
% pause
% 
% %now the apparent temperature models are changed to increase fumrad by 50%,
% %and the process is repeated.
% figure
% for j=1:4
%     [outputs(j).profile50]=apparent_temperature_models(temps(j), 60, 9, areas(j));
%     plot(dist, outputs(j).profile50)
%     hold on
% end
% pause
% 
% %now the apparent temperature models are changed to increase fumrad by 75%,
% %and the process is repeated.
% figure
% for j=1:4
%     [outputs(j).profile75]=apparent_temperature_models(temps(j), 60, 9, areas(j));
%     plot(dist, outputs(j).profile75)
%     hold on
% end
% pause
% 
% %now the apparent temperature models are changed to increase fumrad by 100%,
% %and the process is repeated.
% 
% figure
% for j=1:4
%     [outputs(j).profile100]=apparent_temperature_models(temps(j), 60, 9, areas(j));
%     plot(dist, outputs(j).profile100)
%     hold on
% end
% pause
% 
% %now the apparent temperature models are changed to decrease fumrad by 50%,
% %and the process is repeated.
% figure
% for j=1:4
%     [outputs(j).profilem50]=apparent_temperature_models(temps(j), 60, 9, areas(j));
%     plot(dist, outputs(j).profilem50)
%     hold on
% end
% pause
% 
% 
% %The values are then extracted to a matrix with the representative trends
% for j=1:4
% trends(1:7,j)=[outputs(j).profilem50(59); outputs(j).profilem25(59); outputs(j).profile(59); outputs(j).profile25(59); outputs(j).profile50(59); outputs(j).profile75(59); outputs(j).profile100(59)];
% end
% save 'Apparent temperatures with proportional heat output changes.mat'

% % % % % % % This part is then used to plot the graphs
% % % % % % load 'Apparent temperatures with proportional heat output changes.mat'
% % % % % % 
% % % % % % scrsz = get(0,'ScreenSize');
% % % % % % figure('Position',[200 100 900 600])
% % % % % % 
% % % % % % plot([-50 -25 0 25 50 75 100],trends,'k')
% % % % % % 
% % % % % % colororder=[0 0 0; 0 0 0; 0 0 0; 0 0 0;]
% % % % % % styleorder={':';':';':';':'};
% % % % % % markerorder={'+';'x';'o';'^'};
% % % % % % h=get(gca, 'Children');
% % % % % % h=sort(h, 'ascend');
% % % % % %     for k=1:length(h)
% % % % % %         set(h(k), 'Color', colororder(k,:), 'LineStyle', styleorder{k}, 'Marker', markerorder{k}, 'LineWidth', 1)
% % % % % %     end
% % % % % % legend('50�C', '100�C', '150�C', '200�C', 'location', 'nw')
% % % % % % %title('Changing heat output vs. apparent temperature for theoretical fumaroles', 'fontsize', 12', 'fontweight', 'demi')
% % % % % % xlabel('Change in heat output (%)')
% % % % % % ylabel('Apparent temperature (�C)')
% % % % % % set(gca, 'Xtick', [-50 -25 0 25 50 75 100], 'ygrid', 'on');
% % % % % % 
% % % % % % print('-dtiff', '-r300', 'Figure 2 - changing output');


% %--------------------------------------------------------------------------
 %--------------------------------------------------------------------------
 % This set of code prepares the figure with the distance models
 
 % Calculate the profiles
 [profiles(1).profile] = apparent_temperature_models (50, 60, 9,1);
 [profiles(2).profile] = apparent_temperature_models (100, 60, 9,1);
 [profiles(3).profile] = apparent_temperature_models (150, 60, 9,1);
 [profiles(4).profile] = apparent_temperature_models (200, 60, 9,1);
 dist=[0:1000:6500];
 
 % this part plots the data point locations and symboles
 scrsz = get(0,'ScreenSize');
 figure('Position',[200 100 900 600], 'paperpositionmode', 'auto')
 
 for j=1:4
     plot(dist, profiles(j).profile([1:10:end]))
     hold on
 end
 
 colororder=[0 0 0; 0 0 0; 0 0 0; 0 0 0];
 styleorder={'none';'none';'none';'none'};
 markerorder={'+';'x';'o';'^'};
 h=get(gca, 'Children');
 h=sort(h, 'ascend');
     for k=1:length(h)
         set(h(k), 'Color', colororder(k,:), 'LineStyle', styleorder{k}, 'Marker', markerorder{k}, 'LineWidth', 1)
     end
 
 h=legend('50\circC', '100\circC', '150\circC', '200\circC', 'location', 'ne');
 set(h, 'fontsize', 12);
 %title('Distance vs. apparent temperature for theoretical fumaroles', 'fontsize', 12', 'fontweight', 'demi')
 xlabel('Distance from crater', 'fontsize', 12)
 ylabel('Apparent temperature (\circC)', 'fontsize', 12)
 
 
 % this part plots the lines through the points.
 dist=[0:100:6500];
 for j=1:4
     plot(dist, profiles(j).profile)
     hold on
 end
 
 
 colororder=[0 0 0; 0 0 0; 0 0 0; 0 0 0];
 styleorder={':';':';':';':'};
 markerorder={'none';'none';'none';'none'};
 h=get(gca, 'Children');
 h=sort(h, 'ascend');
     for k=5:length(h)
         set(h(k), 'Color', colororder(k-4,:), 'LineStyle', styleorder{k-4}, 'Marker', markerorder{k-4}, 'LineWidth', 1)
     end
 
 plot(5800, 35, 'kp', 'markersize', 12)
 h=get(gca, 'Children');
 set(h(1), 'marker', 'p', 'markerfacecolor', [0 0 0])
 text(5829, 25, 'Nevado Observatory  \uparrow', 'fontweight', 'demi', 'horizontalalignment', 'right')
 
 xlim([0 6500])
 ylim([0 215])
 
 % Label the graph for the official figure
xlm=xlim; ylm=ylim; text( xlm(1)+0.01*(diff(xlm)), ylm(1)+0.97*(diff(ylm)), 'a)' , 'fontweight', 'bold');
 
print('-dtiff', '-r300', 'Figure 2 - changing distance');