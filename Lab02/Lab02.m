%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2. Generate the following grayscale images of size 256×256 and display the results:
% Note: The images data type should be uint8.
C = uint8(ones(256).*(1:256)')

figure(2)
subplot(1,2,1)
imshow(C)

D = uint8(ones(256).*(1:256)) %% Flipear esto
subplot(1,2,2)
imshow(D)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4. Write a function in Matlab to generate the histogram of a grayscale 
% image without using the specific Matlab function for this purpose. 
% The function signature should be: 
% function h = histogram(image) 
% where h is a column vector with 256 elements of type double and image is 
% the input grayscale image. Each component of h indicates the number of 
% pixels of the corresponding intensity present in the image.

% Final del archivo
% Ejemplo:
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % image = imread("example.jpg");
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % h = histogram(image);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % figure(4)
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % subplot(1,2,1)
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % imshow(image)
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % subplot(1,2,2)
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % bar(h);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 5. Using the function implemented in the previous point, compute the 
% histogram of the images of the exercise 2, and plot the results. 
% Are the histograms the same?
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % figure(5)
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % h = histogram(C);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % subplot(2,2,1)
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % bar(h);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % title('Funcion propia');
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % subplot(2,2,2)
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % imhist(C);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % title('Función de MatLab');
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % h = histogram(C);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % subplot(2,2,3)
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % bar(h);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % title('Funcion propia');
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % subplot(2,2,4);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % imhist(D);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % title('Función de MatLab');

% Sí que son iguales, lo que con la función de matlab muestra una escala de
% colores.

% con nuestra función cada barra va de (por ejemplo) 92.6 hasta 93.4 lo que
% hace que las barras parezcan mas gruesas. En la función de MatLab las
% barras estan encima del número correspondiente.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 6. Resize the images generated in exercise 2 to 512×512, 128×128 and 64×64 using the corresponding Matlab
% function. Plot each resulting image and its corresponding histogram in figures. Given these histograms, what
% can we say about the resizing process in Matlab?
figure(6)
C_512 = imresize(C,2);
C_128 = imresize(C,0.5);
C_64 = imresize(C,0.25);

subplot(3,2,1);
imshow(C_512);
title('512');

subplot(3,2,2);
imhist(C_512);
title('Hist 512');

subplot(3,2,3);
imshow(C_128);
title('128');

subplot(3,2,4);
imhist(C_128);
title('Hist 128');

subplot(3,2,5);
imshow(C_64);
title('64');

subplot(3,2,6);
imhist(C_64);
title('Hist 64');

% Solo lo hemos hecho de una de las imágenes porque el resultado sería el
% mismo para la otra.

% Como podemos ver en el histograma de C_512, para cada intensidad hay 1024
% píxeles, esto se debe a que (512*512)/256 = 1024.
% En los histogramas de C_128 y C_64 esperaríamos encontrar 64
% y 16 píxeles de cada intensidad, pero sin embargo vemos que hay 128 y 64
% respectivamente. Esto se debe a que en el C_128 hay "saltos" de dos en
% dos, y en el C_64 de cuatro en cuatro.

% Con esta conclusión podemos ver que el imresize para augmentar la
% resolución augmenta la cantidad de píxeles de cada intensidad, mientras
% que para disminuir la resolución hace la media de 1/n intensidades siendo
% n el factor de disminución.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 7. Write a function in Matlab to reduce images of size 256×256 to 128×128.
% The intensity value in the output image should be the maximum intensity 
% in a neighborhood of the input image according to the following pattern:
% The function signature should be:
% function himage = halfsize(image)
% where image is the input image (256 × 256) and himage is the output image (128×128).

% Mirar al final del fichero

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 8. Use the function implemented in the previous point to reduce images generated in exercise 2 and display the
% results

C_propia = uint8(halfsize(C));
D_propia = uint8(halfsize(D));

figure(7)
subplot(1,2,1);
imshow(C_propia);
title('C_propia');

subplot(1,2,2);
imshow(D_propia);
title('D_propia');

%%%%%%%% FUNCIONES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function himage = halfsize(image)
    tam = size(image)/2;
    himage = zeros(tam);
    for i = 1:tam
        for j = 1:tam
           aux=double(image(2*i-1,2*j-1))+double(image(2*i-1,2*j))+double(image(2*i,2*j-1))+double(image(2*i,2*j));
           aux=aux/4;
           himage(i,j)=aux;
        end;
    end;
end

% function h = histogram(image)
%     h = zeros(1,size(image));
%     for i = 1:length(image)
%         for j = 1:length(image)
%             ind=image(i,j);
%             h(ind) = h(ind)+1;
%         end;
%     end;
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%