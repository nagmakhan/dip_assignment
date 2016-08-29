function myShrinkImageByFactorD(d,fname)
    %% Loading the image
    im = imread([char(fname) '.png']); 
    im = im2double(im);
    %% Image Resizing
    [nrow ncol] = size(im); %dimension of image
    nrow_res=nrow/d; %dimensions of resized image
    ncol_res=ncol/d;
    
    im_resized = im(1:d:nrow,1:d:ncol);
    
    %% Plotting
    myNumOfColors = 200;
    myColorScale = [ [0:1/(myNumOfColors-1):1]' , ...
[0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' ];

    figure
    subplot(1,2,1), imagesc(im);
    title('Original Image')
    colormap (myColorScale);
    %colormap jet;
    daspect ([1 1 1]);
    axis equal tight;
    colorbar
    subplot(1,2,2), imagesc(im_resized);
    title(['Sub-Sampled by ' num2str(d) ' Image'])
    colormap (myColorScale);
    %colormap jet;
    daspect ([1 1 1]);
    axis equal tight;
    colorbar
    impixelinfo;
    save(['1/images/' char(fname(7:end)) '_shrinked' num2str(d)],'im_resized')
end