N = 10000;
fs = linspace(0, 25, N);
valid = zeros(1, N);
for k = 0:10
    valid((fs >= 23.2/(k+1) & fs <= 21.2/k)) = 1;
end

figure;
plot(fs, valid);
xlabel('f_s (MHz)');
ylabel('is\_valid');
hold on;
area(fs, valid, 'FaceColor', 'c');