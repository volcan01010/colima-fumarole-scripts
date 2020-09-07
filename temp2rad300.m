% function [radiance]=temp2rad300(temp)
% This function converts to radiance from pixel-integrated temperature (in Celcius)
% using an empirical equation derived from the VarioCAM software for the
% 0 to 300 degC calibration mode.

function [radiance]=temp2rad300(temp)
a=0.01222052107083;
b=1.55161671379376;
c=73.94923155214205;

% Use the coefficients to make the quadratic fit
radiance= (a * temp .^2) + (b * temp) + c;