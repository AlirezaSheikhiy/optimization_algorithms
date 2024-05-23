% NESTEROV'S ACCELARATED GRADIENTS
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

% Initial velocity
v_old = zeros([n, 1]);

% A matrix to store all 'v' vectors during iterations
V = zeros(1, n);
V(1, :) = v_old';

% Hyper parameters
treshold = 1e-6;
beta = 0.1;

% Armijo rule parameters
alpha_max = 1;
c = 0.5;

% Define an index for count the number of iterations 
i = 1;

% Define a boolean flag variable to controle the while loop
flag = true;

% Calculate the loop time elapsed
tic

% Nesterov's Accelerated Gradient algorithm
while flag
    % Calculate the lookahead gradient
    g = df(x_old + beta * v_old);
    
    % Armijo rule
    % alpha = randi([1, 4]);
    alpha = alpha_max;
    while f(x_old + beta * v_old - alpha * g) > f(x_old) + c * alpha * g' * (beta * v_old - alpha * g)
        alpha = alpha / 2;
        % alpha = alpha * c;
    end
    
    % Find the new 'v'
    v_new = beta * v_old - alpha * g;
    V(i+1, :) = v_new';

    % Find the new 'x'
    x_new = x_old + v_new;
    X(i+1, :) = x_new';

    % Using Euclidean norm-2 to check treshold
    if norm(x_new - x_old, 2) <= treshold
        flag = false;
    else
        % Update parameters
        x_old = x_new;
        v_old = v_new;
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