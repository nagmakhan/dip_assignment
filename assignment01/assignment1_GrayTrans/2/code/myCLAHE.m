
function myCLAHE(fname,l,clip_limit)
%%
% 
% This function does contrast-limited adaptive histogram equalization on input image taking
%  a window of size 'lxl' and clip limit to be 'clip_limit'. Input to this function is the name of the image file
% (in png format), the extension need not be specified, 'l' and
% 'clip_limit'. This file saves the
% output image as 'fname_CLAHE.mat' in images folder. This means the input
% contrast-limited adaptive histogram equalized version of the input image 'barbara.png' is
% saved as 'barbara_CLAHE.mat', 'TEM.png' is saved as 'TEM_CLAHE.mat' and
% 'canyon.png' is saved as 'canyon_CLAHE.mat'. The output images which have
% used half the clip limit are saved as 'barbara_CLAHE_halflimit.mat',
% 'TEM_CLAHE_halflimit.mat' and 'canyon_CLAHE_halflimit'
% 
% Function additional input paramters:
% l = window length
% clip_limit = clip limit of pdf

%%input image
in_img=imread([char(fname) '.png']);
[x y nchan]= size(in_img);


%% Contrast Limited Histogram Equaliation

for k=1:1:nchan
    img=in_img(:,:,k);
    for i=1:x
        for j=1:y
            c_p = img(i,j); %center point of window
            %Defining window of size lxl around center point
            a=(i-floor(l/2));
            b=(i+floor(l/2));
            c=(j-floor(l/2));
            d=(j+floor(l/2));
            %checking for boundary conditions
            e=max(a,1):1:min(b,x);
            f=max(c,1):1:min(d,y);
            
            img1=img(e,f);
            [m n] = size(img1);
            %calculating values in each bin
            [values,indexes]=imhist(img1);
            
            %checking for values in each bin which is greater than clip
            % limit and then re-distributing the excess in each bin equally
            w = values/(m*n);
            a=sum(w(find(w>clip_limit))-clip_limit);
            w(find(w>clip_limit))=clip_limit;
            w=w+(a/length(w));
            
            %calculating cdf as per re-distributed pixels
            p=cumsum(w);
            
            q=p*255;
            q1=round(q);
            
            %r=find(indexes==c_p);
            
            img2(i,j)=uint8(q1(c_p+1));
        end
        
    end
    out_img(:,:,k)=img2;
    
end
%casting image into same class as input image i.e. uint8
out_img = cast(out_img,'uint8');


%% Plotting

%defining color scale of 200 colors
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
title(['Contrast Limited Histogram Equalized Image(CLAHE)'])
colormap (myColorScale);
%for color images
if nchan>1
    colormap jet;
end
axis equal tight;
colorbar
impixelinfo;
%saving the image
 save(['2/images/' char(fname(7:end)) '_CLAHE_halflimit'],'out_img')
end
        
