% function radiance=fumdist(fumrad)
% With this function, the apparent radiance of a fumarole can be calculated
% from a given actual radiance, fumarole area, viewing distance, background
% radiance. And the transmissivity as calculated by transcalc for viewing
% from Nevado. And the ambient temperature.

function temperature=fumdist(fumrad, fumarea, distance, transmetre, temp)

%here are the variables/constants
backrad=73;

%do the calculations
x=distance * tan( deg2rad(0.1) );
y=distance * tan( deg2rad(0.104) );

pixelarea= x .* y;

fumprop= fumarea ./ pixelarea;

toobig= fumprop > 1;

fumprop(toobig)=1;

% correct for tranmissivity
radiance= (fumrad .* fumprop) + (backrad .* (1 - fumprop));
radiance= radiance .* (transmetre.^distance) + (1 - transmetre.^distance)*temp2rad300(temp);


temperature= rad2temp(radiance);