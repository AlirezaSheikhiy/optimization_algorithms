%% DESCRIPTION

% CONJUGATE GRADIENTS
% Minimization of Unconstrained Quadratic problems

%% Settings

clc
clear all
close all

format long;

%% Problem

% Call 'problem' function to generate a new problem
% [n, f, df, A, x, b, X] = norm_problem();
[n, f, df, Q, x, X] = quadratic_problem();

%% Hyper parameters

% Set a treshold to stop the loop
treshold = 1e-6;

% Learning rate
alpha = 0.0001;

% Armijo and Goldstein Rule parameters
% alpha_max = randi([1, 4]);
% alpha_max = 1;
% c = 0.1;

% Wolfe Conditions parameters
% alpha_max = randi([1, 4]);
% alpha_max = 1;
% c1 = 0.1;
% c2 = 0.2;

%% Loop settings

% Define an index for count the number of iterations
k = 1;

% Define a boolean flag variable to controle the while loop
flag = true;

% Calculate the loop time elapsed
tic

%% Conjugate Gradients algorithm

% Calculate the gradient of 'f(x)' at 'x'
g1 = df(x);

% Calculate the decreasing direction
d1 = -g1;

% Conjugate Gradients algorithm
while flag

    % Calling learning rate functions
    % alpha = exact(Q, g1);
    % alpha = armijo(alpha_max, c, f, x, d1, g1);
    % alpha = wolfe(alpha_max, c1, c2, f, df, x, d1, g1);
    % alpha = strong_wolfe(alpha_max, c1, c2, f, df, x, d1, g1);
    % alpha = goldstein(alpha_max, c, f, x, d1, g1);

    % Find the new 'x'
    x = x + alpha * d1;
    X(k+1, :) = x';

    % Calculate the gradient of 'f(x)' at 'x'
    g2 = df(x);

    % Calculate the decreasing direction
    % beta = (g2' * Q * d1) / (d1' * Q * d1);
    beta = (-g2' * g2) / (-g1' * g1);
    d2 = -g2 + beta * d1;
    
    % Using Euclidean norm-inf to check treshold
    if norm(X(k+1, :)' - X(k, :)', inf) <= treshold
    % if x_new == zeros([n,1]) % Exact methods treshold
        flag = false;
    else
        % Update parameters
        g1 = g2;
        d1 = d2;
    end

    % Update the iterator variable
    k = k + 1;

    % Print the new 'x' using c-style
    fprintf('x_%d = \n\n', k-1)
    disp(x);
    fprintf('\n')
end

%% Output settings

% Get the loop time elapsed
t = toc;

% Print the results using 'printer' function
% norm_printer(f, A, x, b, k, t);
quadratic_printer(f, x, k, t);