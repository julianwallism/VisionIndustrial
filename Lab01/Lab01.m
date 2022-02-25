%%%%%%%%%%%%%%%%%
%%    LAB 01   %%
%%%%%%%%%%%%%%%%%

%{
    Matrices and Matlab
%}

% 1. Create a 5×5 matrix of ones (A).
A = ones(5);

% 2. Create a 5×3 matrix of ones (B).
B = ones(5,3);

% 3. Create a 3×3 matrix of zeros (C).
C = zeros(3);

% 4. Create a 4×4 matrix with equal row, column, and diagonal sums (D).
D = magic(4);

% 5. Create a 4×4 random matrix whose values are uniformly distributed between 0 and 1 (E).
E = rand(4);

% 6. Create a 5×5 identity matrix (F).
F = eye(5); % Multiplicar una matriz por su inversa da como resultado la matriz identidad -> F = A*inv(A)

% 7. Sum the matrices A and F.
A + F

% 8. Subtract the matrices A and F.
A - F

% 9. Sum the matrices A and C. Is it possible?.
% Se haría así: A+C; pero no es posible ya que no son del mismo tamaño

% 10. Compute D^20
D^20

% 11. Compute F × 2.
2*F

% 12. Compute A × F.
A*F

% 13. Compute A × F, element by element.
A.*F

% 14. Compute the transpose matrix of E.
E'

% 15. Compute the inverse matrix of E.
inv(E) % X^(-1)

% 16. Compute the determinant of matrix C.
det(C)

% 17. Store the size of matrix B in two variables, rows and cols.
[rows, cols] = size(B)

% 18. Given the matrix F, obtain the linear indices of the elements whose value is not zero. Hint: find
indF = find(F)

% 19. Set the detected values in the previous point to -1
F(indF)=-1 

% 20. Given those indices, transform them to subscripts (row and column).
[rowsSub, colsSub] = ind2sub(size(F),indF)

% 21. Use those indices to set to -2 all positions in the matrix that are just above a value equal to -1 (except in row 1).
colsSub=colsSub(2:end)
rowsSub=rowsSub(2:end)-1
indF = sub2ind(size(F),rowsSub, colsSub)
F(indF)=-2

% 22. Given a 10×10 matrix, set the values of the even columns to zero.
G = ones(10);
G(:, 2:2:end) = 0 %Todas las filas -> : // Columnas impares -> 2:2:end

% 23. Create a 10×10 matrix where the values of each row coincide with the row number.
tam = 10;
H = zeros(tam);

for n = 1:tam
    H(n,:) = n
end


% 24. Given a 10×10 matrix, set the values of the fourth row to zero.
H(4,:) = 0

% 25. Given a 10×10 matrix, set the values of the second column to zero.
H(2,:) = 0;

% 26. Given a 10×10 matrix, set the values of the fifth column to the values of the first column.
H(1,:) = H(5,:);

% 27. Given a 10×10 matrix, set all the values to zero, except the rows and columns in the edges of the matrix.
I = ones(tam);
I(2:tam-1,2:tam-1)=1

%{
    Introduction to Image Processing Toolbox
%}

% 1. Open and display the image landscape.jpg. Determine the dimensions of the image. Is this a color image?
Img = imread("landscape.jpg");
%figure, imshow(Img)
imfinfo("landscape.jpg")
% The size of the image is 640*480, and its colortype is truecolor

% 2. Convert the image to grayscale, and display the result. 
% Then, save this resulting image into another file called landscapegray.jpg. What is the data type of the pixels?
grayImg = rgb2gray(Img);
%figure, imshow(grayImg)
imwrite(grayImg,"landscapegray.jpg")

% 3. Rescale the pixel values to the range [0, 1] and convert the image to double precision.
normImage = mat2gray(grayImg);
DP = im2double(normImage);

% 4. Display the gray scale image as a three-dimensional plot. Compare the results using two functions: mesh and surf.
surf(grayImg);
mesh(grayImg);

% 5. Convert the gray scale image to an indexed image with a colormap of 16 components and display the result. 
% Do you observe differences between the original and the indexed images?
[X, map] = gray2ind(grayImg, 16);

% 6. Write a Matlab script for generating the negative of the image moon.bmp. 
% First of all do it using nested loops, and then using the matlabs ability to perform vectorized operations. The final results should look like this:

moon = imread("moon.bmp");
negMoon = uint8(zeros(size(moon)));
[rows, cols] = size(moon);
for i = 1:rows;
    for j = 1:cols;
        negMoon(i,j)=255-moon(i,j);
    end
end
%figure, imshow(negMoon)

negMoon2 = uint8(zeros(size(moon)));
for i = 1:size(moon);
        negMoon(i)=255-moon(i);
end
%figure, imshow(negMoon)

% 7. Write a Matlab script which flips the image moon.bmp vertically. 
% Dont use nested loops. Use only sub-scripting. Have a look to functions like flipud or fliplr,
% but don-t use them this time.

moon = imread("moon.bmp");
flippedMoon = uint8(zeros(size(moon)));
flippedMoon(1:end,1:end) = moon(end:-1:1,1:end);
%figure, imshow(flippedMoon)





