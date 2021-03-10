% MECH 358 ENGINEERING ANALYSIS
% ----------------------------------------
% WRITTEN BY: THOMAS BEMENT
% DATE: 3/08/2021
% 
% ASSIGNMENT 003

% QUESTION 1
% ---------------------------------------- %
clc
clear all
close

fprintf('<strong>QUESTION 1:</strong>\n\n')
% Let ˙θ = u and θ = v
% Recast system
du = @(v) -sin(v);
dv = @(u) u;
f = @(v, u, x, dx) u + ((dx/2)*(-sin(v)-sin(v+((dx/2)*(u+x))))) - x;
df = @(v, u, x, dx) (((dx^2)/4)*(-cos(v+((dx/2)*(u+x))))) - 1;
% Initial conditions
steps = 10000;
u = zeros(1,steps); % Row vector
v = zeros(1,steps); % Row vector
u(1) = 0;
v(1) = pi/2;
% Time interval
dt = 0.001;
t = (0:dt:15);
N = length(t);
% Solving with trapazoidal rule
for i = 1:(N-1)
    % Initial guess is last solution
    u(i+1) = u(i);
    while norm(f(v(i),u(i),u(i+1),dt)) > 1e-6
        % Evaluate Newtons method
        u(i+1) = u(i+1)-(f(v(i),u(i),u(i+1),dt)/df(v(i),u(i),u(i+1),dt));
    end 
    % Update dependant variable with value returned by Newtons method
    v(i+1) = v(i) + ((dt/2)*(u(i)+u(i+1)));
end
% Plot results
figure; hold on;
grid on;
xlabel('time[s]');
ylabel('θ [rad]');
title('Trapazoidal rule with h=0.001 and a tolerance of 1e-6 for Newtons');
hold on;
plot(t, v)
hold off;

filename=input('Press "Enter" to continue...','s')
clc
clear all
close
% QUESTION 2
% ---------------------------------------- %
fprintf('<strong>QUESTION 2.a:</strong>\n\n')
% Define functions
Ta = 1;
a = @(x) (-1*((4*x)+6))/((2*x)+1);
b = @(x) ((8*x)+12)/(((2*x)+1)^2);
f = @(x) (8*((2*x)+1))+(3*b(x));
% Initialise step-size variables
h = 0.001;
x = (0:h:1);
% Initialise vectors
%u = zeros(N,1);    v = zeros(N,1);
% Initial conditions
v(1) = 5*Ta;
u(1) = -20;
% Let dT*/dx* = u and T* = v
%du = @(x, v, u) f(x)-(v*b(x))-(u*a(x));     dv = @(x, v, u) u;
odefun = @(x, y) [y(2); f(x)-(y(1)*b(x))-(y(2)*a(x))];
% First guess
y01 = [5;1];
% Seccond guess
y02 = [5;0.5];
% ODE45 solution
[T1, Y1] = RK4fnc(odefun, x, y01);
[T2, Y2] = RK4fnc(odefun, x, y02);
a = [Y1(:,length(Y1)),Y2(:,length(Y2))];
[T4, Y4] = linShooting(a, 0.0001, odefun, x, [5,4]);
[T3, Y3] = ode45(odefun, [0,1], Y4(:,1));
figure; hold on;
title('Shooting method with h=0.001 and maximum error of 0.0001');
plot(T1, Y1(1,:)); 
plot(T2, Y2(1,:)); 
plot(T3, Y3(:,1));
plot(T4, Y4(1,:));
legend('Guess 1', 'Guess 2', 'ODE45', 'Shooting Method')

filename=input('Press "Enter" to continue...','s')
clc
close
fprintf('<strong>QUESTION 2.b:</strong>\n\n')
% Initialize step size variables with N=21
N  = 21;
h  = 0.001;
x  = linspace(0,1,N);
h  = 1/N;
% Define initial conditions
Ta = 1;
v0 = 5*Ta;
vL = 4*Ta;
% Define matricies from functions
a  = -(4.*x + 6)./(2.*x + 1);
b  = (8.*x + 12)./((2.*x + 1).^2);
f  = 8*(2.*x +1) + 3.*b;
% Create indentiy matix A then fill it 
A = eye(N);
for n = 2:N-1
    A(n,n-1)  = (1/h^2 - a(n)/(2*h));
    A(n,n)    = (b(n) - 2/h^2);
    A(n,n+1)  = (1/h^2 + a(n)/(2*h));
end
f(1) = v0;
f(end) = vL;
Sol = Thomas(A,f');
figure; hold on;
title('Finite Difference method with h=0.001 and N=21');
plot(x, Sol)
plot(T4, Y4(1,:));
legend('Finite Difference', 'Shooting Method')