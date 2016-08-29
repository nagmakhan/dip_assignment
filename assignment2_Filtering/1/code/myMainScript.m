%% MyMainScript

tic;
%%
% 
%  'sigma' is the varience of gaussian mask
%  'N' is the size of gaussian mask
%  'alpha' is the scaling factor
%

sigma=20;N=50;alpha=0.5
myUnsharpMasking('1/data/lionCrop.mat',sigma,N,alpha);
sigma=20;N=50;alpha=0.6
myUnsharpMasking('1/data/superMoonCrop.mat',sigma,N,alpha);
toc;
