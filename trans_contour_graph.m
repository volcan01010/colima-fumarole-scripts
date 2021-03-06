% This is a script to create a graph of transmissivity for a variety of
% humidities and temperatures.  It needs to be accompanied by the file
% Modtran_for_figure, which contains the raw data used for the
% interpolation.

% create the matrix
relhum=[50:80];
temp=[-5:15];
A=ones(length(temp), length(relhum));
for m=1:length(temp)
for n=1:length(relhum)
A(m,n)=transcalc(relhum(n), temp(m));
end
end

% plot and hide the old axis labels
figure('PaperPositionMode', 'auto', 'position', [200 100 900 600])
[C,h]=contour(A);
clabel(C,h);
set(h, 'linecolor', 'black', 'linewidth', 1);
cont=gca;
set(gca, 'xtick', []);
set(gca, 'ytick', []);
legend('Transmissivity', 'location', 'ne');


% add the new axis labels
ax2 = axes('Position',get(cont,'Position'),...
           'Color','none',...
           'XColor','k','YColor','k');
xlim([min(relhum) max(relhum)]);
ylim([min(temp) max(temp)]);

xlabel('Relative humidity (%)', 'fontweight', 'demi')
ylabel('Ambient Temperature (\circC)', 'fontweight', 'demi')

% Add the raw data
hold on
load 'Modtran_for_figure'
keep=modtran_results.temp < 14 & modtran_results.rh > 50;
h=text(modtran_results.rh(keep), modtran_results.temp(keep) + 0.5, modtran_results.trans(keep));
set(h, 'BackgroundColor', [1 1 1], 'fontweight', 'demi', 'fontangle', 'italic');
plot(modtran_results.rh, modtran_results.temp, 'ok', 'markersize', 5, 'markerfacecolor', [1 1 1])
plot(modtran_results.rh, modtran_results.temp, 'xk', 'markersize', 5)

% Label the graph for the official figure
xlm=xlim; ylm=ylim; text( xlm(1)+0.01*(diff(xlm)), ylm(1)+0.95*(diff(ylm)), 'b)' , 'fontweight', 'bold');


print( '-dtiff', '-r300', 'trans contours' );