function [new_map, new_pos, new_dir, running] = make_move(map, pos, dir)
    new_pos = pos + dir;    

    running = true;
    if any(new_pos < 1 | new_pos > size(map, 1))
        new_dir = dir;
        map(pos(1), pos(2)) = 'X';
        running = false;
    else
        switch map(new_pos(1), new_pos(2))
            case {'.', 'X'}
                map(pos(1), pos(2)) = 'X';
                new_dir = dir;
            case '#'
                % obstacle hit, don't move
                new_pos = pos;
                map(pos(1), pos(2)) = '^';
                % turn 90 degrees for the new direction
                if isequal(dir, [1, 0])
                    new_dir = [0, -1];
                elseif isequal(dir, [0, -1])
                    new_dir = [-1, 0];
                elseif isequal(dir, [-1, 0])
                    new_dir = [0, 1];
                elseif isequal(dir, [0, 1])
                    new_dir = [1, 0];
                end
            otherwise
                disp("Error:" + map(new_pos(1), new_pos(2)));
        end
    end
    new_map = map;
end

temp = regexp(fileread('input.txt'), '\r?\n', 'split');
Map = vertcat(temp{:});

[row, col] = find(Map == '^');
position = [row, col];
direction = [-1, 0];

running = true;
while running
    [Map, position, direction, running] = make_move(Map, position, direction);
end

count = sum(Map == 'X', "all")