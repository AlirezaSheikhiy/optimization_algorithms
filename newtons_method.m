%% DESCRIPTION

% NEWTON'S METHOD
% Minimization of Unconstrained Quadratic problems

%% Settings

clc
clear all
close all

format long;

%% Problem

% Call 'problem' function to generate a new problem
[f, df, Q, x, X] = quadratic_problem();

%% Hyper parameters

% Set a treshold to stop the loop
treshold = 1e-6;

%% Loop settings

% Define an index for count the number of iterations
k = 1;

% Define a boolean flag variable to controle the while loop
flag = true;

% Calculate the loop time elapsed
tic

%% Newton's Method algorithm

while flag
    
    % Find the new 'x'
    x = x - (eye(size(Q)) / Q) * df(x);
    X(k+1, :) = x';

    % Using Euclidean norm-inf to check treshold
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
quadratic_printer(f, x, k, t);