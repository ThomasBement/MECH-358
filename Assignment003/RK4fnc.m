% ---------------------------------------- %
% MECH-358 Homework Set 3 Matlab Code
% Written By: Thomas Bement
% Student Number: 24099822
% Date: 03/09/2021
% y = [v; u]
% y0 = [v0 ; u0 guess]
% ---------------------------------------- %
function [time,y] = RK4fnc(odefun, time, y0)
    N = length(time);
    h = time(2);
    % Define y array
    y = zeros(2,N);
    y(1,1) = y0(1);
    y(2,1)= y0(2);
    % Initialise K vectors
    ku = zeros(1,4); % to store K values for y
    kv = zeros(1,4); % to store K values for z
    b = [1 2 2 1];   % RK4 coefficients
    % Iterate, computing each K value in turn, then the i+1 step values
    for i = 1:(N-1)        
        temp = odefun(time(i), y(:,i));
        ku(1) = temp(2);
        kv(1) = temp(1);
        
        temp = odefun(time(i) + (h/2), y(:,i) + [(h/2)*ku(1);(h/2)*kv(1)]);
        ku(2) = temp(2);
        kv(2) = temp(1);

        temp = odefun(time(i) + (h/2), y(:,i) + [(h/2)*ku(2);(h/2)*kv(2)]);
        ku(3) = temp(2);
        kv(3) = temp(1);

        temp = odefun(time(i) + h, y(:,i) + [h*ku(3);h*kv(3)]);
        ku(4) = temp(2);
        kv(4) = temp(1);
        
        y(2,i+1) = y(2,i) + (h/6)*sum(b.*ku);       
        y(1,i+1) = y(1,i) + (h/6)*sum(b.*kv);        
    end 
end 