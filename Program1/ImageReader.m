function [imageMatrix] = ImageReader(image)
%This function reads an image given in input and converts it to a 6x5 matrix
I = imread(image);
imageMatrix = im2bw(I);
%converts to bipolar matrix for 1 = black pixel and -1 = white pixel
imageMatrix = -(2*imageMatrix - 1);
end

