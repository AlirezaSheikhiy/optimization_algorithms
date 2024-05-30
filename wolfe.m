%% A function to calculate step length based on Wolfe Conditions

function alpha = wolfe(alpha_max, c1, c2, f, df, x, d1, g1)
    alpha = alpha_max;
    while true
        if f(x + alpha * d1) <= f(x) + c1 * alpha * g1' * d1
            if df(x + alpha * d1)' * d1 >= c2 * g1' * d1
                break
            else
                alpha = alpha / 2;
            end
        else
            alpha = alpha / 2;
        end
    end
end