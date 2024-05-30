%% A function to calculate step length based exact method

function alpha = exact(Q, g1)
    d1 = -g1;
    % This costly 'alpha' is for finding the exact solution of the problem
    alpha = (-g1' * d1) / (d1' * Q * d1);
end