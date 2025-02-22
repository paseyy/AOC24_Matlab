data = readmatrix("input.txt", Range=1);

num_safe = 0;

for r=1:size(data, 1)
    row = data(r, :);
    row = rmmissing(row);

    safe = check_row_safe(row);

    if safe
        num_safe = num_safe + 1;
        continue;
    end

    % row is not safe! try again with one element left out
    row_size = size(row, 2);
    for i=1:row_size
        new_row = row([1:i-1, i+1:end]);

        % we now have the new row with one element left out in new_row,
        % so run the whole algorithm again
        safe = check_row_safe(new_row);

        if safe
            num_safe = num_safe + 1;
            break;
        end
    end
end

num_safe


function safe = check_row_safe(row)
    safe = true;

    if length(row) < 2
        return;
    end


    % remember the last 2 elements and their difference
    pprev = row(1);
    prev = row(2);
    dif1 = pprev - prev;

    for col=3:size(row, 2)
        cur = row(col);
        dif2 = prev - cur;

        % cond 1: has to be strictly in-/decreasing
        if sign(dif2) ~= sign(dif1)
            safe = false;
        end

        % cond 2: difference has to be leq 3
        if abs(dif1) > 3 || abs(dif2) > 3
            safe = false;
        end

        % cond 3: absolute difference has to be greater than 0
        if dif1 == 0 || dif2 == 0
            safe = false;
        end

        % update the last 2 elements and their difference
        dif1 = dif2;
        pprev = prev;
        prev = cur;
    end
end