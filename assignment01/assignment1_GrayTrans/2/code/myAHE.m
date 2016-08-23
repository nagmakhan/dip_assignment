
function myAHE(fname,l)
%%
% 
%  This function does adaptive histogram equalization on input image taking
%  a window of size 'lxl'. Input to this function is the name of the image file
% (in png format), the extension need not be specified and 'l'. This file saves the
% output image as 'fname_AHE.mat' in images folder. This means the input
% adaptive histogram equalized version of the input image 'barbara.png' is
% saved as 'barbara_AHE.mat', 'TEM.png' is saved as 'TEM_AHE.mat' and
% 'canyon.png' is saved as 'canyon_AHE.mat'
% Output image in which a significantly larger window size has been used
% i.e. 300x300 compared to 160x160 is saved as 'barbara_AHE_large.mat',
% 'TEM_AHE_large.mat' and 'canyon_AHE_large.mat'
% Output image in which a significantly smaller window size has been used
% i.e. 50x50 compared to 160x160 is saved as 'barbara_AHE_small.mat',
% 'TEM_AHE_small.mat' and 'canyon_AHE_small.mat'
%
% Function additional input paramters:
% l = window length
% clip_limit = clip limit of pdf


%% Loading the image

in_img=imread([char(fname) '.png']);
[x y nchan]=size(in_img);

%% Adaptive Histogram Equalization
for k=1:1:nchan
    img=in_img(:,:,k);
    for i=1:1:x
        for j=1:1:y
            
            c_p = img(i,j); %center point
            %calculating window around center point
            a=(i-floor(l/2));
            b=(i+floor(l/2));
            c=(j-floor(l/2));
            d=(j+floor(l/2));
            
            %checking for image boundary conditions
            e=max(a,1):1:min(b,x);
            f=max(c,1):1:min(d,y);
            
            img1=img(e,f);
            
            %calculating cdf in each window
            hist =imhist(img1);
            cdf=cumsum(hist);
            cdf= 255*cdf/cdf(end);
            
            %Doing mapping to output image as per cdf
            if img(i,j) ==0
                    new_img(i,j)=0;
            else
                    new_img(i,j)=cdf(img(i,j));
             end
           
        end
    end
    out_img(:,:,k)=new_img;
end
%casting output image in same class as input i.e. uint8
out_img = cast(out_img,'uint8');


%% Plotting

%defining colorscale of 200 colors
myNumOfColors = 200;
myColorScale = [ [0:1/(myNumOfColors-1):1]' , ...
    [0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' ];

figure
subplot(1,2,1), imagesc(in_img);
title('Original Image')
colormap (myColorScale);
%for color images
if nchan>1
    colormap jet;
end
axis equal tight;
colorbar

subplot(1,2,2), imagesc(out_img);
title(['Adaptive Histogram Equalized Image(AHE)'])
colormap (myColorScale);
%for color images
if nchan>1
    colormap jet;
end
axis equal tight;
colorbar
impixelinfo;
%saving the image
 save(['2/images/' char(fname(7:end)) '_AHE_small'],'out_img')

end




