%% DESCRIPTION

% MOMENTUM GRADIENT DESCENT
% Minimization of Unconstrained Quadratic problems

%% Settings

clc
clear all
close all

format long;

%% Problem

% Call 'problem' function to generate a new problem
[n, f, df, Q, x, X] = quadratic_problem();

% Initial velocity
v1 = zeros([n, 1]);

% A matrix to store all 'x' vectors during iterations
V = zeros(1, n);
V(1, :) = v1';

%% Hyper parameters

% Set a treshold to stop the loop
treshold = 1e-6;

% Learning rate
alpha = 0.001;

% Momentum factor
beta = 0.1;

%% Loop settings

% Define an index for count the number of iterations
k = 1;

% Define a boolean flag variable to controle the while loop
flag = true;

% Calculate the loop time elapsed
tic

%% Momentum Gradient Descent algorithm

while flag
    % Calculate the gradient of 'f(x)' at 'x_old'
    g = df(x);

    % Find the new 'v'
    v2 = beta * v1 - alpha * g;
    V(k+1, :) = v2';

    % Find the new 'x'
    x = x + v2;
    X(k+1, :) = x';

    % Using Euclidean norm-inf to check treshold
    if norm(X(k+1, :)' - X(k, :)', inf) <= treshold
        flag = false;
    else
        % Update parameters
        v1 = v2;
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
quadratic_printer(f, x, k, t);