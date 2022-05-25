%%%%%%%%%%%%%%%%%
%%  FINAL LAB  %%
%%%%%%%%%%%%%%%%%
close all;

%% Preprocess data:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% We load all the images
expectedWPonBS = [1,1,2,1,1,2,1,2,3,1];
expectedBP = [3,2,2,2,3,4,4,4,6,6];

myFiles = dir('*.jpg'); 
numImages = length(myFiles);
 
for k = 1:numImages
    img=imread(myFiles(k).name);
    imgBin = imbinarize(im2gray(im2double(img)));

    tic;
    grid = getGrid(imgBin);
    [wp_on_bs, numWpBs] = getWPonBS(imgBin);
    [bp_on_ws, numBpWs] = getWPonBS(imcomplement(imgBin));
    [bp_on_bs, numBpBs] = getBPonBS(imgBin);
    numBp=numBpWs+numBpBs;
    tiempo = toc;   

    figure('units','normalized','outerposition',[0 0 1 1]);
    subplot(2,2,1), imshow(img), title("Original");
    subplot(2,2,2), imshow(grid), title("Grid");
    subplot(2,2,3), imshow(grid+wp_on_bs), ...
        title("White Pieces on Black squares, Expected: "+expectedWPonBS(k)+", got: "+numWpBs);
    subplot(2,2,4), imshow(grid+bp_on_ws+bp_on_bs), ...
        title("White pieces on Black squares, Expected: "+expectedBP(k)+", got: "+numBp);
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
            myFiles(k).name, expectedWPonBS(k),numWpBs, result1);
        fprintf("Filename: %s | Expected number of black pieces: %d \t\t\t\t\t| Got: %d -> %s\n", ...
            myFiles(k).name, expectedBP(k), numBp, result2);
        fprintf("Filename: %s | Time spent: %.3d \n\n", myFiles(k).name, tiempo);
end

tiempo = toc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Functions

%% Function that given a grayscale image, returns a binarized
% image with the chessboard grid
function out = getGrid(image)
    % Queremos eliminar todas las
    out = imerode(image, strel('square', 19));
    out = imfill(out, 'holes');
    out = imdilate(out, strel('square', 23));
    out = imfill(imcomplement(out), 'holes');
    % Técnica de lincoln
    % Hemos probado de hacer dilatación - imagen y erosion - imagen, pero
    % los resultados quedaban muy escalonados asi que las hemos unido.
    % Uniendolas se simplifican las imagenes y nos queda dilatacion -
    % erosion
    out = imdilate(out, strel('square', 21)) - imerode(out, strel('square', 21));
end

%% Function that given a gray scale image it returns an image showing
% the white pieces on the black squares and the number of these
function [out, num] = getWPonBS(image)
    
    % erosionamos para asegurar que las casillas negras sean conexas y
    % quitar pixeles blancos
    out = imerode(image, strel('square',17));
    % Hacemos un imfill para quitar las piezas que estan sobre casillas
    % blancas, tanto las piezas negras sobre casillas blancas como las
    % sombras de las propias casillas negras
    out = imfill(out, 'holes');
    % Quitamos reflejos de las piezas negras sobre fondo negro para
    % quedarnos solo con las piezas blancas sobre fondo negro
    out = imopen(out, strel('square',51));
    % Sabiendo el rango de numero de pixeles de los cuadrados blancos los
    % podemos eliminar sin tocar las piezas blancas
    out = out - bwareafilt(out,[110000 135000]);
    %     % Perfilamos las piezas blancas
    out = imdilate(out, strel('disk', 21));
    
    [~,num]=bwlabel(out);
    %create a kernel of zeros with -1 in the borders and 1 in the center
end

%% Function that given a gray scale image it returns an image showing
% the white pieces on the black squares and the number of these
function [out, num] = getBPonBS(image)
    out = imdilate(image, strel('square', 25));
    out = imcomplement(out);
    out = logical(out-bwareafilt(out,[35000 100000]));
    out = imcomplement(out);
    out = out - bwareafilt(out, [4900000 5400000]);
    % Ponemos un marco de ceros en la imagen para eliminar imperfecciones
    % que no se pueden eliminar con un 
    out(1:25,:) = 0;
    out(end-25:end,:) = 0;
    out(:,1:25) = 0;
    out(:,end-25:end) = 0;

    out= imdilate(out, strel('disk', 11));
    [~,num]=bwlabel(out);
end

% function gridHough(I)
%     I = getGrid(I);
%     BW = edge(I, 'canny', 0.0001,0.31);
%     [H,T,R] = hough(BW);
%     P = houghpeaks(H,22);
%     L = houghlines(BW,T,R,P,'MinLength',50);
%     figure(16);
%     imshow(I), hold on;
%     for k = 1:length(L)
%         xy = [L(k).point1; L(k).point2];
%         plot(xy(:,1),xy(:,2),'LineWidth',3,'Color','red');
%     end
% end










