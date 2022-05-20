%%%%%%%%%%%%%%%%%
%%  FINAL LAB  %%
%%%%%%%%%%%%%%%%%
%close all;

%% 
%% Preprocess data:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% global variables
global kernel_HitMiss;
kernel_HitMiss = ones(101,101);
kernel_HitMiss = kernel_HitMiss*-1;
kernel_HitMiss(2:end-1,2:end-1) = 0;
kernel_HitMiss(51,51) = 1;
% We load all the images

images = cell([1 10]);
myFiles = dir('*.jpg'); %gets all wav files in struct
numImages = length(myFiles); 
for k = 1:numImages
    img = imread(myFiles(k).name);
    img = im2gray(img);
    img = im2double(img);
    images{k}= img;
end

% figure(1);
% I = im2double(im2gray(imread("ex.jpg")));
% [centersBright, radiiBright] = imfindcircles(I,[30 60],"ObjectPolarity","bright");
% [centersDark, radiiDark] = imfindcircles(I,[30 60],"ObjectPolarity","dark");
% 
% imshow(I);
% viscircles(centersBright, radiiBright,'Color','b');
% viscircles(centersDark, centersDark,'Color','r');


% for k = 1:numImages
% figure(1);
% % images{10}= histeq(images{10});
% imshow(images{1})
%     [centers, radii] = imfindcircles(images{1},143);
%     [centersBright, radiiBright] = imfindcircles(images{1},143,'ObjectPolarity','bright');
%     [centersDark, radiiDark] = imfindcircles(images{1},143,'ObjectPolarity','dark');
%     viscircles(centers, radii,'Color','g');
%     viscircles(centersBright, radiiBright,'Color','b');
%     viscircles(centersDark, radiiDark,'Color','r');
% % end

% % Lets see the grayscale images and their histograms
% figure('Name','Original Images');
% for k = 1:numImages
%     subplot(2,5,k), imshow(images{k}), title(sprintf('Image %d', k));
% end
% 
% figure('Name','Images Histogram');
% for k = 1:numImages
%     subplot(2,5,k), imhist(images{k}), title(sprintf('Image %d', k));
% end

figure();
for k = 1:numImages-1
    [out, num] = getWPonBS(images{k});
    subplot(2,5,k),imshow(out);
end
% 
% for k = 1:numImages
%     [out, num] = getBP(images{k});
%     figure(1);
%     subplot(2,5,k),imshow(out), title(k);
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Functions

%% Function that given a grayscale image, returns a binarized 
%% image with the chessboard grid
function out = getGrid(I)
    out = zeros(I);

    BW = edge(I, 'canny');
    [H,T,R] = hough(BW);
    P = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));
    L = houghlines(BW,T,R,P,'FillGap',5,'MinLength',7);

end

% Function that given a gray scale image it returns an image showing
% the white pieces on the black squares and the number of these
function [out, num] = getWPonBS(image)
    global kernel_HitMiss;
    out = imbinarize(image);
    out = imclose(out, strel('disk',9));
    out = imerode(out, strel('square',21));
%     out = out - bwhitmiss(out, kernel_HitMiss);
     out = imfill(out, 'holes');
     out = imopen(out, strel('square',51));
     out = imdilate(out, strel('disk',21));
%     out = imerode(out, strel('square', 3));
    [~,num]=bwlabel(out);
    num = num-32;
    %create a kernel of zeros with -1 in the borders and 1 in the center
end

% Function that given a gray scale image it returns an image showing the
% black pieces and number of these.
function [out, num] = getBP(image)
    global kernel_HitMiss
    out = imadjust(image);
    out = imbinarize(out);
    out = imdilate(out,strel('disk', 5));
    out = imdilate(out,strel('disk', 5));
%     area = regionprops(out, "Area");
    out = out - bwareafilt(out,[50000 80000]) ;
%     out = imdilate(out, strel('square', 20));
%     out = imclose(out,strel('square',25));
%     out = imopen(out, strel('disk',9));
%     out = imclose(out, strel('square',9));
%     out = out - bwhitmiss(out, kernel_HitMiss);
%     out = imcomplement(out);
%     out = imfill(out, 'holes');
%     out = imcomplement(out);
%         out = imerode(out, strel('square', 3));
    [~,num]=bwlabel(out);
    num = num-32;
end