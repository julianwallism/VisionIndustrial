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
I = rgb2gray(I);
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
I = rgb2gray(I);
I = imbinarize(I);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 4. Load the image text.jpg and binarize it
I = imread('text.jpg');
I = im2double(I);
I = rgb2gray(I);
I = imbinarize(I);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 5. Improve the quality of the text using a dilation operation. Perform 
% the operation using several structuring elements available in the strel
% function and display the results. Using these images, explain the effects
% produced by the dilation operation


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 6. Load the image licoln.jpg and binarize it
I = imread('licoln.jpg');
I = im2double(I);
I = rgb2gray(I);
I = imbinarize(I);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 7. Obtain the boundaries of the image combining an erosion or dilation 
% operation with the original image.