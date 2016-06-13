function centroids = calculate_centroids(deg_membership, data_points, num_clusters, num_dimensions, q, means, alpha)
%Calculate centroids of clusters
centroids = zeros(num_clusters, num_dimensions);
mem = deg_membership.^q;
temp = data_points + alpha*means;
for i = 1:num_clusters
    numerator = (mem(:,i)')*(temp);
    denominator = (1+alpha)*sum(mem(:,i), 1);
    centroids(i, :) = (1/denominator)*numerator;
end

end

