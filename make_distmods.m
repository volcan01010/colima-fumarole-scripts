% This is a script for creating the distance models, and for plotting the
% graphs.  to work correctly, apparent_temperature_models must have the
% looks35 function disabled.

for j=1:length(distmods)
distmods(j).profile=apparent_temperature_models( distmods(j).temp, 60, 9, distmods(j).area );
distmods(j).plus50=apparent_temperature_models( distmods(j).temp + 50, 60, 9, distmods(j).area );
distmods(j).plus100=apparent_temperature_models( distmods(j).temp + 100, 60, 9, distmods(j).area );
distmods(j).plus150=apparent_temperature_models( distmods(j).temp + 150, 60, 9, distmods(j).area );
distmods(j).plus200=apparent_temperature_models( distmods(j).temp + 200, 60, 9, distmods(j).area  );
distmods(j).plus250=apparent_temperature_models( distmods(j).temp + 250, 60, 9, distmods(j).area  );
distmods(j).plus300=apparent_temperature_models( distmods(j).temp + 300, 60, 9, distmods(j).area  );
end

for j=1:length(distmods)
distmods(j).profile=apparent_temperature_models( distmods(j).temp, 60, 9, distmods(j).area  );
distmods(j).rh36=apparent_temperature_models( distmods(j).temp, 36, 9, distmods(j).area  );
distmods(j).rh44=apparent_temperature_models( distmods(j).temp, 44, 9, distmods(j).area  );
distmods(j).rh52=apparent_temperature_models( distmods(j).temp, 52, 9, distmods(j).area  );
distmods(j).rh68=apparent_temperature_models( distmods(j).temp, 68, 9, distmods(j).area  );
distmods(j).rh76=apparent_temperature_models( distmods(j).temp, 76, 9, distmods(j).area  );

distmods(j).rh84=apparent_temperature_models( distmods(j).temp, 84, 9, distmods(j).area  );
end

% here we can plot some graphs

% how adding temperatures makes a difference to each fumarole
keep=([0:100:6500] == 5800);
added=[0 50 100 150 200 250 300]';
for j=1:length(distmods)
result(1)=distmods(j).profile(keep);
result(2)=distmods(j).plus50(keep);
result(3)=distmods(j).plus100(keep);
result(4)=distmods(j).plus150(keep);
result(5)=distmods(j).plus200(keep);
result(6)=distmods(j).plus250(keep);
result(7)=distmods(j).plus300(keep);
changetemp(1:7, j) = result;
end
figure
plot(added, changetemp, '-x')
title('Effect on apparent temperature of increasing source temp by x°C')

% how changing relative humidity makes a difference.
keep=([0:100:6500] == 5800);
relhums=[36 44 52 60 68 76 84]';
for j=1:length(distmods)
result(1)=distmods(j).rh36(keep);
result(2)=distmods(j).rh44(keep);
result(3)=distmods(j).rh52(keep);
result(4)=distmods(j).profile(keep);
result(5)=distmods(j).rh68(keep);
result(6)=distmods(j).rh76(keep);
result(7)=distmods(j).rh84(keep);
changerelhum(1:7, j) = result(1:7);
end
figure
plot(relhums, changerelhum, '-x')
title('Effect on apparent temperature on changing RH')