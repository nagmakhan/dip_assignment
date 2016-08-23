%% MyMainScript
%%
% 
%  This is the main script which calls all functions pertaining to
%  question2.
% 

tic;
% Q2

%% question 2(a)
%Doing Linear Contrast Stretching on the images
myLinearContrastStretching('2/data/barbara'); 
myLinearContrastStretching('2/data/TEM');
myLinearContrastStretching('2/data/canyon'); 


%% question 2(b)
%Doing Histogram Equalization on the images
myHE('2/data/barbara'); 
myHE('2/data/TEM');
myHE('2/data/canyon'); 

%% question 2(c)
%Doing Adpative Histogram Equalization on the images, optimum window size
myAHE('2/data/barbara',160); 
myAHE('2/data/TEM',160);
myAHE('2/data/canyon',160); 

%Doing Adpative Histogram Equalization on the images, larger window size
myAHE('2/data/barbara',300); 
myAHE('2/data/TEM',300);
myAHE('2/data/canyon',300); 

%Doing Adaptive Histogram Equalization on the images, smaller window size
myAHE('2/data/barbara',50); 
myAHE('2/data/TEM',50);
myAHE('2/data/canyon',50); 

%% question 2(d)
%Doing CLAHE on the images using optimum parameters
myCLAHE('2/data/barbara',80,0.025); 
myCLAHE('2/data/TEM',80,0.025);
myCLAHE('2/data/canyon',80,0.025); 

%Doing CLAHE on the images using same window size but half the clip limit
myCLAHE('2/data/barbara',80,0.0125); 
myCLAHE('2/data/TEM',80,0.0125);
myCLAHE('2/data/canyon',80,0.0125); 

toc;
