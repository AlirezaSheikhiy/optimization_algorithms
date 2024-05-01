% STEEPEST DESCENT
% To Minimize Unconstrained Quadratic Problems

clc
close all
clear all

format short;

% Problem statement
n = 2;
l = 1;
h = 5;
Q = randi([l, h], n);
x = sym('x', [n, 1]);
b = randi([l, h], [n, 1]);

% Define the function 'f(x)' and gradient of 'f(x)' 
f = collect(1/2 * transpose(x) * Q * x - b' * x);
gradient_f = Q * x - b;

% Initial guess
x_0 = randi([l, h], [n, 1]);
x_old = x_0;

% Hyper parameters
treshold = 1e-6;
alpha = 0.1;

% Define an index for count the number of iterations 
i = 0;

% define a boolean flag variable to controle the while loop
flag = true;

% Steepest Descent algorithm
while flag
    % Calculate the gradient of 'f(x)' at 'x_old'
    g = subs(gradient_f, x, x_old);

    % Calculate the decreasing direction
    d = -g;
    
    % This costly 'alpha' is for finding the exact solution of the problem
    % alpha = (-g' * g) / (g' * Q * g);
    
    % Find the new 'x'
    x_new = x_old + (alpha * d);

    % Print the new 'x' using c-style
    fprintf('x_%d = \n\n', i)
    for j=1:length(x_new)
        fprintf('%d\n', double(x_new(j)))
    end
    fprintf('\n')

    % Using Euclidean norm-2 to check treshold
    if norm(x_new - x_old) <= treshold
        flag = false;
    end

    % Update the 'x_old' vector
    x_old = x_new;

    % Update the iterator variable
    i = i + 1;
end

% Print the results
fprintf('Minimum Value: %d\n\n', double(subs(f, x, x_new)));

fprintf('Minimum Location:\n');
for j=1:length(x_new)
    fprintf('%d\n', double(x_new(j)))
end
