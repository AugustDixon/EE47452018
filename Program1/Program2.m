BSB = ImageReader('BSB.png');
APD = ImageReader('APD.png');
JFB = ImageReader('JFB.png');
JMW = ImageReader('JMW.png');
CRR = ImageReader('CRR.png');
SBC = ImageReader('SBC.png');
SLA = ImageReader('SLA.png');

evaluate =@(w, b, p) Hardlim(w * p + b);%Parses Neural Network inputs given
                                        %the weight, bias, and input

%Turn matrices into input vectors
BSBvec = ScanGrid(BSB);
APDvec = ScanGrid(APD);
JFBvec = ScanGrid(JFB);
JMWvec = ScanGrid(JMW);
CRRvec = ScanGrid(CRR);
SBCvec = ScanGrid(SBC);
SLAvec = ScanGrid(SLA);

%Create input vector arrays
vecArray0_1 = cat(2, BSBvec, APDvec);
vecArray0_2 = cat(2, vecArray0_1, JFBvec);
vecArray0_3 = cat(2, vecArray0_2, JMWvec);
vecArray0_4 = cat(2, vecArray0_3, CRRvec);
vecArray0_5 = cat(2, vecArray0_4, SBCvec);
vecArray0_6 = cat(2, vecArray0_5, SLAvec);

%Calculate NNs using Hebb rule
[wh0_1, bh0_1] = Hebb(vecArray0_1);
[wh0_2, bh0_2] = Hebb(vecArray0_2);
[wh0_3, bh0_3] = Hebb(vecArray0_3);
[wh0_4, bh0_4] = Hebb(vecArray0_4);
[wh0_5, bh0_5] = Hebb(vecArray0_5);
[wh0_6, bh0_6] = Hebb(vecArray0_6);

%Calculate NNs using Pseudoinverse
[wp0_1, bp0_1] = Pseudo(vecArray0_1);
[wp0_2, bp0_2] = Pseudo(vecArray0_2);
[wp0_3, bp0_3] = Pseudo(vecArray0_3);
[wp0_4, bp0_4] = Pseudo(vecArray0_4);
[wp0_5, bp0_5] = Pseudo(vecArray0_5);
[wp0_6, bp0_6] = Pseudo(vecArray0_6);

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
                        htest = isequal(vecArray0_6(:,j+1), evaluate(wh0_1, bh0_1, AddNoise(vecArray0_6(:,j+1), k)));
                        ptest = isequal(vecArray0_6(:,j+1), evaluate(wp0_1, bp0_1, AddNoise(vecArray0_6(:,j+1), k)));
                    case 2
                        htest = isequal(vecArray0_6(:,j+1), evaluate(wh0_2, bh0_2, AddNoise(vecArray0_6(:,j+1), k)));
                        ptest = isequal(vecArray0_6(:,j+1), evaluate(wp0_2, bp0_2, AddNoise(vecArray0_6(:,j+1), k)));
                    case 3
                        htest = isequal(vecArray0_6(:,j+1), evaluate(wh0_3, bh0_3, AddNoise(vecArray0_6(:,j+1), k)));
                        ptest = isequal(vecArray0_6(:,j+1), evaluate(wp0_3, bp0_3, AddNoise(vecArray0_6(:,j+1), k)));
                    case 4
                        htest = isequal(vecArray0_6(:,j+1), evaluate(wh0_4, bh0_4, AddNoise(vecArray0_6(:,j+1), k)));
                        ptest = isequal(vecArray0_6(:,j+1), evaluate(wp0_4, bp0_4, AddNoise(vecArray0_6(:,j+1), k)));
                    case 5
                        htest = isequal(vecArray0_6(:,j+1), evaluate(wh0_5, bh0_5, AddNoise(vecArray0_6(:,j+1), k)));
                        ptest = isequal(vecArray0_6(:,j+1), evaluate(wp0_5, bp0_5, AddNoise(vecArray0_6(:,j+1), k)));
                    case 6
                        htest = isequal(vecArray0_6(:,j+1), evaluate(wh0_6, bh0_6, AddNoise(vecArray0_6(:,j+1), k)));
                        ptest = isequal(vecArray0_6(:,j+1), evaluate(wp0_6, bp0_6, AddNoise(vecArray0_6(:,j+1), k)));
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

pseudoinverse =@(p) (p.' * p)\p.';
[m,n] = size(p);
t = p;
p = cat(1, p, zeros(1, n) + 1);
wb = t * pseudoinverse(p);
b = wb(:,end);
w = wb(:, 1:(end - 1));
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

function Plots(Hebb, Pseudo)

subplot(2,3,1);
%sgt = sgtitle('Number of Digits Stored vs. Percentage Error'); %2018b only
p1 = plot(Hebb(:,1));
title('2-pixel Error, Hebb Rule');
xlabel('Number of Images Stored');
ylabel('Percentage Error');
p1.Marker = 'o';

subplot(2,3,4);
p2 = plot(Pseudo(:,1));
title('2-pixel Error, Pseudoinverse');
xlabel('Number of Images Stored');
ylabel('Percentage Error');
p2.Marker = 'o';

subplot(2,3,2);
p3 = plot(Hebb(:,2));
title('4-pixel Error, Hebb Rule');
xlabel('Number of Images Stored');
ylabel('Percentage Error');
p3.Marker = 'o';

subplot(2,3,5);
p4 = plot(Pseudo(:,2));
title('4-pixel Error, Pseudoinverse');
xlabel('Number of Images Stored');
ylabel('Percentage Error');
p4.Marker = 'o';

subplot(2,3,3);
p5 = plot(Hebb(:,3));
title('6-pixel Error, Hebb Rule');
xlabel('Number of Images Stored');
ylabel('Percentage Error');
p5.Marker = 'o';

subplot(2,3,6);
p6 = plot(Pseudo(:,3));
title('6-pixel Error, Pseudoinverse');
xlabel('Number of Images Stored');
ylabel('Percentage Error');
p6.Marker = 'o';
end

%table
function Table(Hebb, Pseudo)

StoredDigits = ["0,1", "0,1,2", "0,1,3", "0,1,2,3,4", "0,1,2,3,4,5", "0,1,2,3,4,5,6"];
StoredDigits = cellstr(StoredDigits);
Hebb2 = Hebb(:,1);
Pseudo2 = Pseudo(:,1);
Hebb4 = Hebb(:,2);
Pseudo4 = Pseudo(:,2);
Hebb6 = Hebb(:,3);
Pseudo6 = Pseudo(:,3);
fprintf("\t\t\t\t\t\t\t\t\t\t\t Percentage Error\n\tStored Images\t\t2-noisy pixels\t\t   4-noisy pixels\t\t  6-noisy pixels\n");
T = table(Hebb2, Pseudo2, Hebb4, Pseudo4, Hebb6, Pseudo6, 'RowNames', StoredDigits);
disp(T);
end