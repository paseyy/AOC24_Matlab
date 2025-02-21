% Part 1
T = readmatrix("input.txt");
left = T(:, 1);
right = T(:, 2);

left = sortrows(left);
right = sortrows(right);

difference = abs(left - right);
result = sum(difference)

% Part 2
counts = configureDictionary("int32", "int32");

right_index = 1;
previous_count = 0;
current_number = 0;
total = 0;
for n = 1:size(left)
    if right_index > size(right)
        break
    end

    current_count = 0;

    previous_number = current_number;
    current_number = left(n);

    while current_number > right(right_index)
        right_index = right_index + 1;
        if right_index > size(right)
            break
        end
    end

    if right_index > size(right)
        break
    end
    while current_number == right(right_index)
        right_index = right_index + 1;
        current_count = current_count + 1;
        if right_index > size(right)
            break
        end
    end

    if current_number == previous_number
        current_count = previous_count;
    end

    total = total + current_number * current_count;
end

result = total
