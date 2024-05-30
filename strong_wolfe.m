%% A function to calculate step length based on Strong Wolfe Conditions

function alpha = strong_wolfe(alpha_max, c1, c2, f, df, x, d1, g1)
    alpha = alpha_max;
    while true
        if f(x + alpha * d1) <= f(x) + c1 * alpha * g1' * d1
            if abs(df(x + alpha * d1)' * d1) >= c2 * abs(g1' * d1)
                break
            else
                alpha = alpha / 2;
            end
        else
            alpha = alpha / 2;
        end
    end
end