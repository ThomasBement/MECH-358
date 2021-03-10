% ---------------------------------------- %
% MECH-358 Homework Set 3 Matlab Code
% Written By: Thomas Bement
% Student Number: 24099822
% Date: 03/09/2021
% y = [v; u]
% ---------------------------------------- %
function [T, Y] = linShooting(guess, thresh, odefun, time, bc)
    v0 = bc(1);
    vF = bc(2);
    if guess(1,1) > guess(1,2)
        yB = guess(:,1);
        yS = guess(:,2);
    else
        yB = guess(:,2);
        yS = guess(:,1);
    end
%   guess format    | v2 v1 |
%                   | u2 u1 |
    %u = @(yBig, ySmall) ((vF-a(1,2))*(a(2,1)-a(2,2))/(a(1,1)-a(1,2)))+a(2,2);
    u = @(yB, yS) ((vF-yS(1))*(yB(2)-yS(2))/(yB(1)-yS(1)))+yS(2);
    err = thresh+1;
    while err >= thresh
        uNew = u(yB,yS)
        y0New = [v0;uNew];
        [T, Y] = RK4fnc(odefun, time, y0New);
        vNew = Y(1,length(Y));
        if vNew > vF
            yB = [vNew;uNew];    
        else
            yS = [vNew;uNew]; 
        end
        err = abs(vNew-vF);
    end 
end 