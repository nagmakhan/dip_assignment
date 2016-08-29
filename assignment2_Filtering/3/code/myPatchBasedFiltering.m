%% Patch Based Filtering


function [outputImage] = myPatchBasedFiltering(image,sigmad)


%% Generate a noise corrupted Image



sizeImage=size(image);

minimumIntensity=min(min(image));  % Finding maximum intensity
maximumIntensity=max(max(image));  % Finding minimum intensity
intensityRange=maximumIntensity-minimumIntensity;   % Finding maximum intensity range for calculating standard deviation

standardDeviation=0.05*intensityRange;
pd = makedist('Normal','mu',0,'sigma',standardDeviation);  % making normal distribution
noise = random(pd,sizeImage);  % Gaussian noise of the size of image

inputImage=image+noise;   % noise corrupted image

%% Defining Parameters

[m n]=size(inputImage);

W=25;   % Window Size
patchSize=9;  
patchSigma=2;



%% Patch Based Filtering

X=padZeros(inputImage,W);  % Padding Zeros to the noise corrupted image
gaussianMask=fspecial('gaussian', patchSize ,patchSigma);  % 9*9 Gaussian Mask

row=1;
column=1;

% i=13;
% j=13;


for i=(1+floor(W/2)):(m+floor(W/2))  % This is because inputImage is Padded with Zeros, covers all rows of inputImage.
    column=1;
    for j=(1+floor(W/2)):(n+floor(W/2))  %% This is because inputImage is Padded with Zeros, covers all columns of inputImage.
         
        weights=0;  % Initializing all weights to be multiplied with all Neighbourhood pixels to zero. 
        
        
        % Calculating the Neighbourhood for a given pixel in the inputImage
        
        Neighbourhood=inputImage(max(1,row-floor(W/2)):min(m,row+floor(W/2)),max(1,column-floor(W/2)):min(m,column+floor(W/2))); % To generate Neighbourhood of the given pixel in the inputImage according to Window size and also taking care of boundary pixels.
        
        
         
         % Now we want to find out the weights for each pixel in the
         % Neighbourhood matrix so as to calculate the desired intensity
         % for a given pixel.
        
         [K L] = size(Neighbourhood);
         patch=gaussianMask.*X((i-floor(patchSize/2)):(i+floor(patchSize/2)),(j-floor(patchSize/2)):(j+floor(patchSize/2))); % Generating patch matrix for the pixel whose intensity needs to be transformed
         patchMask=1-(patch==0);
         paddedNeighbourhood=padZeros(Neighbourhood,patchSize);  % Zero Padding the neighbourhood matrix so as to generate patch matrix for the boundary pixels in the neighbourhood matrix appropriately 
          %k=5;
          %p=5; 
         
          
        
          % Now (k,p) will be the position of every pixel in the
          % Neighbourhood matrix so as to calculate weights for each of
          % the pixels
          
          for k=(floor(patchSize/2)+1):(K+floor(patchSize/2))
            for p=(floor(patchSize/2)+1):(L+floor(patchSize/2))
                 patchNeigh=paddedNeighbourhood(k-floor(patchSize/2):k+floor(patchSize/2),p-floor(patchSize/2):p+floor(patchSize/2)); % Creating patch for every pixel (k,m) from the paddedNeighbourhood matrix
                 patchNeigh_g=patchNeigh.*patchMask.*gaussianMask;
                 %patchNeigh_g=patchNeigh.*gaussianMask;  % multipliying each patch [corresponding to (k,p)] with the Gaussian mask. 
                 weights(k-floor(patchSize/2),p-floor(patchSize/2))=exp(-(1/sigmad^2).*sum(sum((patch-patchNeigh_g).^2))); % Weight matrix whose elements are the weights for the corresponding pixels in the Neighbourhood matrix
            end
          end
          weights=weights./sum(sum(weights));  % Normalizing Weights
          outputImage(i-floor(W/2),j-floor(W/2))=sum(sum(weights.*Neighbourhood));  % Updating the current pixel intensity.
          column=column+1;
    end
    row=row+1;
end


%% Display of Noiseless, Noisy and Filtered image 

% imshow(uint8(imageOrig));
% figure;
% imshow(uint8(inputImage));
% figure;
% imshow(uint8(outputImage));

originalRMSD=sqrt((1/(m*n))*sum(sum((inputImage-image).^2)))
gaussianMask=fspecial('gaussian',patchSize ,patchSigma);



subplot(221),imshow(image,[]);
title('Noiseless Image');
colorbar

subplot(222),imshow(inputImage,[]);
title('Noisy Image');
colorbar

subplot(223),imshow(outputImage,[]);
title('Filtered Image');
colorbar

subplot(224),imshow(gaussianMask,[]);
title('Gaussian Mask Used ');
colorbar

end