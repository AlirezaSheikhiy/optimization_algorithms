%% A function to print the results

function norm_printer(f, A, x, b, k, t)
    outputs = {'Iterations', 'Time elapsed', 'min f(x)', '||max(Ax-b,0)||'};
    values = [k - 1, t, f(x), norm(max(A*x-b, 0))];
    descriptions = {'number of iterations', 'elapse time to program ends', 'minimum value of function', 'value of norm(max(A*x-b, 0))'};
    outputs = string(outputs);
    descriptions = string(descriptions);
    T = table(outputs', values', descriptions', 'VariableNames', {'Outputs', 'Values', 'Descriptions'});
    disp(T);
    % Write and append the output to the file
    % fileID = fopen('output.txt','a');
    % fprintf(fileID,f(x));
    % fclose(fileID);
end