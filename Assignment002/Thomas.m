% ---------------------------------------- %
% MECH-358 Homework Set 2 Matlab Code
% Written By: Thomas Bement
% Student Number: 24099822
% Date: 02/03/2021
% ---------------------------------------- %
function [x] = Thomas(A, B)
    % Check that A is square and define N
    sz = size(A);
    if sz(1) ~= sz(2)
        fprintf('Matrix Input is Not Square\nQuitting...\n\n')
        %return
    else
        N = sz(1);
    end

    % For row i, e(i)=A(i,i-1), f(i)=A(i,i), g(i)=A(i,i+1) (e is bottom diagonal, f is middle
    % and g is top)
    for i = 2:N
        temp = A(i, (i-1))/A((i-1), (i-1));
        A(i,i) = A(i,i) - (temp*A((i-1), i));
        %A(i,(i-1)) = A(i,(i-1)) - (temp*A((i-1), (i-1)));
        B(i) = B(i) - (temp*B(i-1));
    end
    x = zeros(N,1);
    x(N,1) = B(N,1)/A(N,N);
    for i = (N-1):-1:1
        x(i, 1) = (B(i, 1) - (A(i, (i+1))*x((i+1), 1)))/A(i, i);
    end
end
