function [vec] = ScanGrid(grid)
%This function converts a mxn array into a m*n length vector
[m,n] = size(grid);
scan = zeros(m * n, 1);
for i = 1:n
    for j = 1:m
        scan((i-1) * m + j, 1) = grid(j, i);
    end
end
vec = scan;
end

