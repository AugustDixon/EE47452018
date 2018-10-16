function [grid] = Vec30to6x5(vec)
%This function converts a 1x30 length vector to a 6x5 array

scan = zeros(5,6);
for i = 1:n
    for j = 1:m
        scan(i, j) = vec((i-1) * m + j, 1);
    end
end
grid = scan;
end
