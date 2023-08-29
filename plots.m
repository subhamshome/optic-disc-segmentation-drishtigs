clear; close all; clc;


datatable = readtable("data.csv", "VariableNamingRule","preserve");
data = table2array(datatable);
dice = data(:,1);
jaccard = data(:,2);
precision = data(:,3);
recall = data(:,4);
mcc = data(:,5);
% f1 = data(:,6);
distance = data(:,7);
x = data(:,8);
length = size(data,1);

vect = [0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1];
vect2 = 0.990:0.001:1;
%%
dice_counts = histcounts(dice,vect);
jaccard_counts = histcounts(jaccard,vect);
precision_counts = histcounts(precision,vect);
recall_counts = histcounts(recall,vect);
mcc_counts = histcounts(mcc,vect);
distance_counts = histcounts(distance,vect2);

%%
final_bar_input = [dice_counts',jaccard_counts',precision_counts',recall_counts',mcc_counts'];
x_axis = 0.05:0.1:0.95;
figure;
bar(x_axis,final_bar_input);
legend(["Dice Coefficients","Jaccard Indices","Precision","Recall","Matthews Correlation Coefficients"],"Location","northwest"); 
grid on; grid minor; xlim([0 1]);
xlabel("Evaulation Metrics");
ylabel("Number of Images");
title("OD Segmentation Evaluation Metrics");

%%
final_bar_input2 = distance_counts;
x_axis = 0.990:0.001:0.999;
figure;
bar(x_axis,final_bar_input2,"hist",'b');
legend("Center Localization","Location","northwest"); 
grid on; grid minor; xlim([0.9 1]);
xlabel("Localization Values");
ylabel("Number of Images");
title("Localization of Centers of Optic Discs");
%%
histogram(dice); hold on;
histogram(jaccard); hold on;
% histogram(precision); hold on; 
% histogram(recall); hold on;
% histogram(mcc); hold off;
legend(["Dice Coefficients","Jaccard Indices","Matthews Correlation Coefficients"],"Location","northwest"); 
grid on; grid minor;
xlim([0 1]);
%%
% %%
% figure(5);
% xnew = 1:0.01:length;
% ynew = interp1(x,f1,xnew,'spline');
% plot(x,f1,'r*',xnew,ynew,'b');
% xlim([1 vect1]); grid on;
% xlabel("Images");
% ylabel("Boundary F1 score");
% title("Boundary F1 score for Optic Discs, mean dice score = " + mean(f1));
% legend(["Images", "Error"], "Location","northwest");
% 
% %%
% figure(4);
% xnew = 1:0.01:length;
% ynew = interp1(x,jaccard,xnew,'spline');
% plot(x,jaccard,'r*',xnew,ynew,'b');
% xlim([1 vect1]); grid on;
% xlabel("Images");
% ylabel("Jaccard Index");
% title("Jaccard Index for Optic Discs, mean jaccard index = " + mean(jaccard));
% legend(["Images", "Error"], "Location","northwest");
% 
% %%
% figure(3);
% xnew = 1:0.01:length;
% ynew_euclidean = interp1(x,f1,xnew,'spline');
% ynew_manhattan = interp1(x,distance,xnew,'spline');
% plot(xnew,ynew_euclidean,'b',"LineWidth",1); hold on;
% plot(x,distance,'g*',xnew,ynew_manhattan,'r',"LineWidth",1); hold off;
% xlim([1 vect1]); grid on;
% xlabel("Images");
% ylabel("Distance accuracy of Centers");
% title("Locaization of Centers of Optic Discs");
% legend(["Euclidean", "Image Points", "Manhattan"], "Location", "southeast");
% 
% %%
% figure(2);
% xnew = 1:0.01:length;
% ynew = interp1(x,dist_acc,xnew,'spline');
% plot(xnew,ynew,'b', "LineWidth", 1);
% xlim([1 vect1]); ylim([0.975 1]); grid on; axis square;
% xlabel("Images");
% ylabel("Accuracy of Centers");
% title("Accuracy of Centers of Optic Discs");
% % legend(["Images", "Accuracy"], "Location","northeast");
% 
% %%
% figure(1);
% xnew = 1:0.01:length;
% ynew = interp1(x,dice,xnew,'spline');
% plot(x,dice,'r*',xnew,ynew,'b');
% xlim([1 vect1]); grid on;
% xlabel("Images");
% ylabel("Dice Coefficients");
% title("Dice Coefficients for Optic Discs, mean dice score = " + mean(dice));
% legend(["Images", "Dice Coefficients"], "Location","northeast");


% figure(99);
% xnew = 1:0.01:length;
% ynew_dice = interp1(x,dice,xnew,'spline');
% ynew_jaccard = interp1(x,jaccard,xnew,'spline');
% ynew_accuracy = interp1(x,precision,xnew,'spline');
% ynew_f1 = interp1(x,recall,xnew,'spline');
% ynew_mcc = interp1(x,mcc,xnew,'spline');
% plot(xnew,ynew_dice,"y","LineWidth",1); hold on;
% plot(xnew,ynew_jaccard,"b","LineWidth",1); hold on;
% plot(xnew,ynew_accuracy,"m","LineWidth",1); hold on;
% plot(xnew,ynew_f1,"g","LineWidth",1); hold on;
% plot(xnew,ynew_mcc,"r","LineWidth",1); hold off;
% xlim([1 vect1]); ylim([0.5 1.05]); grid on;
% legend(["Dice Coefficients", "Jaccard Indices", "Accuracy", "F1 Score", "Matthews Correlation Coefficients"],...
%     "Location", "southeast");
% xlabel("Images");
% ylabel("Evaluation Measures");
% title("Segmentation Evaluation Measures for Optic Discs");
