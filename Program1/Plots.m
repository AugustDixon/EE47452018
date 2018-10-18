%graphs
function Plots(Hebb, Pseudo)

subplot(2,3,1);
%sgt = sgtitle('Number of Digits Stored vs. Percentage Error'); %2018b only
p1 = plot(Hebb(:,1));
title('2-pixel Error, Hebb Rule');
xlabel('Number of Digits Stored');
ylabel('Percentage Error');
p1.Marker = 'o';

subplot(2,3,4);
p2 = plot(Pseudo(:,1));
title('2-pixel Error, Pseudoinverse');
xlabel('Number of Digits Stored');
ylabel('Percentage Error');
p2.Marker = 'o';

subplot(2,3,2);
p3 = plot(Hebb(:,2));
title('4-pixel Error, Hebb Rule');
xlabel('Number of Digits Stored');
ylabel('Percentage Error');
p3.Marker = 'o';

subplot(2,3,5);
p4 = plot(Pseudo(:,2));
title('4-pixel Error, Pseudoinverse');
xlabel('Number of Digits Stored');
ylabel('Percentage Error');
p4.Marker = 'o';

subplot(2,3,3);
p5 = plot(Hebb(:,3));
title('6-pixel Error, Hebb Rule');
xlabel('Number of Digits Stored');
ylabel('Percentage Error');
p5.Marker = 'o';

subplot(2,3,6);
p6 = plot(Pseudo(:,3));
title('6-pixel Error, Pseudoinverse');
xlabel('Number of Digits Stored');
ylabel('Percentage Error');
p6.Marker = 'o';
end