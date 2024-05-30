%% A function to generate a new problem

function [n, f, df, A, x, b, X] = norm_problem()
    % Getting dimension of the problem
    n = input("Enter the problem size: ");
    
    % The interval of elements
    % l = 100;
    % h = 200;

    % First method to generate a positive definite matrix
    % A = gallery('randcorr', n);
    % A = round((h - l) * A + l);

    % Second method to generate a positive definite matrix
    % A = unifrnd(l, h, n, n);
    % A = randi([l, h], n);
    % A = A * A';
    % A = A + eye(n) * eps(max(abs(eig(A)))) * 10;

    % Third method to generate a positive definite matrix
    % A = randn(n);
    % A = A + A';
    % A = A + n * eye(n);
    % A = (A * A');

    % Fourth method to generate a positive definite matrix
    A = 200 * rand(n, n) - 100;
    A = A * A';
    A = A + eye(n) * eps(max(abs(eig(A)))) * 10;

    % Check if A is a Positive Definite (PD) matrix
    chol(A);
    
    % Generate a random vector
    xbar = 20 * rand(n, 1);
    b = A * xbar + randi([0,5],[n,1]);  % because of A*x <= b
    % b = randi([l, h], [n, 1]);
    
    % Initial guess
    x = -20 + 40 * rand(n, 1);
    % x = randi([l, h], [n, 1]);
    
    % Define the function 'f(x)' and gradient of 'f(x)'
    f = @(x) 0.5 * norm(max((A * x - b), 0)) ^ 2;
    df = @(x) A' * max((A * x - b), 0);
    
    % A matrix to store all 'x' vectors during iterations
    X = zeros(1, n);
    X(1, :) = x';
end
