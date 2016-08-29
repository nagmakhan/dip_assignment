function myUnsharpMasking(file, sigma,N,alpha)
%%
% 
% loading mat file
% 

load(file);
image=(imageOrig);
image=mat2gray(image);
% size(image)
%%
% 
% Generating the gaussian mask of size 'N' and variance 'sigma'
% Using the gausian mask 'h' to blur the imaage
% Then (LoG) is found by subtracting blrred image 'blurimg' from original image 
%
h=fspecial('gaussian', N, sigma) ;
blurimg=imfilter(image,h,'conv');

unsharpedimg=image-blurimg;
% imshow(unsharpedimg);
sharpenned_image=(image+alpha*unsharpedimg);

%%
% 
% Display of image
% Both Input image 'image' and output image 'sharpenned_image' converted to
% uint8 then displayed
% 
% 


sharpenned_image=cast(255*sharpenned_image,'uint8');
image=cast(255*image,'uint8');
    myNumOfColors = 200;
    %colour scale
    myColorScale = [ [0:1/(myNumOfColors-1):1]' , ...
[0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' ];

    figure
    subplot(1,2,1), imagesc(image);
    title('Original Image')
    colormap (myColorScale);
    %aspect ratio
    daspect ([1 1 1]);
    axis equal tight;
    colorbar
    subplot(1,2,2), imagesc(sharpenned_image);
    title(['Sharpenned Image'])
    colormap (myColorScale);
     %aspect ratio
    daspect ([1 1 1]);
    axis equal tight;
    colorbar
    impixelinfo;
    %saving the image
    save(['1/images/' char(file(7:end)) '_sharpenned_image'],'sharpenned_image')

end