function [w, b] = Pseudo(p)
%Generates weight and bias using (w,b) = T(p,1)+ given p and t = p

pseudoinverse =@(p) inv(p.' * p) * p.';
[m,n] = size(p);
t = p;
p = cat(1, p, zeros(m, 1) + 1);
wb = t * pseudoinverse(p);
b = wb(:,end);
w = wb(:, 1:(end - 1));
end
