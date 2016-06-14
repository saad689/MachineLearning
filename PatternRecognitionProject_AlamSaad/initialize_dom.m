function degree_of_mem = initialize_dom( num_points, num_clusters )
%Initialize a random probability for each member of the degree of
%membership matrix
degree_of_mem = zeros(num_points, num_clusters);
for i = 1:num_points
    s = 0; %Sum of probability
    r = 100; %Remaining probability
    for j = 2:num_clusters
        rval = randi([0 r], 1, 1);
        r = r - rval;
        degree_of_mem(i,j) = rval/100;
        s = s + degree_of_mem(i,j);
    end
    if (s > 1) 
        s = 1; 
    end;
    degree_of_mem(i,1) = 1 - s;
end

end

