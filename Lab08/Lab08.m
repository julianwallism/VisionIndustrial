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
I = imread('house.jpg');
imshow(I);

% 3. Compute the gradients of the image in both directions using the 
% function created in exercise 1. Display the resulting gradients, 
% converting them to a grayscale image.

I = im2double(I);
[Gx, Gy] = gradients(I);
Gx = im2gray(Gx);
Gy = im2gray(Gy);

figure(1);
subplot(1,2,1), imshow(Gx), title('Gx');
subplot(1,2,2), imshow(Gy), title('Gy');

% 4. Compute the magnitude of the gradient at each point using the 
% above-mentioned approximation and display the final magnitude image.

Gz = zeros(size(I));
for i = 1:size(Gx,1)
    for j = 1:size(Gx,2)
        Gz(i,j) = sqrt(Gx(i,j)^2 + Gy(i,j)^2);
    end
end

imshow(Gz);

% 5. Detect edges in the image, selecting as edges pixels whose magnitude 
% is above a given threshold. Try different values for this threshold and 
% display the results.


% 6. Using the edge Matlab’s function, compute the edges of the image 
% using Sobel, Prewitt and Roberts opederators. Test several thresholds 
% for each operator and display the best results obtained. Compare them,
% enumerating the main advantages and disadvantages of each approach.

ImSob = edge(I, 'sobel');
ImPrew = edge(I, 'prewitt');
ImRoberts = edge(I, 'roberts');

% Falta elegir los umbrales!!!!
figure(2);
subplot(1,3,1), imshow(ImSob), title('Sobel');
subplot(1,3,2), imshow(ImPrew), title('Prewitt');
subplot(1,3,3), imshow(ImRoberts), title('Roberts');

% 7. Apply the Canny edge detector to the image using the default 
% parameters, display the obtained edges and compare the results with 
% the previous ones. Vary the parameters of the algorithm and explain 
% the observed effects.

ImCanny = edge(I, 'canny');
imshow(ImCanny);


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
I = imread('house.jpg');
imshow(I);

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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Funciones %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Ejercicio 1.1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CP
function[Gx, Gy] = gradients(img)
    % Sobel operator
    Gx = conv2(img, [-1 0 1; -2 0 2; -1 0 1], 'same');
    Gy = conv2(img, [-1 -2 -1; 0 0 0; 1 2 1], 'same');
end

% Ejercicio 2.1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CP
function imedges = zerocrossings(deriv2, T)
    % Zero-crossings
    imedges = zeros(size(deriv2));
    for i = 2:size(deriv2,1)-1
        for j = 2:size(deriv2,2)-1
            if deriv2(i,j) > T
                if (deriv2(i-1,j) < 0 && deriv2(i+1,j) > 0) || (deriv2(i-1,j) > 0 && deriv2(i+1,j) < 0)
                    imedges(i,j) = 1;
                end
                if (deriv2(i,j-1) < 0 && deriv2(i,j+1) > 0) || (deriv2(i,j-1) > 0 && deriv2(i,j+1) < 0)
                    imedges(i,j) = 1;
                end
            end
        end
    end
end 


