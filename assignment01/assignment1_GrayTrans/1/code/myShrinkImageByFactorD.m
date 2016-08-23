function myShrinkImageByFactorD(d,fname)
%%
% 
%  This program shrinks input image by a factor d. Input is name of file in
%  png format and the factor d. Extension of file need not be specified.
% 

    %% Loading the image
    im = imread([char(fname) '.png']); 
    %% Image Resizing
    [nrow ncol] = size(im); %dimension of image
    nrow_res=nrow/d; %dimensions of resized image
    ncol_res=ncol/d;
    %Resizing
    im_resized = im(1:d:nrow,1:d:ncol);
    
    %% Plotting
    myNumOfColors = 200;
    %colour scale
    myColorScale = [ [0:1/(myNumOfColors-1):1]' , ...
[0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' ];

    figure
    subplot(1,2,1), imagesc(im);
    title('Original Image')
    colormap (myColorScale);
    %aspect ratio
    daspect ([1 1 1]);
    axis equal tight;
    colorbar
    subplot(1,2,2), imagesc(im_resized);
    title(['Sub-Sampled by ' num2str(d) ' Image'])
    colormap (myColorScale);
     %aspect ratio
    daspect ([1 1 1]);
    axis equal tight;
    colorbar
    impixelinfo;
    %saving the image
    save(['1/images/' char(fname(7:end)) '_shrinked' num2str(d)],'im_resized')
end