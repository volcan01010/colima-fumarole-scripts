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

coeffs=[-25.62362229733393;   0.06450261207483;   0.00000319320437;   0.19071725204082;  -0.00034243877551;  -0.00024802040816];

% Create the matrix for multiplication

A= [ones(size(relhumidity)) relhumidity relhumidity.*relhumidity temperature temperature.*temperature relhumidity.*temperature];

% Calculate the transmissivity

trans=A*coeffs;

