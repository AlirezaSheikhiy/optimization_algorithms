%% A function to print the results

function quadratic_printer(f, x, k, t)
    outputs = {'Iterations', 'Time elapsed', 'min f(x)'};
    values = [k - 1, t, f(x)];
    descriptions = {'number of iterations', 'elapse time to program ends', 'minimum value of function'};
    outputs = string(outputs);
    descriptions = string(descriptions);
    T = table(outputs', values', descriptions', 'VariableNames', {'Outputs', 'Values', 'Descriptions'});
    disp(T);
end