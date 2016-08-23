function myBilinearInterpolation(fname)
%% loading image
in_img=imread([char(fname) '.png']);
% imshow(in_img);


% figure
gray_img=mat2gray(in_img);
[m, n]=size(in_img);

%% row interpolation

outr_img=zeros(3*m-2,n);
outr_img(1:3:end,:)=gray_img;
% out_img=[1 2 3 4 5;0 9 8 7 5;5 6 7 8 9;5 6 8 9 0;8 6 4 3 1]
%imshow(gray_img);
rows1=(2)*gray_img(1:end-1,:)+gray_img(2:end,:);
rows2=gray_img(1:end-1,:)+(2)*gray_img(2:end,:);
outr_img(2:3:end,:)=rows1/3;
outr_img(3:3:end,:)=rows2/3;

% disp(outr_img);

%% column interpolation
 out_img=zeros(3*m-2,2*n-1);
 out_img(:,1:2:end)=outr_img;
out_img(:,2:2:end)=(outr_img(:,1:end-1)+outr_img(:,2:end))/2;
% out_img(:,2:2:end)=cols1;


disp(size(out_img));

% figure
% imshow(out_img);
%% Plotting
    myNumOfColors = 200;
    %colour scale
    myColorScale = [ [0:1/(myNumOfColors-1):1]' , ...
[0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' ];

    figure
    subplot(1,2,1), imagesc(in_img);
    title('Original Image')
    colormap (myColorScale);
    %aspect ratio
    daspect ([1 1 1]);
    axis equal tight;
    colorbar
    subplot(1,2,2), imagesc(out_img);
    title(['Bilinear interpolation'])
    colormap (myColorScale);
     %aspect ratio
    daspect ([1 1 1]);
    axis equal tight;
    colorbar
    impixelinfo;
    %saving the image
%     save(['1/images/' char(fname(7:end)) '_shrinked' num2str(d)],'im_resized')

end
