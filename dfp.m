%% DESCRIPTION

% Davidon-Fletcher-Powell (DFP)
% Minimization of Unconstrained Quadratic problems

%% Settings

clc
clear all
close all

format long;

%% Problem

% Call 'problem' function to generate a new problem
[n, f, df, Q, x, X] = quadratic_problem();

%% Hyper parameters

% Set a treshold to stop the loop
treshold = 1e-6;

% Learning rate
alpha = 0.5;

% Initial inversed hessian
B = eye(n);

%% Loop settings

% Define an index for count the number of iterations
k = 1;

% Define a boolean flag variable to controle the while loop
flag = true;

% Calculate the loop time elapsed
tic

%% DFP algorithm

while flag
    g = df(x);
    p = -B * g;
    x = x + alpha * p;
    X(k+1, :) = x';
    delta_g = df(x) - g;
    delta_x = x - X(k, :)';
    B = B + ((delta_x * delta_x') / (delta_x' * delta_g)) - ((B * (delta_g * delta_g') * B') / (delta_g' * B * delta_g));

    % Using Euclidean norm-2 to check treshold
    if norm(X(k+1, :)' - X(k, :)', inf) <= treshold
        flag = false;
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