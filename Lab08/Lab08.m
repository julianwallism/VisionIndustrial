%%%%%%%%%%%%%%%%%
%%    LAB 08   %%
%%%%%%%%%%%%%%%%%

%% First-Order Derivatives

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 1. Write a function in Matlab to compute the gradient of an image in both
% directions using the Sobel operator. You can use Matlab functions, except 
% edge. The function signature should be: function[Gx, Gy] = gradients(img)
% where Gx and Gy are the gradients and img is an image with values between 
% the range [0.0, 1.0].

% 2. Load and display the image house.jpg.

% 3. Compute the gradients of the image in both directions using the 
% function created in exercise 1. Display the resulting gradients, 
% converting them to a grayscale image.

% 4. Compute the magnitude of the gradient at each point using the 
% above-mentioned approximation and display the final magnitude image.

% 5. Detect edges in the image, selecting as edges pixels whose magnitude 
% is above a given threshold. Try different values for this threshold and 
% display the results.

% 6. Detect edges in the image, selecting as edges pixels whose magnitude 
% is above a given threshold. Try different values for this threshold and 
% display the results.

% 7. Detect edges in the image, selecting as edges pixels whose magnitude 
% is above a given threshold. Try different values for this threshold and 
% display the results.

%% Second-Order Derivatives

% 1. Write a function in Matlab to compute zero-crossings given a 
% second-order derivative matrix. The function signature should be:
% function imedges = zerocrossings(deriv2, T)
% where deriv2 is a second-order derivative image, T is a threshold for the
% magnitude and imedges is a binary image with values established to 1
% where exists a zero-crossing. A position (x, y) will be considered as 
% zero crossing if its sign changes in relation to the pixels immediately 
% to the right or below with a magnitude above some threshold T.

% 2. Reload and display the image house.jpg.

% 3. Compute the second-order derivative of the image using the Laplacian 
% operator. Display the results.

% 4. Compute the edges of the image using the derivative obtained in the 
% previous exercise and the function coded in exercise 1. Apply several 
% thresholds and display the output images.

% 5. Compute the second-order derivative of the image using a LoG filter of
% size 13x13 and sigma 2.0. Display the results.

% 6. Compute the edges using the results of the previous exercise and the 
% function written in exercise 1. Apply several thresholds and display the
% resulting images.

% 7. Compute the edges using the results of the previous exercise and the 
% function written in exercise 1. Apply several thresholds and display the 
% resulting images.

%% Hough Transform

% Using the functions available in the Matlab’s Image Processing Toolbox, 
% employ the Hough transform to detect the lines of the road present in the
% images road.jpg and chessboard. As a final result, you should plot the 
% accumulator and the detected lines in the original image as shown in the 
% following figure:
