function [w, b] = Hebb(p)
%Generates weight and bias using (w,b) = T(p,1)' given p and t = p

[m,n] = size(p);
t = p;
p = cat(1, p, zeros(m, 1) + 1);
wb = t * p.';
b = wb(:,end);
w = wb(:, 1:(end - 1));
end

