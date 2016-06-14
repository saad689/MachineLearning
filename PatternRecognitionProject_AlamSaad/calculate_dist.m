function distances = calculate_dist(num_points, num_clusters, num_dim, data_points, centroids)
%Calculates the new degree of membership of each point
distances = zeros(num_points, num_clusters);
temp = zeros(num_points, num_dim);
for i = 1:num_clusters
    for j = 1:num_dim
        temp(:,j) = data_points(:,j) - centroids(i,j);
    end
    distances(:,i) = sqrt(sum(temp.^2, 2));
end    

end

