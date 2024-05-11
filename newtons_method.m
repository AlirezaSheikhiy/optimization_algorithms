% NEWTON'S METHOD
% Minimization of Unconstrained Quadratic problems

clc
clear all
close all

format short;

% Problem statement
n = 2;
l = 100;
h = 200;
Q = gallery('randcorr', n);
Q = round((h-l) * Q + l);
chol(Q);
x = sym('x', [n, 1]);
b = randi([l, h], [n, 1]);

% Define the function 'f(x)' and gradient of 'f(x)' 
f = @(x) 1/2 * x' * Q * x - b' * x;
df = @(x) 1/2 * Q * x - b; 

% Initial guess
x_old = randi([l, h], [n, 1]);

% Hyper parameters
treshold = 1e-6;

% Define an index for count the number of iterations 
i = 1;

% Define a boolean flag variable to controle the while loop
flag = true;

% Calculate the loop time elapsed
tic

while flag
    % Find the new 'x'
    x_new = x_old - (eye(size(Q)) / Q) * df(x_old);

    % Using Euclidean norm-2 to check treshold
    if norm(x_new - x_old, 2) <= treshold
        flag = false;
    end

    % Print the new 'x' using c-style
    fprintf('x_%d = \n\n', i)
    disp(x_new);
    fprintf('\n')

    % Update the 'x_old' vector
    x_old = x_new;
    
    % Update the iterator variable
    i = i + 1;
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
