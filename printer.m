function printer(f, Q, x, b, x_new, i, t)
% Print the results
fprintf('\n____________________________________________________________________________________________________\n');
fprintf("Objective function: f = %s\n", char(collect(1/2 * transpose(x) * Q * x - transpose(b) * x)));
fprintf("Number of iterations: %d\n", i-1);
fprintf("Time elapsed: %f seconds\n", t);
fprintf('Minimum Value: %f\n', f(x_new));
fprintf('Minimum Location: x = [');
for j=1:length(x_new)
    if j==length(x_new)
        fprintf('%f', double(x_new(j)));
    else
        fprintf('%f, ', double(x_new(j)));
    end
end
fprintf("]'\n");
fprintf('____________________________________________________________________________________________________\n\n\n');
end