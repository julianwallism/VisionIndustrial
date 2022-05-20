%%%%%%%%%%%%%%%%%
%%  FINAL LAB  %%
%%%%%%%%%%%%%%%%%
%close all;

%% 
%% Preprocess data:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% global variables
% global kernel_HitMiss;
% kernel_HitMiss = ones(101,101);
% kernel_HitMiss = kernel_HitMiss*-1;
% kernel_HitMiss(2:end-1,2:end-1) = 0;
% kernel_HitMiss(51,51) = 1;
% We load all the images

myFiles = dir('*.jpg'); %gets all wav files in struct
numImages = length(myFiles); 
for k = 1:numImages-1
    img = (im2gray(imread(myFiles(k).name)));
%     [out, num] = getWPonBS(img);
%     subplot(2,5,k),imshow(out), title(num);
    out = getGrid(img);
    subplot(2,5,k), imshow(out), title(k)
end

% figure(1);
% I = im2double(im2gray(imread("ex.jpg")));
% [centersBright, radiiBright] = imfindcircles(I,[30 60],"ObjectPolarity","bright");
% [centersDark, radiiDark] = imfindcircles(I,[30 60],"ObjectPolarity","dark");
% 
% imshow(I);
% viscircles(centersBright, radiiBright,'Color','b');
% viscircles(centersDark, centersDark,'Color','r');


% figure(1);
% % images{10}= histeq(images{10});
% imshow(images{10})
% %     [centers, radii] = imfindcircles(images{1},[100 200]);
% %     [centersBright, radiiBright] = imfindcircles(images{1},[100 200],'ObjectPolarity','bright');
% [centersDark, radiiDark] = imfindcircles(images{10},[100 200],'ObjectPolarity','dark');
% %     viscircles(centers, radii,'Color','g');
% %     viscircles(centersBright, radiiBright,'Color','b');
%     viscircles(centersDark, radiiDark,'Color','r');
% end

% % Lets see the grayscale images and their histograms
% figure('Name','Original Images');
% for k = 1:numImages
%     subplot(2,5,k), imshow(images{k}), title(sprintf('Image %d', k));
% end
% 
% figure('Name','Images Histogram');
% for k = 1:numImages
%     subplot(2,5,k), imhist(images{k}), title(sprintf('Image %d', k));
% end




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Functions

%% Function that given a grayscale image, returns a binarized 
% image with the chessboard grid
function out = getGrid(image)
    out = imbinarize(image);
    % Queremos eliminar todas las 
    out = imerode(out, strel('square', 19));
    out = imfill(out, 'holes');
    out = imdilate(out, strel('square', 23));
    out = imfill(imcomplement(out), 'holes');
    % Técnica de lincoln
    % Hemos probado de hacer dilatación - imagen y erosion - imagen, pero
    % los resultados quedaban muy escalonados asi que las hemos unido.
    % Uniendolas se simplifican las imagenes y nos queda dilatacion -
    % erosion
     out = imdilate(out, strel('square', 41)) - imerode(out, strel('square', 41));

end

%% Function that given a gray scale image it returns an image showing
% the white pieces on the black squares and the number of these
function [out, num] = getWPonBS(image)
    out = imbinarize(image);
    
    % erosionamos para asegurar que las casillas negras sean conexas y
    % quitar pixeles blancos
      out = imerode(out, strel('square',19));
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

%% Function that given a gray scale image it returns an image showing the
% black pieces and number of these.
function [out, num] = getBP(image)
    global kernel_HitMiss
    out = imadjust(image);
    out = imbinarize(out);
    out = imdilate(out,strel('disk', 5));
    out = imdilate(out,strel('disk', 5));
%     area = regionprops(out, "Area");
    out = out - bwareafilt(out,[50000 80000]) ;
%     out = imdilate(out, strel('square', 20));
%     out = imclose(out,strel('square',25));
%     out = imopen(out, strel('disk',9));
%     out = imclose(out, strel('square',9));
%     out = out - bwhitmiss(out, kernel_HitMiss);
%     out = imcomplement(out);
%     out = imfill(out, 'holes');
%     out = imcomplement(out);
%         out = imerode(out, strel('square', 3));
    [~,num]=bwlabel(out);
    num = num-32;
end