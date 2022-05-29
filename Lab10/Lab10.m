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
I = im2double(I_original);
I = im2gray(I);

figure('Name','apple - Histogram');
subplot(1,2,1), imshow(I_original), title('Original');
subplot(1,2,2), imhist(I), title('Histogram');

% Hemos aprovechado que la imagen está en RGB para hacer diferentes pruebas
% basandonos en los tres canales de la imagen para ver si alguno de ellos
% es mejor respecto a los otros. En este caso el mejor es el canal azul

blueChannel = I_original(:,:,3); % blue channel

I = im2double(blueChannel);
I = im2gray(I);

% Como la imagen tiene sombras hemos hecho este bucle para obtener el
% umbral en el cual desaparecen y solo nos quedamos con el objeto
figure('Name','apple - thresholds - blue');

for i = 1:25
    I_aux = imbinarize(I, i/25);
    subplot(5,5,i), imshow(I_aux), title(i/25);
end

% Como vemos se elimo el 0.62

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

I = im2double(I_original);
I = im2gray(I);

figure('Name','bell - Histogram - blue ');
subplot(1,2,1), imshow(I_original), title('Original');
subplot(1,2,2), imhist(I), title('Histogram');

% Hemos aprovechado que la imagen está en RGB para hacer diferentes pruebas
% basandonos en los tres canales de la imagen para ver si alguno de ellos
% es mejor respecto a los otros. En este caso el mejor es el canal azul

blueChannel = I_original(:,:,3); % blue channel

I = im2double(blueChannel);
I = im2gray(I);

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
I = im2double(I_original);
I = im2gray(I);

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
I = im2double(I_original);
I = im2gray(I);

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
areas = [apple.Area, bell.Area, shoe.Area, fork.Area];
orientations = [apple.Orientation, bell.Orientation, shoe.Orientation, fork.Orientation];
eccentricities = [apple.Eccentricity, bell.Eccentricity, shoe.Eccentricity, fork.Eccentricity];
solidities = [apple.Solidity, bell.Solidity, shoe.Solidity, fork.Solidity];
%Normalize all the data between 0 and 1 having in mind that some values are negative
areas = areas/max(areas);
orientations = orientations/max(orientations);
eccentricities = eccentricities/max(eccentricities);
solidities = solidities/max(solidities);

variables = [areas; orientations; eccentricities; solidities];
labels =  ["areas", "orientations", "eccentricities", "solidities"];
% Calculate the highest standard deviation
stds = [std(areas), std(orientations), std(eccentricities), std(solidities)];
[~, idx] = sort(stds,'descend');

disp("best features based on maximum average standard deviation")
labels(idx(1))
labels(idx(2))

figure('Name','Analisis');
k = 1;
avgAux = 0;
stdAux = 0;
for i = 1:4
    for j = 1:4
        subplot(4,4,k), plot(variables(i,:), variables(j,:), 'o');
        %put xlabels and ylabels
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

disp("best variables by maximum distance of means")
labels(avgIdx(1))
labels(avgIdx(2))



%% function that given the dimension of an image and the houghlines of the original 
% image, it inserts the lines as 1s and 0s in a new image

I = imread('road.jpg');
I = im2double(I);
I = im2gray(I);

BW = edge(I, 'canny');
[H,T,R] = hough(BW);
P = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));
L = houghlines(BW,T,R,P,'FillGap',5,'MinLength',7);

figure(1);
imshow(I), hold on;
for k = 1:length(L)
    xy = [L(k).point1; L(k).point2];
    plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','red');
end




% I2 = imread('chessboard.jpg');
% I2 = im2double(I2);
% I2 = im2gray(I2);
% 
% BW2 = edge(I2, 'canny');
% [H2,T2,R2] = hough(BW2);
% P2 = houghpeaks(H2,5,'threshold',ceil(0.3*max(H2(:))));
% L2 = houghlines(BW2,T2,R2,P2,'FillGap',5,'MinLength',7);

matdims = size(I);

[out, strels] = houghlines2mat(matdims, L);

function [out, strels] = houghlines2mat(matdims, lines)
    out = zeros(matdims(1), matdims(2));
    d = zeros(size(lines));
    angles = zeros(size(lines));
    strels = {}
    for i = 1:size(lines, 2)
      %p =[lines(i).point1, lines(i).point2];
      %d(i) = pdist([lines(i).point1(1),lines(i).point1(2); lines(i).point2(1), lines(i).point2(2)]);
      X = [lines(i).point1(1),lines(i).point1(2)];
      Y = [lines(i).point2(1), lines(i).point2(2)];
      d(i) = norm(X - Y);
      fprintf('%d \n', d(i));

        
      opposite = lines(i).point2(2) - lines(i).point1(2);
      adyacent = lines(i).point2(1) - lines(i).point1(1);

      angles(i) = rad2deg(atan(opposite / adyacent));
      %fprintf('%d \n', angles(i));

      SE = strel('line', d(i), angles(i));
      strels{i}=SE;
        
      
      out = insert_elem(out, SE.Neighborhood, lines(i).point1, 1);
      
    end
    figure(2);
    imshow(out);
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