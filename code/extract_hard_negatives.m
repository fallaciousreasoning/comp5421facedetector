function hard_negative_extractor(path_out, path_in, file_names, prediction, false_positives, feature_params)
%HARD_NEGATIVE_EXTRACTOR Summary of this function goes here
%   Detailed explanation goes here

results_count = size(false_positives);
for i = 1:results_count
    if ~false_positives(i)
        continue
    end
    
    save_false_positive(path_out, path_in, file_names(i), prediction(i, :), feature_params.template_size); 
end
end

function save_false_positive(path_out, path_in, file_name, result, template_size)    
    in_name = char(strcat(path_in, '\', file_name));
    out_name = char(strcat(path_out, '\', file_name));
    [path_out,file_name,ext] = fileparts(out_name) 
    
    image = imread(in_name);
    image_size = size(image);
    
    result = floor(result);
    
    result(4) = min(result(4), image_size(1));
    result(3) = min(result(3), image_size(2));
    
    windowed_image = image(result(2):result(4), result(1):result(3));
    image_size = size(windowed_image, 1);
    scale = template_size/image_size;
    windowed_image = imresize(windowed_image, scale(1));
    
    i = 0;
    while exist(strcat(path_out, '\', file_name, num2str(i), ext), 'file') 
        i = i + 1;
    end
    
    imwrite(windowed_image(1:36, 1:36), strcat(path_out, '\', file_name, num2str(i), ext));
end

