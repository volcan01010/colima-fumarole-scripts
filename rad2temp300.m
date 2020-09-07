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