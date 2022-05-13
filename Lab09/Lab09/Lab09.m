%%%%%%%%%%%%%%%%%
%%    LAB 09    %%
%%%%%%%%%%%%%%%%%
clear all;
close all;

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
subplot(2,2,1), imshow(I), title('Original');
subplot(2,2,2), imshow(I5), title('Eroded 5');
subplot(2,2,3), imshow(I10), title('Eroded 10');
subplot(2,2,4), imshow(I20), title('Eroded 20');

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
subplot(2,2,1), imshow(I), title('Original');
subplot(2,2,2), imshow(I7), title('Eroded 7');

[~, numFill] = bwlabel(I7);
disp(numFill);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 4. Load the image text.jpg and binarize it
I = imread('text.jpg');
I = im2double(I);
I = im2gray(I);
I = imbinarize(I);

figure('Name', 'Text');
imshow(I), title('Text');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 5. Improve the quality of the text using a dilation operation. Perform 
% the operation using several structuring elements available in the strel
% function and display the results. Using these images, explain the effects
% produced by the dilation operation

I_diamond = imdilate(I, strel('diamond', 3));
I_disk = imdilate(I, strel('disk', 3));
I_octagon = imdilate(I, strel('octagon', 3));
I_cross = imdilate(I, strel('line', 3, 0));
I_rect = imdilate(I, strel('rectangle', [3 3]));
I_square = imdilate(I, strel('square', 3));
% Hemos puesto un tamaño de 3 ya que el octogono necesita que el tamaño sea
% multiplo de 3

figure('Name', 'Dilation text');
subplot(2,3,1), imshow(I_diamond), title('Diamond');
subplot(2,3,2), imshow(I_disk), title('Disk');
subplot(2,3,3), imshow(I_octagon), title('Octagon');
subplot(2,3,4), imshow(I_cross), title('Cross');
subplot(2,3,5), imshow(I_rect), title('Rectangle');
subplot(2,3,6), imshow(I_square), title('Square');

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% OPENING AND CLOSING

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 1. Load the image shapes.jpg  and apply a threshold in order to obtain 
%% a binary image
I = imread('shapes.jpg');
I = im2double(I);
I = im2gray(I);
threshold = graythresh(I);
I = imbinarize(I, threshold);
figure('Name', 'Shapes');
imshow(I), title('Shapes');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 2. Perform opening operations using squares of different sizes as
% structuring elements. Display the results and observe the effects produced 
% by the opening operation
I_15 = imopen(I, strel('square', 15));
I_19 = imopen(I, strel('square', 19));
I_23 = imopen(I, strel('square', 23));
I_27 = imopen(I, strel('square', 27));

figure('Name', 'Shapes Opening');
subplot(2,2,1), imshow(I_15), title('Opening 15');
subplot(2,2,2), imshow(I_19), title('Opening 19');
subplot(2,2,3), imshow(I_23), title('Opening 23');
subplot(2,2,4), imshow(I_27), title('Opening 27');

% CP
% Como podemos ver el opening elimina los objetos mas pequeños que no
% cumplen con las condiciones de la estructura. Por ejemplo, el opening de
% una imagen con una figura de 3x3, elimina el objeto que no cumpla con las
% condiciones de la estructura. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 3. Perform closing operations using squares of different sizes as 
% structuring elements. Display the results and observe the effects 
% produced by the closing operation.
I_15 = imclose(I, strel('square', 15));
I_19 = imclose(I, strel('square', 19));
I_23 = imclose(I, strel('square', 23));
I_27 = imclose(I, strel('square', 27));

figure('Name', 'Shapes Closing');
subplot(2,2,1), imshow(I_15), title('Closing 15');
subplot(2,2,2), imshow(I_19), title('Closing 19');
subplot(2,2,3), imshow(I_23), title('Closing 23');
subplot(2,2,4), imshow(I_27), title('Closing 27');

%CP
% Como podemos ver el closing elimina los objetos mas grandes que no
% cumplen con las condiciones de la estructura. Por ejemplo, el closing de
% una imagen con una figura de 3x3, elimina el objeto que no cumpla con las
% condiciones de la estructura.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 4. Load the image fingerprint.jpg and apply a threshold in order to 
%  obtain a binary image.
I = imread('fingerprint.jpg');
I = im2double(I);
I = im2gray(I);
threshold = graythresh(I);
I = imbinarize(I, threshold);
figure('Name', 'Fingerprint');
imshow(I), title('Fingerprint');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 5. Improve the quality of the fingerprint using a combination of opening 
% and closing operations and display the final results
s
I_CO_Square_3 = imclose(imopen(I, strel('square', 3)), strel('square', 3));
I_OC_Square_3 = imopen(imclose(I, strel('square', 3)), strel('square', 3));

figure('Name', 'Fingerprint CO y OC');
subplot(1,2,1), imshow(I_CO_Square_3), title('CO Square 3');
subplot(1,2,2), imshow(I_OC_Square_3), title('OC Square 3');

% Hemos probado de hacer el OC y el CO con un disco de tamaños 3, 5, 7 y 9
% pero los resultados son muy malos. También hemos mirado de hacerlo con un
% cuadrado de tamaño 5, 7 y 9 pero el resultado tambien era malo

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Exercises

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 1. Load the image letters2.jpg. Apply a threshold in order to obtain a binary image.
I = imread('letters2.jpg');
I = im2double(I);
I = im2gray(I);
threshold = graythresh(I);
I = imbinarize(I, threshold);
figure('Name', 'Letters');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 2. Apply erosion, dilation, opening and closing transformations to the 
% image using the following structuring elements:
G1 = ones(3,3);
G2 = [1 0 1];
G3 = [0 1 0; 1 1 1; 0 1 0];
G4 = [1 0 1; 0 1 0; 1 0 1];

I_erosion_G1 = imerode(I, G1);
I_erosion_G2 = imerode(I, G2);
I_erosion_G3 = imerode(I, G3);
I_erosion_G4 = imerode(I, G4);

I_dilation_G1 = imdilate(I, G1);
I_dilation_G2 = imdilate(I, G2);
I_dilation_G3 = imdilate(I, G3);
I_dilation_G4 = imdilate(I, G4);

I_opening_G1 = imopen(I, G1);
I_opening_G2 = imopen(I, G2);
I_opening_G3 = imopen(I, G3);
I_opening_G4 = imopen(I, G4);

I_closing_G1 = imclose(I, G1);
I_closing_G2 = imclose(I, G2);
I_closing_G3 = imclose(I, G3);
I_closing_G4 = imclose(I, G4);

figure('Name', 'Letters Erosion');
subplot(2,3,1), imshow(I), title('Original');
subplot(2,3,2), imshow(I_erosion_G1), title('Erosion G1');
subplot(2,3,3), imshow(I_erosion_G2), title('Erosion G2');
subplot(2,3,4), imshow(I_erosion_G3), title('Erosion G3');
subplot(2,3,5), imshow(I_erosion_G4), title('Erosion G4');

figure('Name', 'Letters Dilation');
subplot(2,3,1), imshow(I), title('Original');
subplot(2,3,2), imshow(I_dilation_G1), title('Dilation G1');
subplot(2,3,3), imshow(I_dilation_G2), title('Dilation G2');
subplot(2,3,4), imshow(I_dilation_G3), title('Dilation G3');
subplot(2,3,5), imshow(I_dilation_G4), title('Dilation G4');

figure('Name', 'Letters Opening');
subplot(2,3,1), imshow(I), title('Original');
subplot(2,3,2), imshow(I_opening_G1), title('Opening G1');
subplot(2,3,3), imshow(I_opening_G2), title('Opening G2');
subplot(2,3,4), imshow(I_opening_G3), title('Opening G3');
subplot(2,3,5), imshow(I_opening_G4), title('Opening G4');

figure('Name', 'Letters Closing');
subplot(2,3,1), imshow(I), title('Original');
subplot(2,3,2), imshow(I_closing_G1), title('Closing G1');
subplot(2,3,3), imshow(I_closing_G2), title('Closing G2');
subplot(2,3,4), imshow(I_closing_G3), title('Closing G3');
subplot(2,3,5), imshow(I_closing_G4), title('Closing G4');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 3. Compute the skeleton only for the letters present in the image and 
% display, in the same figure, the original image and the results.
I_skeleton = bwmorph(I, 'skeleton');
figure('Name', 'Letters Skeleton');
subplot(1,2,1), imshow(I), title('Original');
subplot(1,2,2), imshow(I_skeleton), title('Skeleton');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 4. Use the Hit and Miss transform to obtain the end points and the triple 
% junctions of the skeleton. Show, in the same figure: the original skeleton,
% the end points, the triple junctions and the combination of end points and
%triple junctions.
I_endpoints = bwmorph(I_skeleton, 'endpoints');
I_triple_junctions = bwmorph(I_skeleton, 'triple_junctions');
I_endpoints_triple_junctions = I_endpoints | I_triple_junctions;

