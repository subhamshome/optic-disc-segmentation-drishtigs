close all; clear; clc;
tic
    
    type = "data/Training"; % "data/Test"
    folder= type + '/Images/ALL';
    I=dir(fullfile(folder,'*.png'));
    img_count = numel(I);
    input = cell(4, img_count);
    gt_str = cell(1, img_count);
    gt_center = cell(1, img_count);
    dice = zeros(img_count, 1);
    distance = zeros(img_count, 1);
    jaccard = zeros(img_count, 1);
    precision = zeros(img_count, 1);
    recall = zeros(img_count, 1);
    f1 = zeros(img_count, 1);
    mcc = zeros(img_count, 1);
    score_names = cell(img_count,1);
    for k=1:img_count
      filename=fullfile(folder,I(k).name);
      input{1,k}=I(k).name;
      input{1,k} = erase(input{1,k}, ".png");
      gt_str = type + "\GT\" + input{1,k} + "\SoftMap\" + input{1,k} + "_ODsegSoftmap.png";
      gt_center = type + "\GT\" + input{1,k} + "\AvgBoundary\" + input{1,k} + "_diskCenter.txt";
      input{2,k}=imread(filename);
      input{3,k}=imread(gt_str);
      input{4,k}=fileread(gt_center);
    end
    
    for i=1:img_count
        [dice(i), distance(i), jaccard(i), precision(i), recall(i), f1(i), mcc(i), ] = od_seg(input{2,i},input{3,i},input{4,i});
        score_names{i} = input{1,i};
    end
    
    dice_mean = mean(dice);
    distance_accuracy = mean(distance);
    dice_std = std(dice);
    distance_std = std(distance);
    
    disp_dice_mean = ['Mean Dice Coeffeicients: ', num2str(dice_mean)];
    disp_distance_accuracy = ['Mean Center Accuracy: ', num2str(distance_accuracy)];
    disp_dice_std = ['Std Dice Coefficients: ', num2str(dice_std)];
    disp_distance_std = ['Std Distance Accuracy: ', num2str(distance_std)];
    disp(type);
    disp(disp_dice_mean);
    disp(disp_distance_accuracy);
    disp(disp_dice_std);
    disp(disp_distance_std);
    
    final_score = [dice, jaccard, precision, recall, f1, mcc, distance, string(score_names)];

timeElapsed = toc;


