% function [temp]=rad2temp600(radiance)
% This function converts to radiance from pixel-integrated temperature (in Celcius)
% using an empirical equation derived from the VarioCAM software for the
% 100 to 600 degC calibration mode.

function [temp]=rad2temp600(radiance)
a=0.00782067807747;
b=3.09963824470031;
c=4.69194441090604;

% Bring on the quadratic formula
top= -b + ((b^2) - (4 * a * (c - radiance))).^.5;
bottom= 2*a;

temp=top/bottom;