%%%%%%%%%%%%%%%%%
%%  FINAL LAB  %%
%%%%%%%%%%%%%%%%%
close all;
clear;
format shortG;
% Resultados esperados
expectedWPonBS = [1, 1, 2, 1, 1, 2, 1, 2, 3, 1];
expectedBP = [3, 2, 2, 2, 3, 4, 4, 4, 6, 6];

myFiles = dir('*.jpg');
numImages = length(myFiles);
tiempoTotal=0;
% Hacemos los cálculos imagen a imagen
for k = 1:numImages
    % Abrimos la imagen, la pasamos a escala de grises
    tic;
    img = imread(myFiles(k).name);
    imgBin = imresize(imbinarize(im2gray(img),0.35), 1/7);
    grid = getGrid(imgBin);
    [wp_on_bs, numWpBs] = getWPonBS(imgBin);
    [bp_on_ws, numBpWs] = getWPonBS(imcomplement(imgBin));
    [bp_on_bs, numBpBs] = getBPonBS(imgBin);
    numBp = numBpWs + numBpBs;
    tiempo = toc;
    tiempoTotal=tiempoTotal+tiempo;

    figure('units', 'normalized', 'outerposition', [0 0 1 1]);
    subplot(2, 2, 1), imshow(img), title("Original");
    subplot(2, 2, 2), imshow(grid), title("Grid");
    subplot(2, 2, 3), imshow(grid + wp_on_bs), ...
        title("White Pieces on Black squares, Expected: " + expectedWPonBS(k) + ", got: " + numWpBs);
    subplot(2, 2, 4), imshow(grid + bp_on_bs + bp_on_ws), ...
        title("Black pieces, Expected: " + expectedBP(k) + ", got: " + numBp);
    drawnow;

    if numWpBs == expectedWPonBS(k)
        result1 = "Correct ✅";
    else
        result1 = "Incorrect ❌";
    end

    if numBp == expectedBP(k)
        result2 = "Correct ✅";
    else
        result2 = "Incorrect ❌";
    end

    fprintf("Filename: %s | Expected number of white pieces on black squares: %d | Got: %d -> %s\n", ...
        myFiles(k).name, expectedWPonBS(k), numWpBs, result1);
    fprintf("Filename: %s | Expected number of black pieces: %d \t\t\t\t\t| Got: %d -> %s\n", ...
        myFiles(k).name, expectedBP(k), numBp, result2);
    fprintf("Filename: %s | Time spent: %s seconds\n\n", myFiles(k).name, num2str(tiempo));
end
fprintf("Total time spent: %s seconds\n\n", num2str(tiempoTotal));
fprintf("Medium time spent per image: %s seconds\n\n", num2str(tiempoTotal/numImages));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Functions

%% Function that given a grayscale image, returns a binarized
% image with the chessboard grid.

% El algoritmo que usamos para sacar el tablero de la imagen es muy sencillo
% Nuestro sistema se basa en eliminar todas las piezas del tablero y luego
% mediante una dilatación y una erosión sacar la delineación del tablero.
function out = getGrid(image)
    % Primero eliminaremos las piezas sobre casillas blancas. Para hacer
    % esto erosionamos la imagen para que las casillas negras estén
    % conexas. Así si hacemos un imfill de los 'holes' solo rellenará los
    % agujeros dentro de los objetos blancos, es decir las piezas negras y
    % las sombras de las piezas blancas
    out = imerode(image, strel('square', 3));
    out = imfill(out, 'holes');

    % Ahora queremos hacer lo mismo para las casillas negras.
    % Así pues dilatamos la imagen para que las casillas blancas estén
    % conexas y hacemos un imfill con el negativo de la imagen
    out = imdilate(out, strel('square', 4));
    out = imfill(imcomplement(out), 'holes');
    % Al acabar tenemos la imagen en negativo pero la dejamos así porque
    % no interfiere con los siguientes pasos.

    % Técnica de lincoln
    % Ahora ya tenemos el tablero sin casillas así que pasaremos a sacar la
    % delineación. Para hacerlo hemos usado el mismo sistema que en el
    % ejercicio de Lincoln del Lab09, por lo que hemos bautizado esta
    % manera de sacar el tablero como técnica de Licoln.

    % Lo que hacemos es hacer una dilatación o una erosión a la imagen y
    % luego llevamos a cabo una resta de este resultado y la imagen
    % original. De esta manera obtenemos las líneas sin necesidad de usar
    % la transformada de Hough que a veces puede ser díficil encontrar unos
    % parámetros buenos.

    % Hemos probado de hacer dilatación - imagen y erosion - imagen, pero
    % los resultados quedaban muy escalonados asi que las hemos unido.
    % Uniendolas se simplifican las imagenes y nos queda dilatacion -
    % erosion
    out = imdilate(out, strel('square', 5)) - imerode(out, strel('square', 5));

    % Reescalamos la imagen de salida
    out = imresize(out, 7);

    % A la imagen resultante se le puede aplicar distintos filtros o
    % operaciones morfológicas con el fin de que las lineas queden más
    % suavizadas, pero con el fin de que el algoritmo sea lo más rápido
    % posible hemos decicido no implementarlas nosotros.
end

%% Function that given a gray scale image it returns an image showing
% the white pieces on the black squares and the number of these
function [out, num] = getWPonBS(image)

    % Primero eliminaremos las piezas sobre casillas blancas. Para hacer
    % esto erosionamos la imagen para que las casillas negras estén
    % conexas. Así si hacemos un imfill de los 'holes' solo rellenará los
    % agujeros dentro de los objetos blancos, es decir las piezas negras y
    % las sombras de las piezas blancas
    out = imerode(image, strel('square', 2));
    out = imfill(out, 'holes');

    % Quitamos reflejos de las piezas negras sobre fondo negro para
    % quedarnos solo con las piezas blancas sobre fondo negro
    out = imopen(out, strel('disk', 3));

    % Finalemente, tras haber hecho un estudio de tamaño previo podremos
    % hacer un filtrado por tamaño que eliminará las casillas blancas
    % dejandonos las piezas deseadas sobre un fondo negro
    out = out - bwareafilt(out, [2350 12000]) - bwareafilt(out, [1 300]);

    % Para acabar contamos el número de piezas que quedan
    [~, num] = bwlabel(out);
     % Reescalamos la imagen de salida
     out = imresize(out, 7);
end

%% Function that given a gray scale image it returns an image showing
% the white pieces on the black squares and the number of these

% La técnica que hemos seguido para contar las piezas en este tipo de
% superficie es sencilla. Lo que haremos será buscar los otros tres tipos
% de piezas y eliminarlas de la imagen de manera que al final nos
% quedaremos solo con el tipo de imagen deseada
function [out, num] = getBPonBS(image)

    % Dilatamos la imagen para aumentar los reflejos de las piezas negras y
    % eliminar las sombras de las piezas blancas.
    out = imdilate(image, strel('square', 3));

    % Al haber dilatado la imagen cuando pasemos a negativo todos los
    % objetos (tanto casillas blancas como piezas y reflejos) quedaran
    % aislados.
    % De esta manera tras haber hecho un estudio de tamaño previo podremos
    % hacer un filtrado por tamaño que eliminará tanto las piezas negras
    % sobre fondo blanco como las piezas blancas sobre fondo negro
    out = imcomplement(out);
    out = logical(out - bwareafilt(out, [1 1500]));
    out = imcomplement(out);

    % Una vez hemos pasado a positivo los únicos objetos inconexos de la
    % imagen serán los reflejos de las piezas negras sobre casillas negras,
    % es decir habrá num_PiezasNegrasCasillasNegras + 1 objeto blanco en la
    % imagen, siendo este +1 conjunto de casillas blancas del tablero
    out = out - bwareafilt(out, [98200 104300]) - bwareafilt(out, [1 20]);

    % Finalemente hacemos una dilatación con fines únicamente estéticos
    % para que la pieza se pueda distinguir mejor
     out = imdilate(out, strel('disk', 3));

   % Para acabar contamos el número de piezas que quedan
    [~, num] = bwlabel(out);
     % Reescalamos la imagen de salida
     out = imresize(out, 7);
end
