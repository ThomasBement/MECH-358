% ---------------------------------------- %
% MECH-358 Homework Set 2 Matlab Code
% Written By: Thomas Bement
% Student Number: 24099822
% Date: 02/03/2021
% ---------------------------------------- %
function [zero] = Newton2D(g, Jg, x, err, max_iter)
    % Initialize iterations and error variables
    n = 0;
    eps = 1;
 
    while eps>err&n<max_iter
        % Define g(x)
        g = [(x(1) - cos(x(1)+x(2)));(x(2) - sin(x(1)+x(2)))];
        % Compute error
        eps = abs(g(1))+abs(g(2));                           
        % Jacobian
        Jg = [1,sin(x(1)+x(2));-cos(x(1)+x(2)),1];   
        % Compute new itteration
        y = x-Jg\g;
        % Update x with new itteration
        x = y;
        n = n+1;
    end
    zero = x;
end
