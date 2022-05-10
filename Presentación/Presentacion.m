    %% Operaciones Morfológicas
close all

I = imread('huella.jpg'); %POner imagen mejor
I = im2gray(I);
I = im2double(I);

I_texto=imread('texto2.jpeg');
I_texto = im2gray(I_texto);
I_texto = im2double(I_texto);

%Create a 15-by-15 kernel of 0s with a circle of 1s in the middle
kernel = strel('disk',8);
kernel = getnhood(kernel);

%% Kernel cuadrado 3x3
% Erosión
I_erosion = erosion(I,3);
I_erosion_matlab = imerode(I, strel('square',5));
I_diff_erosion = I- I_erosion;

% Dilatación
I_dilatacion = dilatation(I,3);
I_dilatacion_matlab = imdilate(I, strel('square',5));
I_diff_dilatacion = I_dilatacion-I;

% Closing
I_closing = closing(I,3);
I_closing_matlab = imclose(I, strel('square',5));
I_diff_closing = I-I_closing;

% Opening
I_opening = opening(I,3);
I_opening_matlab = imopen(I, strel('square',5));
I_diff_opening = I-I_opening;

%% Kernel circular 15x15

I_15_dilatation = dilatation2(I,kernel);
I_15_erosion = erosion2(I,kernel);

I_15_erosion_m = imerode(I, strel('disk',8));
I_15_dilatation_m  = imdilate(I, strel('disk',8));
I_15_closing_m  = imclose(I, strel('disk',8));
I_15_opening_m  = imopen(I, strel('disk',8));

%% Lectura de texto

I_text_erosion = erosion(I_texto,3);
I_text_diff_erosion = I_texto-I_text_erosion;
I_text_erosion_negativo = imcomplement(I_text_diff_erosion);
text_segunda_erosion=erosion(I_text_erosion_negativo,3);
negativo = imcomplement(text_segunda_erosion);
text_seg_Erosion_bin = imbinarize(negativo,"adaptive");

%% Figures
close all
figure('Name','Original');
imshow(I);

figure('Name', 'Erosion');
subplot(1,3,1), imshow(I_erosion), title('Erosion');
subplot(1,3,2), imshow(I_erosion_matlab), title('Erosion Matlab');
subplot(1,3,3), imshow(I_diff_erosion), title('Diff Erosion')

figure('Name', 'Dilatacion');
subplot(1,3,1), imshow(I_dilatacion), title('Dilatacion');
subplot(1,3,2), imshow(I_dilatacion_matlab), title('Dilatacion Matlab');
subplot(1,3,3), imshow(I_diff_dilatacion), title('Diff Dilatacion');

figure('Name', 'Closing');
subplot(1,3,1), imshow(I_closing), title('Closing');
subplot(1,3,2), imshow(I_closing_matlab), title('Closing Matlab');
subplot(1,3,3), imshow(I_diff_closing), title('Diff Closing');

figure('Name', 'Opening');
subplot(1,3,1), imshow(I_opening), title('Opening');
subplot(1,3,2), imshow(I_opening_matlab), title('Opening Matlab');
subplot(1,3,3), imshow(I_diff_opening), title('Diff Opening');

figure('Name', '15x15 Matlab');
subplot(1,2,1), imshow(I_15_erosion), title('Erosion 15x15');
subplot(1,2,2), imshow(I_15_dilatation), title('Dilatacion 15x15');

figure('Name', '15x15 Matlab');
subplot(1,4,1), imshow(I_15_erosion_m), title('Erosion 15x15 Matlab');
subplot(1,4,2), imshow(I_15_dilatation_m), title('Dilatacion 15x15 Matlab');
subplot(1,4,3), imshow(I_15_closing_m), title('Closing 15x15 Matlab');
subplot(1,4,4), imshow(I_15_opening_m), title('Opening 15x15 Matlab');

figure('Name', 'Texto');
subplot(2,3,1), imshow(I_text_erosion), title('Erosion Texto');
subplot(2,3,2), imshow(I_text_diff_erosion), title('Diff Erosion Texto');
subplot(2,3,3), imshow(I_text_erosion_negativo), title('Negativo Erosion Texto');
subplot(2,3,4), imshow(text_segunda_erosion), title('Segunda Erosion Texto');
subplot(2,3,5), imshow(text_seg_Erosion_bin), title('Binarizacion Texto');

%% Funciones

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

% Erosion 2, coge un kernel y coge el minimo de todos los pixeles
% donde el kernel es 1
function I_erosion = erosion2(I,K)
   I_erosion = zeros(size(I));
    [m,n] = size(I);
    [m2, n2] = size(K);
    for i = m2:m-m2+1
        for j = n2:n-n2+1
            aux = I(i-m2+1:i+m2-1,j-n2+1:j+n2-1);
            I_erosion(i,j) = min(aux(K));
        end
    end
end

% Function that performs dilatation given an image and a kernel size
function I_dilatation = dilatation(I,k)
    I_dilatation = zeros(size(I));
    [m,n] = size(I);
    for i = k:m-k+1
        for j = k:n-k+1
            I_dilatation(i,j)= max(max(I(i-k+1:i+k-1,j-k+1:j+k-1)));
        end
    end
end

% Dilatación 2, coge un kernel y coge el maximo de todos los pixeles
% donde el kernel es 1
function I_dilatation = dilatation2(I,K)
    I_dilatation = zeros(size(I));
    [m,n] = size(I);
    [m2, n2] = size(K);
    for i = m2:m-m2+1
        for j = n2:n-n2+1
            aux = I(i-m2+1:i+m2-1,j-n2+1:j+n2-1);
            I_dilatation(i,j) = max(aux(K));
        end
    end
end

% Function that performs opening given an image and a kernel size
function I_opening = opening(I,k)
    I_opening = erosion(I,k);
    I_opening = dilatation(I_opening,k);
end

% Function that performs closing given an image and a kernel size
function I_closing = closing(I,k)
    I_closing = dilatation(I,k);
    I_closing = erosion(I_closing,k);
end
