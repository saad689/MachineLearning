function [initial spatial] = initialize_data(I, num_rows, num_cols, num_dim)
%Initializes the matrix of data points to be used in the clustering
%algorithm
initial = zeros(num_rows*num_cols, num_dim);
spatial = zeros(num_rows*num_cols, 2);
k = 1;
for i = 1:num_rows
    for j = 1:num_cols
       initial(k, :) = I(i, j, :);
       spatial(k, :) = [i j];
       k = k+1;
    end
end


end

