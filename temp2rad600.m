% function [radiance]=temp2rad600(temp)
% This function converts to radiance from pixel-integrated temperature (in Celcius)
% using an empirical equation derived from the VarioCAM software for the
% 100 to 600 degC calibration mode.

function [radiance]=temp2rad600(temp)
a=0.00782067807747;
b=3.09963824470031;
c=4.69194441090604;
radiance= (a * temp .^2) + (b * temp) + c;