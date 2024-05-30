%% A function to generate a new problem

function [n, f, df, Q, x, X] = quadratic_problem()
    % Getting dimension of the problem
    n = input("Enter the problem size: ");

    % The interval of elements
    l = 100;
    h = 200;

    % First method to generate a positive definite matrix
    Q = gallery('randcorr', n);
    Q = round((h - l) * Q + l);

    % Second method to generate a positive definite matrix
    % Q = unifrnd(l, h, n, n);
    % Q = randi([l, h], n);
    % Q = Q * Q';
    % Q = Q + eye(n) * eps(max(abs(eig(Q)))) * 10;
    
    % Third method to generate a positive definite matrix
    % Q = randn(n);
    % Q = Q + Q';
    % Q = Q + n * eye(n);
    % Q = (Q * Q');
    
    % Check if A is a Positive Definite (PD) matrix
    chol(Q);
    
    % Generate a random vector
    b = randi([l, h], [n, 1]);
    
    % Define the function 'f(x)' and gradient of 'f(x)' 
    f = @(x) 1/2 * x' * Q * x - b' * x;
    df = @(x) Q * x - b;
    
    % Initial guess
    x = randi([l, h], [n, 1]); 

    % A matrix to store all 'x' vectors during iterations
    X = zeros(1, n);
    X(1, :) = x';
end