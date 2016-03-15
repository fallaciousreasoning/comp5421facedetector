function [hog] = histogram_of_gradients(image, cell_size)
%HISTOGRAM_OF_GRADIENTS Summary of this function goes here
%   Detailed explanation goes here
image_size = size(image);

horizontal_filter = [-1, 0, 1];
vertical_filter = [1; 0; -1];

horizontal = imfilter(image, horizontal_filter);
vertical = imfilter(image, vertical_filter);

orientations = zeros(image_size);
magnitudes = zeros(image_size);

for i = 1:image_size(1)
    for j = 1:image_size(2)
        dx = horizontal(i, j);
        dy = vertical(i, j);
        
        magnitudes(i, j) = sqrt(dx*dx + dy*dy);
        orientations(i, j) = atan(dy / dx);
    end
end

hog = [];

end

