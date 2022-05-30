%%%%%%%%%%%%%%%%%
%%   LAB 10    %%
%%%%%%%%%%%%%%%%%
clear all;
close all;

%% Image Processing and feature extraction

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Descriptors
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% apple.jpg

I_original = imread('apple.jpg');
I = im2gray(im2double(I_original));

figure('Name','apple - Histogram');
subplot(1,2,1), imshow(I_original), title('Original');
subplot(1,2,2), imhist(I), title('Histogram');

% Hemos aprovechado que la imagen está en RGB para hacer diferentes pruebas
% basandonos en los tres canales de la imagen para ver si alguno de ellos
% es mejor respecto a los otros. En este caso el mejor es el canal azul
 
blueChannel = I_original(:,:,3); % blue channel

I = im2gray(im2double(blueChannel));

% Como la imagen tiene sombras hemos hecho este bucle para obtener el
% umbral en el cual desaparecen y solo nos quedamos con el objeto
figure('Name','apple - thresholds - blue');

for i = 1:25
    I_aux = imbinarize(I, i/25);
    subplot(5,5,i), imshow(I_aux), title(i/25);
end

% Como vemos se eliminó en el 0.44

I = imbinarize(I, 0.44);
I = imopen(I, strel('disk', 3));
I = imcomplement(I);
I = imfill(I,'holes');

figure('Name','apple - binary - blue');
subplot(1,2,1), imshow(I_original), title('Original');
subplot(1,2,2), imshow(I), title('Final');

% Hemos decidido no coger el centroide ya que no aporta informacion
% relavante de cara al siguiente apartado
apple = regionprops(I, 'Area', 'Orientation','Eccentricity','Solidity');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% bell.jpg

I_original = imread('bell.jpg');
I = im2gray(im2double(I_original));


figure('Name','bell - Histogram - blue ');
subplot(1,2,1), imshow(I_original), title('Original');
subplot(1,2,2), imhist(I), title('Histogram');

% Hemos aprovechado que la imagen está en RGB para hacer diferentes pruebas
% basandonos en los tres canales de la imagen para ver si alguno de ellos
% es mejor respecto a los otros. En este caso el mejor es el canal azul

blueChannel = I_original(:,:,3); % blue channel

I = im2gray(im2double(blueChannel));


% Como la imagen tiene sombras hemos hecho este bucle para obtener el
% umbral en el cual desaparecen y solo nos quedamos con el objeto
figure('Name','bell - thresholds - blue');

for i = 1:25
    I_aux = imbinarize(I, i/25);
    subplot(5,5,i), imshow(I_aux), title(i/25);
end

% Como se ve el mejor umbral es 0.44

I = imbinarize(I, 0.44);
I = imopen(I, strel('disk', 7));
I = imcomplement(I);
I = imfill(I,'holes');

figure('Name','bell - binary - blue');
subplot(1,2,1), imshow(I_original), title('Original');
subplot(1,2,2), imshow(I), title('Final');

% Hemos decidido no coger el centroide ya que no aporta informacion
% relavante de cara al siguiente apartado
bell = regionprops(I, 'Area', 'Orientation','Eccentricity','Solidity');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% shoe.jpg

I_original = imread('shoe.jpg');
I = im2gray(im2double(I_original));

figure('Name','shoe - Histogram');
subplot(1,2,1), imshow(I), title('Original');
subplot(1,2,2), imhist(I), title('Histogram');

I = imbinarize(I);
I = imopen(I, strel('disk', 3));
I = imcomplement(I);
I = imfill(I,'holes');

figure('Name','shoe - Binary');
subplot(1,2,1), imshow(I_original), title('Original');
subplot(1,2,2), imshow(I), title('Binary');

% Hemos decidido no coger el centroide ya que no aporta informacion
% relavante de cara al siguiente apartado
shoeAux = regionprops(I, 'Area', 'Orientation','Eccentricity','Solidity');
shoe.Area = (shoeAux(1).Area + shoeAux(2).Area)/2;
shoe.Orientation = (shoeAux(1).Orientation + shoeAux(2).Orientation)/2;
shoe.Eccentricity = (shoeAux(1).Eccentricity + shoeAux(2).Eccentricity)/2;
shoe.Solidity = (shoeAux(1).Solidity + shoeAux(2).Solidity)/2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% fork.jpg

I_original = imread('fork.jpg');
I = im2gray(im2double(I_original));

figure('Name','fork - Histogram');
subplot(1,2,1), imshow(I), title('Original');
subplot(1,2,2), imhist(I), title('Histogram');

I = imbinarize(I);
I = imfill(I,'holes');

figure('Name','fork - Binary');
subplot(1,2,1), imshow(I_original), title('Original');
subplot(1,2,2), imshow(I), title('Binary');

% Hemos decidido no coger el centroide ya que no aporta informacion
% relavante de cara al siguiente apartado
fork = regionprops(I, 'Area', 'Orientation','Eccentricity','Solidity');



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ANALISIS
%Cargamos los datos
areas = [apple.Area, bell.Area, shoe.Area, fork.Area];
orientations = [apple.Orientation, bell.Orientation, shoe.Orientation, fork.Orientation];
eccentricities = [apple.Eccentricity, bell.Eccentricity, shoe.Eccentricity, fork.Eccentricity];
solidities = [apple.Solidity, bell.Solidity, shoe.Solidity, fork.Solidity];

%Normalizamos los datos
areas = areas/max(areas);
orientations = orientations/max(orientations);
eccentricities = eccentricities/max(eccentricities);
solidities = solidities/max(solidities);

%Array de datos y etiquetas
variables = [areas; orientations; eccentricities; solidities];
labels =  ["areas", "orientations", "eccentricities", "solidities"];

%% Primer analisis
%Buscamos la variable con mayor desviación estandard
stds = [std(areas), std(orientations), std(eccentricities), std(solidities)];
[~, idx] = sort(stds,'descend');

fprintf("Las mejores features basandonos en mayor desviación estandard media son: %s y %s", labels(idx(1)), labels(idx(2)));

%% Segundo análisis
%Buscamos la mayor distancia media entre todas las variables.
figure('Name','Analisis');
k = 1;
avgAux = 0;
for i = 1:4
    for j = 1:4
        subplot(4,4,k), plot(variables(i,:), variables(j,:), 'o');

        xlabel(labels(i));
        ylabel(labels(j));

        % Calculate the average distance between the points
        dist = pdist([variables(i,:);variables(j,:)]);
        avg = mean(dist);
       
        if avg > avgAux
            avgAux = avg;
            avgIdx = [i, j];
        end
        k=k+1;
    end 
end


fprintf("Las mejores features basandonos en mayor distancia de medias son: %s y %s", labels(avgIdx(1)), labels(avgIdx(2)));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Coge las houghlines de las imagenes road y chessboard, y plasmalas en 
% una imagen negra.

I = imread('road.jpg');
I = im2double(I);
I = im2gray(I);

BW = edge(I, 'sobel',[],'vertical');
[H,T,R] = hough(BW);
P = houghpeaks(H,6);
L1 = houghlines(BW,T,R,P);

matdims = size(I);

I2 = imread('chessboard.jpg');
I2 = im2double(I2);
I2 = im2gray(I2);

figure()
BW2 = edge(I2, 'canny',[0.01 0.31]);
[H2,T2,R2] = hough(BW2);
P2 = houghpeaks(H2,22);
L2 = houghlines(BW2,T2,R2,P2);

matdims2 = size(I2);

out_road = houghlines(matdims, L);
out_chess = houghlines(matdims2, L2);
figure('Name','houghlines2mat');
subplot(1,2,1), imshow(out_chess), title("Chess");
subplot(1,2,2), imshow(out_road), title("Road");
% Como podemos ver hay algunas lineas que no siguen el ángulo de los dos
% puntos del houghlines, esto pensamos que se debe a la manera del strel a
% hacer las lineas.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% insert them as 1’s into a matrix of 0’s of the same dimensions as the original image
function out = houghlines2mat(matdims, lines)
    out = zeros(matdims(1), matdims(2));

    for i = 1:size(lines, 2)
      X = [lines(i).point1(1), lines(i).point2(1)];
      Y = [lines(i).point1(2), lines(i).point2(2)];

      adyacente = X(2) - X(1);
      opuesto = Y(2) - Y(1);

      angulo = -atan(opuesto/adyacente) * 180/pi; 
      distancia = sqrt(opuesto^2 + adyacente^2);
      SE = strel('line', distancia, angulo);
      if Y(1) > Y(2)
            posicion = [Y(1) + opuesto, X(1)];
      else
            posicion = [Y(1), X(1)];
      end
      out = insert_elem(out, SE.Neighborhood, posicion, 1);
      
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Function that inserts a matrix in another matrix given a position and the 
% elements of the second matrix to be inserted
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