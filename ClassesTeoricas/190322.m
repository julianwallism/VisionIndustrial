imatge = [190 177 186 192 192 190 127 60 62 67; 
    203 196 186 196 194 151 67 74 128 183;
    204 202 192 175 124 66 102 199 247 244;
    153 135 107 72 59 102 218 251 225 221;
    67 61 62 68 71 164 234 230 205 194];
imatgeFiltrada = imatge;
filtre=[-1 -1 0; -1 0 1; 0 1 1];

[rows, cols] = size(imatge);

for i = 2:rows-1
    for j = 2:cols-1
        for k =1:size(filtre)
            for m = 1:size(filtre)
                sum = sum + filtre(k,m)*imatge(i+k,j+m);
            end
        end
        imatgeFiltrada(i,j) = sum/(size(filtro)*size(filtro));
    end
end

