function [outVec] = AddNoise(inVec, num)
%Adds num noisy digits to the input vector

[m, n] = size(inVec);
temp = invec;
noise = zeros(num, 1);
randgen = 0;
while (randgen ~= num)
    pixel = (m - 1) * rand + 1;
    if(~any(noise(:) == pixel))
        randgen = randgen + 1;
        noise(randgen) = pixel;
    end
end
for i = 1:num
    temp(noise(i)) = -1 * temp(noise(i));
end

outVec = temp;
end

