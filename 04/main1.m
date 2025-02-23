text = readlines("input.txt");
C = char(text);
C = C(1:end-1, :);

DIRECTIONS = [-1, 0; -1, 1; 0, 1; 1, 1; 1, 0; 1, -1; 0, -1; -1, -1];
WORD = ['X', 'M', 'A', 'S'];

sum = 0;
for i=1:size(C, 1)
    for j=1:size(C, 2)
        sum = sum + count_occurrences_at(C, i, j, WORD, DIRECTIONS);
    end
end

sum


function n = count_occurrences_at(C, pos_i, pos_j, WORD, DIRECTIONS)
    n = 0;
    word_index = 1;

    if C(pos_i, pos_j) ~= WORD(word_index)
        return
    end

    
    for dir = DIRECTIONS'
        % initialize the tracking variables
        word_index = 2;
        x = pos_i;
        y = pos_j;

        for i = 1:size(WORD, 2)
            x = x + dir(1);
            y = y + dir(2);
    
            % check if the variables are out of bounds
            if x < 1 || x > size(C, 1) || y < 1 || y > size(C, 2)
                break;
            end
    
            if C(x, y) == WORD(word_index)
                if word_index == size(WORD, 2)
                    % one completed word found!
                    n = n + 1;
                else
                    % on the right direction, but not completed yet.
                    word_index = word_index + 1;
                end
            else
                % no XMAS here - go to next direction
               break;
            end
        end        
    end
end