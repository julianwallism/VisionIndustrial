%%%%%%%%%%%%%%%%%
%%    LAB 08   %%
%%%%%%%%%%%%%%%%%
clear all;

%% First-Order Derivatives

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 1. Write a function in Matlab to compute the gradient of an image in both
% directions using the Sobel operator. You can use Matlab functions, except
% edge. The function signature should be: function[Gx, Gy] = gradients(img)
% where Gx and Gy are the gradients and img is an image with values between
% the range [0.0, 1.0].

% Final del archivo

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 2. Load and display the image house.jpg.
I = imread('house.jpg');
figure(1);
imshow(I);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 3. Compute the gradients of the image in both directions using the
% function created in exercise 1. Display the resulting gradients,
% converting them to a grayscale image.

I = im2double(I);
[Gx, Gy] = gradients(I);
Gx = im2gray(Gx);
Gy = im2gray(Gy);

figure(2);
subplot(1,2,1), imshow(Gx), title('Gx');
subplot(1,2,2), imshow(Gy), title('Gy');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 4. Compute the magnitude of the gradient at each point using the
% above-mentioned approximation and display the final magnitude image.

Gz = zeros(size(I));
Gz = sqrt(Gx.^2 + Gy.^2);

figure(3);
imshow(Gz);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 5. Detect edges in the image, selecting as edges pixels whose magnitude
% is above a given threshold. Try different values for this threshold and
% display the results.
figure(4);
for i = 1:9
    Gz_thresh = Gz;
    thresh = i/10;
    Gz_thresh(Gz_thresh < thresh) = 0;
    Gz_thresh(Gz_thresh >= thresh) = 1;

    subplot(3,3,i),imshow(Gz_thresh), title("Gz thresh "+i);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 6. Using the edge Matlab’s function, compute the edges of the image
% using Sobel, Prewitt and Roberts operators. Test several thresholds
% for each operator and display the best results obtained. Compare them,
% enumerating the main advantages and disadvantages of each approach.

figure(5);
for i = 1:3
    ImRoberts = edge(I, 'roberts',i/4);
    ImSob = edge(I, 'sobel',i/4);
    ImPrew = edge(I, 'prewitt',i/4);
    subplot(3,3,i), imshow(ImSob), title("Sobel - "+(i/4));
    subplot(3,3,i+3), imshow(ImPrew), title("Prewitt - "+(i/4));
    subplot(3,3,i+6), imshow(ImRoberts), title("Roberts - "+(i/4));
end

figure(6);
j = 0.05;
for i = 1:3

    ImRoberts = edge(I, 'roberts',j);
    ImSob = edge(I, 'sobel',j);
    ImPrew = edge(I, 'prewitt',j);
    subplot(3,3,i), imshow(ImSob), title("Sobel - "+(j));
    subplot(3,3,i+3), imshow(ImPrew), title("Prewitt - "+(j));
    subplot(3,3,i+6), imshow(ImRoberts), title("Roberts - "+(j));

    j = j + 0.05;
end

% En primer lugar, hicimos pruebas con threshholds intentando encontrar a
% partir de que umbral los  operadores eran más eficaces. Encontramos que
% con el valor dle umbral 0.25 ya apenas se observaba nada en las imágenes,
% por lo que hicimos una nueva prueba con valores mucho más bajos, en este
% caso 0.05, 0.10 y 0.15.

% En general creemos que el operador Roberts es el que consigue capturas
% más bordes de la imagen original, pero a costa de añadir excesivas líneas
% en ciertas zonas. Por ejemplo, es el único operador que detecta las
% cuatro secciones de la ventana principal. Además, creemos que tiene poca
% tolerancia al ruido ya que la zona izquierda del garaje, la cual está
% ligeramente en contacto con el árbol no la detecta.

% Por otro lado, los operadores de Sobel y Prewitt han tenido
% comportamientos similares o por lo menos, nosotros no hemos apreciado
% ninguna diferencia significativa. Ambos son los que parecen tener menos
% líneas de detección, esto es más notable con el valor de 0.15. Lo cual
% tiene sentido porque parecen menos susceptibles al ruido.

% Comparacion:
% Ventajas de Sobel:
%   - Es 
% Ventajas de Prewitt:
%   - Es
% Ventajas de Roberts:
%   - Es

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 7. Apply the Canny edge detector to the image using the default
% parameters, display the obtained edges and compare the results with
% the previous ones. Vary the parameters of the algorithm and explain
% the observed effects.

figure(7);
z = 1;
for i = 1:3
    for j = 1:5
        if i < j
            ImCanny = edge(I, 'canny',[i/10,j/10]);
            subplot(3,3, z), imshow(ImCanny), title((i/10)+" - "+(j/10));
            z=z+1;
        end
    end
end

% El método de Canny aplica dos umbrales al gradiente: un umbral alto
% (baja sensibilidad de detección) y un umbral bajo (alta sensibilidad de 
% detección). dge comienza con el resultado de baja sensibilidad y, 
% después, lo expande hasta incluir los píxeles de los bordes conectados 
% del resultado de alta sensibilidad. Esto contribuye a llenar los posibles
% huecos en los bordes detectados.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Second-Order Derivatives

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 1. Write a function in Matlab to compute zero-crossings given a
% second-order derivative matrix. The function signature should be:
% function imedges = zerocrossings(deriv2, T)
% where deriv2 is a second-order derivative image, T is a threshold for the
% magnitude and imedges is a binary image with values established to 1
% where exists a zero-crossing. A position (x, y) will be considered as
% zero crossing if its sign changes in relation to the pixels immediately
% to the right or below with a magnitude above some threshold T.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 2. Reload and display the image house.jpg.
I = imread('house.jpg');
figure(8);
imshow(I);

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 3. Compute the second-order derivative of the image using the Laplacian operator.

deriv2 = imfilter(I, fspecial('laplacian'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 4. Compute the edges of the image using the derivative obtained in the
% previous exercise and the function coded in exercise 1. Apply several
% thresholds and display the output images.

figure(9);
for i = 1:9
    thresh = i/10;
    imedges=zerocrossings(deriv2, thresh);
    subplot(3,3,i),imshow(imedges), title("imedges "+i);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 5. Compute the second-order derivative of the image using a LoG filter of
% size 13x13 and sigma 2.0. Display the results.

sigma = 2;
filter = fspecial('log',[13 13],sigma);
deriv2 = imfilter(I, filter);

figure(10);
subplot(1,2,1), imshow(deriv2), title('deriv2');
subplot(1,2,2), imshow(im2bw(deriv2)), title('im2bw(deriv2)');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 6. Compute the edges of the image using the derivative obtained in the
% previous exercise and the function coded in exercise 1. Apply several
% thresholds and display the output images.

figure(11);
for i = 1:9
    thresh = i/10;
    imedges=zerocrossings(deriv2, thresh);
    subplot(3,3,i),imshow(imedges), title("imedges "+i);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 7. Compute the edges of the image using the two previous operators by 
% means of the edge Matlab’s function, with default parameters.
% play the results and compare them with the previous ones.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Hough Transform

% Using the functions available in the Matlab’s Image Processing Toolbox,
% employ the Hough transform to detect the lines of the road present in the
% images road.jpg and chessboard. As a final result, you should plot the
% accumulator and the detected lines in the original image as shown in the
% following figure:

I = imread('road.jpg');
I = im2double(I);
I = im2gray(I);

BW = edge(I, 'canny');
% Hough matrix
[H,T,R] = hough(BW);
% Peaks
P = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));
% Lines
L = houghlines(BW,T,R,P,'FillGap',5,'MinLength',7);
figure(11);
imshow(I), hold on;
for k = 1:length(L)
    xy = [L(k).point1; L(k).point2];
    plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','red');
end


I2 = imread('chessboard.jpg');
I2 = im2double(I2);
I2 = im2gray(I2);

BW2 = edge(I2, 'canny');
% Hough matrix
[H2,T2,R2] = hough(BW2);
% Peaks
P2 = houghpeaks(H2,5,'threshold',ceil(0.3*max(H2(:))));
% Lines
L2 = houghlines(BW2,T2,R2,P2,'FillGap',5,'MinLength',7);
figure(12);
imshow(I2), hold on;
for k = 1:length(L2)
    xy = [L2(k).point1; L2(k).point2];
    plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','red');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Funciones %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Ejercicio 1.1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CP
function[Gx, Gy] = gradients(img)
    Gx = imfilter(img, fspecial('sobel'), 'conv');
    Gy = imfilter(img, fspecial('sobel'), 'conv');
end

% Ejercicio 2.1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CP
function imedges = zerocrossings(deriv2, T)
% Zero-crossings
    [rows, cols]=size(deriv2);
    imedges = false(size(deriv2));
    for i = 1:rows-1
        for j = 1:cols-1
            drow=0.0;
            dcol=0.0;
            a = deriv2(i,j);
            b = deriv2(i+1,j);
            c = deriv2(i,j +1);
         
            if((a >= 0 && b < 0) || (a < 0 && b >= 0))
                drow = abs(a-b);
            end

            if((a >= 0 && c < 0) || (a < 0 && c >= 0))
                dcol = abs(a-c);
            end
            magnitude = max(drow, dcol);
            if(magnitude >= T) % CP
                imedges(i,j) = 1;
            end
        end
    end 
end