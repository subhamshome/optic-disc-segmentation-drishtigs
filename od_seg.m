function [dice_score, distance, jaccard_score, precision, recall, f1, mcc] = od_seg(image,gt,gt_center)
    red_channel = image(:,:,1);
    red_channel(red_channel < 20) = 0;
    [rows, cols] = size(red_channel);
    targetsize = [round(0.75*rows) round(0.75*cols)];
    cropping_val = centerCropWindow2d([rows, cols], targetsize);

    red_cropped2 = imcrop(red_channel, cropping_val);
    red_cropped_adj = imadjust(red_cropped2);
    BW = red_cropped_adj > 180;

    nnz_bw = nnz(BW);
    area = size(red_cropped_adj,1)*size(red_cropped_adj,2);
    ratio = nnz_bw/area;
    
    if ratio > 0.07 && ratio < 0.1
        BW = red_cropped_adj > 210;
    elseif ratio > 0.1 && ratio < 0.22
        BW = red_cropped_adj > 218;
    elseif ratio > 0.22 && ratio < 0.3
        BW = red_cropped_adj > 230;
    elseif ratio > 0.3
        BW = red_cropped_adj > 215;
        se1 = strel('disk', 80);
        BW = imopen(BW, se1);
    end
    BW = bwareafilt(BW, 1);

    rows1 = size(red_channel,2) - cropping_val.XLimits(2);
    cols1 = size(red_channel,1) - cropping_val.YLimits(2);
    
    BW1 = padarray(BW, [cropping_val.YLimits(1) cropping_val.XLimits(1)], 0, "pre");
    BW2 = padarray(BW1, [cols1-1 rows1-1], 0, "post");

    se = strel('disk', 150);
    BW_closed = imclose(BW2, se);

    s = regionprops(BW_closed,'centroid');
    centroids = cat(1,s.Centroid);

    gt(gt<255) = 0;
%     gt(gt>0) = 255;
    gt_bin = gt>0;

    dice_score = dice(BW_closed, gt_bin);
    jaccard_score = jaccard(BW_closed, gt_bin);
%     f1score = bfscore(BW_closed, gt_bin);
    confmat = segmentationConfusionMatrix(BW_closed, gt_bin);
    TP = confmat(1,1);
    FN = confmat(1,2);
    FP = confmat(2,1);
    TN = confmat(2,2);
    total = sum(confmat(:));
%     conf_mat_fin = [TP/total, FP/total; FN/total, TN/total];
    precision = TP/(TP+FP);
    recall = TP/(TP + FN);
    
%     accuracy = (TP + TN)/total;
    f1 = (2 * precision * recall)/(precision + recall);
    mcc = ((TP * TN) - (FP * FN))/sqrt((TP+FP)*(TP+FN)*(TN+FP)*(TN+FN));

    gt_center_points = str2double(strsplit(gt_center, ' '));
    distance1 = hypot(abs(centroids(2)-gt_center_points(1)), abs(centroids(1)-gt_center_points(2)));
    diagonal = hypot(rows, cols);
    distance = 1-((distance1/diagonal));
%     manhattan_distance = sum(abs(bsxfun(@minus,centroids,gt_center_points)),2);
%     distance_accuracy_manhattan = 1-((manhattan_distance/(rows+cols)));

end

