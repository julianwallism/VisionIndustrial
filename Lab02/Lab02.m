%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. Generate the following binary images of size 256×256 and display the results:
% Note: The images should be defined using the logical data type.

A = false(256);
B = false(256);

A(256/3:(256/3)*2,:)=true;
B(:,256/3:(256/3)*2)=true;

figure(1);
subplot(1,2,1), imshow(A);
subplot(1,2,2), imshow(B);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2. Generate the following grayscale images of size 256×256 and display the results:
% Note: The images data type should be uint8.

C = uint8(ones(256).*(0:255)');
D = uint8(ones(256).*(255:-1:0));

figure(2);
subplot(1,2,1), imshow(C);
subplot(1,2,2), imshow(D);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3. Generate the following RGB images of size 256×256 and display the results:
% Note: The images data type should be uint8.

Red = zeros(255,255,3,"uint8");
Green = zeros(255,255,3,"uint8");
Blue = zeros(255,255,3,"uint8");

Red(:,:,1)= 255;
Green(:,:,2)= 255;
Blue(:,:,3)= 255;

figure('Name','RGB');
subplot(1,3,1), imshow(Red);
subplot(1,3,2), imshow(Green);
subplot(1,3,3), imshow(Blue);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4. Write a function in Matlab to generate the histogram of a grayscale 
% image without using the specific Matlab function for this purpose. 
% The function signature should be: 
% function h = histogram(image) 
% where h is a column vector with 256 elements of type double and image is 
% the input grayscale image. Each component of h indicates the number of 
% pixels of the corresponding intensity present in the image.

% Final del archivo

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 5. Using the function implemented in the previous point, compute the 
% histogram of the images of the exercise 2, and plot the results. 
% Are the histograms the same?

h_c = histogram(C);
h_d = histogram(D);

figure('Name','Histogramas');
subplot(1,2,1), bar(h_c), title('C');
subplot(1,2,2), bar(h_d), title('D');


% Sí que son iguales, ya que las dos imagenes son esencialemente la misma
% debido a que una es la rotación de la otra

% Con nuestra función cada barra va de (por ejemplo) 92.6 hasta 93.4 lo que
% hace que las barras parezcan mas gruesas. En la función de MatLab las
% barras estan encima del número correspondiente.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 6. Resize the images generated in exercise 2 to 512×512, 128×128 and 64×64
% using the corresponding Matlab% function. Plot each resulting image and 
% its corresponding histogram in figures. Given these histograms, what
% can we say about the resizing process in Matlab?


C_512 = imresize(C,[512,512]);
C_128 = imresize(C,[128,128]);
C_64 = imresize(C,[64,64]);

figure('Name', 'Resize Matlab');
subplot(3,2,1), imshow(C_512), title('512');
subplot(3,2,2), imhist(C_512), title('Hist 512');

subplot(3,2,3), imshow(C_128), title('128');
subplot(3,2,4), imhist(C_128), title('Hist 128');

subplot(3,2,5), imshow(C_64), title('64');
subplot(3,2,6), imhist(C_64), title('Hist 64');

% Solo lo hemos hecho de una de las imágenes porque el resultado sería el
% mismo para la otra.

% Como podemos ver en el histograma de C_512, para cada intensidad hay 1024
% píxeles, esto se debe a que (512*512)/256 = 1024.
% En los histogramas de C_128 y C_64 esperaríamos encontrar 64
% y 16 píxeles de cada intensidad, pero sin embargo vemos que hay 128 y 64
% respectivamente. Esto se debe a que en el C_128 hay "saltos" de dos en
% dos, y en el C_64 de cuatro en cuatro.

% Nuestra hipótesis para explicar estos saltos es la siguiente: 
% MatLab debe hacer la reducción de tamaño de las imágenes calculando la
% media de cuadrados de píxeles de tamaño (tamaño original/tamaño
% reducción). Así pues si queremos reducir de 256 a 128 por cada 2^2 píxeles 
% tenemos que quedanos con uno, si reducimos de 256 a 64 por cada 4^2 píxeles
% tenemos que quedarnos con uno. 
% Haremos una iteración de como lo debe hacer matlab con las imágenes del
% ejercicio 2:
% Para las dos primeras filas tendremos los siguientes "cuadrantes": [0,0,1,1]
% Hace la media -> 0.5 y redondea a 1
% Para la tercera y cuarta fila tendremos [2,2,3,3], media -> 2.5 redondea
% a 3
% ...
% Cuando acaba con toda la imagen nos queda una nueva imagen de 128*128
% píxeles, con un histograma que da "saltos" de dos en dos.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 7. Write a function in Matlab to reduce images of size 256×256 to 128×128.
% The intensity value in the output image should be the maximum intensity 
% in a neighborhood of the input image according to the following pattern:
% The function signature should be:
% function himage = halfsize(image)
% where image is the input image (256 × 256) and himage is the output image (128×128).

% Mirar al final del fichero

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 8. Use the function implemented in the previous point to reduce images 
% generated in exercise 2 and display the results

C_propia = uint8(halfsize(C));
D_propia = uint8(halfsize(D));

figure('Name', 'Halfsize');
subplot(1,2,1), imshow(C_propia), title('C propia');
subplot(1,2,2), imshow(D_propia), title('D propia');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% FUNCIONES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%% Ejercicio 4 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Para cada valor de intensidad hacemos una búsqueda mediante la función
% find para encontrar el número de valores con esa intensidad, luego
% indexamos el vector h con el valor de esa intensidad y le asociamos su
% número de elementos.
% Esto también se podría hacer con dos bucles anidados recorriendo la
% matriz con un coste asimptotico de O(n^2). De la manera en la que lo
% hemos en teoría tiene un coste O(n^3) pero la función find se hace
% internamente en C (un lenguaje compilado, no interpretado como MatLab),
% así que acaba siendo más eficiente

function h = histogram(image)
    h = zeros(1,length(image),"double");
    for i = 0:255
        aux = length(find(image==i));  
        h(i+1) =aux;
    end
end

%%%%% Ejercicio 7 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Como necesitamos recorrer la imagen original de 4 en 4 elementos, como
% podemos ver en la imagen del enunciado, hemos hecho un doble for de 1
% hasta tamaño/2 y luego indexamos los elementos de la imagen mediante las
% operaciones 2*i, 2*j, 2*i -1 y 2*j -1. Esto nos encontrar el píxel de
% mayor tamaño de manera simple y luego indexar la imagen reducida de
% manera simple.

function himage = halfsize(image)
    tam = size(image)/2;
    himage = zeros(tam);
    for i = 1:tam
        for j = 1:tam    
           aux=max([image(2*i-1,2*j-1), image(2*i-1,2*j), image(2*i,2*j-1), image(2*i,2*j)]);
           himage(i,j)=aux;
        end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%