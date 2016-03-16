function features_hard_neg = get_hard_negatives(train_path_hard_neg, feature_params)
% 'train_path_hard_neg' is a string. This directory contains 36x36 images of
%   faces
% 'feature_params' is a struct, with fields
%   feature_params.template_size (probably 36), the number of pixels
%      spanned by each train / test template and
%   feature_params.hog_cell_size (default 6), the number of pixels in each
%      HoG cell. template size should be evenly divisible by hog_cell_size.
%      Smaller HoG cell sizes tend to work better, but they make things
%      slower because the feature dimensionality increases and more
%      importantly the step size of the classifier decreases at test time.


% 'features_hard_neg' is N by D matrix where N is the number of hard negatives and D
% is the template dimensionality, which would be
%   (feature_params.template_size / feature_params.hog_cell_size)^2 * 31
% if you're using the default vl_hog parameters


image_files = dir( fullfile( train_path_hard_neg, '*.jpg') ); %Caltech Faces stored as .jpg
num_images = length(image_files);

cells_a_template = feature_params.template_size / feature_params.hog_cell_size;
features_hard_neg = zeros(num_images, cells_a_template^2 *31);

for i = 1:num_images
    path = strcat(train_path_hard_neg, '/', image_files(i).name);
    image = imread(path);
        
    hog = vl_hog(single(image)/255.0, feature_params.hog_cell_size);
    hog_size = size(hog);
    
    feature = reshape(hog, 1, []);
    features_hard_neg(i, :) = feature(1, :);
    disp(i/num_images);
end
end

