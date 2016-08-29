function myAHE2(fname)
%% Loading the image

in_img=imread([char(fname) '.png']);
[x y nchan]=size(in_img);
l=80;

%% Adaptive Histogram Equalization
fun = @(block_struct) myHE_modified(block_struct.data); %function handle to myHe_modified
for k=1:1:nchan
    img = in_img(:,:,k);
    new_img = blockproc(img,[l l],fun,'BorderSize',[l/20,l/20], ...
    'TrimBorder',true);
    out_img(:,:,k)=new_img;
end


 %to remove tile artifacts
% out_img = imfilter(out_img,(1/9)*ones(),'replicate');  
 %out_img = imresize(out_img,1,'nearest');
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

 save(['2/images/' char(fname(7:end)) '_AHE2'],'out_img')
figure,imhist(in_img(:,:,1))
figure,imhist(out_img(:,:,1))
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


