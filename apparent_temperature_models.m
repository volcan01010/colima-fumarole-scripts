% function [profile] = apparent_temperature_models (temp, relhum, atmtemp, area)
% This 'function' will plot variation in apparent temperature with measurement
% distance for various fumarole configurations.

function [profile] = apparent_temperature_models (fumtemp, relhum, atmtemp, area)

dist=[0:100:6500];

%Use this if you want to calculate the appropriate
%area for a given apparent temperature at Nevado.  The entered value for
%area then becomes a dummy.
area=looks35(fumtemp)

fumrad=temp2rad300(fumtemp);

%This line is used to model increasing fumarole output
fumrad=fumrad;

pixrad=fumdist(fumrad, area, dist, atmtemp);

measured=transmitted( pixrad, dist, atmtemp, relhum );

profile= rad2temp300(measured);

return


%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%-------------  This is where the sub-functions live
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

% function radiance=fumdist(fumrad)
% With this function, the apparent radiance of a fumarole-containing pixelcan be calculated
% from a given actual radiance, fumarole area, viewing distance, background
% radiance. And the transmissivity as calculated by transcalc for viewing
% from Nevado. And the ambient temperature.

function pixrad=fumdist(fumrad, fumarea, dist, atmtemp)

%here are the variables/constants
backrad=temp2rad300(atmtemp); 

%do the calculations
x=dist * tan( (pi/180)*(0.1) );
y=dist * tan( (pi/180)*(0.104) );
pixelarea= x .* y;

% this finds out the proportion of the pixel that is fumarole
fumprop= fumarea ./ pixelarea;

% correct where the fumarole is no longer sub-pixel
toobig= fumprop > 1;
fumprop(toobig)=1;

pixrad = (fumrad .* fumprop) + (backrad .* (1 - fumprop));

return

%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

% function area=looks35(temp)
% This function finds the area that corresponds of a fumarole of given
% temperature that has an apparent temperature of 35�C from Nevado during
% 'standard conditions'.
function area=looks35(temp)
measured=temp2rad300(35);
trans=transcalc(60,9); % standard conditions

source_rad= measured - (1-trans)*temp2rad300(9);
source_rad= source_rad / trans;
temp2rad300(temp);
%multiply source_rad by the area
source_rad=source_rad * 106.57;

area= (source_rad-(106.57*temp2rad300(9))) / (temp2rad300(temp) - temp2rad300(9));
return

%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

% function [temp]=rad2temp300(radiance)
% This function converts to radiance from pixel-integrated temperature (in Celcius)
% using an empirical equation derived from the VarioCAM software for the
% 0 to 300 degC calibration mode.

function [temp]=rad2temp300(radiance)
a=0.01222052107083;
b=1.55161671379376;
c=73.94923155214205;

% Bring on the quadratic formula
top= -b + ((b^2) - (4 * a * (c - radiance))).^.5;
bottom= 2*a;

temp=top/bottom;
return
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

% function [radiance]=temp2rad300(temp)
% This function converts to radiance from pixel-integrated temperature (in Celcius)
% using an empirical equation derived from the VarioCAM software.

function [radiance]=temp2rad300(temp)
a=0.01232005529550;
b=1.54127999848515;
c=73.58736349286312;
radiance= (a * temp .^2) + (b * temp) + c;
return
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

% function [trans]=transcalc(relhum, temp)
% This function returns transmissivity for a given temperature and relative
% humidity.  The results only apply to data taken from Nevado with ambient
% temperature between -5 and 20C and RH between 36 and 84%.  Temp and
% relhum can be vectors or scalars.

function [trans, A, coeffs]=transcalc(relhumidity, temperature)

% Convert/ensure temperatures are in Kelvin
convert= mean(temperature) < 200;
if convert==1
    temperature=temperature + 273.15;
end

% Load the coefficients for the equation.  Equation is of the form:
% trans= c1 +% c2*relhum + c3*relhum*relhum 
%        + c4*temp + c5*temp*temp + c6*relhum*temp.

coeffs=[-25.62362229733393;   0.06450261207483;   0.00000319320437;...
    0.19071725204082;  -0.00034243877551;  -0.00024802040816];

% Create the matrix for multiplication

A= [ones(size(relhumidity)) relhumidity relhumidity.*relhumidity ...
    temperature temperature.*temperature relhumidity.*temperature];

% Calculate the transmissivity

trans=A*coeffs;

return

%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

% function [measured_radiation] = transmitted( source_rad, dist, atmtemp, relhum )
% This function will return the measured radiation at the camera from a
% pixel a source emitting source_rad at distance dist and in atmosphere of
% temperature atmtemp.

function [measured_radiation] = transmitted( source_rad, dist, atmtemp, relhum )

trans=transcalc(relhum, atmtemp);
transmetre=trans^(1/5800);

measured_radiation= source_rad .* (transmetre.^dist) + (1 - transmetre.^dist)*temp2rad300(atmtemp);

return