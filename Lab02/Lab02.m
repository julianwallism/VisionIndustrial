% 1. Generate the following binary images of size 256×256 and display the results:
% Note: The images should be defined using the logical data type.
A = false(256);
A(256/3:(256/3)*2,:)=true

figure(1)
subplot(1,2,1)
imshow(A)

B = false(256);
B(:,256/3:(256/3)*2)=true

subplot(1,2,2)
imshow(B)

% 2. Generate the following grayscale images of size 256×256 and display the results:
% Note: The images data type should be uint8.
C = uint8(ones(256).*(1:256)')

figure(2)
subplot(1,2,1)
imshow(C)

D = uint8(ones(256).*(1:256)) %% Flipear esto
subplot(1,2,2)
imshow(D)

% 3. Generate the following RGB images of size 256×256 and display the results:
% Note: The images data type should be uint8.
Red = zeros(255,255,3,"uint8");
Red (:,:,1)= 255;

figure(3)
subplot(1,3,1)
imshow(Red)

Green = zeros(255,255,3,"uint8");
Green(:,:,2)= 255;

subplot(1,3,2)
imshow(Green)

Blue = zeros(255,255,3,"uint8");
Blue(:,:,3)= 255;

subplot(1,3,3)
imshow(Blue)

% 4. Write a function in Matlab to generate the histogram of a grayscale 
% image without using the specific Matlab function for this purpose. 
% The function signature should be: 
% function h = histogram(image) 
% where h is a column vector with 256 elements of type double and image is 
% the input grayscale image. Each component of h indicates the number of 
% pixels of the corresponding intensity present in the image.

% Final del archivo


% 5. Using the function implemented in the previous point, compute the 
% histogram of the images of the exercise 2, and plot the results. 
% Are the histograms the same?

image = imread("example.jpg");
h = histogram(image);

figure(4)
subplot(1,2,1)
bar(h);
title('Funcion propia');

subplot(1,2,2)
imhist(image);
title('Función de MatLab');

% Sí que son iguales, lo que con la función de matlab muestra una escala de
% colores.

% 6. Resize the images generated in exercise 2 to 512×512, 128×128 and 64×64 using the corresponding Matlab
% function. Plot each resulting image and its corresponding histogram in figures. Given these histograms, what
% can we say about the resizing process in Matlab?

% 7. Write a function in Matlab to reduce images of size 256×256 to 128×128. The intensity value in the output
% image should be the maximum intensity in a neighborhood of the input image according to the following
% pattern:
% The function signature should be:
% function h = histogram(image)
% where image is the input image (256 × 256) and himage is the output image (128×128).

% 8. Use the function implemented in the previous point to reduce images generated in exercise 2 and display the
% results


function h = histogram(image)
    h = zeros(1,256);
    for i = 1:length(image)
        for j = 1:length(image)
            ind=image(i,j);
            h(ind) = h(ind)+1;
        end;
    end;
end
