%%%%%%%%%%%%%%%%%
%%    LAB 07   %%
%%%%%%%%%%%%%%%%%
close all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Developing tools, Counting Shoes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. Write a function in Matlab to insert a matriz into another bigger
% matrix in the specified position. 
% The function signature should be: function out = locate(m1, m2, p)

% Final del archivo

% Ejemplo:
m1 = [1 2 3; 4 5 6; 7 8 9];
m2 = [1 2; 3 4];
p = [2 2];
out = locate(m1, m2, p);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2. Write a function in Matlab to insert one specific value of a matrix
% into another bigger matrix in the specified position. 
% The function signature should be: function out=insert_elem(m1,m2,p,val)

% Final del archivo

% Ejemplo:
m1 = [1 2 3; 9 5 6; 7 8 9];
m2 = [1 2; 1 4];
p = [2 2];
val = 1;
out = insert_elem(m1, m2, p, val);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3. Implement a script in Matlab to separate the objects from the 
% background and counting automatically the number of shoes present in the 
% image shoes1.jpg.

% Shoes 1
% Para la primera imagen seguimos el siguiente procedimiento:
% 1. Converitmos la imagen a blanco y negro en un rango [0.0, 1.0]
% 2. Calculamos un umbral mediante la función graythresh
% 3. Usamos el filtro de mediana ya que tiene ruido salt and pepper
% 4. Usamos la función imbinarize con el umbral anterior para diferenciar
% las areas donde hay zapatos y en las que no
% 5. Buscamos la imagen negativa mediante la función imcomplement ya que
% luego tenemos que usar el bwlabel que cuenta zonas blancas inconexas, no
% negras
% 6. Aplicamos un filtro de minimos para que nos quite los pixeles blancos
% que nos puedan quedar en mitad de la imagen
% 7. Aplicamos la función imfill para que rellene huecos 

I1 = imread('shoes1.jpg');
I1 = im2gray(I1);
I1 = im2double(I1);

thresholdGraytresh = graythresh(I1);
filteredImage = medfilt2(I1,'symmetric');
binarizedImage = imbinarize(filteredImage, thresholdGraytresh);
negative = imcomplement(binarizedImage);
filterMin = ordfilt2(negative, 1, ones(3,3));
fillImage = imfill(filterMin,'holes');

[~, numFill] = bwlabel(fillImage);
disp("Shoes 1: " + numFill);

figure(1)
subplot(2,3,1), imshow(I1), title('Original');
subplot(2,3,2), imshow(filteredImage), title('Filtered');
subplot(2,3,3), imshow(binarizedImage), title('Binarized');
subplot(2,3,4), imshow(negative), title('Negative');
subplot(2,3,5), imshow(filterMin), title('FilterMin');
subplot(2,3,6), imshow(fillImage), title('FillImage');


% Shoes 2
% Para la segunda imagen haremos los mismos pasos que en la Imagen 1 menos
% el paso 6. Además modificamos un poco el valor del umbral.

I2 = imread('shoes2.jpg');
I2 = im2gray(I2);
I2 = im2double(I2);

thresholdGraytresh = graythresh(I2)
filteredImage = medfilt2(I2,'symmetric');
binarizedImage = imbinarize(filteredImage, thresholdGraytresh*1.3);
negative = imcomplement(binarizedImage);
fillImage = imfill(negative,'holes');

[~, numFill] = bwlabel(fillImage);
disp("Shoes 2: " + numFill);

figure(2)
subplot(2,3,1), imshow(I2), title('Original');
subplot(2,3,2), imshow(filteredImage), title('Filtered');
subplot(2,3,3), imshow(binarizedImage), title('Binarized');
subplot(2,3,4), imshow(negative), title('Negative');
subplot(2,3,5), imshow(fillImage), title('FillImage');


% Shoes 3
% Para la tercera imagen seguimos los mismos pasos que para la segunda

I3 = imread('shoes3.jpg');
I3 = im2gray(I3);
I3 = im2double(I3);

thresholdGraytresh = graythresh(I3);
filteredImage = medfilt2(I3, 'symmetric');
binarizedImage = imbinarize(filteredImage, thresholdGraytresh*1.45);
negative = imcomplement(binarizedImage);
fillImage = imfill(negative,'holes');

[~, numFill] = bwlabel(fillImage);
disp("Shoes 3: "+numFill);

figure(3)
subplot(2,3,1), imshow(I3), title('Original');
subplot(2,3,2), imshow(filteredImage), title('Filtered');
subplot(2,3,3), imshow(binarizedImage), title('Binarized');
subplot(2,3,4), imshow(negative), title('Negative');
subplot(2,3,5), imshow(fillImage), title('FillImage');



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Funciones %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
function out = locate(m1, m2, p)
    [r, c] = size(m2);
    [r1,c1] = size(m1);
    out = m1;
    if p(1) + r -1<= r1 && p(2) + c -1 <= c1
        out(p(1):p(1)+r-1, p(2):p(2)+c-1) = m2;
    else
        disp('Error: Out of bounds')
    end
    
end


function out = insert_elem(m1, m2, p, val)
    [r,c] = size(m2);
    [r1,c1] = size(m1);
    ind = find(m2==val);
    [rowsSub, colsSub] = ind2sub(size(m2),ind);
    out = m1;
    if isempty(ind)
        disp('Error: no elements with val')
    else
        if p(1) + r -1<= r1 && p(2) + c -1 <= c1
           for i = 1:length(rowsSub)
               rowsSub(i);
               p(1);
               out(rowsSub(i)+p(1)-1,colsSub(i)+p(2)-1) = val;
           end
        else
            disp('Error: Out of bounds')
        end
    end
end