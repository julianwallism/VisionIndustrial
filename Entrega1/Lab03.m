%%%%%%%%%%%%%%%%%
%%    LAB 03   %%
%%%%%%%%%%%%%%%%%
close all

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

% La imagen pollenlow es la que tiene menor contraste, esto lo podemos ver
% a simple vista en la imagen pero también con el histograma ya que la
% diferencia entre el valor de intensidad mayor y el menor es mas pequeña
% que la de las demás imágenes.

% La imagen pollenwhite es la que tiene mayor contraste.

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
low_norm = rescale(low);
black_norm = rescale(black);
white_norm = rescale(white);

low_adjust = adjust(low_norm);
black_adjust = adjust(black_norm);
white_adjust = adjust(white_norm);

figure('Name', 'Adjust');
subplot(3,3,1), imshow(low_adjust), title('Low adjust');
subplot(3,3,2), imhist(low_adjust), title('Hist low adjust');
subplot(3,3,3), imhist(low), title('Hist low');

subplot(3,3,4), imshow(black_adjust), title('Black adjust');
subplot(3,3,5), imhist(black_adjust), title('Hist black adjust');
subplot(3,3,6), imhist(black), title('Hist black');

subplot(3,3,7), imshow(white_adjust), title('White adjust');
subplot(3,3,8), imhist(white_adjust), title('Hist white adjust');
subplot(3,3,9), imhist(white), title('Hist white');

% Al comparar los histogramas de las imágenes podemos ver que tienen la
% misma forma, lo que en el histograma ajustado los valores van de 0 a 1.
% Es decir, hemos aumentado el contraste.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4. Apply the function provided by Matlab for adjusting the contrast of 
% the three images, and display the resulting images with their histograms
% Are these histograms the same as the ones obtained in the previous 
% exercise? Why?

low_adjust_m = imadjust(low_norm);
black_adjust_m = imadjust(black_norm);
white_adjust_m = imadjust(white_norm);

figure('Name', 'Matlab Adjust');
subplot(3,2,1), imshow(low_adjust_m), title('low adjust');
subplot(3,2,2), imhist(low_adjust_m), title('hist low adjust');

subplot(3,2,3), imshow(black_adjust_m), title('black adjust');
subplot(3,2,4), imhist(black_adjust_m), title('hist black adjust');

subplot(3,2,5), imshow(white_adjust_m), title('white adjust');
subplot(3,2,6), imhist(white_adjust_m), title('hist white adjust');

% No quedan iguales ya que matlab condensa los valores por debajo del 1% y
% los que estan por encima del 99% mientras que nosotros no. Si quiséramos
% que lo hiciese podríamos usar la función stretchlim para conseguir los
% valores I_min e I_max. 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 5. Would it be possible to use the Matlab’s contrast adjusting function 
% to obtain the complement (negative) of an image?. Think about it, try to 
% perform this operation using the three images and show the results.

low_adjust_neg = imadjust(low, [0,1], [1,0]);
black_adjust_neg = imadjust(black, [0,1], [1,0]);
white_adjust_neg = imadjust(white, [0,1], [1,0]);

figure('Name', 'Matlab Adjust Negative');
subplot(3,2,1), imshow(low_adjust_neg), title('Low adjust');
subplot(3,2,2), imhist(low_adjust_neg), title('Hist low adjust');

subplot(3,2,3), imshow(black_adjust_neg), title('Black adjust');
subplot(3,2,4), imhist(black_adjust_neg), title('Hist black adjust');

subplot(3,2,5), imshow(white_adjust_neg), title('White adjust');
subplot(3,2,6), imhist(white_adjust_neg), title('Hist white adjust');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 6. Given the three versions of the images: the original one, the adjusted
% one obtained with your function and the adjusted one using the Matlabs 
% function, which one would you use for a further processing step? Why?

% De primeras podemos descartar la imagen original, tiene un contraste muy
% bajo y visualmente no aporta mucha información.

% Tenemos que decidir entre la imagen de nuestra función y la de MatLab.
% Aunque nuestra función retorna una imagen más realista, ya que no hacemos
% niguna saturación de los extremos, puede haber algún caso en el que el 
% hecho de no hacer la saturación nos perjudique. Por ejemplo si tenemos
% una imagen que todos los píxeles están entre 90 y 100 pero justamente
% tenemos un píxel de valor 0 y otro de valor 255 no haría ningun
% "histogram stretching".

% Así pues, nosotros elegiríamos la función de MatLab, ya que hace más
% visibles los rangos centrals a costa de perder sensibilidad, ya que
% satura los valores extremos. 
% Si trabajasemos con una aplicación que únicamente necesita información 
% fiable de los extremos, sería buena idea usar nuestra función. Pero como
% será el caso mayoritario nosotros escogemos la función de MatLab.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Histogram Equalization

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. Write a function in Matlab for computing the cumulative sum of a 
% normalized histogram. The function signature should be: 
% functioncdf = csum(hnorm) 
% where hnorm is the normalized histogram of an image and cdf is the 
% resulting cumulative sum.

% Mirar final del archivo

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2. Write a function in Matlab to equalize an image using a uniform 
% transformation with 256 gray levels. The function signature should be: 
% function imageeq = equalize(image) 
% where image is the input image and imageeq is the resulting equalized 
% image. This function must use the csum function implemented in the 
% previous exercise

% Mirar final del archivo

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3. Equalize the images pollenlow.jpg, pollenblack.jpg, pollenwhite.jpg 
% using the function written in the previous point. Display each resulting
% image and its corresponding histogram in figures.

low_eq = equalize(low);
black_eq = equalize(black);
white_eq = equalize(white);

figure('Name', 'Equalized');
subplot(3,2,1), imshow(low_eq), title('low equalized');
subplot(3,2,2), imhist(low_eq), title('hist low equalized');

subplot(3,2,3), imshow(black_eq), title('black equalized');
subplot(3,2,4), imhist(black_eq), title('hist black equalized');

subplot(3,2,5), imshow(white_eq), title('white equalized');
subplot(3,2,6), imhist(white_eq), title('hist white equalized');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4. Equalize the images pollenlow.jpg, pollenblack.jpg, pollenwhite.jpg 
% using the function provided by Matlab. Display the resulting images and 
% their histograms, and compare the results with the histograms computed in 
% the previous exercise.

low_eq_m = histeq(low);
black_eq_m = histeq(black);
white_eq_m = histeq(white);

figure('Name', 'Matlab equalized');
subplot(3,2,1), imshow(low_eq_m), title('low equalized');
subplot(3,2,2), imhist(low_eq_m), title('hist low equalized');

subplot(3,2,3), imshow(black_eq_m), title('black equalized');
subplot(3,2,4), imhist(black_eq_m), title('hist black equalized');

subplot(3,2,5), imshow(white_eq_m), title('white equalized');
subplot(3,2,6), imhist(white_eq_m), title('hist white equalized');

% Como podemos observar obtenemos un resultado bastante similar, siendo la
% imagen blanca en la que hay mayores diferencias. Estas diferencias
% principalemte son que en el histograma de nuestra función hay mayor
% cantidad de niveles de grises, como podemos ver si ejecutamos el
% siguiente código:
% num = unique(white_eq)
% num = unique(white_eq_m)
% Con el nuestro tenemos 125 valores de grises y con el de matlab 57, esto
% hace que la cantidad de píxeles por valor de gris sea menor con nuestra
% función.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 5. Compare the results obtained with histogram stretching and equalization 
% and explain briefly the main differences between both approaches.


% Podemos ver en los histogramas resultantes que al usar el estiramiento de
% histograma este mantiene su forma, pero al usar la ecualización la
% pierde.

% Como ya sabemos el "histogram stretching" y el "histogram equalization"
% son técnicas de mejora de imagenes que aumentan el contraste de las 
% imágenes.
% El histogram stretching consiste en aumentar la diferencia entre el valor
% de intensidad menor y el mayor repartiendo las demás intensidades en ese 
% rango, es decir aumentamos el contraste.
% Por el otro lado el "histogram equalization" consiste en modificar las
% intensidades de los pixeles de tal forma que el histograma quede lo más
% "plano" posible.
% Otra diferencia que cabe destacar es que con el stretching podemos hacer
% el proceso inverso para obtener la imagen original pero con el
% equalization no.

% Una idea interesante sería unir las dos técnicas. De hacerlo primero
% deberíamos hacer el estiramiento de histograma y luego la ecualización.
% Con las funciones de MatLab el código sería el siguiente:
% histeq(imadjust(low));
% Con nuestras funciones sería así:
% equalize(adjust(low));



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 6. Examine the adapthisteq Matlab’s function. How does it work?. 
% Equalize the histograms of the images pollenlow.jpg, pollenblack.jpg 
% and pollenwhite.jpg using two different grid sizes and display the results

% Este algoritmo trabaja sobre pequeñas regiones de la imagen llamadas
% "tiles", en vez de trabajar sobre la imagen completa. Esto se hace de
% manera que la región de salida coincida aproximadamente con el histograma
% especificado. Luego los "tiles" se combinan mediante la interpolación
% bilineal para eliminar los límites inducidos artificialmente.

low_adapt8 = adapthisteq(low, "NumTiles", [8,8]);
low_adapt16 = adapthisteq(low, "NumTiles", [16,16]);

black_adapt8 = adapthisteq(black, "NumTiles", [8,8]);
black_adapt16 = adapthisteq(black, "NumTiles", [16,16]);

white_adapt8 = adapthisteq(white, "NumTiles", [8,8]);
white_adapt16 = adapthisteq(white, "NumTiles", [16,16]);

figure('Name', 'Adapthiseq');
subplot(3,2,1), imshow(low_adapt8), title('NumTiles = 8*8');
subplot(3,2,2), imhist(low_eq_m), title('NumTiles = 16*16');

subplot(3,2,3), imshow(black_eq_m), title('NumTiles = 8*8');
subplot(3,2,4), imhist(black_eq_m), title('NumTiles = 16*16');

subplot(3,2,5), imshow(white_eq_m), title('NumTiles = 8*8');
subplot(3,2,6), imhist(white_eq_m), title('NumTiles = 16*16');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FUNCIONES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%% Ejercicio HS.1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function imadj = adjust(image)
   imadj = zeros(size(image));
   I_min = min(min(image));
   I_max = max(max(image));
   O_min=0;
   O_max=1;
   for i = 1:length(image);
       for j = 1:length(image);
           imadj(i,j)=(O_max-O_min)*((image(i,j)-I_min)/(I_max-I_min))+O_min;
       end
   end
end

%%%%% Ejercicio HE.1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function cdf = csum(hnorm)
   cdf=zeros(1,length(hnorm));
   for k = 1:256
       cdf(k)=sum(hnorm(1:k));
   end
end

%%%%% Ejercicio HE.2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function imageeq = equalize(image)
   imageeq = zeros(size(image),"uint8");
   hnorm = imhist(image)/numel(image);
   cdf = csum(hnorm);
  newHist = 255*cdf;
  for i = 1:size(image)
      for j = 1:size(image)
          imageeq(i,j) = uint8(round(newHist(image(i,j)+1)));
      end
  end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
