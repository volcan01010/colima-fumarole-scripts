% function [temp]=rad2temp120(radiance)
% This function converts to radiance from pixel-integrated temperature (in Celcius)
% using an empirical equation derived from the VarioCAM software for the
% -40 to 120 degC calibration mode.

function [temp]=rad2temp120(radiance)
a=0.01121637761038;
b=1.63198952993464;
c=74.91736982826220;

% Bring on the quadratic formula
top= -b + ((b^2) - (4 * a * (c - radiance))).^.5;
bottom= 2*a;

temp=top/bottom;