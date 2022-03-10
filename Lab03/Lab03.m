%%%%%%%%%%%%%%%%%
%%    LAB 03   %%
%%%%%%%%%%%%%%%%%

%% Histogram Stretching

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. Display the images pollenlow.jpg, pollenblack.jpg, pollenwhite.jpg 
% along with their corresponding histograms using the imhist function. 
% What can you say about the contrast of each of these images?

low = imread("pollenlow.jpg");
black = imread("pollenblack.jpg");
white = imread("pollenwhite.jpg");

figure('Name', 'Pollen Histograms');
subplot(3,2,1), imshow(low), title('low');
subplot(3,2,2), imhist(low), title('Hist low');

subplot(3,2,3), imshow(black), title('black');
subplot(3,2,4), imhist(black), title('Hist black');

subplot(3,2,5), imshow(white), title('white');
subplot(3,2,6), imhist(white), title('Hist white');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2. Write a function in Matlab to adjust the contrast of an image using 
% the above-mentioned formula and avoidiing specific Matlab functions 
% designed for this purpose. The function signature should be:
% function imadj = adjust(image)
% where image is the original image containing values in the range 
% [0.0, 1.0] and imadj is the resulting adjusted image.

% final del archivo

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3. Using the function created in the previous point, adjust the contrast 
% of the three images of exercise 1 and display the resulting images along 
% with their corresponding histograms. Compare the histograms of the 
% adjusted images with the original ones.

low_norm = double(low)/255
black_norm = double(black)/255;
white_norm = double(white)/255;

low_adjust = adjust(low_norm);
black_adjust = adjust(black_norm);
white_adjust = adjust(white_norm);

figure('Name', 'Adjust');
subplot(3,2,1), imshow(low_adjust), title('low adjust');
subplot(3,2,2), imhist(low_adjust), title('hist low adjust');

subplot(3,2,3), imshow(black_adjust), title('black adjust');
subplot(3,2,4), imhist(black_adjust), title('hist black adjust');

subplot(3,2,5), imshow(white_adjust), title('white adjust');
subplot(3,2,6), imhist(white_adjust), title('hist white adjust');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4. Apply the function provided by Matlab for adjusting the contrast of 
% the three images, and display the resulting images with their histograms
% Are these histograms the same as the ones obtained in the previous 
% exercise? Why?

figure('Name', 'Matlab Adjust');
subplot(3,1,1), imadjust(low), title('low adjust');
subplot(3,1,2), imadjust(black), title('black adjust');
subplot(3,1,3), imadjust(white), title('white adjust');



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 5. Would it be possible to use the Matlab’s contrast adjusting function 
% to obtain the complement (negative) of an image?. Think about it, try to 
% perform this operation using the three images and show the results.



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 6. Given the three versions of the images: the original one, the adjusted
% one obtained with your function and the adjusted one using the Matlabs 
% function, which one would you use for a further processing step? Why?


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Histogram Equalization

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. Write a function in Matlab for computing the cumulative sum of a 
% normalized histogram. The function signature should be: 
% functioncdf = csum(hnorm) 
% where hnorm is the normalized histogram of an image and cdf is the 
% resulting cumulative sum.



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2. Write a function in Matlab to equalize an image using a uniform 
% transformation with 256 gray levels. The function signature should be: 
% function imageeq = equalize(image) 
% where image is the input image and imageeq is the resulting equalized 
% image. This function must use the csum function implemented in the 
% previous exercise



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3. Equalize the images pollenlow.jpg, pollenblack.jpg, pollenwhite.jpg 
% using the function written in the previous point. Display each resulting
% image and its corresponding histogram in figures.



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4. Equalize the images pollenlow.jpg, pollenblack.jpg, pollenwhite.jpg 
% using the function provided by Matlab. Display the resulting images and 
% their histograms, and compare the results with the histograms computed in 
% the previous exercise.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 5. Compare the results obtained with histogram stretching and equalization 
% and explain briefly the main differences between both approaches.



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 6. Examine the adapthisteq Matlab’s function. How does it work?. 
% Equalize the histograms of the images pollenlow.jpg, pollenblack.jpg 
% and pollenwhite.jpg using two different grid sizes and display the results



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FUNCIONES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%% Ejercicio HS.1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function imadj = adjust(image)
   imadj = zeros(size(image));
   I_min = min(min(image))
   I_max = max(max(image))
   O_min=0;
   O_max=1;
   for i = 1:length(image);
       for j = 1:length(image);
        imadj(i,j)=(O_max-O_min)*((image(i,j)-I_min)/(I_max-I_min))+O_min;
       end
   end
end

%%%%% Ejercicio HE.1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function cdf = csum(image)
   
end

%%%%% Ejercicio HE.2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function imageeq = equalize(image)
   
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%