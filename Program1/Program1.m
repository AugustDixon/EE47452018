%EE 4745 Program 1
%


num0 = { -1  1  1  1 -1;
          1 -1 -1 -1  1;
          1 -1 -1 -1  1;
          1 -1 -1 -1  1;
          1 -1 -1 -1  1;
         -1  1  1  1 -1 };
num1 = { -1  1  1 -1 -1;
         -1 -1  1 -1 -1;
         -1 -1  1 -1 -1;
         -1 -1  1 -1 -1;
         -1 -1  1 -1 -1;
         -1 -1  1 -1 -1 };
num2 = {  1  1  1 -1 -1;
         -1 -1 -1  1 -1;
         -1 -1 -1  1 -1;
         -1  1  1 -1 -1;
         -1  1 -1 -1 -1;
         -1  1  1  1  1 };
num3 = {  1  1  1  1 -1;
         -1 -1 -1 -1  1;
         -1 -1 -1 -1  1;
         -1 -1  1  1  1;
         -1 -1 -1 -1  1;
          1  1  1  1 -1 };
num4 = {  1 -1 -1 -1  1;
          1 -1 -1 -1  1;
          1 -1 -1 -1  1;
          1  1  1  1  1;
         -1 -1 -1 -1  1;
         -1 -1 -1 -1  1 };
num5 = { -1  1  1  1  1;
         -1  1 -1 -1 -1;
         -1  1  1  1 -1;
         -1 -1 -1 -1  1;
         -1 -1 -1 -1  1;
         -1  1  1  1 -1 };
num6 = {  1  1  1  1 -1;
          1 -1 -1 -1 -1;
          1 -1 -1 -1 -1;
          1  1  1  1 -1;
          1 -1 -1  1 -1;
          1  1  1  1 -1 };
      
evaluate =@(w, b, p) Hardlim(w * p + b);%Parses Neural Network inputs given
                                        %the weight, bias, and input
numvec0 = ScanGrid(num0);
numvec1 = ScanGrid(num1);
numvec2 = ScanGrid(num2);
numvec3 = ScanGrid(num3);
numvec4 = ScanGrid(num4);
numvec5 = ScanGrid(num5);
numvec6 = ScanGrid(num6);

numvec0_1 = cat(2, numvec0, numvec1);
numvec0_2 = cat(2, numvec0-1, numvec2);
numvec0_3 = cat(2, numvec0-2, numvec3);
numvec0_4 = cat(2, numvec0-3, numvec4);
numvec0_5 = cat(2, numvec0-4, numvec5);
numvec0_6 = cat(2, numvec0-5, numvec6);

pseudoinverse =@(p) inv(p.' * p) * p.';
w0_1 = Hebb(numvec0-1);

