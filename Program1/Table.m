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
fprintf("\t\t\t\t\t\t\t\t\t\t\t Percentage Error\n\tStored Digits\t\t2-noisy pixels\t\t   4-noisy pixels\t\t  6-noisy pixels\n");
T = table(Hebb2, Pseudo2, Hebb4, Pseudo4, Hebb6, Pseudo6, 'RowNames', StoredDigits);
disp(T);
end