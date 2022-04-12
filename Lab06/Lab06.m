%%%%%%%%%%%%%%%%%
%%    LAB 06   %%
%%%%%%%%%%%%%%%%%
close all

%% Image Restoration

% Hemos  repetido cada ejercicio para las cuatro imagenes asi como se nos 
% pide en el ejercicio 7.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. Load and display the image board1.jpg
I1 = imread('board1.jpg');
I1 = im2gray(I1);
I1 = im2double(I1);

I2 = imread('board2.jpg');
I2 = im2gray(I2);
I2 = im2double(I2);

I3 = imread('board3.jpg');
I3 = im2gray(I3);
I3 = im2double(I3);

I4 = imread('board4.jpg');
I4 = im2gray(I4);
I4 = im2double(I4);

figure(1, 'Name', 'Original Images');
subplot(2,2,1), imshow(I1), title('Image 1');
subplot(2,2,2), imshow(I2), title('Image 2');
subplot(2,2,3), imshow(I3), title('Image 3');
subplot(2,2,4), imshow(I4), title('Image 4');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2. What kind of noise is affecting the image? Which filter would you 
% apply in this case?

% Para una imagen con ruido S&P aplicaríamos un filtro espacial no lineal.
% Existen tres: mediana, max y min. 
% Para una imagen con ruido S&P debemos aplicar el filtro de la mediana.
% Para una imagen con ruido Salt debemos aplicar el filtro min.
% Para una imagen con ruido Pepper debemos aplicar el filtro max.
% Para una imagen con ruido guassiano aplicaríamos un filtro espacial 
% lineal, en concreto el de la media.

% Así pues la imagen board1 tiene ruido S&P, ya que hay píxeles "aleatorios"
% con valor 0 y 1, debemos aplicar el filtro de la mediana.

% La imagen board2 tiene ruido Salt, ya que hay píxeles "aleatorios" con
% valor 1, debemos aplicar el filtro min.

% La imagen board3 tiene ruido Pepper, ya que hay píxeles "aleatorios" con
% valor 0, debemos aplicar el filtro max.

% La imagen board4 tiene ruido Gaussiano, ya que se puede apreciar que 
% presenta un ruido "continuo" en toda la imagen que responde a una 
% distribución norrmal. Debemos aplicar el filtro de la media


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3. Apply the following filters to the image: average, median, max and min

% Board 1
average = imfilter(I1, fspecial('average', 3));
median = medfilt2(I1);
max = ordfilt2(I1, 9, ones(3,3));
min = ordfilt2(I1, 1, ones(3,3));

figure(2, 'Name', 'Filters on Image 1');
subplot(2,2,1), imshow(average), title('Average');
subplot(2,2,2), imshow(median), title('Median');
subplot(2,2,3), imshow(max), title('Max');
subplot(2,2,4), imshow(min), title('Min');

% Board 2
average = imfilter(I2, fspecial('average', 3));
median = medfilt2(I2);
max = ordfilt2(I2, 9, ones(3,3));
min = ordfilt2(I2, 1, ones(3,3));

figure(3, 'Name', 'Filters on Image 2');
subplot(2,2,1), imshow(average), title('Average');
subplot(2,2,2), imshow(median), title('Median');
subplot(2,2,3), imshow(max), title('Max');
subplot(2,2,4), imshow(min), title('Min');

% Board 3
average = imfilter(I3, fspecial('average', 3));
median = medfilt2(I3);
max = ordfilt2(I3, 9, ones(3,3));
min = ordfilt2(I3, 1, ones(3,3));

figure(4, 'Name', 'Filters on Image 3');
subplot(2,2,1), imshow(average), title('Average');
subplot(2,2,2), imshow(median), title('Median');
subplot(2,2,3), imshow(max), title('Max');
subplot(2,2,4), imshow(min), title('Min');

% Board 4
average = imfilter(I4, fspecial('average', 3));
median = medfilt2(I4);
max = ordfilt2(I4, 9, ones(3,3));
min = ordfilt2(I4, 1, ones(3,3));

figure(5, 'Name', 'Filters on Image 4');
subplot(2,2,1), imshow(average), title('Average');
subplot(2,2,2), imshow(median), title('Median');
subplot(2,2,3), imshow(max), title('Max');
subplot(2,2,4), imshow(min), title('Min');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4. Compare the results displaying the resulting images in the same figure
% Which filter works better?

% Como hemos explicado en el ejercicio 1 el que mejor funciona para el 
% board1 es el filtro de la mediana, para el board2 el filtro de min, para
% el board3 el filtro de max y para el board4 el filtro de la media.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 5. Once selected the best filter to apply, check the effect of the filter
% size for this case. Display the best results obtained.

% Board 1
tres_1 = medfilt2(I1, [3 3]);
cinco_1 = medfilt2(I1, [5 5]);
siete_1 = medfilt2(I1, [7 7]);
nueve_1 = medfilt2(I1, [9 9]);

figure(6, 'Name', 'Sizes on Image 1');
subplot(2,2,1), imshow(tres_1), title('3x3');
subplot(2,2,2), imshow(cinco_1), title('5x5');
subplot(2,2,3), imshow(siete_1), title('7x7');
subplot(2,2,4), imshow(nueve_1), title('9x9');

% Como vemos obtenemos el mejor resultado usando un filtro de tamaño XxX

% Board 2
tres_2 = medfilt2(I2, [3 3]);
cinco_2 = medfilt2(I2, [5 5]);
siete_2 = medfilt2(I2, [7 7]);
nueve_2 = medfilt2(I2, [9 9]);

figure(7, 'Name', 'Sizes on Image 2');
subplot(2,2,1), imshow(tres_2), title('3x3');
subplot(2,2,2), imshow(cinco_2), title('5x5');
subplot(2,2,3), imshow(siete_2), title('7x7');
subplot(2,2,4), imshow(nueve_2), title('9x9');

% Como vemos obtenemos el mejor resultado usando un filtro de tamaño XxX

% Board 3
tres_3 = medfilt2(I3, [3 3]);
cinco_3 = medfilt2(I3, [5 5]);
siete_3 = medfilt2(I3, [7 7]);
nueve_3 = medfilt2(I3, [9 9]);

figure(8, 'Name', 'Sizes on Image 3');
subplot(2,2,1), imshow(tres_3), title('3x3');
subplot(2,2,2), imshow(cinco_3), title('5x5');
subplot(2,2,3), imshow(siete_3), title('7x7');
subplot(2,2,4), imshow(nueve_3), title('9x9');

% Como vemos obtenemos el mejor resultado usando un filtro de tamaño XxX

% Board 4
tres_4 = medfilt2(I4, [3 3]);
cinco_4 = medfilt2(I4, [5 5]);
siete_4 = medfilt2(I4, [7 7]);
nueve_4 = medfilt2(I4, [9 9]);

figure(9, 'Name', 'Sizes on Image 4');
subplot(2,2,1), imshow(tres_4), title('3x3');
subplot(2,2,2), imshow(cinco_4), title('5x5');
subplot(2,2,3), imshow(siete_4), title('7x7');
subplot(2,2,4), imshow(nueve_4), title('9x9');

% Como vemos obtenemos el mejor resultado usando un filtro de tamaño XxX

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 6. Use the imnoise function to add a different noise than the original to
% the restored image. Display the resulting image.
speckle_1 = imnoise(tres_1, 'speckle');
speckle_2 = imnoise(cinco_2, 'speckle');
speckle_3 = imnoise(siete_3, 'speckle');
speckle_4 = imnoise(nueve_4, 'speckle');

figure(10, 'Name', 'Speckle Noise');
subplot(2,2,1), imshow(speckle_1), title('speckle on Image 1');
subplot(2,2,2), imshow(speckle_2), title('speckle on Image 2');
subplot(2,2,3), imshow(speckle_3), title('speckle on Image 3');
subplot(2,2,4), imshow(speckle_4), title('speckle on Image 4');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 7. Repeat exercises 1-6 using the following images: board2.jpg, 
% board3.jpg, board4.jpg.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 8. Explain the main advantages and disadvantages of each of these filters,
% indicating when should be used each one and the effects that produces in 
% the output image.


