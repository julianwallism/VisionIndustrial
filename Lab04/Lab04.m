%%%%%%%%%%%%%%%%%
%%    LAB 04   %%
%%%%%%%%%%%%%%%%%
close all

%% Negative transormations

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. Open the image breast.tif and convert it to the range of values [0.0, 1.0].
I = imread('breast.tif');
I = mat2gray(I);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2. Obtain the negative of this image using the provided function in Matlab.
% negative of image I
I_neg = imcomplement(I);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3. Display in a figure both images and their corresponding histograms.
% display both images and their corresponding histograms
figure(1)
subplot(2,2,1), imshow(I), title('Original Image');
subplot(2,2,2), imhist(I), title('Original Image Histogram');
subplot(2,2,3), imshow(I_neg), title('Negative Image');
subplot(2,2,4), imhist(I_neg), title('Negative Image Histogram');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4. What can be observed? What is the effect of applying the negative transformation to the image?


%% Log transformations

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. Write a function in Matlab to transform a grayscale image using the
% logarithmic transformation. The function signature should be: function 
% logimage = logtrans(image, c) where image is a grayscale input image with 
% values in the range [0.0, 1.0], c is the constant and logimage is the 
% output image.

% final del archivo

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2. Open the image light.tif and convert it to [0.0, 1.0].
Img = imread("light.tif");
normImage = im2gray(Img); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3. Apply the logtrans function to this image.
%logImage = logtrans(normImage, 10); % entre 8 i 12

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4. Display in the same figure both images and their corresponding 
% histograms.
figure(2)
subplot(2,2,1), imshow(normImage), title('Original Image');
subplot(2,2,2), imhist(normImage), title('Original Image Histogram');
%subplot(2,2,3), imshow(logImage), title('Logarithmic Image');
%subplot(2,2,4), imhist(logImage), title('Logarithmic Image Histogram');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 5. What can be observed? What is the effect of applying the log 
% transformation to the image?
% The effect is that the image is more bright and the image is more
% contrasty. CP

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Power Law transformations

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. Write a function in Matlab to transform a grayscale image using a 
% power law transformation. The function signature should be:
% function plimage = powerlaw ( image , gamma)
% where image is an intensity image with values in the range [0.0, 1.0], 
% gamma is the exponent of the power law transformation and plimage is the 
% output image. Assume that the constant c is 1.

% final del archivo

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2. Display the image spine.jpg and its histogram.
Img = imread("spine.jpg");
normImage = im2gray(Img);
normImage = im2double(normImage);
figure(3);
subplot(1,2,1), imshow(normImage), title('Original Image');
subplot(1,2,2), imhist(normImage), title('Original Image Histogram');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3. If a lighter image is wanted, which values of γ do we need to use: 
% lower or higher than 1?
% lower than 1 because the image is darker and the image is more contrasty CP

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4. Using different values of gamma, obtain three lighter versions of the image.
% Show the resulting images and their corresponding histograms.

Img_1 = powerlaw(normImage, 0.75);
Img_2 = powerlaw(normImage, 0.5);
Img_3 = powerlaw(normImage, 0.25);

figure(4);
subplot(3,2,1), imshow(Img_1), title('Power Law Image 1');
subplot(3,2,2), imhist(Img_1), title('Power Law Image 1 Histogram');
subplot(3,2,3), imshow(Img_2), title('Power Law Image 2');
subplot(3,2,4), imhist(Img_2), title('Power Law Image 2 Histogram');
subplot(3,2,5), imshow(Img_3), title('Power Law Image 3');
subplot(3,2,6), imhist(Img_3), title('Power Law Image 3 Histogram');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 5. Which image would you use for a further processing step? Why?

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 6. Display the image landscape.jpg and its histogram.
Img = imread("landscape2.jpg");
normImage = im2gray(Img);
normImage = im2double(normImage);
figure(5);
subplot(1,2,1), imshow(normImage), title('Original Image');
subplot(1,2,2), imhist(normImage), title('Original Image Histogram');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 7. Enhance the image using three power law transformations.
Img_1= powerlaw(normImage, 3);
Img_2= powerlaw(normImage, 4);
Img_3= powerlaw(normImage, 5);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 8. Show the resulting images and their corresponding histograms.
figure(6);
subplot(3,2,1), imshow(Img_1), title('Power Law Image 1');
subplot(3,2,2), imhist(Img_1), title('Power Law Image 1 Histogram');
subplot(3,2,3), imshow(Img_2), title('Power Law Image 2');
subplot(3,2,4), imhist(Img_2), title('Power Law Image 2 Histogram');
subplot(3,2,5), imshow(Img_3), title('Power Law Image 3');
subplot(3,2,6), imhist(Img_3), title('Power Law Image 3 Histogram');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 9. Which image would you use for a further processing step? Why?

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Thresholding

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. Open the image screws.jpg and display it.
Img = imread("screws.jpg");
normImage = im2gray(Img);
normImage = im2double(normImage);
figure(7);
subplot(1,2,1), imshow(normImage), title('Original Image');
subplot(1,2,2), imhist(normImage), title('Original Image Histogram');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2. In order to separate the screws from the background, what might be a 
% good range of intensities for thresholding? Justify your answer 
% graphically.
% 0.5 is a good threshold because it separates the background from the 
% screws. CP

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3. Write a function in Matlab to apply a thresholding operation to an 
% image. The function signature should be:
% function binimage = thresh(image , T)
% where image is a grayscale image with values in the range [0.0, 1.0], 
% T is a threshold between 0 and 1 and binimage is the output binary image. 
% binimage must be defined as type logical

% final del archivo

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4. Binarize the image screws.jpg using the function written in the 
% previous exercise and display the results.
binarizedImage = thresh(normImage, 0.5);

figure(8);
subplot(1,2,1), imshow(normImage), title('Original Image');
subplot(1,2,2), imshow(binarizedImage), title('Binarized Image');

% 5. Binarize the image screws.jpg using the appropriate Matlab function
% and display the results.
binarizedImageMatlab = imbinarize(normImage, 0.5);

figure(9);
subplot(1,3,1), imshow(normImage), title('Original Image');
subplot(1,3,2), imshow(binarizedImage), title('Binarized Image');
subplot(1,3,3), imshow(binarizedImageMatlab), title('Binarized Image Matlab');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 6. Analyze the Matlab function adaptthresh and graythresh. What does they 
% do? Use graythresh for obtaining the value of the threshold with Otsu's 
% method. Binarize screws.jpg with different thresholds and display the
% results

% adaptthresh is a function that adaptively thresholds an image.        CP
% graythresh is a function that thresholds an image with Otsu's method.
Img = imread("screws.jpg");
normImage = rgb2gray(Img);
normImage = im2double(normImage);

thresholdG = graythresh(normImage);
thresholdA = adaptthresh(normImage, 'ForegroundPolarity','dark');
binarizedImage1 = imbinarize(normImage, thresholdG);
binarizedImage2 = imbinarize(normImage, thresholdA);

figure(10);
subplot(1,2,1), imshow(binarizedImage1), title('Binarized Image 1');
subplot(1,2,2), imshow(binarizedImage2), title('Binarized Image 2');


%%%%% Ejercicio 1 L.T %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function logimage = logtrans(image, c)
    logimage = c*log(1 + image);
end


%%%%% Ejercicio 1 P.W.T %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function plimage = powerlaw ( image , gamma)
    plimage = image.^gamma;
end

%%%%% Ejercicio 3 T %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function binimage = thresh(image , T)
    for i=1:size(image,1)
        for j=1:size(image,2)
            if image(i,j) > T
                binimage(i,j) = 1;
            else
                binimage(i,j) = 0;
            end
        end
    end
end
