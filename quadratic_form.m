function [n, Q, x, b, f, df, x_old] = quadratic_form()
   % Problem statement
    n = 2;
    l = 100;
    h = 200;
    % First method to generate a positive definite matrix
    Q = gallery('randcorr', n);
    Q = round((h-l) * Q + l);
    % Second method to generate a positive definite matrix
    % Q = unifrnd(l, h, n, n)
    % Q = randi([l, h], n);
    % Q = Q * Q';
    % Q = Q + eye(n) * eps(max(abs(eig(Q)))) * 10;
    chol(Q);
    x = sym('x', [n, 1]);
    b = randi([l, h], [n, 1]);
    
    % Define the function 'f(x)' and gradient of 'f(x)' 
    f = @(x) 1/2 * x' * Q * x - b' * x;
    df = @(x) Q * x - b;
    % df = @(x) jacobian(f, x)';
    
    % Initial guess
    x_old = randi([l, h], [n, 1]); 
end