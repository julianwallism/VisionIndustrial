%%%%%%%%%%%%%%%%%
%%    LAB 09    %%
%%%%%%%%%%%%%%%%%
clear all;

%% Morphological Image Processing

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Erosion and Dilation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 1. Load the image morph1.jpg and binarize it
I  = imread('morph1.jpg');
I = im2double(I);
I = im2gray(I);
I = imbinarize(I);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 2. Erode the binary image using disks of radius 5, 10 and 20, respectively. 
% Display the results and the original image in the same figure. 
% Using these images, explain the effects produced by the erosion operation.
I5 = imerode(I, strel('disk', 5));
I10 = imerode(I, strel('disk', 10));
I20 = imerode(I, strel('disk', 20));

figure('Name', 'Erosion');
subplot(2,2,1); imshow(I); title('Original');
subplot(2,2,2); imshow(I5); title('Eroded 5');
subplot(2,2,3); imshow(I10); title('Eroded 10');
subplot(2,2,4); imshow(I20); title('Eroded 20');

% The erosion operation is used to remove the small features in the image.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 3. Write a code to automatically count the number of circles in the 
% image circles.jpg. Display the output image
I = imread('circles.jpg');
I = im2double(I);
I = im2gray(I);
I = imbinarize(I);

I7 = imerode(I, strel('disk', 7));

figure('Name', 'Erosion');
subplot(2,2,1); imshow(I); title('Original');
subplot(2,2,2); imshow(I7); title('Eroded 7');

[~, numFill] = bwlabel(I7);
disp(numFill);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 4. Load the image text.jpg and binarize it
I = imread('text.jpg');
I = im2double(I);
I = im2gray(I);
I = imbinarize(I);

figure('Name', 'Text');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 5. Improve the quality of the text using a dilation operation. Perform 
% the operation using several structuring elements available in the strel
% function and display the results. Using these images, explain the effects
% produced by the dilation operation

I_diamond = imdilate(I, strel('diamond', 5));
I_disk = imdilate(I, strel('disk', 5));
I_octagon = imdilate(I, strel('octagon', 5));
I_cross = imdilate(I, strel('line', 5, 0));
I_rect = imdilate(I, strel('rectangle', [5 5]));
I_square = imdilate(I, strel('square', 5));

figure('Name', 'Dilation text');
figure(2,3,1); imshow(I_diamond); title('Diamond');
figure(2,3,2); imshow(I_disk); title('Disk');
figure(2,3,3); imshow(I_octagon); title('Octagon');
figure(2,3,4); imshow(I_cross); title('Cross');
figure(2,3,5); imshow(I_rect); title('Rectangle');
figure(2,3,6); imshow(I_square); title('Square');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 6. Load the image licoln.jpg and binarize it
I = imread('licoln.jpg');
I = im2double(I);
I = im2gray(I);
I = imbinarize(I);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 7. Obtain the boundaries of the image combining an erosion or dilation 
% operation with the original image.
I_dilation = imdilate(I, strel('disk', 3));
boundaries = I_dilation - I;

figure('Name', 'Boundaries');
imshow(boundaries);