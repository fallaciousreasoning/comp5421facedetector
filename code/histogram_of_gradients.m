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

hog_width = floor(image_size(2)/cell_size);
hog_height = floor(image_size(1)/cell_size);
pixels_per_cell = 31;
hog = zeros(hog_width, hog_height, pixels_per_cell);

for i = 1:hog_height - 1
    for j = 1:hog_width - 1
        %The buckets for different gradient orientations
        buckets = zeros(1, pixels_per_cell);
        
        start_y = (i - 1) * cell_size + 1;
        start_x = (j - 1) * cell_size + 1;
        
        for k = 1:cell_size
            for l = 1:cell_size 
                y = start_y + k;
                x = start_x + l;
                
                dx = horizontal(y, x);
                dy = vertical(y, x);
        
                magnitudes(y, x) = sqrt(dx*dx + dy*dy);
                orientation = atand(dy/dx);
                if isnan(orientation)
                    orientation = 0;
                end
                
                while orientation < 0
                    orientation = 360 + orientation;
                end
                orientations(y, x) = orientation;
                
                %Calculate which bucket we should put this gradient in
                bucket_index = floor(orientation / (360 / size(buckets, 2))) + 1;
                buckets(1, bucket_index) = buckets(1, bucket_index) + magnitudes(y, x);                
            end
        end
        
        length_squared = 0;
        for bucket_index = 1:9
            length_squared = length_squared + buckets(bucket_index) ^ 2;
        end
        
        length = sqrt(length_squared);
        %Normalize the buckets vector
        %buckets = buckets ./ length;
        hog(i, j,:) = buckets;
    end
end
end


function cell = draw_hog(buckets, cell_size)
    cell = zeros(cell_size * cell_size);
    angle = 0;
    
    for i = 1:size(buckets)
        %How the fuck do I draw the lines?
        angle = angle + 360/size(buckets);
    end
end
