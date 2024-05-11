% CONJUGATE GRADIENTS
% Minimization of Unconstrained Quadratic problems

clc;
% clear all;
close all;

format short;

% Problem statement
n = 2;
l = 100;
h = 200;
% First method to generate a positive definite matrix
Q = gallery('randcorr', n);
Q = round((h-l) * Q + l);
% Second method to generate a positive definite matrix
% Q = unifrnd(l, h, n, n)
%Q = randi([l, h], n);
%Q = Q * Q';
%Q = Q + eye(n) * eps(max(abs(eig(Q)))) * 10;
chol(Q);
x = sym('x', [n, 1]);
b = randi([l, h], [n, 1]);

% Define the function 'f(x)' and gradient of 'f(x)' 
f = collect(1/2 * transpose(x) * Q * x - transpose(b) * x);
gradient_f = transpose(jacobian(f, x));
% f = 1/2 * x' * Q * x - b' * x;
% gradient_f = jacobian(f, x)';

% f = 0.5 * norm(max((Q*x-b), zeros([n,1])))^2;
% gradient_f = Q' * max((Q*x-b), zeros([n,1]));

% Initial guess
x_old = randi([l, h], [n, 1]);

% Initial direction
g_old = double(subs(gradient_f, x, x_old));
d_old = -g_old;

% Hyper parameters
treshold = 1e-6;
% alpha = 0.001;

% Armijo rule parameters
alpha_max = 1;
c = 0.1;

% Define an index for count the number of iterations 
i = 1;

% Define a boolean flag variable to controle the while loop
flag = true;

% Calculate the loop time elapsed
tic

% Steepest Descent algorithm
while flag
    % This costly 'alpha' is for finding the exact solution of the problem
    % alpha = (-transpose(g_old) * d_old) / (transpose(d_old) * Q * d_old);

    % Armijo rule
    alpha = alpha_max;
    while double(subs(f, x, x_old + alpha * d_old)) > double(subs(f, x, x_old) + c * alpha * transpose(g_old) * d_old)
        alpha = alpha / 2;
    end

    % Find the new 'x'
    x_new = x_old + alpha * d_old;

    % Calculate the gradient of 'f(x)' at 'x_old'
    g_new = double(subs(gradient_f, x, x_new));

    % Calculate the decreasing direction
    % beta = (transpose(g_new) * Q * d_old) / (transpose(d_old) * Q * d_old);
    beta = (-transpose(g_new) * g_new) / (-transpose(g_old) * g_old);
    d_new = -g_new + beta * d_old;
    
    % Print the new 'x' using c-style
    fprintf('x_%d = \n\n', i)
    disp(x_new);
    fprintf('\n')

    % Using Euclidean norm-2 to check treshold
    if norm(x_new - x_old, 2) <= treshold
        flag = false;
    end

    % Exact methods treshold
    % if x_new == zeros([n,1])
    %     flag = false;
    % end

    % Update parameters
    x_old = x_new;
    g_old = g_new;
    d_old = d_new;

    % Update the iterator variable
    i = i + 1;
end

% Get the loop time elapsed
t = toc;

% Print the results
fprintf('\n____________________________________________________________________________________________________\n');
fprintf("Objective function: f = %s\n", char(f));
fprintf("Number of iterations: %d\n", i);
fprintf("Time elapsed: %d seconds\n", t);
fprintf('Minimum Value: %d\n', double(subs(f, x, x_new)));
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
