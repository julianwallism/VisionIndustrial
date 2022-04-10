%%%%%%%%%%%%%%%%%
%%    LAB 07   %%
%%%%%%%%%%%%%%%%%
close all

%% Developing tools, Counting Shoes

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. Write a function in Matlab to insert a matriz into another bigger
% matrix in the specified position. 
% The function signature should be: function out = locate(m1, m2, p)

% Final del archivo

% Ejemplo:
m1 = [1 2 3; 4 5 6; 7 8 9];
m2 = [1 2; 3 4];
p = [2 3];
out = locate(m1, m2, p)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2. Write a function in Matlab to insert one specific value of a matrix
% into another bigger matrix in the specified position. 
% The function signature should be: function out=insert_elem(m1,m2,p,val)

% Final del archivo

% Ejemplo:
m1 = [1 2 3; 9 5 6; 7 8 9];
m2 = [1 2; 1 4];
p = [2 2];
val = 1;
out = insert_elem(m1, m2, p, val)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3. Implement a script in Matlab to separate the objects from the 
% background and counting automatically the number of shoes present in the 
% image shoes1.jpg.



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Funciones %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
function out = locate(m1, m2, p)
    [r, c] = size(m2);
    [r1,c1] = size(m1);
    out = m1;
    if p(1) + r -1<= r1 && p(2) + c -1 <= c1
        out(p(1):p(1)+r-1, p(2):p(2)+c-1) = m2;
    else
        disp('Error: Out of bounds')
    end
    
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
               rowsSub(i)
               p(1)
                out(rowsSub(i)+p(1)-1,colsSub(i)+p(2)-1) = val;
           end
        else
            disp('Error: Out of bounds')
        end
    end
end