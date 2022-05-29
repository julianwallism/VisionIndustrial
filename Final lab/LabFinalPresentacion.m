%%%%%%%%%%%%%%%%%
%%  FINAL LAB  %%
%%%%%%%%%%%%%%%%%
close all;
% Para poder ejecutarlo en modo presentación hay que poner un breakpoint al
% principio de cada bucle for.

myFiles = dir('*.jpg');
numImages = length(myFiles);
opcion = "";

while opcion ~= "q"
    prompt = sprintf("Que quieres ver? \n 1 -> Grid \n 2 " + ...
    "-> Piezas blancas sobre casillas negras \n 3 -> Piezas negras \n q -> exit \n");
    opcion = input(prompt, 's');

    switch opcion
        case "1"
            showGrid(myFiles);
        case "2"
            showWPonBS(myFiles, false);
        case "3"
            showBP(myFiles);
    end

end

function showGrid(myFiles)
    figure("Name", "Grid");

    for k = 1:length(myFiles)
        img = im2gray(imread(myFiles(k).name));
        subplot(2, 5, k), imshow(img), title(k);
    end

    for k = 1:length(myFiles)
        img = imbinarize(im2gray(imread(myFiles(k).name)), 0.35);
        subplot(2, 5, k), imshow(img), title(k);
    end

    for k = 1:length(myFiles)
        img = imresize(imbinarize(im2gray(imread(myFiles(k).name)), 0.35), 1/7);
        out = imerode(img, strel('square', 3));
        out = imfill(out, 'holes');
        out = imresize(out, 7);

        subplot(2, 5, k), imshow(out), title(k);
    end

    for k = 1:length(myFiles)
        img = imresize(imbinarize(im2gray(imread(myFiles(k).name)), 0.35), 1/7);
        out = imerode(img, strel('square', 3));
        out = imfill(out, 'holes');
        out = imdilate(out, strel('square', 4));
        out = imfill(imcomplement(out), 'holes');
        out = imresize(out, 7);

        subplot(2, 5, k), imshow(out), title(k);
    end

    for k = 1:length(myFiles)
        img = imresize(imbinarize(im2gray(imread(myFiles(k).name)), 0.35), 1/7);

        out = imerode(img, strel('square', 3));
        out = imfill(out, 'holes');

        out = imdilate(out, strel('square', 4));
        out = imfill(imcomplement(out), 'holes');

        out = imdilate(out, strel('square', 5)) - imerode(out, strel('square', 5));
        out = imresize(out, 7);

        subplot(2, 5, k), imshow(out), title(k);
    end

end

function showWPonBS(myFiles, negative)
    expectedWPonBS = [1, 1, 2, 1, 1, 2, 1, 2, 3, 1];
    expectedBPonWS = [2, 1, 1, 1, 1, 2, 1, 2, 3, 3];

    if ~negative
        figure("Name", "White Pieces on Black Squares");

        for k = 1:length(myFiles)
            img = im2gray(imread(myFiles(k).name));
            subplot(2, 5, k), imshow(img), title(k);
        end

        for k = 1:length(myFiles)
            img = imbinarize(im2gray(imread(myFiles(k).name)), 0.35);
            [~, num] = bwlabel(img);
            subplot(2, 5, k), imshow(img), title("Img: " + k + ", Expected: " + expectedWPonBS(k) + ", Actual: " + num);
        end

        for k = 1:length(myFiles)
            img = imresize(imbinarize(im2gray(imread(myFiles(k).name)), 0.35), 1/7);
            out = imerode(img, strel('square', 2));
            out = imfill(out, 'holes');
            [~, num] = bwlabel(out);
            imresize(out, 7);
            subplot(2, 5, k), imshow(out), title("Img: " + k + ", Expected: " + expectedWPonBS(k) + ", Actual: " + num);
        end

        for k = 1:length(myFiles)
            img = imresize(imbinarize(im2gray(imread(myFiles(k).name)), 0.35), 1/7);
            out = imerode(img, strel('square', 2));
            out = imfill(out, 'holes');
            out = imopen(out, strel('disk', 3));
            [~, num] = bwlabel(out);
            out = imresize(out, 7);

            subplot(2, 5, k), imshow(out), title("Img: " + k + ", Expected: " + expectedWPonBS(k) + ", Actual: " + num);
        end

        for k = 1:length(myFiles)
            img = imresize(imbinarize(im2gray(imread(myFiles(k).name)), 0.35), 1/7);

            out = imerode(img, strel('square', 2));
            out = imfill(out, 'holes');
            out = imopen(out, strel('disk', 3));
            out = out - bwareafilt(out, [2350 12000]) - bwareafilt(out, [1 300]);

            [~, num] = bwlabel(out);
            out = imresize(out, 7);
            subplot(2, 5, k), imshow(out), title("Img: " + k + ", Expected: " + expectedWPonBS(k) + ", Actual: " + num);
        end

        for k = 1:length(myFiles)
            img = imresize(imbinarize(im2gray(imread(myFiles(k).name)), 0.35), 1/7);

            out = imerode(img, strel('square', 2));
            out = imfill(out, 'holes');
            out = imopen(out, strel('disk', 3));
            out = out - bwareafilt(out, [2350 12000]) - bwareafilt(out, [1 300]);

            [~, num] = bwlabel(out);

            grid = imerode(img, strel('square', 3));
            grid = imfill(grid, 'holes');
            grid = imdilate(grid, strel('square', 4));
            grid = imfill(imcomplement(grid), 'holes');
            grid = imdilate(grid, strel('square', 5)) - imerode(grid, strel('square', 5));

            out = out + grid;
            imwrite(out, "images/"+k+"/WP_BS/final.jpg")

            imresize(out, 7);
            subplot(2, 5, k), imshow(out + grid), title("Img: " + k + ", Expected: " + expectedWPonBS(k) + ", Actual: " + num);
        end

    else

        for k = 1:length(myFiles)
            img = im2gray(imread(myFiles(k).name));
            subplot(2, 5, k), imshow(img), title(k);
        end

        for k = 1:length(myFiles)
            img = imcomplement(imbinarize(im2gray(imread(myFiles(k).name)), 0.35));
            [~, num] = bwlabel(img);
            subplot(2, 5, k), imshow(img), title("Img: " + k + ", Expected: " + expectedBPonWS(k) + ", Actual: " + num);
        end

        for k = 1:length(myFiles)
            img = imresize(imcomplement(imbinarize(im2gray(imread(myFiles(k).name)), 0.35)), 1/7);

            out = imerode(img, strel('square', 2));
            out = imfill(out, 'holes');

            [~, num] = bwlabel(out);
            out = imresize(out, 7);
            subplot(2, 5, k), imshow(out), title("Img: " + k + ", Expected: " + expectedBPonWS(k) + ", Actual: " + num);
        end

        for k = 1:length(myFiles)
            img = imresize(imcomplement(imbinarize(im2gray(imread(myFiles(k).name)), 0.35)), 1/7);

            out = imerode(img, strel('square', 2));
            out = imfill(out, 'holes');
            out = imopen(out, strel('disk', 3));

            [~, num] = bwlabel(out);
            out = imresize(out, 7);
            subplot(2, 5, k), imshow(out), title("Img: " + k + ", Expected: " + expectedBPonWS(k) + ", Actual: " + num);
        end

        for k = 1:length(myFiles)
            img = imresize(imcomplement(imbinarize(im2gray(imread(myFiles(k).name)), 0.35)), 1/7);

            out = imerode(img, strel('square', 2));
            out = imfill(out, 'holes');
            out = imopen(out, strel('disk', 3));
            out = out - bwareafilt(out, [2350 5500]) - bwareafilt(out, [1 300]);

            [~, num] = bwlabel(out);
            out = imresize(out, 7);
            subplot(2, 5, k), imshow(out), title("Img: " + k + ", Expected: " + expectedBPonWS(k) + ", Actual: " + num);
        end

    end

end

function showBP(myFiles)
    expectedBPonBS = [1, 1, 1, 1, 2, 2, 3, 2, 3, 3];
    expectedBP = [3, 2, 2, 2, 3, 4, 4, 4, 6, 6];

    figure("Name", "Black pieces on white squares");

    showWPonBS(myFiles, true);

    figure("Name", "Black pieces on black squares");

    for k = 1:length(myFiles)
        img = im2gray(imread(myFiles(k).name));
        subplot(2, 5, k), imshow(img), title(k);
    end

    for k = 1:length(myFiles)
        img = imbinarize(im2gray(imread(myFiles(k).name)), 0.35);

        [~, num] = bwlabel(img);
        subplot(2, 5, k), imshow(img), title("Img: " + k + ", Expected: " + expectedBPonBS(k) + ", Actual: " + num);
    end

    for k = 1:length(myFiles)
        img = imresize(imbinarize(im2gray(imread(myFiles(k).name)), 0.35), 1/7);

        out = imdilate(img, strel('square', 3));

        [~, num] = bwlabel(out);
        subplot(2, 5, k), imshow(img), title("Img: " + k + ", Expected: " + expectedBPonBS(k) + ", Actual: " + num);
    end

    for k = 1:length(myFiles)
        img = imresize(imbinarize(im2gray(imread(myFiles(k).name)), 0.35), 1/7);

        out = imdilate(img, strel('square', 3));

        out = imcomplement(out);
        out = logical(out - bwareafilt(out, [1 1500]));
        out = imcomplement(out);

        [~, num] = bwlabel(out);
        subplot(2, 5, k), imshow(out), title("Img: " + k + ", Expected: " + expectedBPonBS(k) + ", Actual: " + num);
    end

    for k = 1:length(myFiles)
        img = imresize(imbinarize(im2gray(imread(myFiles(k).name)), 0.35), 1/7);

        out = imdilate(img, strel('square', 3));

        out = imcomplement(out);
        out = logical(out - bwareafilt(out, [1 1500]));
        out = imcomplement(out);

        out = out - bwareafilt(out, [98240 104205]);

        [~, num] = bwlabel(out);
        subplot(2, 5, k), imshow(out), title("Img: " + k + ", Expected: " + expectedBPonBS(k) + ", Actual: " + num);
    end

    for k = 1:length(myFiles)
        img = imresize(imbinarize(im2gray(imread(myFiles(k).name)), 0.35), 1/7);

        out = imdilate(img, strel('square', 3));

        out = imcomplement(out);
        out = logical(out - bwareafilt(out, [1 1500]));
        out = imcomplement(out);

        out = out - bwareafilt(out, [98200 104300]) - bwareafilt(out, [1 20]);

        [~, num] = bwlabel(out);

        subplot(2, 5, k), imshow(out), title("Img: " + k + ", Expected: " + expectedBPonBS(k) + ", Actual: " + num);
    end

    for k = 1:length(myFiles)
        img = imresize(imbinarize(im2gray(imread(myFiles(k).name)), 0.35), 1/7);
        out = imdilate(img, strel('square', 3));

        out = imcomplement(out);
        out = logical(out - bwareafilt(out, [1 1500]));
        out = imcomplement(out);

        out = out - bwareafilt(out, [98200 104300]) - bwareafilt(out, [1 20]);

        out = imdilate(out, strel('disk', 3));

        [~, num] = bwlabel(out);
        imresize(out, 7);
        subplot(2, 5, k), imshow(out), title("Img: " + k + ", Expected: " + expectedBPonBS(k) + ", Actual: " + num);
    end

    figure('Name', 'Black pieces');

    for k = 1:length(myFiles)
        img = imread(myFiles(k).name);
        img = imresize(imbinarize(im2gray(img), 0.35), 1/7);

        out1 = imdilate(img, strel('square', 3));
        out1 = imcomplement(out1);
        out1 = logical(out1 - bwareafilt(out1, [1 1500]));
        out1 = imcomplement(out1);
        out1 = out1 - bwareafilt(out1, [98200 104300]) - bwareafilt(out1, [1 20]);
        out1 = imdilate(out1, strel('disk', 3));

        grid = imerode(img, strel('square', 3));
        grid = imfill(grid, 'holes');
        grid = imdilate(grid, strel('square', 4));
        grid = imfill(imcomplement(grid), 'holes');
        grid = imdilate(grid, strel('square', 5)) - imerode(grid, strel('square', 5));

        [~, num1] = bwlabel(out1);
        img = imread(myFiles(k).name);
        img = imresize(imcomplement(imbinarize(im2gray(img), 0.35)), 1/7);

        out2 = imerode(img, strel('square', 2));
        out2 = imfill(out2, 'holes');
        out2 = imopen(out2, strel('disk', 3));
        out2 = out2 - bwareafilt(out2, [2350 5500]) - bwareafilt(out2, [1 300]);

        [~, num2] = bwlabel(out2);
        
        num = num1 + num2;
        out = out1 + out2 + grid;
        out = imresize(out, 7);
        subplot(2, 5, k), imshow(out), title("Img: " + k + ", Expected: " + expectedBP(k) + ", Actual: " + num);
    end

end
