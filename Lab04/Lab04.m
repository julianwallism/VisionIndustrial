%%%%%%%%%%%%%%%%%
%%    LAB 04   %%
%%%%%%%%%%%%%%%%%
close all

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
normImage = mat2gray(Img);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3. Apply the logtrans function to this image.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4. Display in the same figure both images and their corresponding 
% histograms.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 5. What can be observed? What is the effect of applying the log 
% transformation to the image?

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Power Law transformations

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. Write a function in Matlab to transform a grayscale image using a 
% power law transformation. The function signature should be:
% function plimage = powerlaw ( image , gamma)
% where image is an intensity image with values in the range [0.0, 1.0], 
% gamma is the exponent of the power law transformation and plimage is the 
% output image. Assume that the constant c is 1.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2. Display the image spine.jpg and its histogram.
Img2 = imread("spine.jpg");
h_Img2 = histogram(Img2);

figure('Name', 'Spine');
subplot(1,2,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3. If a lighter image is wanted, which values of γ do we need to use: 
% lower or higher than 1?

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4. Using different values of γ, obtain three lighter versions of the 
% image. Show the resulting images and their corresponding histograms.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 5. Which image would you use for a further processing step? Why?

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 6. Display the image landscape.jpg and its histogram.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 7. Enhance the image using three power law transformations.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 8. Show the resulting images and their corresponding histograms.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 9. Which image would you use for a further processing step? Why?

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Thresholding

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. Open the image screws.jpg and display it.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2. In order to separate the screws from the background, what might be a 
% good range of intensities for thresholding? Justify your answer 
% graphically.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3. Write a function in Matlab to apply a thresholding operation to an 
% image. The function signature should be:
% function binimage = thresh(image , T)
% where image is a grayscale image with values in the range [0.0, 1.0], 
% T is a threshold between 0 and 1 and binimage is the output binary image. 
% binimage must be defined as type logical

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4. Binarize the image screws.jpg using the function written in the 
% previous exercise and display the results.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4. Binarize the image screws.jpg using the function written in the 
% previous exercise and display the results.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 6. Analyze the Matlab function adaptthresh and graythresh. What does they 
% do? Use graythresh for obtaining the value of the threshold with Otsu's 
% method. Binarize screws.jpg with different thresholds and display the
% results

%%%%% Ejercicio 1 L.T %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function logimage = logtrans(image, c)
end

%%%%% Ejercicio 1 P.W.T %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function plimage = powerlaw ( image , gamma)
end

%%%%% Ejercicio 3 T %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function binimage = thresh(image , T)
end

