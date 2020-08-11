%% q1_1
INTERVAL = 1;
b_set = [-1.5, -0.5, 0.5, 1.5] * INTERVAL;
a_set = [];

for k1 = 1:4
    for k2 = 1:4
        a_set(end + 1) = (1 + 1j) * b_set(k1) + (1 - 1j) * b_set(k2);
    end
end

figure;
plot(a_set, 'x');
set(gca, 'XAxisLocation', 'origin', 'YAxisLocation', 'origin');
axis([-4, 4, -4, 4] * INTERVAL);
axis square;
xlabel('Re');
ylabel('j \cdot Im');
title('\{a_k\} 星座图');

%% q1_2
c_set = a_set .* (1 + 1j) / 2;
figure;
hold on;
plot(c_set, 'x');
for k = -1:1
    pos = INTERVAL * k;
    plot([pos, pos], [-2, 2] * INTERVAL, 'm--');
    plot([-2, 2] * INTERVAL, [pos, pos], 'm--');
end

set(gca, 'XAxisLocation', 'origin', 'YAxisLocation', 'origin');
axis([-2, 2, -2, 2] * INTERVAL);
axis square;
xlabel('Re');
ylabel('j \cdot Im');
title('\{c_k\} 星座图及判决区间');

%% q1_3
sigma = 0.25;
figure;
hold on;
plot(c_set, 'x');
plot([-1, -1] * INTERVAL, [-2, 2] * INTERVAL, 'm--');
plot([-2, 2] * INTERVAL, [-1, -1] * INTERVAL, 'm--');
plot([0, 0] * INTERVAL - log(2) * sigma / INTERVAL, [-2, 2] * INTERVAL, 'm--');
plot([-2, 2] * INTERVAL, [0, 0] * INTERVAL - log(2) * sigma / INTERVAL, 'm--');
plot([1, 1] * INTERVAL + log(2) * sigma / INTERVAL, [-2, 2] * INTERVAL, 'm--');
plot([-2, 2] * INTERVAL, [1, 1] * INTERVAL + log(2) * sigma / INTERVAL, 'm--');

set(gca, 'XAxisLocation', 'origin', 'YAxisLocation', 'origin');
axis([-2, 2, -2, 2] * INTERVAL);
axis square;
xlabel('Re');
ylabel('j \cdot Im');
title('\{c_k\} 星座图及判决区间');
