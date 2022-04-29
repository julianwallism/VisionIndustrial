    %% Operaciones Morfológicas
close all

I = imread('texto2.jpeg');
I = im2gray(I);
I = im2double(I);
% threshold= graythresh(I);
% I = imbinarize(I, threshold);
% I = imadjust(I);

% Erosión
I_erosion = erosion(I,3);
I_erosion_matlab = imerode(I, strel('disk',3));
I_diff_erosion = I-I_erosion;
I_erosion_negativo = imcomplement(I_diff_erosion);
segunda_erosion=erosion(I_erosion_negativo,3);
threshold = graythresh(segunda_erosion);
seg_Erosion_bin = imbinarize(segunda_erosion,0.95);

% Dilatacion
I_dilation = dilation(I,3);
I_dilation_matlab = imdilate(I, strel('disk',3));
I_diff_dilation = I_dilation-I ;
I_dilation_negativo = imcomplement(I_diff_dilation);
segunda_dilation=dilation(I_dilation_negativo,3);

% Closing
I_closing = closing(I,3);
I_closing_matlab = imclose(I, strel('disk',3));
I_diff_closing = I_closing-I ;
I_closing_negativo = imcomplement(I_closing);

% Opening
I_opening = opening(I,3);
I_opening_matlab = imopen(I, strel('disk',3));
I_diff_opening = I_opening-I ;
I_opening_negativo = imcomplement(I_opening);

figure('Name','Original');
imshow(I);

figure('Name', 'Erosion');
subplot(2,2,1), imshow(I_erosion), title('Erosion');
subplot(2,2,2), imshow(I_erosion_matlab), title('Erosion Matlab');
subplot(2,2,3), imshow(I_diff_erosion), title('Diff Erosion');
subplot(2,2,4), imshow(I_erosion_negativo), title('Erosion Negativo');

figure('Name', '2da Erosion');
%imhist(segunda_erosion);
%%
imshow(seg_Erosion_bin), title('Segunda erosion bin');
%%
figure('Name', 'Dilation');
subplot(2,2,1), imshow(I_dilation), title('Dilation');
subplot(2,2,2), imshow(I_dilation_matlab), title('Dilation Matlab');
subplot(2,2,3), imshow(I_diff_dilation), title('Diff Dilation');
subplot(2,2,4), imshow(I_dilation_negativo), title('Dilation Negativo');

figure('Name', '2da Dilation');
imshow(segunda_dilation), title('Segunda dilation');

figure('Name', 'Opening');
subplot(2,2,1), imshow(I_opening), title('Opening');
subplot(2,2,2), imshow(I_opening_matlab), title('Opening Matlab');
subplot(2,2,3), imshow(I_diff_opening), title('Diff Opening');
subplot(2,2,4), imshow(I_opening_negativo), title('Opening Negativo');

figure('Name', 'Closing');
subplot(2,2,1), imshow(I_closing), title('Closing');
subplot(2,2,2), imshow(I_closing_matlab), title('Closing Matlab');
subplot(2,2,3), imshow(I_diff_closing), title('Diff Closing');
subplot(2,2,4), imshow(I_closing_negativo), title('Closing Negativo');

% Function that performs erosion given an image and a kernel size
function I_erosion = erosion(I,k)
    I_erosion = zeros(size(I));
    [m,n] = size(I);
    for i = k:m-k+1
        for j = k:n-k+1
            I_erosion(i,j)= min(min(I(i-k+1:i+k-1,j-k+1:j+k-1)));
        end
    end
end

% Function that performs dilation given an image and a kernel size
function I_dilation = dilation(I,k)
    I_dilation = zeros(size(I));
    [m,n] = size(I);
    for i = k:m-k+1
        for j = k:n-k+1
            I_dilation(i,j)= max(max(I(i-k+1:i+k-1,j-k+1:j+k-1)));
        end
    end
end

% Function that performs opening given an image and a kernel size
function I_opening = opening(I,k)
    I_opening = erosion(I,k);
    I_opening = dilation(I_opening,k);
end

% Function that performs closing given an image and a kernel size
function I_closing = closing(I,k)
    I_closing = dilation(I,k);
    I_closing = erosion(I_closing,k);
end
