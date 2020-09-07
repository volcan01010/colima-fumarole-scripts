load modis
figure('PaperPositionMode', 'auto', 'position', [200 100 900 600])
plot(modis(:,1), modis(:,2), 'k^', 'Markerfacecolor', 'k')
xlim([731217 733408])
ylim([-0.8 0.4])
monthtick(gca);
datetick('x', 'yyyy')
set(gca, 'YTick', [-0.8:0.2:0.4])

xlabel('Date', 'fontweight', 'demi')
ylabel('Hotspot Intensity (nti)', 'fontweight', 'demi')
%title('MODVOLC Alerts at Volcán de Colima, 2002-2007', 'fontsize', 12, 'fontweight', 'bold')

t2001=text(datenum(2002,7,1,0,0,0), -0.35, {'2001-2003'; 'Effusive'; 'Eruption'; '\downarrow'})
set(t2001, 'horizontalalignment' , 'center', 'fontweight', 'bold')

t2004=text(datenum(2004,2,1,0,0,0), -0.2, {'2004'; 'Effusive'; 'Eruption \rightarrow'})
set(t2004, 'horizontalalignment' , 'left', 'fontweight', 'bold')

t2005=text(datenum(2005,7,1,0,0,0), 0.05, {'2005'; 'Explosions and'; 'Pyroclastic Flows';, '\downarrow'})
set(t2005, 'horizontalalignment' , 'center', 'fontweight', 'bold')


print( '-dtiff', '-r300', 'C:\Documents and Settings\John\My Documents\Paper - Fumarole monitoring\MODVOLC' );