%EE 4745 Program 1
%


num0 = [ -1  1  1  1 -1; 
          1 -1 -1 -1  1; 
          1 -1 -1 -1  1; 
          1 -1 -1 -1  1; 
          1 -1 -1 -1  1; 
         -1  1  1  1 -1 ];
num1 = [ -1  1  1 -1 -1;
         -1 -1  1 -1 -1;
         -1 -1  1 -1 -1;
         -1 -1  1 -1 -1;
         -1 -1  1 -1 -1;
         -1 -1  1 -1 -1 ];
num2 = [  1  1  1 -1 -1;
         -1 -1 -1  1 -1;
         -1 -1 -1  1 -1;
         -1  1  1 -1 -1;
         -1  1 -1 -1 -1;
         -1  1  1  1  1 ];
num3 = [  1  1  1  1 -1;
         -1 -1 -1 -1  1;
         -1 -1 -1 -1  1;
         -1 -1  1  1  1;
         -1 -1 -1 -1  1;
          1  1  1  1 -1 ];
num4 = [  1 -1 -1 -1  1;
          1 -1 -1 -1  1;
          1 -1 -1 -1  1;
          1  1  1  1  1;
         -1 -1 -1 -1  1;
         -1 -1 -1 -1  1 ];
num5 = [ -1  1  1  1  1;
         -1  1 -1 -1 -1;
         -1  1  1  1 -1;
         -1 -1 -1 -1  1;
         -1 -1 -1 -1  1;
         -1  1  1  1 -1 ];
num6 = [  1  1  1  1 -1;
          1 -1 -1 -1 -1;
          1 -1 -1 -1 -1;
          1  1  1  1 -1;
          1 -1 -1  1 -1;
          1  1  1  1 -1 ];
      
evaluate =@(w, b, p) Hardlim(w * p + b);%Parses Neural Network inputs given
                                        %the weight, bias, and input

%Turn matrices into input vectors
numvec0 = ScanGrid(num0);
numvec1 = ScanGrid(num1);
numvec2 = ScanGrid(num2);
numvec3 = ScanGrid(num3);
numvec4 = ScanGrid(num4);
numvec5 = ScanGrid(num5);
numvec6 = ScanGrid(num6);

%Create input vector arrays
numvec0_1 = cat(2, numvec0, numvec1);
numvec0_2 = cat(2, numvec0_1, numvec2);
numvec0_3 = cat(2, numvec0_2, numvec3);
numvec0_4 = cat(2, numvec0_3, numvec4);
numvec0_5 = cat(2, numvec0_4, numvec5);
numvec0_6 = cat(2, numvec0_5, numvec6);

%Calculate NNs using Hebb rule
[wh0_1, bh0_1] = Hebb(numvec0_1);
[wh0_2, bh0_2] = Hebb(numvec0_2);
[wh0_3, bh0_3] = Hebb(numvec0_3);
[wh0_4, bh0_4] = Hebb(numvec0_4);
[wh0_5, bh0_5] = Hebb(numvec0_5);
[wh0_6, bh0_6] = Hebb(numvec0_6);

%Calculate NNs using Pseudoinverse
[wp0_1, bp0_1] = Pseudo(numvec0_1);
[wp0_2, bp0_2] = Pseudo(numvec0_2);
[wp0_3, bp0_3] = Pseudo(numvec0_3);
[wp0_4, bp0_4] = Pseudo(numvec0_4);
[wp0_5, bp0_5] = Pseudo(numvec0_5);
[wp0_6, bp0_6] = Pseudo(numvec0_6);

%Test
errorh = zeros(6, 3);
errorp = zeros(6, 3);
for i = 1:6
    numtests = (i + 1) * 10.0;
    for k = 2:2:6
        ecounth = 0.0;
        ecountp = 0.0;
        for j = 0:i
            for l = 1:10
                switch i
                    case 1
                        htest = isequal(numvec0_6(:,j+1), evaluate(wh0_1, bh0_1, AddNoise(numvec0_6(:,j+1), k)));
                        ptest = isequal(numvec0_6(:,j+1), evaluate(wp0_1, bp0_1, AddNoise(numvec0_6(:,j+1), k)));
                    case 2
                        htest = isequal(numvec0_6(:,j+1), evaluate(wh0_2, bh0_2, AddNoise(numvec0_6(:,j+1), k)));
                        ptest = isequal(numvec0_6(:,j+1), evaluate(wp0_2, bp0_2, AddNoise(numvec0_6(:,j+1), k)));
                    case 3
                        htest = isequal(numvec0_6(:,j+1), evaluate(wh0_3, bh0_3, AddNoise(numvec0_6(:,j+1), k)));
                        ptest = isequal(numvec0_6(:,j+1), evaluate(wp0_3, bp0_3, AddNoise(numvec0_6(:,j+1), k)));
                    case 4
                        htest = isequal(numvec0_6(:,j+1), evaluate(wh0_4, bh0_4, AddNoise(numvec0_6(:,j+1), k)));
                        ptest = isequal(numvec0_6(:,j+1), evaluate(wp0_4, bp0_4, AddNoise(numvec0_6(:,j+1), k)));
                    case 5
                        htest = isequal(numvec0_6(:,j+1), evaluate(wh0_5, bh0_5, AddNoise(numvec0_6(:,j+1), k)));
                        ptest = isequal(numvec0_6(:,j+1), evaluate(wp0_5, bp0_5, AddNoise(numvec0_6(:,j+1), k)));
                    case 6
                        htest = isequal(numvec0_6(:,j+1), evaluate(wh0_6, bh0_6, AddNoise(numvec0_6(:,j+1), k)));
                        ptest = isequal(numvec0_6(:,j+1), evaluate(wp0_6, bp0_6, AddNoise(numvec0_6(:,j+1), k)));
                end
                if ~htest
                    ecounth = ecounth + 1.0;
                end
                if ~ptest
                    ecountp = ecountp + 1.0;
                end
            end
        end
        errorh(i, k / 2) = ecounth / numtests;
        errorp(i, k / 2) = ecountp / numtests;
    end
end

Plots(errorh, errorp);
Table(errorh, errorp);

%Function definitions

function vec = ScanGrid(grid)
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

function [w, b] = Hebb(p)
%Generates weight and bias using (w,b) = T(p,1)' given p and t = p

[m,n] = size(p);
t = p;
p = cat(1, p, zeros(1, n) + 1);
wb = t * p.';
b = wb(:,end);
w = wb(:, 1:(end - 1));
end

function [w, b] = Pseudo(p)
%Generates weight and bias using (w,b) = T(p,1)+ given p and t = p

pseudoinverse =@(p) inv(p.' * p) * p.';
[m,n] = size(p);
t = p;
p = cat(1, p, zeros(1, n) + 1);
wb = t * pseudoinverse(p);
b = wb(:,end);
w = wb(:, 1:(end - 1));
end

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

function [vecOut] = Hardlim(vecIn)
%Applies Hardlim function to vector
[m, n] = size(vecIn);
lim =@(num) (num >= 0) * 1 + (num < 0) * -1;
for i = 1:m
    vecIn(i, 1) = lim(vecIn(i, 1));
end
vecOut = vecIn;
end

function [outVec] = AddNoise(inVec, num)
%Adds num noisy digits to the input vector

[m, n] = size(inVec);
temp = inVec;
noise = zeros(num, 1);
randgen = 0;
while (randgen ~= num)
    pixel = floor( (m - 1) * rand + 1);
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
