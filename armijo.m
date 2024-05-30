%% A function to calculate step length based on Armijo Rule

function alpha = armijo(alpha_max, c, f, x, d1, g1)
    alpha = alpha_max;
    while f(x + alpha * d1) > f(x) + c * alpha * g1' * d1
        alpha = alpha / 2;
        % alpha = alpha * c;
    end
end