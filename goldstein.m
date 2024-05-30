%% A function to calculate step length based on Goldstein Conditions

function alpha = goldstein(alpha_max, c, f, x, d1, g1)
    alpha = alpha_max;
    while true
        if f(x + alpha * d1) <= f(x) + c * alpha * g1' * d1
            if f(x + alpha * d1) >= f(x) + (1 - c) * alpha * g1' * d1
                break
            else
                alpha = alpha / 2;
            end
        else
            alpha = alpha / 2;
        end
    end
end