% ---------------------------------------- %
% MECH-358 Homework Set 1 Matlab Code
% Written By: Thomas Bement
% Student Number: 24099822
% Date: 01/18/2021
% ---------------------------------------- %

% Clean up any mess
clc
clear all
close all
clearvars global

% QUESTION 1
% ---------------------------------------- %
fprintf('<strong>QUESTION 1:</strong>\n\n')

% Define random symetric matrix B N =10
N = 10;
B = rand(N,N);
B = B'*B;
[V1, lambda1, V2, lambda2] = BigEig(B, 1E-6);

%Print all results with labels
    %Iterative Results
fprintf('<strong>Iterative Method</strong>')
fprintf('\nLargest Eigen Value: %f', lambda1)
fprintf('\nAssociated Vector: [')
fprintf('%g ', V1);
fprintf(']\n');
    %Built in results
fprintf('<strong>Built In Method</strong>')
fprintf('\nLargest Eigen Value: %f', lambda2)
fprintf('\nAssociated Vector: [')
fprintf('%g ', V2);
fprintf(']\n\n');

% Define random symetric matrix B N =100
N = 100;
B = rand(N,N);
B = B'*B;
[V1, lambda1, V2, lambda2] = BigEig(B, 1E-6);

%Print all results with labels
    %Iterative Results
fprintf('<strong>Iterative Method</strong>')
fprintf('\nLargest Eigen Value: %f', lambda1)
fprintf('\nAssociated Vector: [')
fprintf('%g ', V1);
fprintf(']\n');
    %Built in results
fprintf('<strong>Built In Method</strong>')
fprintf('\nLargest Eigen Value: %f', lambda2)
fprintf('\nAssociated Vector: [')
fprintf('%g ', V2);
fprintf(']\n');

% QUESTION 2 C
% ---------------------------------------- %
fprintf('\n<strong>QUESTION 2-C:</strong>\n')

% Define A as the Matrix Given in the Assignment
A = [2 1 0; 4 2 1; 0 2 4];
[P, U, L, N] = GaussElim(A);

% Test results by displaying P'*L*U = A
EqualToA = inv(P)*L*U
A

% Display results
P
U
L

% QUESTION 2 E
% ---------------------------------------- %
fprintf('\n<strong>QUESTION 2-E:</strong>\n')
% Define b as the Vector Giving in the Assignment
b = [1;4;14];
[z, x] = SubSol(P, L, U, b, N);
% Check results
ShouldBeZero = (A*x)-b
% Print formatted results
fprintf('\nVector Z: [')
fprintf('%g ', z);
fprintf(']\n');
fprintf('\nVector X: [')
fprintf('%g ', x);
fprintf(']\n');

% QUESTION 2 F
% ---------------------------------------- %
fprintf('\n<strong>QUESTION 2-F:</strong>\n')
A = [4 8 12 -8; 1 2 -3 4; 2 3 2 1; -3 -1 1 -4];
b = [60;3;1;5];
[P, U, L, N] = GaussElim(A);
[z, y] = SubSol(P, L, U, b, N);
% Check results
ShouldBeZero = (A*y)-b
% Output y, what we are trying to solve
fprintf('\nVector Y: [')
fprintf('%g ', y);
fprintf(']\n');

% QUESTION 2 G
% ---------------------------------------- %
fprintf('\n<strong>QUESTION 2-G:</strong>\n')
A = rand(10,10);
b = rand(10,1);
[P, U, L, N] = GaussElim(A);
[z, x] = SubSol(P, L, U, b, N);
% Check results
ShouldBeZero = (A*x)-b