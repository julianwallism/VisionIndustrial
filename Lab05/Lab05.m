%%%%%%%%%%%%%%%%%
%%    LAB 05   %%
%%%%%%%%%%%%%%%%%
close all

%% Smoothing

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. Write a function in Matlab to perform a convolution between an image 
% and a mask of any odd dimension without using Matlab specific functions. 
% The function signature should be: 
% function cimage = correlation(img , mask) 
% where img is a gray level image with values in the range [0.0, 1.0], mask
% is the convolution matrix and cimage is the output image, having the same
% size as the original. Wherever the operation can not be performed, set 
% the pixel values to zero 

% Final del archivo

% 2. Use the function created in the previous exercise to apply an average 
% filter to the image letters.jpg and display the results, converting the 
% resulting matrix to an image.
I = imread('letters.jpg');
I = im2gray(I);
I = im2double(I);
mask = [1/9 1/9 1/9; 1/9 1/9 1/9; 1/9 1/9 1/9];
cimage = correlation(I, mask);
figure(1);
subplot(1,2,1), imshow(I), title('Original');
subplot(1,2,2), imshow(cimage), title('Correlation');

% 3. Apply an average filter to the image letters.jpg using the function 
% available in Matlab. Obtain different versions of the image using kernels
% of size 3×3, 5×5, 9×9, 15×15 and 35×35 and display the resulting images. 
% What is the effect of using an average filter? What is the effect of 
% augmenting the size of the kernel?
I = imread('letters.jpg');
I = im2double(I);
tres = fspecial('average', 3);
cinco = fspecial('average', 5);
nueve = fspecial('average', 9);
quince = fspecial('average', 15);
treinta = fspecial('average', 35);

figure(2);
subplot(2,3,1), imshow(I), title('Original');
subplot(2,3,2), imshow(imfilter(I, tres)), title('3x3');
subplot(2,3,3), imshow(imfilter(I, cinco)), title('5x5');
subplot(2,3,4), imshow(imfilter(I, nueve)), title('9x9');
subplot(2,3,5), imshow(imfilter(I, quince)), title('15x15');
subplot(2,3,6), imshow(imfilter(I, treinta)), title('35x35');

% 4. Using the function written in exercise 1, apply the following weighted average filter to the image and compare the results with the ones obtained in exercise 2:
I = imread('letters.jpg');
I = im2gray(I);
I = im2double(I);
mask1 = [5/100 10/100 5/100; 10/100 40/100 10/100; 5/100 10/100 5/100];
mask2= [1/9 1/9 1/9; 1/9 1/9 1/9; 1/9 1/9 1/9];
cimage1 = correlation(I, mask);
cimage2 = correlation(I, mask2);

figure(3);
subplot(1,3,1), imshow(I), title('Original');
subplot(1,3,2), imshow(cimage1), title('Correlation 1');
subplot(1,3,3), imshow(cimage2), title('Correlation 2');

%% Sharpening

% 1. Load the image moon.bmp, convert it to the range [0.0, 1.0] and display it.
I = imread('moon.bmp');
I = im2gray(I);
I = im2double(I);
figure(4);
imshow(I), title('moon');

% 2. Using the filtering function available in Matlab, apply the above-mentioned Laplacian mask to the image in order to obtain the second derivative. Subtract the response from the original image in order to sharp the details and display the resulting images
I = imread('moon.bmp');
I = im2gray(I);
I = im2double(I);

mask = [0 -1 0; -1 4 -1; 0 -1 0];
cimage = imfilter(I, mask);
I = I - cimage;

figure(5);
subplot(1,2,1), imshow(I), title('Original');
subplot(1,2,2), imshow(cimage), title('Correlation');


% 3. Create a blurred version of the original image convolving it with 
% an average filter. Then, subtract this resulting image from the original
% one, and add this resulting image again to the original one in order 
% to sharp it. Display the results.
I = imread('moon.bmp');
I = im2gray(I);
I = im2double(I);
cimage= imfilter(I, fspecial('average', 3));
diff = I - cimage;
I = I + diff;
figure(6);
subplot(1, 3, 1), imshow(I), title('Original');
subplot(1, 3, 2), imshow(diff), title('Diff');
subplot(1, 3, 3), imshow(cimage), title('Sharpening');

% 4. Sharp the image with the unsharp filter available in the fspecial function and show the results. Is it the same as the previous ones?
I = imread('moon.bmp');
I = im2gray(I);
I = im2double(I);
cimage= imfilter(I, fspecial('unsharp'));
figure(7);
subplot(1, 2, 1), imshow(I), title('Original');
subplot(1, 2, 2), imshow(cimage), title('Sharpening');

%% Template Matching

% Given the image imag_tmatch.bmp and the template pattern_tmatch.bmp, detect the points in the image where the letter a exist. Using normXcorr2
% The final result must be a binary image where the positions of the detected letters are white pixels.
I = imread('imag_tmatch.bmp');
I = im2gray(I);
I = im2double(I);
pattern = imread('pattern_tmatch.bmp');
pattern = im2gray(pattern);
pattern = im2double(pattern);
c = normxcorr2(pattern, I);
figure(8);
subplot(1,3,1), imshow(I), title('Original');
subplot(1,3,2), imshow(pattern), title('Pattern');
subplot(1,3,3),imshow(c), title('Correlation');



% Ejercicio 1.S %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function cimage = correlation(img , mask)
    k = floor(size(mask)/2)
    [m,n] = size(img);
    img = addBorder(img, floor(size(mask,1)/2));
    cimage = zeros(m,n);
    for i = k+1:m-k
        for j = k+1:n-k
            cimage(i, j) =sum(img(i-k:i+k, j-k:j+k).*mask,"all");  
        end
    end
    % cut border from array
    cimage = cimage(k+1:m-k, k+1:n-k);
end

function image = addBorder(img, bsize)
    k = floor(bsize/2);
    [m,n] = size(img);
    image = zeros(size(img)+k*2);
    image(k+1:m-k, k+1:n-k) = img;
end