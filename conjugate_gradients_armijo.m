% CONJUGATE GRADIENTS
% With Armijo Rule to calculate Learning Rate
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

% Armijo rule parameters
alpha_max = 1;
c = 0.1;

% Define an index for count the number of iterations 
i = 1;

% Define a boolean flag variable to controle the while loop
flag = true;

% Calculate the loop time elapsed
tic

% Conjugate Gradients algorithm
while flag
    % Calculate the gradient of 'f(x)' at 'x_old'
    g_old = df(x_old);
    d_old = -g_old;

    % This costly 'alpha' is for finding the exact solution of the problem
    % alpha = (-g_old' * d_old) / (d_old' * Q * d_old);

    % Armijo rule
    % alpha = randi([1, 4]);
    alpha = alpha_max;
    while f(x_old + alpha * d_old) > f(x_old) + c * alpha * g_old' * d_old
        alpha = alpha / 2;
        % alpha = alpha * c;
    end

    % Find the new 'x'
    x_new = x_old + alpha * d_old;
    X(i+1, :) = x_new';

    % Calculate the gradient of 'f(x)' at 'x_new'
    g_new = df(x_new);

    % Calculate the decreasing direction
    % beta = (g_new' * Q * d_old) / (d_old' * Q * d_old);
    beta = (-g_new' * g_new) / (-g_old' * g_old);
    d_new = -g_new + beta * d_old;
    
    % Using Euclidean norm-2 to check treshold
    if norm(x_new - x_old, 2) <= treshold
    % if x_new == zeros([n,1]) % Exact methods treshold
        flag = false;
    else
        % Update parameters
        x_old = x_new;
        g_old = g_new;
        d_old = d_new;
    end

    % Update the iterator variable
    i = i + 1;

    % Print the new 'x' using c-style
    fprintf('x_%d = \n\n', i)
    disp(x_new);
    fprintf('\n')
end

% Get the loop time elapsed
t = toc;

% Print the results
fprintf('\n____________________________________________________________________________________________________\n');
fprintf("Objective function: f = %s\n", char(collect(1/2 * transpose(x) * Q * x - transpose(b) * x)));
fprintf("Number of iterations: %d\n", i);
fprintf("Time elapsed: %d seconds\n", t);
fprintf('Minimum Value: %d\n', double(f(x_new)));
fprintf('Minimum Location: x = [');
for j=1:length(x_new)
    if j==length(x_new)
        fprintf('%d', double(x_new(j)));
    else
        fprintf('%d, ', double(x_new(j)));
    end
end
fprintf("]'\n");
fprintf('____________________________________________________________________________________________________\n\n\n');
