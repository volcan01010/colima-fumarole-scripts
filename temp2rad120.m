% function [radiance]=temp2rad120(temp)
% This function converts to radiance from pixel-integrated temperature (in Celcius)
% using an empirical equation derived from the VarioCAM software for the
% -40 to 120 degC calibration mode.

function [radiance]=temp2rad120(temp)
a=0.01121637761038;
b=1.63198952993464;
c=74.91736982826220;
radiance= (a * temp .^2) + (b * temp) + c;


   
   
