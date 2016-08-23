function myAHE3(fname)
%% Loading the image

in_img=imread([char(fname) '.png']);
[x y nchan]=size(in_img);
l=100;

%% Adaptive Histogram Equalization
for k=1:1:nchan
    img=in_img(:,:,k);
    for i=1:1:x
        for j=1:1:y
            
          new_img(i,j,k) = myHE_modified(in_img(i,j,k)); 
           
        end
    end
    out_img(:,:,k)=new_img;
end



%% Plotting

myNumOfColors = 200;
myColorScale = [ [0:1/(myNumOfColors-1):1]' , ...
    [0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' ];

figure
subplot(1,2,1), imagesc(in_img);
title('Original Image')
colormap (myColorScale);
if nchan>1
    colormap jet;
end
axis equal tight;
colorbar

subplot(1,2,2), imagesc(out_img);
title(['Adaptive Histogram Equalized Image(AHE)'])
colormap (myColorScale);
if nchan>1
    colormap jet;
end
axis equal tight;
colorbar
impixelinfo;

 save(['2/images/' char(fname(7:end)) '_CLAHE'],'out_img')

end
function im_equalized = myHE_modified(im)
  %% Histogram Equalization
    [nrow ncol] = size(im); %dimension of image patch
        %calculating cdf of the image patch
        [count x] = imhist(im);
        cdf_im = cumsum (count);
        %normalizing the cdf
        cdf_im = 255.*cdf_im./max(cdf_im);
        
        %mapping to final image using cdf as mapping function
        for k = 1:ncol
            for l=1:nrow
                if im(l,k) ==0
                    im_equalized(l,k) = 0;
                else
                   im_equalized(l,k) = cdf_im(im(l,k));
                end
           
            end
        
        end
       
    %making output image as same class as input image
    im_equalized = cast(im_equalized,'uint8');
end


