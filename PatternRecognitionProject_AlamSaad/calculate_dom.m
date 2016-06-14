function deg_membership = calculate_dom(distances, num_clusters, num_points, q, alpha, weights)
%Calculates the new degree of membership of each point
deg_membership = zeros(num_points, num_clusters);
for k = 1:num_points
    a = weights(k, :);
    a = a(a ~= 0);
    for i = 1:num_clusters
        b = distances(:,i);
        b = b(a);
        deg_membership(k,i) = (distances(k,i)^2 + (alpha/length(b))*sum(b.^2))^(-1/(q-1));
    end
    deg_membership(k,:) = deg_membership(k,:)./(ones(1, num_clusters)*sum(deg_membership(k,:),2));
end

end

