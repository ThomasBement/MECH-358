% ---------------------------------------- %
% MECH-358 Homework Set 2 Matlab Code
% Written By: Thomas Bement
% Student Number: 24099822
% Date: 02/03/2021
% ---------------------------------------- %

% Clean up any mess
clc
clear all
close all
clearvars global

% QUESTION 1
% ---------------------------------------- %
fprintf('<strong>QUESTION 1:</strong>\n\n')

% Define variables
A1 = [34 -7 0; 10 1 30; 0 -11 19];
B1 = [10;-1;44];

A2 = [9 1 0 0 0 0; 1 -1 1 0 0 0; 0 15 0 19 0 0; 0 0 2 -3 11 0; 0 0 0 13 -8 4; 0 0 0 0 9 -11];
B2 = [4;18;-100;13;13;0];

% Call Thomas algorithm on variables
x = Thomas(A2, B2);

% Print Results
isZeros = (A2*x)-(B2)


% QUESTION 2
% ---------------------------------------- %
fprintf('<strong>QUESTION 2-A:</strong>\n\n')
f1 = @(x) (5*sin(x)) - x;
isZero = Secant1D(f1, 5, 6, 10) - fsolve(@(x) f1(x), 2)

fprintf('<strong>QUESTION 2-B:</strong>\n\n')

% Define constants
x = [0.3;0.9];
max_iter = 100;
err = 1e-6;

% Intialize updated variables for while loop
n = 0;
eps = 1;
    
%Computation loop
while eps>err&n<max_iter
    % Evaluate g(x1,x2) for current step
    g = [(x(1) - cos(x(1)+x(2)));(x(2) - sin(x(1)+x(2)))];
    % Evaluate error for current step
    eps = abs(g(1))+abs(g(2));
    % Evaluate Jg(x1,x2) for current step
    Jg = [1,sin(x(1)+x(2));-cos(x(1)+x(2)),1];
    % Evaluate new values for x1 and x2
    x = x-Jg\g;
    n = n+1;
end

% Output results
fprintf("Found intersection at: [X1 = %f | X2 = %f]\n",x(1),x(2))
fprintf("Proscess took %i itterations and has an associated error of %f\n",n,eps)


% QUESTION 3
% ---------------------------------------- %
fprintf('<strong>QUESTION 3:</strong>\n\n')

% Define initial conditions
tmax = 2;
t0 = 0;
y0 = 2;
dt = 0.025;
t = (t0:dt:tmax);
sz = size(t);
steps = sz(2);

% Define analytitcal solution
yan = 2*exp(-10*t);

% Define empty arrays for explicit and implicit
yexp = zeros(1, steps);
yimp = zeros(1, steps);

yexp(1,1) = y0;
yimp(1,1) = y0;
% Explicit solution
for i = 1:(steps-1)
    dy = -10*yexp(1,i);
    yexp(1,i+1) = yexp(1,i)+(dy*dt);
end

% Implicit solution
for i = 2:steps
    yimp(1,i) = yimp(1,(i-1))/((10*dt)+1);
end

figure(1)
hold on
plot(t, yan)
plot(t, yexp)
plot(t, yimp)
title('Anaylitical, Implicit and Explicit Solutions of y, Deta T = 0.025')
xlabel('Time (s)') 
ylabel('y (amplitude)') 
legend('Analytical', 'Explicit', 'Implicit')
hold off
grid


% QUESTION 4
% ---------------------------------------- %
fprintf('<strong>QUESTION 4:</strong>\n\n')
A = double(rgb2gray(imread('einstein.jpg')));
[U, S, V] = svd(A);
sz = size(A);
A2 = zeros(sz);
%Define number of matricies to sum
N =  2;
for i = 1:N
    VT = V.';
    A2 = A2 + (S(i,i)*U(:,i)*(VT(i,:)));
end
imwrite(A2,gray,'einsteincompressed.jpg');
