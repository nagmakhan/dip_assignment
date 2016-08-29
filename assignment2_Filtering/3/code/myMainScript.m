%% MyMainScript
tic;
close all;
clear all;
clc;

%% Loading Image for Patch Based Filtering

load('barbara.mat');% Image in .mat format loaded in to imageOrig
image=imageOrig; 
[m n]=size(image);


sigmad=0.9;
outputImage = myPatchBasedFiltering(image,sigmad);
a=1;
waitbar(a/3);

optimalRMSD=sqrt((1/(m*n))*sum(sum((outputImage-image).^2)))



sigmad_0_9=0.9*0.9;
outputImage_0_9=myPatchBasedFiltering(image,sigmad_0_9);
a=2;
waitbar(a/3);

RMSD_0_9=sqrt((1/(m*n))*sum(sum((outputImage_0_9-image).^2)))



sigmad_1_1=1.1*0.9;
outputImage_1_1=myPatchBasedFiltering(image,sigmad_1_1);
a=3;
waitbar(a/3);

RMSD_1_1=sqrt((1/(m*n))*sum(sum((outputImage_1_1-image).^2)))


toc;
