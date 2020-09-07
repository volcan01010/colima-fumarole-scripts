% function [actrad, actprop]=subpix(temp)
% This function looks at sets of fumarole data from the evenings or
% mornings and uses the changing temperatures in a 'dual band' scheme to try and estimate the
% actual fumarole temperatures and proportional areas of the pixels that
% they occupy.

function [proportions, radiances]=subpix(temp)

% convert temperature to radiance
rads=temp2rad120(temp);

% find transmissivity - standard conditions are 2.6 degC, 52% RH - and
% correct.
trans=transcalc(52, 2.6);
rads=rads / trans;

dimension=size(rads);
dimension=dimension(1);

% create matrix for results
fumrad=zeros(dimension, dimension);
fumprop=zeros(dimension, dimension);

% begin the loop
for j=1:dimension
    dayrad=rads(j,1);
    dayback=mean( rads(j,5:6) );
    for k=(j+1):dimension
        nightrad=rads(k,1);
        nightback=mean( rads(k,5:6) );
        % calculate the fumarole proportion
        fumprop(j,k)= 1 - ( ( nightrad - dayrad) / ( nightback - dayback) );
        % calculate the fumarole radiance
        fumrad(j,k)= (dayrad - dayback + (dayback*fumprop(j,k))) / fumprop(j,k);
        end
end

% ditch fumarole proportions > 1
to_keepprop= 0< fumprop & fumprop < 1;
% ditch temperatures outside 0-1000C range
to_keeprad= 75 < fumrad & fumrad < 1.0629e+004;
to_keep= to_keepprop & to_keeprad;
proportions=fumprop(to_keep);
radiances=fumrad(to_keep);