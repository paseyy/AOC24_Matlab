Rules = readmatrix("order.txt", Delimiter="|");
Updates = readmatrix("updates.txt", Delimiter=",");

Order = cell(100, 1);

for rule = Rules'
    Order{rule(1)} = [Order{rule(1)}, rule(2)];
end

Order;

sum = 0;
for update = Updates'
    u = rmmissing(update);

    valid = true;
    for n=1:size(u, 1)
        for m=n:size(u, 1)
            if ismember(u(n), Order{u(m)})
                valid = false;
            end
        end
    end

    if valid
        sum = sum + u(ceil(size(u, 1) / 2));
    end
end

sum