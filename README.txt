Bonus Features:
	Hard Negative Mining (disabled by default)
		You can enable the mining by uncommenting line 160 which will cause the program to save all false positives as 36x36 images in the hard negatives directory (specified by the 'hard_negatives' variable)

		To enable the use of hard negatives change line 70 from:
				features_hard_neg = zeros(0, 1116);%get_hard_negatives(hard_negative_path, feature_params);
			to
				features_hard_neg = get_hard_negatives(hard_negative_path, feature_params);

		Using both options together is useful for iteratively mining hard negatives, as it means in each iteration the negatives you encounter will be 'harder' than the last.

	Training on different data set
		There are several changes you have to make to get the program to run on a different data set.
			Firstly, the format of all the images in the other data set are PNG's, so by default the program will not load them. Change the '*.jpg' in get_positive_features, get_random_negative_features, run_detector and visualize_detections_by_image_no_gt to '*.png' which will tell the program the actual image format we want.

			Secondly, change the size of the HoG cells to 3 and the template size to 24. The input images are 24x24 (hence the change to the template format) and we decrease the HoG cell size because otherwise we have significantly fewer features (due to the smaller input image size).

			Thirdly, change the directory that the program looks for test images:
				positive_folder: 'positive_buildings'
				negative_folder: 'negative_buildings'
				test_scn_path = fullfile(data_path,'test_buildings');

			Finally, you should change the visualization method from 'visualize_detections_by_image(bboxes, confidences, image_ids, tp, fp, test_scn_path, label_path)' to 'visualize_detections_by_image_no_gt(bboxes, confidences, image_ids, test_scn_path)' as we don't have outlines for the buildings in the test images.



