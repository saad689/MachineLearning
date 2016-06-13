I = zeros(256, 256);
I(:, 1:128) = 100;
I(:, 129:256) = 60;
X = imnoise(mat2gray(I, [0 255]), 'gaussian', 0.1);
%X = rgb2gray(imread('tropicalfruits_small.jpg'));
figure
imshow(X);
[row col dim] = size(X);

%Defining the number of data points, clusters, and dimension of points
num_data_points = row*col;
num_clusters = 2;
num_dimensions = dim;
alpha = 7;
neighbor_dist = 2;
num_neighbors = 8;

%Minimum and maximum value that each data point dimension can take
minimum = 0;
maximum = 255;

%Initialize degree of membership matrix
degree_of_membership = initialize_dom(num_data_points, num_clusters);

%Set C-Means control parameters
epsilon = 0.001;
fuzziness = 2;
max_diff = 1;

%Matrix of all data points
[data_point spatial_info] = initialize_data(X, row, col, dim);

%Find neighbors of all pixels
weights = zeros(num_data_points, num_neighbors);
temp = zeros(num_data_points,2);
for k = 1:num_data_points
    temp(:,1) = abs(spatial_info(k,1) - spatial_info(:,1));
    temp(:,2) = abs(spatial_info(k,2) - spatial_info(:,2));
    w = (temp(:,1) <= 1) & (temp(:,2) <= 1);
    w(k) = 0;
    neighbors = find(w);
    weights(k,:) = [neighbors' zeros(1, num_neighbors - length(neighbors))];
end
clear temp;
clear w;

means = zeros(num_data_points, num_dimensions);
for k = 1:num_data_points
   a = weights(k,:);
   a = a(a ~= 0);
   means(k,:) = mean(data_point(a), 1);
end

centroids = calculate_centroids(degree_of_membership, data_point, num_clusters, num_dimensions, fuzziness, means, alpha);
while (max_diff > epsilon)
    %Calculate cluster centers
    centroids_old = centroids;
    
    %Calculate distance of each point from each cluster centroid
    distances = calculate_dist(num_data_points, num_clusters, num_dimensions, data_point, centroids);

    %Calculate new degrees of membership
    degree_of_membership_new = calculate_dom(distances, num_clusters, num_data_points, fuzziness, alpha, weights);

    %max_diff = max(max(abs(degree_of_membership - degree_of_membership_new)))
    
    degree_of_membership = degree_of_membership_new;
    centroids = calculate_centroids(degree_of_membership, data_point, num_clusters, num_dimensions, fuzziness, means, alpha);
    max_diff = max(max(abs(centroids_old - centroids)))
end

[~, C] = max(degree_of_membership, [], 2);
y = linspace(0, 255, num_clusters);

Output = X;
for i = 1:num_data_points
    Output(spatial_info(i,1), spatial_info(i,2)) = y(C(i));
end
figure
imshow(mat2gray(Output));
