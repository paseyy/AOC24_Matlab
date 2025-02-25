Rules = readmatrix("order.txt", Delimiter="|");
Updates = readmatrix("updates.txt", Delimiter=",");

Order = cell(100, 1);

for rule = Rules'
    Order{rule(1)} = [Order{rule(1)}, rule(2)];
end

invalids = cell(size(Updates, 1), 1);
counter = 0;
sum = 0;
for update = Updates'
    u = rmmissing(update);

    valid = check_valid(u, Order);
    if valid
        sum = sum + u(ceil(size(u, 1) / 2));
    else
        counter = counter + 1;
        invalids{counter} = u';
    end
end
sum
invalids = invalids(1:counter)

Sorted = cell(size(invalids, 1), 1);
counter = 0;
sum = 0;
for u = invalids'
    sorted = reorder(u{1}, Order);

    valid = check_valid(sorted, Order);
    if ~valid
        disp("WRONG!!!");
    end

    sum = sum + sorted(ceil(size(sorted, 2) / 2));

    counter = counter + 1;
    Sorted{counter} = sorted;
end

Sorted
sum



function sorted = reorder(unsorted, order)
    sorted = [unsorted(1)];
    for unsorted_i = 2:size(unsorted,2)
        laters = order{unsorted(unsorted_i)};

        found = false;
        for sorted_i = 1:size(sorted,2)
            if ismember(sorted(sorted_i), laters)
                sorted = [sorted(1:sorted_i-1), unsorted(unsorted_i), sorted(sorted_i:end)];
                found = true;
                break;
            end
        end
        if ~found
            sorted = [sorted(1:sorted_i), unsorted(unsorted_i)];
        end
    end
end

function valid = check_valid(u, order)
    valid = true;
    for n=1:size(u, 1)
        for m=n:size(u, 1)
            if ismember(u(n), order{u(m)})
                valid = false;
            end
        end
    end
end
