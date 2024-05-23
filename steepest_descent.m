% STEEPEST DESCENT
% Minimization of Unconstrained Quadratic problems

clc
clear all
close all

format long;

% Generate new problem
[n, Q, x, b, f, df, x_old] = quadratic_form();

% A matrix to store all 'x' vectors during iterations
X = zeros(1, n);
X(1, :) = x_old';

% Hyper parameters
treshold = 1e-6;
alpha = 0.001;

% Define an index for count the number of iterations 
i = 1;

% define a boolean flag variable to controle the while loop
flag = true;

% Calculate the loop time elapsed
tic

% Steepest Descent algorithm
while flag
    % Calculate the gradient of 'f(x)' at 'x_old'
    g = df(x_old);

    % Calculate the decreasing direction
    d = -g;
    
    % This costly 'alpha' is for finding the exact solution of the problem
    % alpha = (-g' * g) / (g' * Q * g);
    
    % Find the new 'x'
    x_new = x_old + alpha * d;
    X(i+1, :) = x_new';

    % Using Euclidean norm-2 to check treshold
    if norm(x_new - x_old, 2) <= treshold
        flag = false;
    else
        % Update parameters
        x_old = x_new;
    end

    % Update the iterator variable
    i = i + 1;

    % Print the new 'x' using c-style
    fprintf('x_%d = \n\n', i-1)
    disp(x_new);
    fprintf('\n')
end

% Get the loop time elapsed
t = toc;

% Print the results using 'printer' function
printer(f, Q, x, b, x_new, i, t);