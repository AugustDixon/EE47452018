% EE 4745 Program 2

%Constants
alpha = .12;
numSamples = 100000;
sampleRate = 44100;

%Compute expected values
m1f =@(k) .12 * sin(2 * pi * k / 3 + pi / 2);
m2f =@(k) 1.2 * sin(2 * pi * k / 3 - 3 * pi / 2);
vf =@(k) 1.2 * sin(2 * pi * k / 3);
em1v = integral(@(k) m1f(k) * vf(k), 0, 2 * pi, 'ArrayValued', true) / (2 * pi);
em1vneg1 = integral(@(k) m1f(k) * vf(k-1), 0, 2 * pi, 'ArrayValued', true) / (2 * pi);
em2v = integral(@(k) m2f(k) * vf(k), 0, 2 * pi, 'ArrayValued', true) / (2 * pi);
em2vneg1 = integral(@(k) m2f(k) * vf(k-1), 0, 2 * pi, 'ArrayValued', true) / (2 * pi);
evsquared = integral(@(k) vf(k)^2, 0, 2 * pi, 'ArrayValued', true) / (2 * pi);
evvneg1 = integral(@(k) vf(k) * vf(k-1), 0, 2 * pi, 'ArrayValued', true) / (2 * pi);
em1squared = integral(@(k) m1f(k)^2, 0, 2 * pi, 'ArrayValued', true) / (2 * pi);
em2squared = integral(@(k) m2f(k)^2, 0, 2 * pi, 'ArrayValued', true) / (2 * pi);
essquared = integral(@(s) s * s, -2, 2, 'ArrayValued', true) / 4;
h1 = [em1v; em1vneg1];
h2 = [em2v; em2vneg1];
R = [evsquared evvneg1; evvneg1 evsquared];
c1 = essquared + em1squared;
c2 = essquared + em2squared;



[V, D] = eig(R);
fprintf('Eigenvalues of R');
D
fprintf('Eigenvectors of R');
V
xstar1 = inv(R) * h1;
xstar2 = inv(R) * h2;
X1 = -3:.1:3;
X2 = -3:.1:3;
Z1 =@(x1, x2) c1 - 2  * [x1 x2] * h1 + [x1 x2] * R * [x1; x2];
Z2 =@(x1, x2) c2 - 2  * [x1 x2] * h2 + [x1 x2] * R * [x1; x2];

lambdaMax = R(1, 1);
if R(2,2) > lambdaMax
    lambdaMax = R(2,2);
end
maxLearning = 1 / lambdaMax

figure(1);
fcontour(Z1);
title('Contour Plot, m(k) = .12sin(2pik/3+pi/2)');
figure(2);
fcontour(Z2);
title('Contour Plot, m(k) = 1.2sin(2pik/3-3pi/2)');

%Array Instantiations
W1 = [0 0];
W2 = [0 0];
s = zeros(1, numSamples);
v = zeros(1, numSamples);
m1 = zeros(1, numSamples);
m2 = zeros(1, numSamples);
t1 = zeros(1, numSamples);
t2 = zeros(1, numSamples);
r1 = zeros(1, numSamples);
r2 = zeros(1, numSamples);
a1 = zeros(1, numSamples);
a2 = zeros(1, numSamples);
e1 = zeros(1, numSamples);
e2 = zeros(1, numSamples);

%LMS
v0 = 1.2 * sin(0);
s(1) = rand * 4 - 2;
v(1) = 1.2 * sin(2 * pi * 1 / 3);
a1(1) = W1 * [v(1) v0]';
a2(1) = W2 * [v(1) v0]';
m1(1) = .12 * sin(2 * pi * 1 / 3 + pi / 2);
m2(1) = 1.2 * sin(2 * pi * 1 / 3 - 3 * pi / 2);
t1(1) = s(1) + m1(1);
t2(1) = s(1) + m2(1);
e1(1) = m1(1) - a1(1);
e2(1) = m2(1) - a2(1);
r1(1) = s(1) - e1(1);
r2(1) = s(1) - e2(1);
W1 = W1 + 2 * alpha * e1(1) * [v(1) v0];
W2 = W2 + 2 * alpha * e2(1) * [v(1) v0];
    
for k = 2:numSamples
    s(k) = rand * 4 - 2;
    v(k) = 1.2 * sin(2 * pi * k / 3);
    a1(k) = W1 * [v(k) v(k-1)]';
    a2(k) = W2 * [v(k) v(k-1)]';
    m1(k) = .12 * sin(2 * pi * k / 3 + pi / 2);
    m2(k) = 1.2 * sin(2 * pi * k / 3 - 3 * pi / 2);
    t1(k) = s(k) + m1(k);
    t2(k) = s(k) + m2(k);
    e1(k) = m1(k) - a1(k);
    e2(k) = m2(k) - a2(k);
    r1(k) = s(k) - e1(k);
    r2(k) = s(k) - e2(k);
    W1 = W1 + 2 * alpha * e1(k) * [v(k) v(k-1)];
    W2 = W2 + 2 * alpha * e2(k) * [v(k) v(k-1)];
end

xstar1
W1
xstar2
W2

%Plot
k = 1:100;
figure(3);
plot(k, r1(1:100), k, s(1:100));
title('Original and Restored, m(k) = .12sin(2pik/3+pi/2)');
legend({'Restored','Original'}, 'Location', 'northeast');
figure(4);
plot(k, r2(1:100), k, s(1:100));
title('Original and Restored, m(k) = 1.2sin(2pik/3-3pi/2)');
legend({'Restored','Original'}, 'Location', 'northeast');




%Write audio files
audiowrite('Original.mp4', s, sampleRate);
audiowrite('Noise1.mp4', m1, sampleRate);
audiowrite('Corrupted1.mp4', t1, sampleRate);
audiowrite('Restored1.mp4', r1, sampleRate);
audiowrite('Noise2.mp4', m2, sampleRate);
audiowrite('Corrupted2.mp4', t2, sampleRate);
audiowrite('Restored2.mp4', r2, sampleRate);
