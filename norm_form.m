function [n, A, x, b, f, df, x_old] = quadratic_form()
   % Problem statement
    n = 2;
    l = 100;
    h = 200;
    % First method to generate a positive definite matrix
    A = gallery('randcorr', n);
    A = round((h - l) * A + l);
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
    chol(A);
    x = sym('x', [n, 1]);
    b = randi([l, h], [n, 1]);
    
    % Define the function 'f(x)' and gradient of 'f(x)' 
    f = @(x) 0.5 * norm(max((A * x - b), zeros([n, 1])), 1)^2;
    df = @(x) A' * max((A * x - b), zeros([n, 1]));
    % df = @(x) jacobian(f, x)';
    
    % Initial guess
    x_old = randi([l, h], [n, 1]); 
end