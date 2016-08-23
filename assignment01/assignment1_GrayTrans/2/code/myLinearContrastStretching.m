function myLinearContrastStretching(fname)
%%
% 
%  This function maps the pixel intensity values from their current range
%  to 0-255. The mapping is done using a linear function, hence the name.
%  It accepts the filename as input (only the filename needs to
%  be specified, files are assumed to be png). This file saves the
% output image as 'fname_stretched.mat' in images folder. This means the input
% contrast stretched version of the input image 'barbara.png' is
% saved as 'barbara_stretched.mat', 'TEM.png' is saved as 'TEM_stretched.mat' and
% 'canyon.png' is saved as 'canyon_stretched.mat'
% 

  %% Loading the image
    im = imread([char(fname) '.png']); 
    im = im2double(im);
     %% Image Stretching
    [nrow ncol nchan] = size(im); %dimension of image
    for i=1:nchan;
        c = min(min(im(:,:,i))); %min pixel intensity of input image
        d = max(max(im(:,:,i))); %max pixel intensity of input image
        im_stretched(:,:,i) = (im(:,:,i)-c).*(1/(d-c));
        %Mapping to output image using a linear function
    end
 %% Plotting
    myNumOfColors = 200;
    %Defining the colorscale with 200 intensities
    myColorScale = [ [0:1/(myNumOfColors-1):1]' , ...
[0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' ];

    figure
    subplot(1,2,1), imagesc(im);
    title('Original Image')
    colormap (myColorScale);
    %For color images
    if nchan>1
        colormap jet;
    end
    axis equal tight;
    colorbar
    subplot(1,2,2), imagesc(im_stretched);
    title(['Contrast Stretched Image'])
    colormap (myColorScale);
    if nchan>1
        colormap jet;
    end
    axis equal tight;
    colorbar
    impixelinfo;
    %Saving the image in .mat format
    save(['2/images/' char(fname(7:end)) '_stretched'],'im_stretched')
end