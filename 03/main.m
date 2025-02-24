text = fileread("input.txt");
results = regexp(text, "(mul\(\d+,\d+\)|do\(\)|don't\(\))", "match");

enable = 1;
sum = 0;
for i = 1:size(results, 2)
    pair = textscan(results{i}, "mul(%d,%d)");

    if size(pair{1}, 1) ~= 0 && size(pair{2}, 1) ~= 0
        sum = sum + pair{1} * pair{2} * enable;
    elseif strcmp(results{i}, "do()")
        enable = 1;
    elseif strcmp(results{i}, "don't()")
        enable = 0;
    end
end

sum
