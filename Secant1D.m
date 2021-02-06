% ---------------------------------------- %
% MECH-358 Homework Set 2 Matlab Code
% Written By: Thomas Bement
% Student Number: 24099822
% Date: 02/03/2021
% ---------------------------------------- %
function [zero] = Secant1D(f, x0, x1, N)
    for i =1:N
        x2 = x1 - f(x1) * (x1 - x0) / (f(x1) - f(x0));
        x0 = x1; 
        x1 = x2;
    end
    zero = x2;
end