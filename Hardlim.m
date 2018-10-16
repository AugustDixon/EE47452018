function [vecOut] = Hardlim(vecIn)
%Applies Hardlim function to vector
[m, n] = size(vecIn);
lim =@(num) (num >= 0) * 1 + (num < 0) * -1;
for i = 1:m
    vecIn(i, 1) = lim(vecIn(i, 1));
end
vecOut = vecIn;
end

