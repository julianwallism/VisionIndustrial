%%%%%%%%%%%%%%%%%
%%  FINAL LAB  %%
%%%%%%%%%%%%%%%%%

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
            showWPonBS(myFiles);
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
        img = imbinarize(im2gray(imread(myFiles(k).name)));
        subplot(2, 5, k), imshow(img), title(k);
    end

    for k = 1:length(myFiles)
        img = imbinarize(im2gray(imread(myFiles(k).name)));
        out = imerode(img, strel('square', 19));
        out = imfill(out, 'holes');
        subplot(2, 5, k), imshow(out), title(k);
    end

    for k = 1:length(myFiles)
        img = imbinarize(im2gray(imread(myFiles(k).name)));
        out = imerode(img, strel('square', 19));
        out = imfill(out, 'holes');
        out = imdilate(out, strel('square', 23));
        out = imfill(imcomplement(out), 'holes');
        subplot(2, 5, k), imshow(out), title(k);
    end

    for k = 1:length(myFiles)
        img = imbinarize(im2gray(imread(myFiles(k).name)));
        out = imerode(img, strel('square', 19));
        out = imfill(out, 'holes');
        out = imdilate(out, strel('square', 23));
        out = imfill(imcomplement(out), 'holes');
        out = imdilate(out, strel('square', 25)) - imerode(out, strel('square', 25));
        subplot(2, 5, k), imshow(out), title(k);
    end
end

function showWPonBS(myFiles, negative)
    expectedWPonBS = [1, 1, 2, 1, 1, 2, 1, 2, 3, 1];
    expectedBPonWS = [2, 1, 1, 1, 1, 2, 1, 2, 3, 3];

    figure("Name", "White Pieces on Black Squares");

    if ~negative
        for k = 1:length(myFiles)
            img = im2gray(imread(myFiles(k).name));
            subplot(2, 5, k), imshow(img), title(k);
        end

        for k = 1:length(myFiles)
            img = imbinarize(im2gray(imread(myFiles(k).name)));
            [~, num] = bwlabel(img);
            subplot(2, 5, k), imshow(img), title("Img: " + k + ", Expected: " + expectedWPonBS(k) + ", Actual: " + num);
        end

        for k = 1:length(myFiles)
            img = imbinarize(im2gray(imread(myFiles(k).name)));
            out = imerode(img, strel('square', 17));
            out = imfill(out, 'holes');
            [~, num] = bwlabel(out);
            subplot(2, 5, k), imshow(out), title("Img: " + k + ", Expected: " + expectedWPonBS(k) + ", Actual: " + num);
        end

        for k = 1:length(myFiles)
            img = imbinarize(im2gray(imread(myFiles(k).name)));
            out = imerode(img, strel('square', 17));
            out = imfill(out, 'holes');
            out = imopen(out, strel('square', 51));
            [~, num] = bwlabel(out);
            subplot(2, 5, k), imshow(out), title("Img: " + k + ", Expected: " + expectedWPonBS(k) + ", Actual: " + num);
        end

        for k = 1:length(myFiles)
            img = imbinarize(im2gray(imread(myFiles(k).name)));
            out = imerode(img, strel('square', 17));
            out = imfill(out, 'holes');
            out = imopen(out, strel('square', 51));
            out = out - bwareafilt(out, [110000 135000]);
            [~, num] = bwlabel(out);
            subplot(2, 5, k), imshow(out), title("Img: " + k + ", Expected: " + expectedWPonBS(k) + ", Actual: " + num);
        end

        for k = 1:length(myFiles)
            img = imbinarize(im2gray(imread(myFiles(k).name)));
            out = imerode(img, strel('square', 17));
            out = imfill(out, 'holes');
            out = imopen(out, strel('square', 51));
            out = out - bwareafilt(out, [110000 135000]);
            out = imdilate(out, strel('disk', 21));
            [~, num] = bwlabel(out);
            subplot(2, 5, k), imshow(out), title("Img: " + k + ", Expected: " + expectedWPonBS(k) + ", Actual: " + num);
        end

        for k = 1:length(myFiles)
            img = imbinarize(im2gray(imread(myFiles(k).name)));
            out = imerode(img, strel('square', 17));
            out = imfill(out, 'holes');
            out = imopen(out, strel('square', 51));
            out = out - bwareafilt(out, [110000 135000]);
            out = imdilate(out, strel('disk', 21));
            [~, num] = bwlabel(out);

            grid = imerode(img, strel('square', 19));
            grid = imfill(grid, 'holes');
            grid = imdilate(grid, strel('square', 23));
            grid = imfill(imcomplement(grid), 'holes');
            grid = imdilate(grid, strel('square', 25)) - imerode(grid, strel('square', 25));

            subplot(2, 5, k), imshow(out + grid), title("Img: " + k + ", Expected: " + expectedWPonBS(k) + ", Actual: " + num);
        end
    else
        for k = 1:length(myFiles)
            img = im2gray(imread(myFiles(k).name));
            subplot(2, 5, k), imshow(img), title(k);
        end

        for k = 1:length(myFiles)
            img = imcomplement(imbinarize(im2gray(imread(myFiles(k).name))));
            [~, num] = bwlabel(img);
            subplot(2, 5, k), imshow(img), title("Img: " + k + ", Expected: " + expectedBPonWS(k) + ", Actual: " + num);
        end

        for k = 1:length(myFiles)
            img = imcomplement(imbinarize(im2gray(imread(myFiles(k).name))));
            out = imerode(img, strel('square', 17));
            out = imfill(out, 'holes');
            [~, num] = bwlabel(out);
            subplot(2, 5, k), imshow(out), title("Img: " + k + ", Expected: " + expectedBPonWS(k) + ", Actual: " + num);
        end

        for k = 1:length(myFiles)
            img = imcomplement(imbinarize(im2gray(imread(myFiles(k).name))));
            out = imerode(img, strel('square', 17));
            out = imfill(out, 'holes');
            out = imopen(out, strel('square', 51));
            [~, num] = bwlabel(out);
            subplot(2, 5, k), imshow(out), title("Img: " + k + ", Expected: " + expectedBPonWS(k) + ", Actual: " + num);
        end

        for k = 1:length(myFiles)
            img = imcomplement(imbinarize(im2gray(imread(myFiles(k).name))));
            out = imerode(img, strel('square', 17));
            out = imfill(out, 'holes');
            out = imopen(out, strel('square', 51));
            out = out - bwareafilt(out, [110000 135000]);
            [~, num] = bwlabel(out);
            subplot(2, 5, k), imshow(out), title("Img: " + k + ", Expected: " + expectedBPonWS(k) + ", Actual: " + num);
        end

        for k = 1:length(myFiles)
            img = imcomplement(imbinarize(im2gray(imread(myFiles(k).name))));
            out = imerode(img, strel('square', 17));
            out = imfill(out, 'holes');
            out = imopen(out, strel('square', 51));
            out = out - bwareafilt(out, [110000 135000]);
            out = imdilate(out, strel('disk', 21));
            [~, num] = bwlabel(out);
            subplot(2, 5, k), imshow(out), title("Img: " + k + ", Expected: " + expectedBPonWS(k) + ", Actual: " + num);
        end

    end
end

function showBP(myFiles)
    expectedBPonBS = [1, 1, 1, 1, 2, 2, 3, 2, 3, 3];
    expectedBP = [3, 2, 2, 2, 3, 4, 4, 4, 6, 6];
    
    showWPonBS(myFiles, true);

    figure("Name", "Black pieces on black squares");

    for k = 1:length(myFiles)
        img = im2gray(imread(myFiles(k).name));
        subplot(2, 5, k), imshow(img), title(k);
    end

    for k = 1:length(myFiles)
        img = imbinarize(im2gray(imread(myFiles(k).name)));
        [~, num] = bwlabel(img);

        subplot(2, 5, k), imshow(img), title("Img: " + k + ", Expected: " + expectedBPonBS(k) + ", Actual: " + num);
    end

    for k = 1:length(myFiles)
        img = imbinarize(im2gray(imread(myFiles(k).name)));
        out = imdilate(img, strel('square', 25));
        [~, num] = bwlabel(out);

        subplot(2, 5, k), imshow(img), title("Img: " + k + ", Expected: " + expectedBPonBS(k) + ", Actual: " + num);
    end

    for k = 1:length(myFiles)
        img = imbinarize(im2gray(imread(myFiles(k).name)));
        out = imdilate(img, strel('square', 25));
        out = imcomplement(out);
        out = logical(out - bwareafilt(out, [35000 100000]));
        out = imcomplement(out);
        [~, num] = bwlabel(out);

        subplot(2, 5, k), imshow(out), title("Img: " + k + ", Expected: " + expectedBPonBS(k) + ", Actual: " + num);
    end

    for k = 1:length(myFiles)
        img = imbinarize(im2gray(imread(myFiles(k).name)));
        out = imdilate(img, strel('square', 25));
        out = imcomplement(out);
        out = logical(out - bwareafilt(out, [35000 100000]));
        out = imcomplement(out);
        out = out - bwareafilt(out, [4900000 5400000]);
        [~, num] = bwlabel(out);

        subplot(2, 5, k), imshow(out), title("Img: " + k + ", Expected: " + expectedBPonBS(k) + ", Actual: " + num);
    end

    for k = 1:length(myFiles)
        img = imbinarize(im2gray(imread(myFiles(k).name)));
        out = imdilate(img, strel('square', 25));
        out = imcomplement(out);
        out = logical(out - bwareafilt(out, [35000 100000]));
        out = imcomplement(out);
        out = out - bwareafilt(out, [4900000 5400000]);
        out(1:25, :) = 0;
        out(end - 25:end, :) = 0;
        out(:, 1:25) = 0;
        out(:, end - 25:end) = 0;
        [~, num] = bwlabel(out);

        subplot(2, 5, k), imshow(out), title("Img: " + k + ", Expected: " + expectedBPonBS(k) + ", Actual: " + num);
    end

    for k = 1:length(myFiles)
        img = imbinarize(im2gray(imread(myFiles(k).name)));
        out = imdilate(img, strel('square', 25));
        out = imcomplement(out);
        out = logical(out - bwareafilt(out, [35000 100000]));
        out = imcomplement(out);
        out = out - bwareafilt(out, [4900000 5400000]);
        out(1:25, :) = 0;
        out(end - 25:end, :) = 0;
        out(:, 1:25) = 0;
        out(:, end - 25:end) = 0;
        out = imdilate(out, strel('disk', 11));
        [~, num] = bwlabel(out);

        subplot(2, 5, k), imshow(out), title("Img: " + k + ", Expected: " + expectedBPonBS(k) + ", Actual: " + num);
    end

    figure('Name', 'Black pieces');
    for k = 1:length(myFiles)
        img = imbinarize(im2gray(imread(myFiles(k).name)));
        out1 = imdilate(img, strel('square', 25));
        out1 = imcomplement(out1);
        out1 = logical(out1 - bwareafilt(out1, [35000 100000]));
        out1 = imcomplement(out1);
        out1 = out1 - bwareafilt(out1, [4900000 5400000]);
        out1(1:25, :) = 0;
        out1(end - 25:end, :) = 0;
        out1(:, 1:25) = 0;
        out1(:, end - 25:end) = 0;
        out1 = imdilate(out1, strel('disk', 11));
        [~, num1] = bwlabel(out);

        out2 = imerode(imcomplement(img), strel('square', 17));
        out2 = imfill(out2, 'holes');
        out2 = imopen(out2, strel('square', 51));
        out2 = out2 - bwareafilt(out2, [110000 135000]);
        out2 = imdilate(out2, strel('disk', 21));
        [~, num2] = bwlabel(out);
        num = num1 + num2;

        grid = imerode(img, strel('square', 19));
        grid = imfill(grid, 'holes');
        grid = imdilate(grid, strel('square', 23));
        grid = imfill(imcomplement(grid), 'holes');
        grid = imdilate(grid, strel('square', 25)) - imerode(grid, strel('square', 25));

        subplot(2, 5, k), imshow(out1 + out2 + grid), title("Img: " + k + ", Expected: " + expectedBP(k) + ", Actual: " + num);
    end
end
