function myHE(fname)
%%
% 
% This function does histogram equalization on input image. In input the
% filename (in png format) needs to be specified without any extension.
%  This file saves the
% output image as 'fname_equalized.mat' in images folder. This means the input
% histogram equalized version of the input image 'barbara.png' is
% saved as 'barbara_equalized.mat', 'TEM.png' is saved as 'TEM_equalized.mat' and
% 'canyon.png' is saved as 'canyon_equalized.mat'

     %% Loading the image
    im = imread([char(fname) '.png']); 
    
     %% Histogram Equalization
    [nrow ncol nchan] = size(im); %dimension of image
    for i=1:nchan
        %calculating cdf of the image
        [count x] = imhist(im(:,:,i));
        cdf_im = cumsum (count);
        %normalizing the cdf
        cdf_im = 255.*cdf_im./max(cdf_im);
        %mapping to final image using cdf as mapping function
        for k = 1:ncol
            for l=1:nrow
                if im(l,k,i) ==0
                    im_equalized(l,k,i) = 0;
                else
                   im_equalized(l,k,i) = cdf_im(im(l,k,i));
                end
           
            end
        
        end
    end
    %making output image as same class as input image i.e. uint8
    im_equalized = cast(im_equalized,'uint8');
    %% Plotting
    myNumOfColors = 200;
    %defining color scale of 200 colors
    myColorScale = [ [0:1/(myNumOfColors-1):1]' , ...
[0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' ];

    figure
    subplot(1,2,1), imagesc(im);
    title('Original Image')
    colormap (myColorScale);
    if nchan>1
        colormap jet;
    end
    axis equal tight;
    colorbar
    subplot(1,2,2), imagesc(im_equalized);
    title(['Histogram Equalized Image'])
    colormap (myColorScale);
    if nchan>1
        colormap jet;
    end
    axis equal tight;
    colorbar
    impixelinfo;
    %saving the image
    save(['2/images/' char(fname(7:end)) '_equalized'],'im_equalized')
end
