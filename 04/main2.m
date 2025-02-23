text = readlines("input.txt");
C = char(text);
C = C(1:end-1, :);

DIRECTIONS = [-1, 0; -1, 1; 0, 1; 1, 1; 1, 0; 1, -1; 0, -1; -1, -1];
WORD = ['X', 'M', 'A', 'S'];

sum = 0;
for i=2:size(C, 1)-1
    for j=2:size(C, 2)-1
        sum = sum + check_x_mas(C, i, j);
    end
end

sum


function n = check_x_mas(C, pos_i, pos_j)
    n = 0;

    if C(pos_i, pos_j) ~= 'A'
        return
    end

    LU = C(pos_i-1, pos_j-1);
    RU = C(pos_i-1, pos_j+1);
    LD = C(pos_i+1, pos_j-1);
    RD = C(pos_i+1, pos_j+1);

    if (LU ~= 'M' && LU ~= 'S') || (RU ~= 'M' && RU ~= 'S') ||...
       (LD ~= 'M' && LD ~= 'S') || (RD ~= 'M' && RD ~= 'S')
        return 
    end

    if LU ~= RD && LD ~= RU
        n = 1;
    end
end