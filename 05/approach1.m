Order = readmatrix("order.txt", Delimiter="|");
Updates = readmatrix("updates.txt", Delimiter=",");

Pages = unique(Order);
Lookup = NaN(size(Pages));

ctr = 1;
while size(Order, 1) > 0
    first = Pages(~ismember(Pages, Order(:, 2)))
    last = Pages(~ismember(Pages, Order(:, 1)))
    
    cond = ismember(Order(:, 1), first);
    Order(cond, :) = [];
    Pages(ismember(Pages(:, 1), first), :) = [];

    Lookup(ctr) = first;
    ctr = ctr + 1;
end
Lookup(ctr) = Pages;

sum = 0;
for update = Updates'
    u = rmmissing(update);
    [~, idx] = ismember(u, Lookup);
    
    if issorted(idx)
        sum = sum + u(ceil(size(u, 1) / 2));
    end
end

sum


